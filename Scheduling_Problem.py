import numpy as np
from pysat.formula import *
from pysat.pb import EncType as pbenc
from pysat.pb import *
from pysat.card import *
from pysat.solvers import *
from pysat.examples.rc2 import RC2
from pysat.formula import WCNF
# Conference scheduling parameters
conference_sessions = 40
slots = 7
papers_range = [3,4,5,6]
max_parallel_sessions = 11
working_groups = 20 
np= [14,23,12,9,9,6,10,4,10,7,6,5,3,5,6,4,3,12,7,16,4,5,14,11,4,3,10,6,6,4,13,3,4,9,5,4,11,6,6,8]
npMax = [4, 6, 6, 4, 4, 5,  3]
length_of_paper_range = len(papers_range)
globalEncType = EncType.sortnetwrk




# Define the working groups associated with each session
session_groups = [
    [1], [2], [3], [], [], [], [6], [7], [7, 8], [10], [8], [8, 11], [5, 8], 
    [3, 8], [7], [13], [13], [14], [], [8], [16], [16], [20], [17], [13], 
    [], [9], [11], [11, 12], [9], [6, 19], [], [], [18], [10], [5], [16], 
    [4, 5], [8, 12], [7, 15]
]



# Initialize the weighted clause normal form (WCNF) for the constraints
constraints = WCNF()


# Function to compute variable index for session-slot-paper combination
def var_x(s, c, l):
    return (s-1)*slots *length_of_paper_range  + (c-1)*length_of_paper_range + l
    
    

# Function to decode the variable index back to session, slot, and paper count
def decode_var_x(x, slots, papers_range_length):
    # Adjust for 1-indexing
    x -= 1  
    l = x % papers_range_length + 1
    x //= papers_range_length
    c = x % slots + 1
    s = x // slots + 1
    return s, c, l

# Compute the maximum index for var_x
max_var_x = var_x(conference_sessions, slots, length_of_paper_range)


# Function to compute variable index for session-slot (z variable)
def var_z(s, c): 
    return max_var_x + (s - 1) * slots + c

# Define the last variable 
max_var_z = var_z(conference_sessions, slots)   

y_var = max_var_z  



# First Constraint: At most one amount of papers chosen for a (session, slot) pair
for s in range(1, conference_sessions + 1):
    for c in range(1, slots + 1):
        vars_for_s_c = []
        for l in range(1 , length_of_paper_range + 1):
            vars_for_s_c.append(var_x(s, c, l))
        amo_clause = CardEnc.atmost(lits=vars_for_s_c, bound=1, top_id=y_var,encoding=globalEncType) 
        y_var=amo_clause.nv
        constraints.extend(amo_clause.clauses)
####################################################################################        





# Second Constraint: Subdivision of a session into slots covers all the papers in the session
for s in range(1, conference_sessions +1):
    aux_vars = []  
    aux_weight = []  
    for c in range(1,slots + 1):
        for l in range(1,length_of_paper_range+1):
            aux_vars.append(var_x(s, c, l))
            aux_weight.append(papers_range[l-1])
    eq_clause = PBEnc.equals(lits=aux_vars, weights=aux_weight,bound=np[s-1], top_id=y_var, encoding=pbenc.sortnetwrk)
    y_var=eq_clause.nv
    constraints.extend(eq_clause.clauses)
####################################################################################





# Third Constraint : The subdivision respects the maximum length of each slot
for s in range(1, conference_sessions + 1):
    for c in range(1, slots + 1):
        for l in range(1,length_of_paper_range+1):
            if papers_range[l-1] > npMax[c-1]:
               # I create a constraint using the negation of x when l exceeds npMax(c).
                constraints.append([-var_x(s, c, l)])
####################################################################################
                



# Fourth Constraint: Number of parallel sessions is not exceeded for each slot
for c in range(1, slots + 1):
    neg_z_vars = []
    for s in range(1, conference_sessions + 1):
        neg_z_vars.append(-var_z(s, c))
    atmost_clause = CardEnc.atmost(lits=neg_z_vars, bound=max_parallel_sessions, top_id=y_var, encoding=globalEncType)
    y_var=atmost_clause.nv
    constraints.extend(atmost_clause.clauses)
####################################################################################




# Implementing the equivalence transformation for session-slot (z variable)
for s in range(1, conference_sessions + 1):
    for c in range(1, slots + 1):
        z_var = var_z(s, c)
        x_vars=[]
        for l in range(1,length_of_paper_range+1):
            x_vars.append(var_x(s, c, l))
        or_clause = x_vars + [z_var]
        constraints.append(or_clause)

        for x in x_vars:
            constraints.append([-z_var, -x])
####################################################################################
            




# Soft Constraints to Minimize Working-Group Conflicts

# Iterate over all possible pairs of sessions (s1, s2), ensuring s1 is less than s2 to avoid duplicates
for s1 in range(1, conference_sessions + 1):

    for s2 in range(s1 + 1, conference_sessions + 1):  # Ensure s1 < s2
        # Identify common working groups between the two sessions     
        common_groups = set(session_groups[s1 - 1]).intersection(session_groups[s2 - 1])

        # For each slot, check if the common groups between these two sessions lead to a conflict
        for c in range(1, slots + 1):
            for g in common_groups:
                # Create a new variable for each potential conflict (increment y_var)
                y_var = y_var + 1
                # Add a soft constraint for this potential conflict with a weight of 1.
                # This means the solver will try to avoid this situation but can still accept it at a cost
                constraints.append([-y_var], weight=1)  
                # Hard Constraint : Add a constraint to indicate a conflict if both sessions s1 and s2 are scheduled in the same slot c. 
                constraints.append([var_z(s1,c),var_z(s2,c),y_var])
####################################################################################



# Specific Constraint for Session 34:
# This constraint ensures that session 34 is assigned only to slots 5, 6, or 7.
for i in range (1,5):
    constraints.append([var_z(34,i)])
####################################################################################

constraints.to_file("file.cnf")




# Assuming other parts of your code (constraint definitions, SAT model setup) are correctly implemented

def display_assignments_by_slot_with_counts(model, slots, papers_range, conference_sessions):
    slot_assignments = {c: {} for c in range(1, slots + 1)}  # Initialize dictionaries for each slot

    # Processing the model to populate slot assignments
    for var in range(max_var_x):
        modelI= model[var]
        if modelI > 0:
            s, c, l = decode_var_x(model[var], slots, length_of_paper_range)
            print(f"  Conference Session {s} in slot {c} with {papers_range[l-1]} papers ")          
        



with RC2(constraints, solver="Cadical153") as solver:
    for model in solver.enumerate():
        print('Model has cost:', solver.cost)
        # print('Model:', solver.model)

        display_assignments_by_slot_with_counts(model, slots, papers_range, conference_sessions)
        break  # Process only the first model

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
old_file_path = 'file.cnf'
new_file_path = 'file_new_format.cnf'

# Call the function to convert the file format
convert_cnf_format(old_file_path, new_file_path)

