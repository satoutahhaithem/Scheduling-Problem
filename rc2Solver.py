import sys
import argparse
import logging
from pysat.examples.rc2 import RC2
from pysat.formula import WCNF

# Setting up the argument parser
parser = argparse.ArgumentParser(description='Solve a weighted CNF instance using RC2 solver.')
parser.add_argument('instance_file', type=str, help='Path to the instance file.')
parser.add_argument('--verbose', action='store_true', help='Increase output verbosity.')

args = parser.parse_args()

# Configure logging based on the verbose flag
if args.verbose:
    logging.basicConfig(level=logging.INFO)
    pysat_logger = logging.getLogger('pysat')
    pysat_logger.setLevel(logging.INFO)  # Explicitly set the logging level for the 'pysat' logger
else:
    logging.basicConfig(level=logging.WARNING)

# Load the WCNF formula from the specified file
wcnf = WCNF(from_file=args.instance_file)

# Solve the WCNF instance using RC2
with RC2(wcnf, solver="cd") as solver:
    for model in solver.enumerate():
        print('Model has cost:', solver.verbose)
        print('Model has cost:', solver.cost)
        
        
