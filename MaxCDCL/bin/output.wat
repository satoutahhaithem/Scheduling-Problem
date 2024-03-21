runsolver Copyright (C) 2010-2013 Olivier ROUSSEL

This is runsolver version 3.3.5 (svn: 2013)

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

command line: ./run --timestamp -d 10 -o output.out -v output.var -w output.wat -C -W -M ./maxcdcl-scip-maxhs 11_session_file.cnf 600 1200 

running on 16 cores: 0-15

Enforcing CPUTime limit (soft limit, will send SIGTERM then SIGKILL): 0 seconds
Enforcing CPUTime limit (hard limit, will send SIGXCPU): 30 seconds
Current StackSize limit: 8192 KiB


[startup+0 s]
/proc/loadavg: 0.61 0.50 0.50 6/1201 361912
/proc/meminfo: memFree=25351052/32588432 swapFree=443156/2268656
[pid=361912] ppid=361910 vsize=0 CPUtime=0 cores=0-15
/proc/361912/stat : 361912 (run) Z 361910 361912 358322 34817 361910 4227148 45 0 0 0 0 0 0 0 20 0 1 0 7439868 0 0 18446744073709551615 0 0 0 0 0 0 0 0 24578 1 0 0 17 3 0 0 0 0 0 0 0 0 0 0 0 0 32512
/proc/361912/statm: 0 0 0 0 0 0 0

Solver just ended. Dumping a history of the last processes samples

Child status: 127
Real time (s): 0.0192169
CPU time (s): 0.001553
CPU user time (s): 0.001553
CPU system time (s): 0
CPU usage (%): 8.08143
Max. virtual memory (cumulated for all children) (KiB): 0

getrusage(RUSAGE_CHILDREN,...) data:
user time used= 0.001553
system time used= 0
maximum resident set size= 1152
integral shared memory size= 0
integral unshared data size= 0
integral unshared stack size= 0
page reclaims= 45
page faults= 0
swaps= 0
block input operations= 0
block output operations= 0
messages sent= 0
messages received= 0
signals received= 0
voluntary context switches= 1
involuntary context switches= 0

runsolver used 0.004318 second user time and 0.017272 second system time

The end
