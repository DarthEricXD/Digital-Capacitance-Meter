# Digital Circuit and Logic Design A: Digital Capacitance Meter

Digital Circuit and Logic Design A is a course I attended at Nanjing University of Posts and Telecommunications from October 24, 2022, to November 4, 2022 where I built a digital capacitance meter.

## Overall Scheme Design
System Block Diagram:
- There are many design methods for capacitance measuring instruments, including measurement frequency method, measurement period method, measurement phase method, measurement integration method, measurement square wave method, and capacitance bridge method.
- This design adopts the method of measuring cycle to measure capacitance, and the schematic diagram is as follows:

<p align="center">
  <img src="https://github.com/DarthEricXD/Simple-Capacitance-Tester/blob/main/pics/schematic%20diagram.png" alt="image">
</p>

- A multi harmonic oscillator composed of the measured capacitor C and NE555. The input pulse period (or width) of the oscillator is directly proportional to the capacity of the tested capacitor. This period is used as the counting gate of the digital counter to count a standard frequency (1MHz). By selecting the timing resistor reasonably in the multi harmonic oscillator, the counting value of the counter can be directly used as the capacity value of the capacitor, which is displayed after floating-point conversion

The system flowchart is as follows:

<p align="center">
  <img src="https://github.com/DarthEricXD/Simple-Capacitance-Tester/blob/main/pics/system%20flowchart.png" alt="image">
</p>


## ISE schematic diagram:
<p align="center">
  <img src="https://github.com/DarthEricXD/Simple-Capacitance-Tester/blob/main/pics/1%20ISE%20schematic%20diagram.png" alt="image">
</p>

## Circuit Connection Diagram:
<p align="center">
  <img src="https://github.com/DarthEricXD/Simple-Capacitance-Tester/blob/main/pics/2%20circuit%20connection%20diagram.jpg" alt="image">
</p>

## Result:
<p align="center">
  <img src="https://github.com/DarthEricXD/Simple-Capacitance-Tester/blob/main/pics/3%20result1.png" alt="image">
</p>

<p align="center">
  <img src="https://github.com/DarthEricXD/Simple-Capacitance-Tester/blob/main/pics/4%20result2.png" alt="image">
</p>
