# OTTER
This repository contains the source code and implementation files for a 50 mega hertz processor designed using system Verilog. The code has been programmed onto the Basys 3 board, allowing for physical testing and verification of the processor's functionality.

## OTTER architecture

### Full architecture elaborate design with all the components linked together.
![full architecture image with all the components linked together](otter-archi-files/OTTER-(full-architecture).png)

### The left side of the design features an intricate arrangement of interconnected components. These include a PC counter which is responsible for advancing to the next set of instructions, as well as a main memory module which reads and links the set of instructions to the register component.
![left half of the architecture image with components](otter-archi-files/OTTER-(left-half).png)

### The right side of the design showcases a complex arrangement of interconnected components, namely the register, ALU (Arithmetic Logical Unit), branch generator, and control unit. These components play a crucial role in performing a range of operations, including jumps, branches, and arithmetic functions such as addition, subtraction, shifting etc. Additionally, the register component is responsible for temporary and permanent storage of data.
![Right half of the architecture image with components](otter-archi-files/OTTER-(right-half).png)

### The design also includes an elaborate Control Unit Decoder, which consists of interconnected components. The Decoder component is primarily responsible for controlling the selector operation of various multiplexers. 
![Elaborate design of decoder with all the components](otter-archi-files/control-unit-Decoder.png)

### The design also features a detailed layout of interconnected components for the Control Unit Finite State Machine. The Finite State Machine is responsible for determining both the present and future states of the machine, and plays a crucial role in the overall operation of the system. 
![Elaborate design of FSM with all the components](otter-archi-files/control-unit-FSM.png)
