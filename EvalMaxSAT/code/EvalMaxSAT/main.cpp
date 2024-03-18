#include <iostream>
#include <cassert>
#include <csignal>
#include <zlib.h>
#include <chrono>

#include <unistd.h>
#include <sys/types.h>
#include <signal.h>
#include <sys/wait.h>
#include <memory>

#include "EvalMaxSAT.h"
#include "lib/CLI11.hpp"

using namespace MaLib;

std::string PATH_INCOMPLET_SOLVER = "./";

Chrono TotalChrono("c Total time");

std::string exec(std::string cmd) {
    std::array<char, 128> buffer;
    std::string result;
    std::unique_ptr<FILE, decltype(&pclose)> pipe(popen(cmd.c_str(), "r"), pclose);
    if (!pipe) {
        throw std::runtime_error("popen() failed!");
    }
    while (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr) {
        result += buffer.data();
    }
    return result;
}


std::tuple<std::vector<bool>, t_weight, bool> getUB(std::string file, unsigned int timeout=60, std::string incompletSolver = "nuwls") {
    std::vector<bool> values;
    t_weight weight = std::numeric_limits<t_weight>::max();

    std::string result = exec(toString("timeout -s 15 ",timeout," timeout -s 9 ", timeout+10, " ", PATH_INCOMPLET_SOLVER, incompletSolver, " ", file));
    std::istringstream issResult(result);

    std::string line;
    std::string res;
    bool optimal = false;
    while (std::getline(issResult, line))
    {
        std::istringstream iss(line);
        char action;
        if(!(iss >> action)) {
            continue;
        }
        switch (action) {

        case 'c':
        {
            break;
        }

        case 'o':
        {
            if(!(iss >> weight)) {
                assert(false);
            }
            break;
        }

        case 's':
        {
            if(!(iss >> res)) {
                assert(false);
            }
            if( (res.compare("SATISFIABLE") == 0) ) {
                optimal = false;
            }
            if( (res.compare("OPTIMUM") == 0) ) {
                optimal = true;
            }
            break;
        }

        case 'v':
        {
            if(!(iss >> res)) {
                assert(false);
            }
            values.push_back(0); // fake lit

            int res2;
            if(!(iss >> res2)) {
                if(res.compare("-1") ==  0) {
                    res = "0"; // special case of a single variable
                }

                // New format
                for(unsigned int i=0; i<res.size(); i++) {
                    values.push_back(res[i] == '1');
                }
            } else {
                // Old format
                int lit = std::atoi(res.c_str());
                values.push_back(lit > 0);
                assert((values.size()-1) == abs(lit));

                values.push_back(res2 > 0);

                while(iss>>lit) {
                    values.push_back(lit > 0);
                    assert((values.size()-1) == abs(lit));
                }
            }

            break;
        }

        default:
            assert(false);
        }
    }

    return {values, weight, optimal};
}



std::string cur_file;
std::unique_ptr<EvalMaxSAT<Solver_cadical>> monMaxSat;
bool oldOutputFormat = false;
unsigned int bench = 0;

void signalHandler( int signum ) {

    if(monMaxSat != nullptr) {
        if(bench) {
                std::cout << cur_file << "\t" << calculateCost(cur_file, monMaxSat->solution) << "\t" << TotalChrono.tacSec() << std::endl;
        } else
        if(oldOutputFormat) {
            std::cout << "o " << calculateCost(cur_file, monMaxSat->solution) << std::endl;
            std::cout << "s OPTIMUM FOUND" << std::endl;
            std::cout << "v";
            for(unsigned int i=1; i<monMaxSat->solution.size(); i++) {
                if(monMaxSat->solution[i]) {
                    std::cout << " " << i;
                } else {
                    std::cout << " -" << i;
                }
            }
            std::cout << std::endl;
        } else {
            std::cout << "o " << calculateCost(cur_file, monMaxSat->solution) << std::endl;
            std::cout << "s UNKNOWN" << std::endl;
            //std::cout << "o " << calculateCost(file, solution) << std::endl;
            std::cout << "v ";
            for(unsigned int i=1; i<monMaxSat->solution.size(); i++) {
                std::cout << monMaxSat->solution[i];
            }
            std::cout << std::endl;
        }
    }

    //std::cout << "c Interrupt signal (" << signum << ") received, curFile = "<<cur_file<< std::endl;
    exit(signum);
}

template<class SOLVER>
std::tuple<std::vector<bool>, t_weight> solveFile(SOLVER *monMaxSat, std::string file, double targetComputationTime=3600, double timeForSCIP=500, double timeForUB=300) {
    cur_file = file;
    bool isOptimal=false;
    if(timeForUB>0) {
        auto [sol, solCost, isOptimal] = getUB(file, timeForUB/2.0, "loandra");
        MonPrint("c UB loandra = ", solCost);
        if(solCost<monMaxSat->solutionCost) {
            monMaxSat->solution = sol;
            monMaxSat->solutionCost = solCost;
        }
        if(!isOptimal) {
            auto [sol, solCost, isOptimal] = getUB(file, timeForUB/2.0, "nuwls");
            MonPrint("c UB nuwls = ", solCost);
            if(solCost<monMaxSat->solutionCost) {
                monMaxSat->solution = sol;
                monMaxSat->solutionCost = solCost;
            }
        }

        isOptimal = false; // To re-prove that it's an optimal solution
    }

    if(!isOptimal) {
        if(!parse(file, monMaxSat)) {
            std::cerr << "Unable to read the file " << file << std::endl;
            assert(false);
            return std::make_tuple<std::vector<bool>, t_weight>({},-1);
        }

        monMaxSat->setTargetComputationTime( targetComputationTime - TotalChrono.tacSec(), timeForSCIP );
        if(monMaxSat->isWeighted() == false) {
            monMaxSat->disableOptimize();
        }
        if(!monMaxSat->solve()) {
            std::cout << "s UNSATISFIABLE" << std::endl;
            return std::make_tuple<std::vector<bool>, t_weight>({},-1);
        }
    }

    assert(monMaxSat->solutionCost == calculateCost(file, monMaxSat->solution));

    return {monMaxSat->solution, calculateCost(file, monMaxSat->solution)};
}


int main(int argc, char *argv[])
{
    assert([](){std::cout << "c Assertion activated. For better performance, compile the project with assertions disabled. (-DNDEBUG)" << std::endl; return true;}());

    signal(SIGINT, signalHandler);
    signal(SIGTERM, signalHandler);

    ///////////////////////////
    /// PARSE ARG
    ///
        CLI::App app{"EvalMaxSAT Solver"};

        std::string file;
        app.add_option("file", file, "File with the formula to be solved (wcnf format)")->check(CLI::ExistingFile)->required();

        unsigned int minimalRefTime=1;
        app.add_option("--minRefTime", minimalRefTime, toString("Minimal reference time to improve unsat core (default = ",minimalRefTime,")"));

        unsigned int maximalRefTime=5*60;
        app.add_option("--maxRefTime", maximalRefTime, toString("Maximal reference time to improve unsat core (default = ",maximalRefTime,")"));

        unsigned int targetComputationTime = 60*60;
        app.add_option("--TCT", targetComputationTime, toString("Target Computation Time (default = ",targetComputationTime,")"));

        double coefOnRefTime = 1.66;
        app.add_option("--coefAVG", coefOnRefTime, toString("Average coef on ref time (default = ",coefOnRefTime,")"));

        double initialCoef = 10;
        app.add_option("--coefInit", initialCoef, toString("Initial coef on ref time (default = ",initialCoef,")"));

        app.add_flag("--old", oldOutputFormat, "Use old output format");

        unsigned int timeForUB = 60;
        app.add_option("--timeUB", timeForUB, toString("Time in seconds for the calculation of an upper bound (default: ",timeForUB,")"));

        unsigned int timeForSCIP = 500;
        app.add_option("--timeSCIP", timeForSCIP, toString("Time in seconds for SCIP (default: ",timeForSCIP,")"));
        
        app.add_option("--path_incomplet_solver", PATH_INCOMPLET_SOLVER, toString("Path to incomplet solvers (default: ",PATH_INCOMPLET_SOLVER,")"))->check(CLI::ExistingDirectory);

        app.add_option("--bench", bench, "Bench mode");

        CLI11_PARSE(app, argc, argv);
    ///
    ////////////////////////////////////////

    monMaxSat = std::make_unique<EvalMaxSAT<Solver_cadical>>();
    monMaxSat->setCoef(initialCoef, coefOnRefTime);
    monMaxSat->setBoundRefTime(minimalRefTime, maximalRefTime);
    auto [solution, cost] = solveFile(monMaxSat.get(), file, targetComputationTime, timeForSCIP, timeForUB);

    if(bench) {
            std::cout << file << "\t" << calculateCost(file, solution) << "\t" << TotalChrono.tacSec() << std::endl;
    } else
    if(oldOutputFormat) {
        ////// PRINT SOLUTION OLD FORMAT //////////////////
        ///
            std::cout << "o " << calculateCost(file, solution) << std::endl;
            std::cout << "s OPTIMUM FOUND" << std::endl;
            std::cout << "v";
            for(unsigned int i=1; i<solution.size(); i++) {
                if(solution[i]) {
                    std::cout << " " << i;
                } else {
                    std::cout << " -" << i;
                }
            }
            std::cout << std::endl;
        ///
        ///////////////////////////////////////
    } else {
        ////// PRINT SOLUTION NEW FORMAT //////////////////
        ///
            std::cout << "o " << calculateCost(file, solution) << std::endl;
            std::cout << "s OPTIMUM FOUND" << std::endl;
            std::cout << "v ";
            for(unsigned int i=1; i<solution.size(); i++) {
                std::cout << solution[i];
            }
            std::cout << std::endl;
        ///
        ///////////////////////////////////////
    }

    return 0;
}





