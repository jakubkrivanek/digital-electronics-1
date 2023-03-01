----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.03.2023 15:19:45
-- Design Name: 
-- Module Name: tb_top1 - Behavioral
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

entity tb_top1 is
--  Port ( );
end tb_top1;

architecture Behavioral of tb_top1 is
    signal s_SW :  std_logic_vector(3 downto 0);
    signal s_LED : std_logic_vector(7 downto 0);
    signal s_CA : std_logic;
    signal s_CB : std_logic;
    signal s_CC : std_logic;
    signal s_CD : std_logic;
    signal s_CE : std_logic;
    signal s_CF : std_logic;
    signal s_CG : std_logic;
    signal s_LedPos4: std_logic;
    signal s_LedPos5 : std_logic;
    signal s_LedPos6: std_logic;
    signal s_LedPos7: std_logic;
    signal s_AN : std_logic_vector(7 downto 0);
    signal s_BTNC : std_logic;
    
begin
    uut_top : entity work.top
        port map(
            SW => s_SW,
            LED => s_LED,
            CA => s_CA,
            CB => s_CB,
            CC => s_CC,
            CD => s_CD,
            CE => s_CE,
            CF => s_CF,
            CG => s_CG,
            LEDP4 => s_LedPos4,
            LEDP5 => s_LedPos5,
            LEDP6 => s_LedPos6,
            LEDP7 => s_LedPos7,
            AN => s_AN,
            BTNC => s_BTNC
            );
            
        p_stimulus : process is
             begin

    report "Stimulus process started";   
      for ii in 0 to 15 loop
        s_SW <= std_logic_vector(to_unsigned(ii, 4));
      wait for 50 ns;

    end loop;

    
    report "Stimulus process finished";
    wait;

  end process p_stimulus;             
            

end behavioral;

