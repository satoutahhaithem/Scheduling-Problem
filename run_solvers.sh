#!/bin/bash

max_parallel_sessions="15"
yearRodef="2023"
cnf_file="instance/${yearRodef}/${max_parallel_sessions}_session_file_new_format.wcnf"
cnf_file_old_format="instance/${yearRodef}/${max_parallel_sessions}_session_file.wcnf"

timeout_duration="3600s"
solver_dir="Solvers"
# output_dir="outputs/${yearRodef}"
# time_dir="TimeSolver/${yearRodef}"
output_dir="outputsPcHeythem/${yearRodef}"
time_dir="TimeSolverPcHeythem/${yearRodef}"
evalMaxSatFolder="EvalMaxSAT/bin/EvalMaxSAT"
maxcdclFolder="./MaxCDCL/bin/maxcdcl-scip-maxhs"

chmod +x "$solver_dir/EvalMaxSAT"
chmod +x "$solver_dir/maxcdcl_static"
chmod +x "$solver_dir/open-wbo"
chmod +x "$evalMaxSatFolder"
chmod +x "$maxcdclFolder"

# This command of rc2 is "rc2.py -s 'cd' instance/2023/10_session_file.wcnf" for 10 par exemple work with rc2.py

{ 
    time timeout "$timeout_duration" rc2.py -s 'cd' "$cnf_file_old_format"  > "$output_dir/${max_parallel_sessions}_session_Rc2_output.txt"
} 2> "$time_dir/${max_parallel_sessions}_session_Rc2_time.txt"


{ 
    time timeout "$timeout_duration" "$solver_dir/maxcdcl_static" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxcdcl_output.txt"
} 2> "$time_dir/${max_parallel_sessions}_session_maxcdcl_time.txt"

{ 
    time timeout "$timeout_duration" "$solver_dir/EvalMaxSAT" "$cnf_file" > "$output_dir/${max_parallel_sessions}_session_EvalMaxSAT_output.txt"
} 2> "$time_dir/${max_parallel_sessions}_session_EvalMaxSAT_time.txt"


{ 
    time timeout "$timeout_duration" "$solver_dir/open-wbo" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_open-wbo_output.txt"
} 2> "$time_dir/${max_parallel_sessions}_session_open-wbo_time.txt"





echo "Execution times and outputs recorded in respective files."






############################################################################################################

# This command of rc2 work with python script  rc2Solver.py i write it 

# { 
#     time timeout "$timeout_duration" python3 "rc2Solver.py" "$cnf_file_old_format"  > "$output_dir/${max_parallel_sessions}_session_Rc2_output.txt"
# } 2> "$time_dir/${max_parallel_sessions}_session_Rc2_time.txt"


# { 
#     time timeout "$timeout_duration" "$evalMaxSatFolder" --timeUB 0 --minRefTime 5 "$cnf_file" > "$output_dir/${max_parallel_sessions}_session_EvalMaxSAT_SCIP_output.txt"
# } 2> "$time_dir/${max_parallel_sessions}_session_EvalMaxSAT_SCIP_time.txt"

# { 
#     time timeout "$timeout_duration" "$maxcdclFolder" "$wcnf_file" 600 1200 > "$output_dir/${max_parallel_sessions}_session_WMaxCDCL-S6-HS12_output.txt"
# } 2> "$time_dir/${max_parallel_sessions}_session_WMaxCDCL-S6-HS12_time.txt"