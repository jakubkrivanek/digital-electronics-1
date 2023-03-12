----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.03.2023 12:25:20
-- Design Name: 
-- Module Name: jk_ff_rst - Behavioral
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

entity jk_ff_rst is
    Port ( J : in STD_LOGIC;
           K : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           q : out STD_LOGIC;
           q_bar : out STD_LOGIC);
end jk_ff_rst;

architecture Behavioral of jk_ff_rst is
signal sig_q : std_logic;

begin

 p_jk_ff_rst : process (clk)
    begin
        if rising_edge(clk) then  -- Synchronous process
            if(rst='1') then
                sig_q<='0';
            elsif(J='0' AND K='0') then
                sig_q <= sig_q;
             elsif(J='1' AND K='1') then
                sig_q<= not sig_q;
             elsif(J='1' AND K='0') then
                sig_q <='0';
             else
                sig_q <='1'; 
             end if;                 
        end if;
        
        q<=sig_q;
        q_bar<=not sig_q;
        
    end process p_jk_ff_rst;

end Behavioral;