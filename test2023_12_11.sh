#!/bin/bash





timeout_duration="3600"
solver_dir="Solvers"
# output_dir="outputsPcHeythem/${yearRodef}"
# time_dir="TimeSolverPcHeythem/${yearRodef}"
# output_dir="outputsPcHeythem/${yearRodef}"
# time_dir="TimeSolverPcHeythem/${yearRodef}"
evalMaxSatFolder="EvalMaxSAT/bin/EvalMaxSAT"
maxcdclFolder="./MaxCDCL/bin/maxcdcl-scip-maxhs"

chmod +x "$solver_dir/EvalMaxSAT"
chmod +x "$solver_dir/maxcdcl"
chmod +x "$solver_dir/open-wbo"
chmod +x "$evalMaxSatFolder"
chmod +x "$maxcdclFolder"






# echo "start 2023 12 sansZ"
# yearRodef=2023
# max_parallel_sessions=12
# output_dir="outputsSansZ/${yearRodef}"
# time_dir="TimeSolverSansZ/${yearRodef}"
# cnf_file="instanceSansZ/${yearRodef}/${max_parallel_sessions}_session_file_new_format.wcnf"
# cnf_file_old_format="instanceSansZ/${yearRodef}/${max_parallel_sessions}_session_file.wcnf"


# { 
#     time timeout --signal=INT "$timeout_duration" python3 "./myenv/bin/rc2.py" --verbose -s 'cd' "$cnf_file_old_format"  > "$output_dir/${max_parallel_sessions}_session_Rc2_output.txt"
# } 2> "$time_dir/${max_parallel_sessions}_session_Rc2_time.txt"

# { 
#     time timeout "$timeout_duration" "$solver_dir/maxhs" -no-printSoln "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxhs_output.txt"
# } 2> "$time_dir/${max_parallel_sessions}_session_maxhs_time.txt"

# { 
#     time timeout "$timeout_duration" "$solver_dir/cashwmaxsatcoreplus" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_cashwmaxsatcoreplus_output.txt"
# } 2> "$time_dir/${max_parallel_sessions}_session_cashwmaxsatcoreplus_time.txt"


# { 
#     time timeout "$timeout_duration" "$solver_dir/maxcdcl_static" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxcdcl_static_output.txt"
# } 2> "$time_dir/${max_parallel_sessions}_session_maxcdcl_static_time.txt"



# { 
#     time timeout "$timeout_duration" "$solver_dir/open-wbo" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_open-wbo_output.txt"
# } 2> "$time_dir/${max_parallel_sessions}_session_open-wbo_time.txt"

# echo "finish 2023 12 sansZ"



# echo "start 2023 12 with z"
# yearRodef=2023
# max_parallel_sessions=12
# output_dir="outputs/${yearRodef}"
# time_dir="TimeSolver/${yearRodef}"
# cnf_file="instance/${yearRodef}/${max_parallel_sessions}_session_file_new_format.wcnf"
# cnf_file_old_format="instance/${yearRodef}/${max_parallel_sessions}_session_file.wcnf"


# { 
#     time timeout --signal=INT "$timeout_duration" python3 "./myenv/bin/rc2.py" --verbose -s 'cd' "$cnf_file_old_format"  > "$output_dir/${max_parallel_sessions}_session_Rc2_output.txt"
# } 2> "$time_dir/${max_parallel_sessions}_session_Rc2_time.txt"

# { 
#     time timeout "$timeout_duration" "$solver_dir/maxhs" -no-printSoln "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxhs_output.txt"
# } 2> "$time_dir/${max_parallel_sessions}_session_maxhs_time.txt"

# { 
#     time timeout "$timeout_duration" "$solver_dir/cashwmaxsatcoreplus" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_cashwmaxsatcoreplus_output.txt"
# } 2> "$time_dir/${max_parallel_sessions}_session_cashwmaxsatcoreplus_time.txt"


# { 
#     time timeout "$timeout_duration" "$solver_dir/maxcdcl_static" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxcdcl_static_output.txt"
# } 2> "$time_dir/${max_parallel_sessions}_session_maxcdcl_static_time.txt"


# { 
#     time timeout "$timeout_duration" "$solver_dir/open-wbo" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_open-wbo_output.txt"
# } 2> "$time_dir/${max_parallel_sessions}_session_open-wbo_time.txt"

# echo "finish 2023 12 with z"




# echo "starrt 2023 12 with z best enc"
# yearRodef=2023
# max_parallel_sessions=12
# output_dir="outputsChangeEncType/${yearRodef}"
# time_dir="TimeSolverChangeEncType/${yearRodef}"
# cnf_file="instanceChangeEncType/${yearRodef}/${max_parallel_sessions}_session_file_new_format.wcnf"
# cnf_file_old_format="instanceChangeEncType/${yearRodef}/${max_parallel_sessions}_session_file.wcnf"


# { 
#     time timeout --signal=INT "$timeout_duration" python3 "./myenv/bin/rc2.py" --verbose -s 'cd' "$cnf_file_old_format"  > "$output_dir/${max_parallel_sessions}_session_Rc2_output.txt"
# } 2> "$time_dir/${max_parallel_sessions}_session_Rc2_time.txt"

# { 
#     time timeout "$timeout_duration" "$solver_dir/maxhs" -no-printSoln "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxhs_output.txt"
# } 2> "$time_dir/${max_parallel_sessions}_session_maxhs_time.txt"



# { 
#     time timeout "$timeout_duration" "$solver_dir/maxcdcl_static" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxcdcl_static_output.txt"
# } 2> "$time_dir/${max_parallel_sessions}_session_maxcdcl_static_time.txt"



# { 
#     time timeout "$timeout_duration" "$solver_dir/cashwmaxsatcoreplus" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_cashwmaxsatcoreplus_output.txt"
# } 2> "$time_dir/${max_parallel_sessions}_session_cashwmaxsatcoreplus_time.txt"


# { 
#     time timeout "$timeout_duration" "$solver_dir/open-wbo" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_open-wbo_output.txt"
# } 2> "$time_dir/${max_parallel_sessions}_session_open-wbo_time.txt"

# echo "finish 2023 12 with z best enc"







































###################################################11 Parallll Session###########################################################################

echo "start 2023 11 sansZ"
yearRodef=2023
max_parallel_sessions=11
output_dir="outputsSansZ/${yearRodef}"
time_dir="TimeSolverSansZ/${yearRodef}"
cnf_file="instanceSansZ/${yearRodef}/${max_parallel_sessions}_session_file_new_format.wcnf"
cnf_file_old_format="instanceSansZ/${yearRodef}/${max_parallel_sessions}_session_file.wcnf"


{ 
    time timeout --signal=INT "$timeout_duration" python3 "./myenv/bin/rc2.py" --verbose -s 'cd' "$cnf_file_old_format"  > "$output_dir/${max_parallel_sessions}_session_Rc2_output.txt"
} 2> "$time_dir/${max_parallel_sessions}_session_Rc2_time.txt"

{ 
    time timeout "$timeout_duration" "$solver_dir/maxhs" -no-printSoln "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxhs_output.txt"
} 2> "$time_dir/${max_parallel_sessions}_session_maxhs_time.txt"

{ 
    time timeout "$timeout_duration" "$solver_dir/cashwmaxsatcoreplus" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_cashwmaxsatcoreplus_output.txt"
} 2> "$time_dir/${max_parallel_sessions}_session_cashwmaxsatcoreplus_time.txt"


{ 
    time timeout "$timeout_duration" "$solver_dir/maxcdcl_static" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxcdcl_static_output.txt"
} 2> "$time_dir/${max_parallel_sessions}_session_maxcdcl_static_time.txt"



{ 
    time timeout "$timeout_duration" "$solver_dir/open-wbo" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_open-wbo_output.txt"
} 2> "$time_dir/${max_parallel_sessions}_session_open-wbo_time.txt"

echo "finish 2023 11 sansZ"



echo "start 2023 11 with z"
yearRodef=2023
max_parallel_sessions=11
output_dir="outputs/${yearRodef}"
time_dir="TimeSolver/${yearRodef}"
cnf_file="instance/${yearRodef}/${max_parallel_sessions}_session_file_new_format.wcnf"
cnf_file_old_format="instance/${yearRodef}/${max_parallel_sessions}_session_file.wcnf"


{ 
    time timeout --signal=INT "$timeout_duration" python3 "./myenv/bin/rc2.py" --verbose -s 'cd' "$cnf_file_old_format"  > "$output_dir/${max_parallel_sessions}_session_Rc2_output.txt"
} 2> "$time_dir/${max_parallel_sessions}_session_Rc2_time.txt"

{ 
    time timeout "$timeout_duration" "$solver_dir/maxhs" -no-printSoln "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxhs_output.txt"
} 2> "$time_dir/${max_parallel_sessions}_session_maxhs_time.txt"

{ 
    time timeout "$timeout_duration" "$solver_dir/cashwmaxsatcoreplus" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_cashwmaxsatcoreplus_output.txt"
} 2> "$time_dir/${max_parallel_sessions}_session_cashwmaxsatcoreplus_time.txt"


{ 
    time timeout "$timeout_duration" "$solver_dir/maxcdcl_static" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxcdcl_static_output.txt"
} 2> "$time_dir/${max_parallel_sessions}_session_maxcdcl_static_time.txt"


{ 
    time timeout "$timeout_duration" "$solver_dir/open-wbo" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_open-wbo_output.txt"
} 2> "$time_dir/${max_parallel_sessions}_session_open-wbo_time.txt"

echo "finish 2023 11 with z"




echo "starrt 2023 11 with z best enc"
yearRodef=2023
max_parallel_sessions=11
output_dir="outputsChangeEncType/${yearRodef}"
time_dir="TimeSolverChangeEncType/${yearRodef}"
cnf_file="instanceChangeEncType/${yearRodef}/${max_parallel_sessions}_session_file_new_format.wcnf"
cnf_file_old_format="instanceChangeEncType/${yearRodef}/${max_parallel_sessions}_session_file.wcnf"


{ 
    time timeout --signal=INT "$timeout_duration" python3 "./myenv/bin/rc2.py" --verbose -s 'cd' "$cnf_file_old_format"  > "$output_dir/${max_parallel_sessions}_session_Rc2_output.txt"
} 2> "$time_dir/${max_parallel_sessions}_session_Rc2_time.txt"

{ 
    time timeout "$timeout_duration" "$solver_dir/maxhs" -no-printSoln "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxhs_output.txt"
} 2> "$time_dir/${max_parallel_sessions}_session_maxhs_time.txt"



{ 
    time timeout "$timeout_duration" "$solver_dir/maxcdcl_static" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxcdcl_static_output.txt"
} 2> "$time_dir/${max_parallel_sessions}_session_maxcdcl_static_time.txt"



{ 
    time timeout "$timeout_duration" "$solver_dir/cashwmaxsatcoreplus" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_cashwmaxsatcoreplus_output.txt"
} 2> "$time_dir/${max_parallel_sessions}_session_cashwmaxsatcoreplus_time.txt"


{ 
    time timeout "$timeout_duration" "$solver_dir/open-wbo" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_open-wbo_output.txt"
} 2> "$time_dir/${max_parallel_sessions}_session_open-wbo_time.txt"

echo "finish 2023 11 with z best enc"
