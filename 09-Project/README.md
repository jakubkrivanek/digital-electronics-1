# VHDL project

### UART (Universal Asynchronous Receiver/Transmitter)

### Team members

* Lukas Kriz
* Michal Kovar
* Jakub Krivanek

## Theoretical description and explanation

UART stands for Universal Asynchronous Receiver/Transmitter, and it is a commonly used communication protocol for transmitting and receiving serial data between electronic devices. It is widely used in embedded systems, such as microcontrollers, and other electronic devices. UARTconsists of two lines: one for transmitting data, called TX, and the other for receiving data, called RX. The TX line is driven by the transmitter, while the RX line is monitored by the receiver. 

## Hardware description of demo application
Block diagram of UART designed in VHDL:
[top level code](https://github.com/KrizLuk0/digital-electronics1/blob/main/09-Project/UART_2.5.2023/UART_2.5.2023.srcs/sources_1/new/top.vhd)
![uart_schema](https://user-images.githubusercontent.com/124684744/235447990-62608f3f-8d7b-46f5-b637-c452ca2f4952.png)
We used the ASCII table for decoding:
![ascii](https://user-images.githubusercontent.com/124684834/235461945-d93e6585-7254-4841-86ae-12a44e3b3109.png)
Insert descriptive text and schematic(s) of your implementation.

There is nothing here because after implementing it on the board, it doesn't work.

## Software description

#### Transmitter:
[code on uart_tx](https://github.com/KrizLuk0/digital-electronics1/blob/main/09-Project/UART_2.5.2023/UART_2.5.2023.srcs/sources_1/new/uart_tx.vhd)
This module uses "clk" and "reset" inputs for clocking and resetting, "tx_start" input to initiate data transmission, and "data_in" input for 8-bit data to be transmitted. The "tx" output is the serial data output, and "tx_done" output signals when the transmission is complete. Two processes are used: "baud_clk_process" generates the baud clock signal, while "tx_reg_process" shifts the data bits into a shift register for serial transmission. The "tx_process" outputs serial data based on the shift register value. When "tx_start" is high and "tx_busy" is low, the process sets the shift register to all zeroes, sets "tx_busy" high, and outputs the start bit, 8 data bits, and stop bit in sequence. "tx_done" output is set high when transmission is complete.

#### Reciever:
[code on uart_rx](https://github.com/KrizLuk0/digital-electronics1/blob/main/09-Project/UART_2.5.2023/UART_2.5.2023.srcs/sources_1/new/uart_rx.vhd)
This module has input signals "clk" for clock, "reset" for reset, and "rx" for single-ended input carrying serial data. It has output signals "data_out" (8-bit wide) for received byte and "rx_done" flag (set to 1 when byte is received). The state machine has four states: "idle", "start_bit", "data_bits", and "stop_bit". It waits for "start bit", receives 8 data bits, and then a stop bit. The received byte is stored in "data_out" register and "rx_done" flag is set when stop bit is received. "bit_counter" signal counts the received bits. When in "start_bit" state, "bit_counter" is incremented until 7, and received bits are stored in "data_reg". If stop bit is received, the received byte is stored in "data_out" register and "rx_done" flag is set to 1.

### Component(s) simulation

Screenshot of our UART :
[code on testbench of UART](https://github.com/KrizLuk0/digital-electronics1/blob/main/09-Project/UART_2.5.2023/UART_2.5.2023.srcs/sim_1/new/tb_uart.vhd)
![uart_tb1](https://user-images.githubusercontent.com/124684744/235448080-d529142f-33d2-4819-acda-e9c990656aa9.png)

## Instructions

### Transmitter:
1. It is necessary to connect the transmitter's GND to the GND pin and connect tx to JA 2.
2. Use the first eight switches from the right-hand side to set the desired binary combination. 
The combination should be displayed on the first two seven-segment displays from the right-hand side.
3. Wait for the process to complete
4. When reset is needed, press the middle button.

### Reciever:
1. It is necessary to connect the reciver's GND to the GND pin and connect rx to JA 1.
2. Wait for the process to complete
3. After receiving data, the received eight-bit combination should be displayed on the 3rd and 4th seven-segment displays from the right-hand side.
4. Reset is on the central button.

## References
1. MANO, M. Morris a Michael D. CILETTI. Digital design: with an introduction to the Verilog HDL, VHDL, and SystemVerilog. Sixth edition
2.https://github.com/tomas-fryza/digital-electronics-1