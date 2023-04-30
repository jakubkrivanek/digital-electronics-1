### Team members

* Lukáš Kříž 
* Michal Kovář
* Jakub Křivánek

## Theoretical description and explanation

UART stands for Universal Asynchronous Receiver/Transmitter, and it is a commonly used communication protocol for transmitting and receiving serial data between electronic devices. It is widely used in embedded systems, such as microcontrollers, and other electronic devices. UARTconsists of two lines: one for transmitting data, called TX, and the other for receiving data, called RX. The TX line is driven by the transmitter, while the RX line is monitored by the receiver. 

## Hardware description of demo application
                                         Block diagram of UART designed in VHDL:
![TOP_uart](https://user-images.githubusercontent.com/124684744/235367565-ab059bf5-4c3a-4a8e-aee5-b239c80b32a5.png)


Insert descriptive text and schematic(s) of your implementation.

## Software description

###Transmitter:
The definition of the entity includes two generics, DBIT and SB_TICK, which specify the number of data cycles and the number of clock cycles for each bit on the bus. The architecture defines a finite-state machine (FSM) with four states: idle, start, data, and stop. The process that defines the next state of the FSM is triggered by the rising edge of the clock input. When the reset button is pressed, the FSM is initialized to the idle state and all registers are set to zero or one. In the idle state, the transmitter waits for a high value of tx_start. When this occurs, the transmitter enters the start state. In the start state, the transmitter waits for the bus state to go through all possible values (0-15) before transitioning to the data state. In the data state, the transmitter sends each bit of the data byte, starting with the least significant bit, before transitioning to the stop state. In the stop state, the transmitter sends the stop bit and then transitions back to the idle state. The output of the transmitter is represented by the signal tx_next, which is updated based on the current state and register values.

###Reciever:
The input port "rx" is a serial data input from the converter. The input port "s_tick" is a control signal that specifies the symbol length in clock cycles. The output port "rx_done_tick" indicates when the receiver has finished receiving data. The entity has parameters DBIT, which sets the width of the data word, and SB_TICK, which sets the symbol length in clock cycles. The architecture defines an FSM with four states: idle, start, data, and stop. The main behavior of the receiver is implemented in a process that calculates the next state of the receiver and updates internal signals. The process uses a case statement to implement different behavior for the receiver in each state. The behavior of the receiver includes detecting the start bit, reading data bits, and detecting the stop bit. The process also updates output signals, such as "rx_done_tick" and "dout", based on the received data. 

### Component(s) simulation

Write descriptive text and simulation screenshots of your components.

## Instructions
###Transmitter:
1. It is necessary to connect the transmitter's GND to the GND pin and connect rx to JC 1.
2. Use the first eight switches from the right-hand side to set the desired binary combination. 
The combination should be displayed on the first two seven-segment displays from the right-hand side.
3. To send, press the right button.
4. When reset is needed, press the middle button.
###Reciever:
1. It is necessary to connect the transmitter's GND to the GND pin and connect tx to JC 1.
2. To receive data, press the left button.
3. After receiving data, the received eight-bit combination should be displayed on the 3rd and 4th seven-segment displays from the right-hand side.
4. Reset is on the central button.

## References
1. Put here the literature references you used.
2. ...