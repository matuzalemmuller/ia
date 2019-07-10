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
target = ctrl.Antecedent(np.arange(0, 17, 1), 'target')
command = ctrl.Consequent(np.arange(0, 81, 1), 'command')

# Defines areas of each fuzzy input and output
temperature['too-cold'] = fuzz.trapmf(temperature.universe, [-10, -10, 0, 5])
temperature['cold'] = fuzz.trapmf(temperature.universe, [0, 5, 10, 15])
temperature['warm'] = fuzz.trapmf(temperature.universe, [10, 15, 20, 25])
temperature['hot'] = fuzz.trapmf(temperature.universe, [20, 25, 30, 35])
temperature['too-hot'] = fuzz.trapmf(temperature.universe, [30, 35, 40, 40])

target['cold'] = fuzz.trimf(target.universe, [0, 3, 6])
target['warm'] = fuzz.trimf(target.universe, [5, 8, 11])
target['hot'] = fuzz.trimf(target.universe, [10, 13, 16])

command['cool'] = fuzz.trimf(command.universe, [0, 0, 30])
command['no-change'] = fuzz.trimf(command.universe, [25, 40, 55])
command['heat'] = fuzz.trimf(command.universe, [50, 80, 80])

# See curves of each fuzzy variable
# temperature.view()
# target.view()
# command.view()

# Rules: Warm
rule1 = ctrl.Rule(
    (
        temperature['too-cold'] | temperature['cold']) & target['warm'],
        command['heat']
    )
rule2 = ctrl.Rule(
    (
        temperature['too-hot'] | temperature['hot']) & target['warm'],
        command['cool']
    )
rule3 = ctrl.Rule(
        temperature['warm'] & target['warm'],
        command['no-change']
    )

# Rules: Cold
rule4 = ctrl.Rule(
        temperature['cold'] & target['cold'],
        command['no-change']
    )
rule5 = ctrl.Rule(
    (
        temperature['too-hot'] | temperature['hot'] | temperature['warm']) &
        target['cold'],
        command['cool']
    )
rule6 = ctrl.Rule(
        temperature['too-cold'] & target['cold'],
        command['heat']
    )

# Rules: Hot
rule7 = ctrl.Rule(
    (
        temperature['too-cold'] | temperature['cold'] | temperature['warm']) &
        target['hot'],
        command['heat']
    )
rule8 = ctrl.Rule(
        temperature['hot'] & target['hot'],
        command['no-change']
    )
rule9 = ctrl.Rule(
        temperature['too-hot'] & target['hot'],
        command['cool']
    )

# Applies rules to control system
command_ctrl = ctrl.ControlSystem(
                [rule1, rule2, rule3, rule4, rule5, rule6, rule7, rule8, rule9]
                )

# Creates control system simulation with input
command_simulator = ctrl.ControlSystemSimulation(command_ctrl)
command_simulator.input['temperature'] = -10
command_simulator.input['target'] = 8 # 3 for cold, 8 for warm, 13 for hot

# Crunch the numbers
command_simulator.compute()

# Prints and plots results
print(command_simulator.output['command'])
command.view(sim=command_simulator)
plt.show()