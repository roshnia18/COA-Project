PROJECT TITLE:
Hardware Implementation of Maximum Subarray Sum using Verilog

------------------------------------------------------------
1. PROJECT DESCRIPTION
------------------------------------------------------------

This project implements the Maximum Subarray Sum problem using Verilog HDL. 
The goal is to find the contiguous subarray within a given array of integers 
that has the maximum possible sum.

The design is inspired by Kadane’s Algorithm and is implemented as a sequential 
hardware module that processes input data using clock-driven logic.

This type of computation is widely used in signal processing, financial analysis, 
and real-time data stream evaluation.

------------------------------------------------------------
2. FEATURES
------------------------------------------------------------

- Hardware implementation using Verilog HDL
- Sequential processing of input array
- Uses registers to store intermediate values:
  - Current sum
  - Maximum sum
- Supports signed integer inputs
- Testbench-based verification
- Works for positive, negative, and mixed inputs

------------------------------------------------------------
3. FILES INCLUDED
------------------------------------------------------------

Project.v        -> Main Verilog module (design implementation)
Project_tb.v     -> Testbench for simulation and verification

------------------------------------------------------------
4. HOW TO COMPILE AND RUN
------------------------------------------------------------

Use Icarus Verilog (iverilog) for simulation.

Step 1: Compile
--------------------------------------------
iverilog -o sim Project.v Project_tb.v

Step 2: Run simulation
--------------------------------------------
vvp sim

------------------------------------------------------------
5. EXPECTED OUTPUT
------------------------------------------------------------

The simulation prints the Maximum Subarray Sum for the given test cases.

Example:
Input:  [-2, -3, 4, -1, -2, 1, 5, -3]
Output: 7

------------------------------------------------------------
6. DESIGN OVERVIEW
------------------------------------------------------------

- The input array is stored in a flattened register format.
- A sequential process evaluates each element on every clock cycle.
- The algorithm maintains:
    curr_sum → current subarray sum
    max_sum  → maximum sum found so far

- At each step:
    If (curr_sum + arr[i]) > arr[i]
        curr_sum = curr_sum + arr[i]
    else
        curr_sum = arr[i]

    max_sum is updated accordingly.

------------------------------------------------------------
7. CHALLENGES FACED
------------------------------------------------------------

- Converting a dynamic programming algorithm into hardware logic
- Handling signed number operations in Verilog
- Ensuring correct sequential updates in simulation
- Debugging incorrect intermediate values in testbench

------------------------------------------------------------
8. FUTURE WORK
------------------------------------------------------------

- Pipelined architecture optimization
- FPGA implementation for real-time processing
- Support for streaming input data
- Performance improvement for large datasets

------------------------------------------------------------
9. AUTHOR NOTE
------------------------------------------------------------

This project is developed as part of an academic Digital Design / Verilog course 
to demonstrate hardware implementation of algorithmic problems.

------------------------------------------------------------
