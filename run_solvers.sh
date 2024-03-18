#!/bin/bash

max_parallel_sessions="10"
cnf_file="instance/${max_parallel_sessions}_session_file_new_format.cnf"
cnf_file_old_format="instance/${max_parallel_sessions}_session_file.cnf"

solver_dir="Solvers"
output_dir="outputs"
evalMaxSatFolder="./EvalMaxSAT/bin/EvalMaxSAT"
maxcdclFolder="./MaxCDCL/bin/maxcdcl-scip-maxhs"

chmod +x "$solver_dir/EvalMaxSAT"
chmod +x "$solver_dir/maxcdcl_static"
chmod +x "$solver_dir/open-wbo"
chmod +x "$evalMaxSatFolder"
chmod +x "$maxcdclFolder"




{
    time "$solver_dir/open-wbo" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_open-wbo_output.txt"
} 2> "$output_dir/${max_parallel_sessions}_time_open-wbo.txt"


{
    time "$solver_dir/maxcdcl_static" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxcdcl_output.txt"
} 2> "$output_dir/${max_parallel_sessions}_time_maxcdcl.txt"


{
    time "$solver_dir/EvalMaxSAT" "$cnf_file" > "$output_dir/${max_parallel_sessions}_session_EvalMaxSAT_output.txt"
} 2> "$output_dir/${max_parallel_sessions}_time_EvalMaxSAT.txt"

# {
#     time "$evalMaxSatFolder" --timeUB 0 --minRefTime 5 "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_EvalMaxSAT-SCIPT_output.txt"
# } 2> "$output_dir/${max_parallel_sessions}_time_EvalMaxSAT-SCIPT.txt"


echo "Execution times and outputs recorded in respective files."
