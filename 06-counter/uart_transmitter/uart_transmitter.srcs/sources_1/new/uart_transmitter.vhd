----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.04.2023 13:51:10
-- Design Name: 
-- Module Name: uart_transmitter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_transmitter is
    Port ( clk      : in STD_LOGIC;
           reset    : in STD_LOGIC;
           tx_in    : in STD_LOGIC_VECTOR (7 downto 0);
           tx_start : in STD_LOGIC;
           tx       : out STD_LOGIC;
           tx_done  : out STD_LOGIC);
end uart_transmitter;

architecture Behavioral of uart_transmitter is
    signal state_reg  : std_logic_vector (1 downto 0);
    signal state_next : std_logic_vector (1 downto 0);
    signal s_reg      : std_logic_vector (3 downto 0);
    signal s_next     : std_logic_vector (3 downto 0);
    signal n_reg      : std_logic_vector(integer(ceil(log2(real(8)))) - 1 downto 0); 
    signal n_next     : std_logic_vector(integer(ceil(log2(real(8)))) - 1 downto 0);
    signal b_reg      : std_logic_vector (7 downto 0);
    signal b_next     : std_logic_vector (7 downto 0);
    signal tx_reg     : std_logic_vector;
    signal tx_next    : std_logic_vector;
    
    
 
begin


end Behavioral;
