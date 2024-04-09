def data_for_2024():
    conference_sessions = 40
    slots = 7 
    papers_range = [3,4,5,6]
    # max_parallel_sessions = 14
    working_groups = 20 
    np= [14,23,12,9,9,6,10,4,10,7,6,5,3,5,6,4,3,12,7,16,4,5,14,11,4,3,10,6,6,4,13,3,4,9,5,4,11,6,6,8]
    npMax = [4, 6, 6, 4, 4, 5,  3]

    # Define the working groups associated with each session
    session_groups = [
        [1], [2], [3], [], [], [], [6], [7], [7, 8], [10], [8], [8, 11], [5, 8], 
        [3, 8], [7], [13], [13], [14], [], [8], [16], [16], [20], [17], [13], 
        [], [9], [11], [11, 12], [9], [6, 19], [], [], [18], [10], [5], [16], 
        [4, 5], [8, 12], [7, 15]
    ]
    return conference_sessions, slots, papers_range, working_groups, np, npMax, session_groups
    

def data_for_2023():
    conference_sessions = 47
    slots = 7
    papers_range = [3,4,5,6]
    # max_parallel_sessions =20
    working_groups = 24 
    np= [6,3,7,8,8,4,12,4,15,10,11,12,14,12,8,10,8,
         5,3,12,3,11,11,3,11,3,6,3,3,3,10,4,6,4,4,5,3,7,3,6,7,12,8,17,6,10,17,2]
    npMax = [5,4,4,6,5,4,4]

    # Define the working groups associated with each session
    session_groups = [  
        [17],[7],[13],[5],[4],[],[18,6,22],[18,6],[8],[9],[5],[12],[],[7],[16],[23],[13],[4],[],[],[9,5],
        [2,18],[],[11],[3],[18],[18,6],[5,8],[16,3],[19],[14],[5],[20,15,21],[10],[10],[13],[2,5],[],[],
        [5],[8,9],[7],[13],[5,4],[18,6],[9],[1,24]
    ]
    return conference_sessions, slots, papers_range, working_groups, np, npMax, session_groups


def data_for_2022():
    conference_sessions = 42
    slots = 8
    papers_range = [3,4,5]
    # max_parallel_sessions = 14                                                                                                              
    working_groups = 24                                                                                                                                                                                                                                                                                                                             
    np= [5,5,5,5,9,9,9,5,11,11,17,20,4,7,11,4,4,8,12,11,6,6,6,5,6,7,7,4,12,4,4,8,7,13,3,4,6,7,12,4,4,4] 
    # npMax = [5,4,3,4,3,4,4,4]
    npMax = [5,4,3,4,3,4,4,4]

    # Define the working groups associated with each session
    session_groups = [
    [6,16], [5,8,16], [], [14], [20], [5,16], [5,16], [13], [], [7,19], [5,16], [22], [11,19], [3,21], 
    [15,21], [], [1,18], [8,19], [12,22], [4,23], [], [2,16], [], [5,16], [10,23], [6,16], [17],
    [11,19], [9,18], [5,16], [], [], [], [], [], [3,13], [4,23], [6,16], [11,19], [13], [2,5,16], [3,13]
    ]
    # session_groups = [
    # [6,16], [5,8,16], [], [14], [20], [5,16], [5,16], [13], [], [7,19], [5,16], [22], [11,19], [3,21], 
    # [15,21], [], [1,18], [8,19], [12,22], [4,23], [], [2,16], [], [5,16], [10,23], [6], [17],
    # [11,19], [9,18], [5], [], [], [], [], [], [3,13], [4,23], [6], [11,19], [13], [2,5], [3,13]
    # ]
    
    # session_groups = [
    # [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [],
    #   [], [], [], [], [], [], [], [], [], [], [], [],[]
    # ]
    return conference_sessions, slots, papers_range, working_groups, np, npMax, session_groups


def data_for_2021():
    conference_sessions = 27
    slots = 11
    papers_range = [3,4,5]
    working_groups = 17 
    np= [11, 11, 8, 8, 8, 8, 10, 10, 13, 7, 4, 7, 10, 6, 5, 4, 5, 5, 5, 7, 4, 4, 6, 3,4, 4, 5]

    npMax = [4,5,3,3,4,3,5,4,4,3,5]

    # Define the working groups associated with each session
    session_groups = [
    [9], [4], [9], [2], [3], [14], [10], [4], [12], [11], [4], [6], [7], [4],[1],[16],
    [13] , [4] , [17] , [16] ,[17] , [17] , [9] , [] ,[3,8] ,[15,5] , [6,4]
    ]
    return conference_sessions, slots, papers_range, working_groups, np, npMax, session_groups
    



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
# np= [6,3,7,8,8,4,12,4,15,10,11,12,14,12,8,10,8,
# 5,3,12,3,11,11,3,11,3,6,3,3,3,10,4,6,4,4,5,3,7,3,6,7,12,8,17,6,10,17,2]
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
