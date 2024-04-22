import sys
import logging
from pysat.examples.rc2 import RC2
from pysat.formula import WCNF

# Configure logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

# Check if the correct number of command-line arguments has been provided.
if len(sys.argv) != 2:
    # Logging error when incorrect number of arguments are provided
    logging.error("Incorrect usage. Expected one argument for the path to the instance file.")
    print("Usage: python3 rc2Solver.py <path_to_instance_file>")
    sys.exit(1)

# Logging the start of the instance file processing
logging.info(f"Processing the instance file: {sys.argv[1]}")

# Extract the instance file path from the command line arguments
instance_file = sys.argv[1]

# Load the WCNF formula from the provided instance file
wcnf = WCNF(from_file=instance_file)

# Initialize the RC2 solver with the loaded WCNF formula, using 'cd' solver
with RC2(wcnf, solver="cd") as solver:
    # Enumerate all models for the given WCNF instance
    for model in solver.enumerate():
        # Logging the cost of the current model
        logging.debug(f'Model found with cost: {solver.cost}')
        # Output the cost of the model
        print('Model has cost:', solver.cost)
        # Break after finding the first model to avoid processing all models
        break  
