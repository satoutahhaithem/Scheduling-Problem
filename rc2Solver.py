from pysat.examples.rc2 import RC2
from pysat.formula import WCNF

wcnf = WCNF(from_file='11_session_file')

with RC2(wcnf, solver="Cadical153") as solver:
    for model in solver.enumerate():
        print('Model has cost:', solver.cost)
        # print('Model:', solver.model)
