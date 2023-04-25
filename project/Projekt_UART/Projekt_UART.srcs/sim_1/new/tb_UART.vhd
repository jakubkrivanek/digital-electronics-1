----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.04.2023 12:48:53
-- Design Name: 
-- Module Name: tb_UART - Behavioral
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
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_UART is

end tb_UART;

architecture Behavioral of tb_UART is
    component Transmitter is
        generic(
            Clk_per_bit   :     integer := 650
        );
        port(
            Clk           :       in std_logic;
            tx_data_valid :       in std_logic; -- platny signal
            tx_byte       :       in std_logic_vector(8-1 downto 0); -- data pro prenos
            tx_A          :       out std_logic; -- aktivni signal na vystupu
            tx_serial     :       out std_logic; -- samotna prenasena data
            tx_end        :       out std_logic -- dokonceni prenosu dat      
        );
    end component;
    
    component receiver is
         generic(
            Clk_per_bit   :     integer := 650
        );
        port(
            Clk           :     in  std_logic;    -- Vstupní hodinový signál
            rx_serial     :     in  std_logic;    -- Vstupní sériový datový signál
            rx_data_valid :     out std_logic;    -- Výstupní indikátor platného datového signálu
            rx_dout       :     out std_logic_vector(7 downto 0) -- Výstupní osmibitový datový signál
        );
    end component;
    
    constant Clk_per_bit : integer := 10400;
    constant bit_period : time := 10 ns;
    
    signal s_clk : std_logic           := '0';
    signal s_tx_data_valid : std_logic:= '0';
    signal s_tx_byte : std_logic_vector(8-1 downto 0) := (others => '0');
    signal s_tx_serial : std_logic;
    signal s_tx_end : std_logic;
    signal s_rx_data_valid : std_logic;
    signal s_rx_dout : std_logic_vector(8-1 downto 0);
    signal s_rx_serial : std_logic := '1';
    
procedure UART_WRITE_BYTE (
    i_data_in       : in  std_logic_vector(7 downto 0);
    signal o_serial : out std_logic) is
begin

 -- Send Start Bit
    o_serial <= '0';
    wait for bit_period;
    
    for ii in 0 to 7 loop
    o_serial <= i_data_in(ii);
    wait for bit_period;
    end loop;

    o_serial <='1';
    wait for bit_period; 
    end UART_WRITE_BYTE;
begin
    UART_TX_INST : Transmitter 
  generic map (
    Clk_per_bit => Clk_per_bit
  ) 
    port map(
        Clk => s_Clk,
        tx_data_valid=> s_tx_data_valid,
        tx_byte => s_tx_byte,
        tx_A => open,
        tx_serial => s_tx_serial,
        tx_end => s_tx_end        
    ); 
 UART_RX_INST : receiver 
  generic map (
    Clk_per_bit => Clk_per_bit
  )
  port map(
    Clk => s_Clk,
    rx_serial => s_rx_serial,
    rx_data_valid => s_rx_data_valid,
    rx_dout=>s_rx_dout
  );     
 s_clk <= not s_clk after 50ns;
 
 process is
 begin
    wait until s_clk'event and s_clk ='1';
    wait until s_clk'event and s_clk ='1'; 
    
    s_tx_data_valid <='1';
    s_tx_byte <=X"AB";   
    
    wait until s_clk'event and s_clk ='1';
    UART_WRITE_BYTE(X"3F", s_rx_serial); 
    wait until s_clk'event and s_clk ='1';
    
    if s_rx_dout = X"3F" then
    report "Test Passed - Correct Byte Received" severity note;
  else
    report "Test Failed - Incorrect Byte Received" severity note;
  end if;
 
  assert false report "Tests Complete" severity failure;
   
end process; 

end Behavioral;
