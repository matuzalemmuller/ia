# Based on
#    http://cs.bilkent.edu.tr/~zeynep/files/short_fuzzy_logic_tutorial.pdf
#    https://www.tutorialspoint.com/artificial_intelligence/artificial_intelligence_fuzzy_logic_systems.htm
# UFSC - Campus Trindade
# PPGEAS - Introducao a Algoritmos
# Matuzalem Muller dos Santos
# 2019/1

import numpy as np
import matplotlib.pyplot as plt
import skfuzzy as fuzz
from skfuzzy import control as ctrl

# Antecedents are Inputs and Consequents are Outputs
temperature = ctrl.Antecedent(np.arange(-10, 41, 1), 'temperature')
target = ctrl.Antecedent(np.arange(0, 3, 1), 'target')
command = ctrl.Consequent(np.arange(0, 81, 1), 'command')

# Defines areas of each fuzzy input and output
temperature['too-cold'] = fuzz.trapmf(temperature.universe, [-10, -10, 0, 5])
temperature['cold'] = fuzz.trapmf(temperature.universe, [0, 5, 10, 15])
temperature['warm'] = fuzz.trapmf(temperature.universe, [10, 15, 20, 25])
temperature['hot'] = fuzz.trapmf(temperature.universe, [20, 25, 30, 35])
temperature['too-hot'] = fuzz.trapmf(temperature.universe, [30, 35, 40, 40])

target['warm'] = fuzz.trimf(target.universe, [0, 1, 2])

command['cool'] = fuzz.trimf(command.universe, [0, 0, 30])
command['no-change'] = fuzz.trimf(command.universe, [25, 40, 55])
command['heat'] = fuzz.trimf(command.universe, [50, 80, 80])

# See curves of each fuzzy variable
temperature.view()
# command.view()

"""
Rules
  * if target temperature is warm:
    * if temperature is cold or too-cold, command is to heat
    * if temperature is hot or too-hot, command is to cool
    * if temperature is warm, command is to not change
"""
rule1 = ctrl.Rule(
    (temperature['too-cold'] | temperature['cold']) & target['warm'],
    command['heat']
    )
rule2 = ctrl.Rule(
    (temperature['too-hot'] | temperature['hot']) & target['warm'],
    command['cool']
    )
rule3 = ctrl.Rule(
    temperature['warm'] & target['warm'],
    command['no-change']
    )

# Applies rules to control system
command_ctrl = ctrl.ControlSystem([rule1, rule2, rule3])

# Creates control system simulation with input
command_simulator = ctrl.ControlSystemSimulation(command_ctrl)
command_simulator.input['temperature'] = 30
command_simulator.input['target'] = 1 # 1 for warm, > 2 otherwise

# Crunch the numbers
command_simulator.compute()

# Prints and plots results
print(command_simulator.output['command'])
command.view(sim=command_simulator)
plt.show()