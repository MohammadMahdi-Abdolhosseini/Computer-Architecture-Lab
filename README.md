# Computer-Architecture-Lab
Computer Architecture Lab - Assignments - Fall 2023

## Introduction

This repository contains the System Verilog code for an ARM processor. Follow the instructions below to create a project, set up the driver, and use SignalTab for monitoring signals.

## Getting Started

### Create Project

1. Open Quartus: File -> New -> New Quartus Project
2. Choose a project name and set the top module name the same as the project name.
3. Add files: Add -> Device Family: Cyclone II, Name Filter: EP2C35F672C6 -> Finish
4. Import Assignments: Assignment -> Import Assignments -> Choose DE2_pin_assignments.csv file.
5. Add Code: Compile -> Tools -> Programmer -> Select FPGA -> Hardware Setup: USB -> Start

### Driver Setup

1. Open Device Manager.
2. Locate USB-Blaster, right-click, and select Update Driver.
3. Browse to C:/altera/quartus/drivers/usb-blaster.

### SignalTab

1. Open SignalTab: Tools -> SignalTab.
2. Add Clock Signal:
   - Filter: Design Entry: CLOCK_50
   - Add/Ok
   - Type: Conditional -> D.C.
3. Add Conditional Signal:
   - Filter: Design Entry: Select an output and condition
   - Compile
4. License Setup:
   - Tools -> License Setup -> Internet Connectivity -> Talkback Options -> Enable -> Compile
5. Trigger Condition:
   - R.C. (Falling Edge)
  
## Screenshots
+ DE2Board
+ ARM Processor Architecture
