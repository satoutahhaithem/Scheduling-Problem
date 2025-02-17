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

for yearRodef in {2021..2024}; do
    if [[ "$yearRodef" -eq 2024 || "$yearRodef" -eq 2023 || "$yearRodef" -eq 2021 ]]; then
    # if [ "$yearRodef" -eq 2022 ]; then
        continue  # Skip the rest of the loop for year 2022
    fi
    max_parallel_sessions_range_2024=($(seq 15 -1 10))
    max_parallel_sessions_range_2023=($(seq 18 -1 13))
    max_parallel_sessions_range_2022=($(seq 16 -1 11))
    max_parallel_sessions_range_2021=($(seq 10 -1 5))
    case $yearRodef in
        2024)
            max_parallel_sessions_range=("${max_parallel_sessions_range_2024[@]}")
            ;;
        2023)
            max_parallel_sessions_range=("${max_parallel_sessions_range_2023[@]}")
            ;;
        2022)
            max_parallel_sessions_range=("${max_parallel_sessions_range_2022[@]}")
            ;;
        2021)
            max_parallel_sessions_range=("${max_parallel_sessions_range_2021[@]}")
            ;;
        *)
            echo "Year not supported"
            exit 1
    esac
    output_dir="outputsSansZ/${yearRodef}"
    time_dir="TimeSolverSansZ/${yearRodef}"
    # output_dir="outputsPcHeythemSansZ/${yearRodef}"
    # time_dir="TimeSolverPcHeythemSansZ/${yearRodef}"
    for max_parallel_sessions in "${max_parallel_sessions_range[@]}"; do
        cnf_file="instanceSansZ/${yearRodef}/${max_parallel_sessions}_session_file_new_format.wcnf"
        cnf_file_old_format="instanceSansZ/${yearRodef}/${max_parallel_sessions}_session_file.wcnf"

        # This command of rc2 is "rc2.py -s 'cd' instance/2023/10_session_file.wcnf" for 10 par exemple work with rc2.py

        # { 
        #     time timeout "$timeout_duration" "$solver_dir/maxcdcl_static" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxcdcl_static_output.txt"
        # } 2> "$time_dir/${max_parallel_sessions}_session_maxcdcl_static_time.txt"

        # { 
        #     time timeout "$timeout_duration" "$solver_dir/EvalMaxSAT" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_EvalMaxSAT_output.txt"
        # } 2> "$time_dir/${max_parallel_sessions}_session_EvalMaxSAT_time.txt"
        echo $year
        # { 
        #     time timeout "$timeout_duration" "$solver_dir/open-wbo" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_open-wbo_output.txt"
        # } 2> "$time_dir/${max_parallel_sessions}_session_open-wbo_time.txt"

        # { 
        #     time timeout "$timeout_duration" "$solver_dir/maxhs" -no-printSoln "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxhs_output.txt"
        # } 2> "$time_dir/${max_parallel_sessions}_session_maxhs_time.txt"
        
        # { 
        # time timeout "$timeout_duration" python3 "rc2Solver.py" "$cnf_file_old_format"  > "$output_dir/${max_parallel_sessions}_session_Rc2_output.txt"
        #  } 2> "$time_dir/${max_parallel_sessions}_session_Rc2_time.txt"

        # { 
        #     time timeout "$timeout_duration" "$solver_dir/cashwmaxsatcoreplus" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_cashwmaxsatcoreplus_output.txt"
        # } 2> "$time_dir/${max_parallel_sessions}_session_cashwmaxsatcoreplus_time.txt"



    done


        echo "Execution times Without Z and outputs for year $yearRodef recorded in respective files."
done



for yearRodef in {2021..2024}; do
    if [[ "$yearRodef" -eq 2024 || "$yearRodef" -eq 2023 || "$yearRodef" -eq 2021 ]]; then
        continue  # Skip the rest of the loop for year 2022
    fi
    max_parallel_sessions_range_2024=($(seq 15 -1 10))
    max_parallel_sessions_range_2023=($(seq 18 -1 13))
    max_parallel_sessions_range_2022=($(seq 16 -1 11))
    max_parallel_sessions_range_2021=($(seq 10 -1 5))
    case $yearRodef in
        2024)
            max_parallel_sessions_range=("${max_parallel_sessions_range_2024[@]}")
            ;;
        2023)
            max_parallel_sessions_range=("${max_parallel_sessions_range_2023[@]}")
            ;;
        2022)
            max_parallel_sessions_range=("${max_parallel_sessions_range_2022[@]}")
            ;;
        2021)
            max_parallel_sessions_range=("${max_parallel_sessions_range_2021[@]}")
            ;;
        *)
            echo "Year not supported"
            exit 1
    esac
    output_dir="outputs/${yearRodef}"
    time_dir="TimeSolver/${yearRodef}"
    # output_dir="outputsPcHeythemSansZ/${yearRodef}"
    # time_dir="TimeSolverPcHeythemSansZ/${yearRodef}"
    for max_parallel_sessions in "${max_parallel_sessions_range[@]}"; do
        cnf_file="instance/${yearRodef542717}/${max_parallel_sessions}_session_file_new_format.wcnf"
        cnf_file_old_format="instance/${yearRodef}/${max_parallel_sessions}_session_file.wcnf"

        # This command of rc2 is "rc2.py -s 'cd' instance/2023/10_session_file.wcnf" for 10 par exemple work with rc2.py
        
        # { 
        #     time timeout --signal=INT "$timeout_duration" python3 "./myenv/bin/rc2.py" --verbose -s 'cd' "$cnf_file_old_format"  > "$output_dir/${max_parallel_sessions}_session_Rc2_output.txt"
        # } 2> "$time_dir/${max_parallel_sessions}_session_Rc2_time.txt"

        # { 
        #     time timeout "$timeout_duration" "$solver_dir/maxcdcl_static" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxcdcl_static_output.txt"
        # } 2> "$time_dir/${max_parallel_sessions}_session_maxcdcl_static_time.txt"

        # { 
        #     time timeout "$timeout_duration" "$solver_dir/EvalMaxSAT" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_EvalMaxSAT_output.txt"
        # } 2> "$time_dir/${max_parallel_sessions}_session_EvalMaxSAT_time.txt"
        echo $year


        # { 
        #     time timeout "$timeout_duration" "$solver_dir/open-wbo" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_open-wbo_output.txt"
        # } 2> "$time_dir/${max_parallel_sessions}_session_open-wbo_time.txt"

        # { 
        #     time timeout "$timeout_duration" "$solver_dir/maxhs" -no-printSoln "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxhs_output.txt"
        # } 2> "$time_dir/${max_parallel_sessions}_session_maxhs_time.txt"

        # { 
        #     time timeout "$timeout_duration" "$solver_dir/cashwmaxsatcoreplus" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_cashwmaxsatcoreplus_output.txt"
        # } 2> "$time_dir/${max_parallel_sessions}_session_cashwmaxsatcoreplus_time.txt"

        
        

    done


        echo "Execution times  With Z and outputs for year $yearRodef recorded in respective files."
done



for yearRodef in {2021..2024}; do
    if [[ "$yearRodef" -eq 2024 || "$yearRodef" -eq 2023 || "$yearRodef" -eq 2021 ]]; then
        continue  # Skip the rest of the loop for year 2022
    fi
    max_parallel_sessions_range_2024=($(seq 15 -1 10))
    max_parallel_sessions_range_2023=($(seq 18 -1 13))
    max_parallel_sessions_range_2022=($(seq 16 -1 11))
    max_parallel_sessions_range_2021=($(seq 10 -1 5))
    case $yearRodef in
        2024)
            max_parallel_sessions_range=("${max_parallel_sessions_range_2024[@]}")
            ;;
        2023)
            max_parallel_sessions_range=("${max_parallel_sessions_range_2023[@]}")
            ;;
        2022)
            max_parallel_sessions_range=("${max_parallel_sessions_range_2022[@]}")
            ;;
        2021)
            max_parallel_sessions_range=("${max_parallel_sessions_range_2021[@]}")
            ;;
        *)
            echo "Year not supported"
            exit 1
    esac
    output_dir="outputsChangeEncType/${yearRodef}"
    time_dir="TimeSolverChangeEncType/${yearRodef}"
    # output_dir="outputsPcHeythemSansZ/${yearRodef}"
    # time_dir="TimeSolverPcHeythemSansZ/${yearRodef}"
    for max_parallel_sessions in "${max_parallel_sessions_range[@]}"; do
        cnf_file="instanceChangeEncType/${yearRodef542717}/${max_parallel_sessions}_session_file_new_format.wcnf"
        cnf_file_old_format="instanceChangeEncType/${yearRodef}/${max_parallel_sessions}_session_file.wcnf"

        # This command of rc2 is "rc2.py -s 'cd' instance/2023/10_session_file.wcnf" for 10 par exemple work with rc2.py
        
        # { 
        #     time timeout --signal=INT "$timeout_duration" python3 "./myenv/bin/rc2.py" --verbose -s 'cd' "$cnf_file_old_format"  > "$output_dir/${max_parallel_sessions}_session_Rc2_output.txt"
        # } 2> "$time_dir/${max_parallel_sessions}_session_Rc2_time.txt"

        # { 
        #     time timeout "$timeout_duration" "$solver_dir/maxcdcl_static" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxcdcl_static_output.txt"
        # } 2> "$time_dir/${max_parallel_sessions}_session_maxcdcl_static_time.txt"

        # { 
        #     time timeout "$timeout_duration" "$solver_dir/EvalMaxSAT" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_EvalMaxSAT_output.txt"
        # } 2> "$time_dir/${max_parallel_sessions}_session_EvalMaxSAT_time.txt"
        echo $year


        # { 
        #     time timeout "$timeout_duration" "$solver_dir/open-wbo" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_open-wbo_output.txt"
        # } 2> "$time_dir/${max_parallel_sessions}_session_open-wbo_time.txt"

        # { 
        #     time timeout "$timeout_duration" "$solver_dir/maxhs" -no-printSoln "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_maxhs_output.txt"
        # } 2> "$time_dir/${max_parallel_sessions}_session_maxhs_time.txt"

        # { 
        #     time timeout "$timeout_duration" "$solver_dir/cashwmaxsatcoreplus" "$cnf_file_old_format" > "$output_dir/${max_parallel_sessions}_session_cashwmaxsatcoreplus_output.txt"
        # } 2> "$time_dir/${max_parallel_sessions}_session_cashwmaxsatcoreplus_time.txt"

        
        

    done


        echo "Execution times  With Z and outputs for year $yearRodef recorded in respective files."
done