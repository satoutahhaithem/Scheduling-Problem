#!/bin/bash

max_parallel_sessions="9"
cnf_file="instance/${max_parallel_sessions}_session_file_new_format.cnf"
wcnf_file="instance/${max_parallel_sessions}_session_file.wcnf"
cnf_file_old_format="instance/${max_parallel_sessions}_session_file.cnf"

timeout_duration="3600s"
solver_dir="Solvers"
output_dir="outputs"
time_dir="TimeSover"
evalMaxSatFolder="EvalMaxSAT/bin/EvalMaxSAT"
maxcdclFolder="./MaxCDCL/bin/maxcdcl-scip-maxhs"

chmod +x "$solver_dir/EvalMaxSAT"
chmod +x "$solver_dir/maxcdcl_static"
chmod +x "$solver_dir/open-wbo"
chmod +x "$evalMaxSatFolder"
chmod +x "$maxcdclFolder"


{ 
    time timeout "$timeout_duration" python3 "rc2Solver.py" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_Rc2_output.txt"
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


{ 
    time timeout "$timeout_duration" "$evalMaxSatFolder" --timeUB 0 --minRefTime 5 "$cnf_file" > "$output_dir/${max_parallel_sessions}_session_EvalMaxSAT_SCIP_output.txt"
} 2> "$time_dir/${max_parallel_sessions}_session_EvalMaxSAT_SCIP_time.txt"

{ 
    time timeout "$timeout_duration" "$maxcdclFolder" "$wcnf_file" 600 1200 > "$output_dir/${max_parallel_sessions}_session_WMaxCDCL-S6-HS12_output.txt"
} 2> "$time_dir/${max_parallel_sessions}_session_WMaxCDCL-S6-HS12_time.txt"


echo "Execution times and outputs recorded in respective files."
