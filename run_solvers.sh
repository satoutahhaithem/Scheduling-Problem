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



{
    { timeout 5s "$solver_dir/maxcdcl_static" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxcdcl_output.txt"; } 2> >(if grep -q "timeout"; then echo "timeout" > "$output_dir/${max_parallel_sessions}_time_maxcdcl.txt"; fi)
    { time "$solver_dir/maxcdcl_static" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxcdcl_output.txt"; } 2>> "$output_dir/${max_parallel_sessions}_time_maxcdcl.txt"
} 2> /dev/null


{
    { timeout 5s "$solver_dir/open-wbo" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_open-wbo_output.txt"; } 2> >(if grep -q "timeout"; then echo "timeout" > "$output_dir/${max_parallel_sessions}_time_open-wbo.txt"; fi)
    { time "$solver_dir/open-wbo" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_open-wbo_output.txt"; } 2>> "$output_dir/${max_parallel_sessions}_time_open-wbo.txt"
} 2> /dev/null


{
    { timeout 5 "$solver_dir/EvalMaxSAT" "$cnf_file" > "$output_dir/${max_parallel_sessions}_session_EvalMaxSAT_output.txt"; } 2> >(if grep -q "timeout"; then echo "timeout" > "$output_dir/${max_parallel_sessions}_time_EvalMaxSAT.txt"; fi)
    { time "$solver_dir/EvalMaxSAT" "$cnf_file" > "$output_dir/${max_parallel_sessions}_session_EvalMaxSAT_output.txt"; } 2>> "$output_dir/${max_parallel_sessions}_time_EvalMaxSAT.txt"
} 2> /dev/null

echo "Execution times and outputs recorded in respective files."