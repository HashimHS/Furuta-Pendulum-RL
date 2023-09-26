
# Control Furuta Pendulum with Reinforcement Learning
The Furuta Pendulum is a type of inverted pendulum, the control of which is a classic control theory problem in robotics and engineering. It consists of a pendulum arm that can rotate in the vertical plane, a joint section which connects the arm and the base, and a motorized rotary base that can rotate the pendulum base in the horizontal plane.

The goal of this project is to balance the Furuta Pendulum upward using various learning techniques and to compare the results.

You can find more information about this project in the [included report](https://github.com/HashimHS/Furuta-Pendulum-RL/blob/main/report/final/Final_report.pdf).

# Included Models
- AlphaZero
- TD3
- State feedback control model with TD3
- Model Predictive Control (buggy but works in simulation)

All these models are found in the Jupyter Notebooks included [here](https://github.com/HashimHS/Furuta-Pendulum-RL/tree/main/src).

# Requirements
- Julia v1.8.5

- ReinforcementLearning.jl v0.10.2

- Flux v0.12.10

- FurutaPendulums Package [(included)](https://github.com/HashimHS/Furuta-Pendulum-RL/tree/main/model/FurutaPendulums/ATRXR)

- Jupyter notebooks
