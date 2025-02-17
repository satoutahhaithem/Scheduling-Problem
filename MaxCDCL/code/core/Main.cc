/*****************************************************************************************[Main.cc]
Copyright (c) 2003-2006, Niklas Een, Niklas Sorensson
Copyright (c) 2007-2010, Niklas Sorensson

Chanseok Oh's MiniSat Patch Series -- Copyright (c) 2015, Chanseok Oh

Maple_LCM, Based on MapleCOMSPS_DRUP --Copyright (c) 2017, Mao Luo, Chu-Min LI, Fan Xiao: implementing a learnt clause minimisation approach
 Reference: M. Luo, C.-M. Li, F. Xiao, F. Manya, and Z. L. , “An effective learnt clause minimization approach for cdcl sat solvers,” in IJCAI-2017, 2017, pp.703-711.
 
Maple_CM, Based on Maple_LCM --Copyright (c) 2018, Chu-Min LI, Mao Luo, Fan Xiao: implementing a clause minimisation approach.

Copyright (c) 2021,Chu-Min Li (chu-min.li@u-picardie.fr)

A MaxSAT solver combining branch-and-bound and clause learning, implemented by Chu-Min Li with the help of Jordi Coll
Based on Maple_LCM

Reference: Chu-Min Li, Zhenxing Xu, Jordi Coll, Felip Manyà, Djamal Habet, Kun He, Combining Clause Learning and Branch and Bound for MaxSAT, in CP-2021, to appear

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute,
sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or
substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT
OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
**************************************************************************************************/

/* Based on MaxCDCL1.1-involv+falseLit-imply+optUP+impLitbis */



#define _CRT_SECURE_NO_DEPRECATE
#include <errno.h>

#include <signal.h>
#ifdef _MSC_VER 
#   include <win/zlib.h> 
#else 
#   include <zlib.h> 
#endif 

#include "utils/System.h"
#include "utils/ParseUtils.h"
#include "utils/Options.h"
#include "core/Dimacs.h"
#include "core/Solver.h"

using namespace Minisat;

//=================================================================================================

#ifdef _MSC_VER 
void printStats(Solver& solver)
{
	double cpu_time = cpuTime();
	double mem_used = 0;//memUsedPeak();
	printf("c restarts              : %-12lld (%-12lld conflicts in avg)\n", solver.starts, (solver.starts>0 ? solver.conflicts / solver.starts : 0));
	printf("c conflicts             : %-12lld   (%.0f /sec)\n", solver.conflicts, solver.conflicts / cpu_time);
	printf("c decisions             : %-12lld   (%4.2f %% random) (%.0f /sec)\n", solver.decisions, (float)solver.rnd_decisions * 100 / (float)solver.decisions, solver.decisions / cpu_time);
	printf("c propagations          : %-12lld   (%.0f /sec)\n", solver.propagations, solver.propagations / cpu_time);

	printf("c conflict literals     : %-12lld   (%4.2f %% deleted)\n", solver.tot_literals, (solver.max_literals - solver.tot_literals) * 100 / (double)solver.max_literals);
	if (mem_used != 0) printf("Memory used           : %.2f MB\n", mem_used);
	printf("c CPU time              : %g s\n", cpu_time);
	// simplify
	printf("c nbSimplifyAll         : %llu\n", solver.nbSimplifyAll);
	printf("c s_propagations        : %-12lld\n", solver.s_propagations);
	printf("c s_cost_ratio          : %4.2f%%\n", solver.s_propagations * 100 / (double)solver.propagations);

}
#else 

void printStats(Solver& solver)
{
	double cpu_time = cpuTime();
	double mem_used = memUsedPeak();
	printf("c restarts              : %"PRIu64"\n", solver.starts);
	printf("c conflicts             : %-12"PRIu64"   (%.0f /sec)\n", solver.conflicts, solver.conflicts / cpu_time);
	printf("c decisions             : %-12"PRIu64"   (%4.2f %% random) (%.0f /sec)\n", solver.decisions, (float)solver.rnd_decisions * 100 / (float)solver.decisions, solver.decisions / cpu_time);
	printf("c propagations          : %-12"PRIu64"   (%.0f /sec)\n", solver.propagations, solver.propagations / cpu_time);
	printf("c conflict literals     : %-12"PRIu64"   (%4.2f %% deleted)\n", solver.tot_literals, (solver.max_literals - solver.tot_literals) * 100 / (double)solver.max_literals);
	if (mem_used != 0) printf("c Memory used           : %.2f MB\n", mem_used);
	printf("c CPU time              : %g s\n", cpu_time);
	// simplify
	printf("c nbSimplifyAll         : %llu\n", solver.nbSimplifyAll);
	printf("c s_propagations        : %-12"PRIu64"\n", solver.s_propagations);
	printf("c s_cost_ratio          : %4.2f%%\n", solver.s_propagations * 100 / (double)solver.propagations);

}
#endif


static Solver* solver;
// Terminate by notifying the solver and back out gracefully. This is mainly to have a test-case
// for this feature of the Solver as it may take longer than an immediate call to '_exit()'.
static void SIGINT_interrupt(int signum) { solver->interrupt(); }

// Note that '_exit()' rather than 'exit()' has to be used. The reason is that 'exit()' calls
// destructors and may cause deadlocks if a malloc/free function happens to be running (these
// functions are guarded by locks for multithreaded use).
static void SIGINT_exit(int signum) {
    printf("\n"); printf("c *** INTERRUPTED ***\n");
    if (solver->verbosity > 0){
        printStats(*solver);
        printf("\n"); printf("c *** INTERRUPTED ***\n"); }
    _exit(1); }


//=================================================================================================
// Main:


int main(int argc, char** argv)
{
    try {
        setUsageHelp("USAGE: %s [options] <input-file> <result-output-file>\n\n  where input may be either in plain or gzipped DIMACS.\n");
        printf("c This is COMiniSatPS.\n");
        
#if defined(__linux__)
        fpu_control_t oldcw, newcw;
        _FPU_GETCW(oldcw); newcw = (oldcw & ~_FPU_EXTENDED) | _FPU_DOUBLE; _FPU_SETCW(newcw);
        printf("c WARNING: for repeatability, setting FPU to use double precision\n");
#endif
        // Extra options:
        //
        IntOption    verb   ("MAIN", "verb",   "Verbosity level (0=silent, 1=some, 2=more).", 1, IntRange(0, 2));
        IntOption    cpu_lim("MAIN", "cpu-lim","Limit on CPU time allowed in seconds.\n", INT32_MAX, IntRange(0, INT32_MAX));
        IntOption    mem_lim("MAIN", "mem-lim","Limit on memory usage in megabytes.\n", INT32_MAX, IntRange(0, INT32_MAX));
        
        parseOptions(argc, argv, true);

        Solver S;
        double initial_time = cpuTime();

        S.verbosity = verb;
        
        solver = &S;
        // Use signal handlers that forcibly quit until the solver will be able to respond to
        // interrupts:
        //signal(SIGINT, SIGINT_exit);
        //signal(SIGXCPU,SIGINT_exit);
#ifndef _MSC_VER 
        // Set limit on CPU-time:
        if (cpu_lim != INT32_MAX){
            rlimit rl;
            getrlimit(RLIMIT_CPU, &rl);
            if (rl.rlim_max == RLIM_INFINITY || (rlim_t)cpu_lim < rl.rlim_max){
                rl.rlim_cur = cpu_lim;
                if (setrlimit(RLIMIT_CPU, &rl) == -1)
                    printf("c WARNING! Could not set resource limit: CPU-time.\n");
            } }

        // Set limit on virtual memory:
        if (mem_lim != INT32_MAX){
            rlim_t new_mem_lim = (rlim_t)mem_lim * 1024*1024;
            rlimit rl;
            getrlimit(RLIMIT_AS, &rl);
            if (rl.rlim_max == RLIM_INFINITY || new_mem_lim < rl.rlim_max){
                rl.rlim_cur = new_mem_lim;
                if (setrlimit(RLIMIT_AS, &rl) == -1)
                    printf("c WARNING! Could not set resource limit: Virtual memory.\n");
            } }
#endif            
        if (argc == 1)
            printf("c Reading from standard input... Use '--help' for help.\n");
        
        gzFile in = (argc == 1) ? gzdopen(0, "rb") : gzopen(argv[1], "rb");
        if (in == NULL)
            printf("c ERROR! Could not open file: %s\n", argc == 1 ? "<stdin>" : argv[1]), exit(1);
        
        if (S.verbosity > 0){
            printf("c ============================[ Problem Statistics ]=============================\n");
            printf("c |                                                                             |\n"); }
        
        parse_DIMACS(in, S);
        gzclose(in);
	if (argc >= 3 && atoi(argv[2]) > 0)
	  S.initUB = atoi(argv[2]);
	else S.initUB = INT32_MAX;
	printf("c initial UB: %llu\n", S.initUB);
        FILE* res = (argc >= 4) ? fopen(argv[3], "wb") : NULL;
        
        if (S.verbosity > 0){
            printf("c |  Number of variables:  %12d                                         |\n", S.nVars());
            printf("c |  Number of clauses:    %12d                                         |\n", S.nClauses()); }
        
        double parsed_time = cpuTime();
        if (S.verbosity > 0){
            printf("c |  Parse time:           %12.2f s                                       |\n", parsed_time - initial_time);
            printf("c |                                                                             |\n"); }
	S.nbOrignalVars = S.nVars();
        // Change to signal-handlers that will only notify the solver and allow it to terminate
        // voluntarily:
        signal(SIGINT, SIGINT_interrupt);
#ifndef _MSC_VER
		signal(SIGXCPU, SIGINT_interrupt);
#endif       
        if (!S.simplify()){
            if (res != NULL) fprintf(res, "UNSAT\n"), fclose(res);
            if (S.verbosity > 0){
                printf("c ===============================================================================\n");
                printf("c Solved by unit propagation\n");
                printStats(S);
                printf("\n"); }
            printf("s UNSATISFIABLE\n");
            exit(20);
        }
        
        vec<Lit> dummy;
        lbool ret = S.solveLimited(dummy);
        if (S.verbosity > 0){
            printStats(S);
            printf("\n"); }
        printf(ret == l_True ? "s SATISFIABLE\n" : ret == l_False ? "s UNSATISFIABLE\n" : "s UNKNOWN\n");
	if (ret == l_True){
	  printf("v ");
	  for (int i = 0; i < S.nVars(); i++)
	    if (S.model[i] != l_Undef)
	      printf("%s%s%d", (i==0)?"":" ", (S.model[i]==l_True)?"":"-", i+1);
	  printf(" 0\n");
	}

        if (res != NULL){
            if (ret == l_True){
                fprintf(res, "SAT\n");
                for (int i = 0; i < S.nVars(); i++)
                    if (S.model[i] != l_Undef)
                        fprintf(res, "%s%s%d", (i==0)?"":" ", (S.model[i]==l_True)?"":"-", i+1);
                fprintf(res, " 0\n");
            }else if (ret == l_False)
                fprintf(res, "UNSAT\n");
            else
                fprintf(res, "INDET\n");
            fclose(res);
        }
        
#ifdef NDEBUG
        exit(ret == l_True ? 10 : ret == l_False ? 20 : 0);     // (faster than "return", which will invoke the destructor for 'Solver')
#else
        return (ret == l_True ? 10 : ret == l_False ? 20 : 0);
#endif
    } catch (OutOfMemoryException&){
        printf("c ===============================================================================Out of Memory\n");
        printf("s UNKNOWN\n");
        exit(0);
    }
}
