#!/bin/bash

max_parallel_sessions="11"
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

"$solver_dir/EvalMaxSAT" "$cnf_file" > "$output_dir/${max_parallel_sessions}_session_EvalMaxSAT.txt"
# "$evalMaxSatFolder" --timeUB 0 --minRefTime 5 "$cnf_file_old_format" > "outputs/${max_parallel_sessions}_session_EvalMaxSAT-SCIPT.txt"
"$solver_dir/open-wbo" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_open-wbo.txt"
"$solver_dir/maxcdcl_static" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxcdcl.txt"

echo "Outputs saved in the $output_dir directory."
