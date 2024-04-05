def data_for_2024():
    conference_sessions = 40
    slots = 7
    papers_range = [3,4,5,6]
    max_parallel_sessions = 11
    working_groups = 20
    np = [14,23,12,9,9,6,10,4,10,7,6,5,3,5,6,4,3,12,7,16,4,5,14,11,4,3,10,6,6,4,13,3,4,9,5,4,11,6,6,8]
    npMax = [4, 6, 6, 4, 4, 5, 3]
    session_groups = [
        [1], [2], [3], [], [], [], [6], [7], [7, 8], [10], [8], [8, 11], [5, 8], 
        [3, 8], [7], [13], [13], [14], [], [8], [16], [16], [20], [17], [13], 
        [], [9], [11], [11, 12], [9], [6, 19], [], [], [18], [10], [5], [16], 
        [4, 5], [8, 12], [7, 15]
    ]
    return conference_sessions, slots, papers_range, max_parallel_sessions, working_groups, np, npMax, session_groups





def data_for_2023():
    conference_sessions = 47
    slots = 7
    papers_range = [3,4,5,6]
    max_parallel_sessions =20
    working_groups = 24 
    np= [6,3,7,8,8,4,12,4,15,10,11,12,14,12,8,10,8,5,3,12,3,11,11,3,11,3,6,3,3,3,10,4,6,4,4,5,3,7,3,6,7,12,8,17,6,10,17,2]
    npMax = [5,4,4,6,5,4,4]

    # Define the working groups associated with each session
    session_groups = [  
        [17],[7],[13],[5],[4],[],[18,6,22],[18,6],[8],[9],[5],[12],[],[7],[16],[23],[13],[4],[],[],[9,5],
        [2,18],[],[11],[3],[18],[18,6],[5,8],[16,3],[19],[14],[5],[20,15,21],[10],[10],[13],[2,5],[],[],
        [5],[8,9],[7],[13],[5,4],[18,6],[9],[1,24]
    ]
    return conference_sessions, slots, papers_range, max_parallel_sessions, working_groups, np, npMax, session_groups




def data_for_2022():
    conference_sessions = 43
    slots = 8
    papers_range = [3,4,5]
    max_parallel_sessions = 20
    working_groups = 15 
    np= [4,5,5,5,5,9,9,5,4,12,16,20,4,7,11,4,4,8,12,11,6,6,6,5,6,7,7,4,12,4,4,8,7,9,3,3,6,7,12,4,4,4,4]
    npMax = [5,4,3,4,3,4,4,4]

    # Define the working groups associated with each session
    session_groups = [
    [6,17], [8,5,17], [], [14], [21], [5,17], [5,17], [13], [], [7,20], [5,17], [15,23], [11,20], [3,22], 
    [16,22], [], [1,19], [8,20], [12,23], [4,24], [], [2,17], [], [5,17], [10,24], [6,17], [14,18],
    [11,20], [9,19], [5,17], [], [], [], [], [], [], [4,24], [6,17], [11,20], [13], [2,5,17], [13,3], []
    ]
    return conference_sessions, slots, papers_range, max_parallel_sessions, working_groups, np, npMax, session_groups


def data_for_2021():
    conference_sessions = 43
    slots = 8
    papers_range = [3,4,5]
    max_parallel_sessions = 20
    working_groups = 15 
    np= [4,5,5,5,5,9,9,5,4,12,16,20,4,7,11,4,4,8,12,11,6,6,6,5,6,7,7,4,12,4,4,8,7,9,3,3,6,7,12,4,4,4,4]
    npMax = [5,4,3,4,3,4,4,4]

    # Define the working groups associated with each session
    session_groups = [
    [6,17], [8,5,17], [], [14], [21], [5,17], [5,17], [13], [], [7,20], [5,17], [15,23], [11,20], [3,22], 
    [16,22], [], [1,19], [8,20], [12,23], [4,24], [], [2,17], [], [5,17], [10,24], [6,17], [14,18],
    [11,20], [9,19], [5,17], [], [], [], [], [], [], [4,24], [6,17], [11,20], [13], [2,5,17], [13,3], []
    ]
    return conference_sessions, slots, papers_range, max_parallel_sessions, working_groups, np, npMax, session_groups



# Conference scheduling parameters
# conference_sessions = 40
# slots = 7 
# papers_range = [3,4,5,6]
# max_parallel_sessions = 14
# working_groups = 20 
# np= [14,23,12,9,9,6,10,4,10,7,6,5,3,5,6,4,3,12,7,16,4,5,14,11,4,3,10,6,6,4,13,3,4,9,5,4,11,6,6,8]
# npMax = [4, 6, 6, 4, 4, 5,  3]

# # Define the working groups associated with each session
# session_groups = [
#     [1], [2], [3], [], [], [], [6], [7], [7, 8], [10], [8], [8, 11], [5, 8], 
#     [3, 8], [7], [13], [13], [14], [], [8], [16], [16], [20], [17], [13], 
#     [], [9], [11], [11, 12], [9], [6, 19], [], [], [18], [10], [5], [16], 
#     [4, 5], [8, 12], [7, 15]
# ]
# conference_sessions = 47
# slots = 7
# papers_range = [3,4,5,6]
# max_parallel_sessions = 14
# working_groups = 24 
# np= [6,3,7,8,8,4,12,4,15,10,11,12,14,12,8,10,8,5,3,12,3,11,11,3,11,3,6,3,3,3,10,4,6,4,4,5,3,7,3,6,7,12,8,17,6,10,17,2]
# npMax = [5,4,4,6,5,4,4]

# # Define the working groups associated with each session
# session_groups = [  
#     [17],
#     [7],
#     [13],
#     [5],
#     [4],
#     [],
#     [18,6,22],
#     [18,6],
#     [8],
#     [9],
#     [5],
#     [12],
#     [],
#     [7],
#     [16],    
#     [23],
#     [13],
#     [4],
#     [],
#     [],
#     [9,5],
#     [2,18],
#     [],
#     [11],
#     [3],
#     [18],
#     [18,6],
#     [5,8],
#     [16,3],
#     [19],
#     [14],
#     [5],
#     [20,15,21],
#     [10],
#     [10],
#     [13],
#     [2,5],
#     [],
#     [],
#     [5],
#     [8,9],
#     [7],
#     [13],
#     [5,4],
#     [18,6],
#     [9],
#     [1,24]
# ]
