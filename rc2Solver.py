import sys
from pysat.examples.rc2 import RC2
from pysat.formula import WCNF

if len(sys.argv) != 2:
    print("Usage: python3 rc2Solver.py <path_to_instance_file>")
    sys.exit(1)

instance_file = sys.argv[1]

wcnf = WCNF(from_file=instance_file)

with RC2(wcnf, solver="Cadical153") as solver:
    for model in solver.enumerate():
        print('Model has cost:', solver.cost)
        break  
