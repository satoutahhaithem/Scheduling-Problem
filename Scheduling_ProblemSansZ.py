import numpy as np
from pysat.formula import WCNF, IDPool
from pysat.pb import PBEnc
from pysat.card import CardEnc
from pysat.examples.rc2 import RC2
from data import *
import sys
if len(sys.argv) < 3:
    print("You must write the year roadef as a second parameter and maxparrallel session as third parameter 'for exemple python3 Scheduling_Problem.py 2024 11'")
    sys.exit(1)  # Exit the script with an error code

# Extract the year of roadef from the command-line arguments
data_set_choice = sys.argv[1]
max_parallel_sessions = int(sys.argv[2])
# Check if a command line argument is provided
if len(sys.argv) > 1:
    data_set_choice = sys.argv[1]

# Choose data set based on the argument
if data_set_choice == "2024":
    if (max_parallel_sessions < 9 ): 
        print ("max_parallel_sessions must more than 9")
        sys.exit(1) 
    else:
        conference_sessions, slots, papers_range, working_groups, np, npMax, session_groups = data_for_2024() 
elif data_set_choice == "2023":
    if (max_parallel_sessions < 12 ): 
        print ("max_parallel_sessions must be more than 12")
        sys.exit(1) 
    else:
        conference_sessions, slots, papers_range, working_groups, np, npMax, session_groups = data_for_2023() 
elif data_set_choice == "2022":
    if (max_parallel_sessions < 11 ): 
        print ("max_parallel_sessions must be more than 11")
        sys.exit(1) 
    else:
        conference_sessions, slots, papers_range, working_groups, np, npMax, session_groups = data_for_2022() 
elif  data_set_choice == "2021":
    if (max_parallel_sessions < 5 ): 
        print ("max_parallel_sessions must be more than 5")
        sys.exit(1) 
    else:
        conference_sessions, slots, papers_range, working_groups, np, npMax, session_groups = data_for_2021()  
else:
    print("The data available for 2024 , 2023 , 2022 and 2021 only")
    sys.exit(1)


# Variable pool for creating new variables
vpool = IDPool()

# Initialize the weighted clause normal form (WCNF) for the constraints
constraints = WCNF()

# Function to compute variable index for session-slot-paper combination
def var_x(s, c, l):
    return vpool.id(f'x_{s}_{c}_{l}')

# Function to create and retrieve conflict variable
def var_y(s1, s2, c):
    return vpool.id(f'y_{s1}_{s2}_{c}')

# First Constraint: At most one amount of papers chosen for a (session, slot) pair
for s in range(1, conference_sessions + 1):
    for c in range(1, slots + 1):
        vars_for_s_c = [var_x(s, c, l) for l in range(1, len(papers_range) + 1)]
        constraints.extend(CardEnc.atmost(vars_for_s_c, 1).clauses)

# Second Constraint: Subdivision of a session into slots covers all the papers in the session
for s in range(1, conference_sessions + 1):
    aux_vars = [var_x(s, c, l) for c in range(1, slots + 1) for l in range(1, len(papers_range) + 1)]
    aux_weights = [papers_range[l-1] for c in range(1, slots + 1) for l in range(1, len(papers_range) + 1)]
    constraints.extend(PBEnc.equals(lits=aux_vars, weights=aux_weights, bound=np[s-1]).clauses)

# Third Constraint: Respects the maximum length of each slot
for s in range(1, conference_sessions + 1):
    for c in range(1, slots + 1):
        for l, paper in enumerate(papers_range, 1):
            if paper > npMax[c-1]:
                constraints.append([-var_x(s, c, l)])

for c in range(1, slots + 1):
    x_vars = []
    for s in range(1, conference_sessions + 1):
        for l in range(1, len(papers_range) + 1):
            x_vars.append(var_x(s, c, l))
    constraints.extend(CardEnc.atmost(x_vars, max_parallel_sessions).clauses)
    
# Soft Constraints to Minimize Working-Group Conflicts
for s1 in range(1, conference_sessions + 1):
    for s2 in range(s1 + 1, conference_sessions + 1):
        common_groups = set(session_groups[s1 - 1]).intersection(session_groups[s2 - 1])
        for c in range(1, slots + 1):
            if common_groups:
                y_var = var_y(s1, s2, c)
                constraints.append([-y_var], weight=1)
                for l in range(1, len(papers_range) + 1):
                    constraints.append([-var_x(s1, c, l), -var_x(s2, c, l), y_var])

# Write constraints to a file
constraints.to_file(f"instance/sansZ/{data_set_choice}/{max_parallel_sessions}_session_file.wcnf")

# Solver setup and solution
with RC2(constraints, solver="Cadical153") as solver:
    for model in solver.enumerate():
        print('Model has cost:', solver.cost)
        # print('Model:', solver.model)

        # display_assignments_by_slot_with_counts(model, slots, papers_range, conference_sessions)
        break  
def convert_cnf_format(old_file_path, new_file_path):
    with open(old_file_path, 'r') as old_file, open(new_file_path, 'w') as new_file:
        for line in old_file:
            # Check if the line starts with 'p wcnf'
            if line.startswith('p wcnf'):
                # Remove 'p wcnf' from the line and prepend 'h'
                new_line = 'h ' + line.split(' ', 2)[2]
                new_file.write(new_line)
            else:
                # Write the line to the new file as is
                new_file.write(line)

# Specify the old and new file paths
old_file_path = "./instance/"+data_set_choice+"sansZ/"+str(max_parallel_sessions)+"_session_file.wcnf"
new_file_path = "./instance/"+data_set_choice+"sansZ/"+str(max_parallel_sessions)+'_session_file_new_format.wcnf'

# Call the function to convert the file format
convert_cnf_format(old_file_path, new_file_path)
