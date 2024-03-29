----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.02.2023 13:54:00
-- Design Name: 
-- Module Name: top - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( SW : in STD_LOGIC_VECTOR (3 downto 0);
           LED : out STD_LOGIC_VECTOR (7 downto 0);
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           LEDP4 : out std_logic;
           LEDP5 : out std_logic;
           LEDP6 : out std_logic;
           LEDP7 : out std_logic;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           BTNC : in STD_LOGIC);
end top;

architecture Behavioral of top is

begin

   --------------------------------------------------------------------
  -- Instance (copy) of hex_7seg entity
  --------------------------------------------------------------------

  hex2seg : entity work.hex_7seg
    port map (
      blank  => BTNC,
      hex    => SW,
      seg(6) => CA,
      seg(5) => CB,
      seg(4) => CC,
      seg(3) => CD,
      seg(2) => CE,
      seg(1) => CF,
      seg(0) => CG,
      LED(4) => LEDP4,
      LED(5) => LEDP5,
      LED(6) => LEDP6,
      LED(7) => LEDP7
                );

  -- Connect one common anode to 3.3V
  AN <= b"1111_0111"; -- jak� 7-seg displej vyberu (4 vlevo, 4 vpravo)

  -- Display input value on LEDs
  LED(3 downto 0) <= SW;

--------------------------------------------------------------------
-- Experiments on your own: LED(7:4) indicators

--  LED(4) on if input value is equal to 0, ie "0000"
  LEDP4 <= '1' when (SW = "0000") else
          '0';
-- Turn LED(5) on if input value is greater than "1001", ie 10, 11, 12, ...p�smena
  LEDP5 <= '1' when (SW = "1010" OR SW = "1011" OR SW = "1100" OR SW = "1101" OR SW = "1110" OR SW = "1111") else 
          '0';

-- Turn LED(6) on if input value is odd, ie 1, 3, 5, ... lich� ?�sla
  LEDP6 <= '1' when (SW = "0001" OR SW = "0011" OR SW = "0101" OR SW = "0111" OR SW = "1001") else 
          '0';

-- Turn LED(7) on if input value is a power of two, ie 1, 2, 4, or 8 ... mocnina ?�sla 2
  LEDP7 <= '1' when (SW = "0001" OR SW = "0010" OR SW = "0100" OR SW = "1000") else 
          '0';


end architecture Behavioral;


