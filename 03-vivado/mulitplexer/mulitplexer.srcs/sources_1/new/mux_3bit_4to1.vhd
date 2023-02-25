-- assignments.
-- EDA Playground
--
-- Copyright (c) 2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for mux_3bit_4to1
------------------------------------------------------------
entity mux_3bit_4to1 is
    port(
        a_i           : in  std_logic_vector(3 - 1 downto 0);
        b_i           : in  std_logic_vector(3 - 1 downto 0);-- COMPLETE THE ENTITY DECLARATION
        c_i           : in  std_logic_vector(3 - 1 downto 0);
        d_i           : in  std_logic_vector(3 - 1 downto 0);
        sel_i         : in  std_logic_vector(2 - 1 downto 0);
        f_o           : out std_logic_vector(3 - 1 downto 0)
        );
end entity mux_3bit_4to1;

------------------------------------------------------------
-- Architecture body for mux_3bit_4to1
------------------------------------------------------------
architecture Behavioral of mux_3bit_4to1 is
begin
with sel_i select
    f_o <= a_i when "00",  -- If addr_i = "000" then y_o = a_i
           b_i when "01",
           c_i when "10",
           d_i when others; -- All other combinations
         
end architecture Behavioral;
