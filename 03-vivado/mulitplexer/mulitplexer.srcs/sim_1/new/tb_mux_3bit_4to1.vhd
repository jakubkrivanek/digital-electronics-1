------------------------------------------------------------
--
-- Testbench for 2-bit binary comparator.
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
-- Entity declaration for test bench
------------------------------------------------------------
entity tb_mux_3bit_4to1 is
    -- Entity of testbench is always empty
end entity tb_mux_3bit_4to1;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture Behavioral of tb_mux_3bit_4to1 is

    -- Local signals
       signal s_a           : std_logic_vector(3 - 1 downto 0);
       signal s_b           : std_logic_vector(3 - 1 downto 0); -- COMPLETE THE ENTITY DECLARATION
       signal s_c           : std_logic_vector(3 - 1 downto 0);
       signal s_d           : std_logic_vector(3 - 1 downto 0);
       signal s_sel         : std_logic_vector(2 - 1 downto 0);
       signal s_f           : std_logic_vector(3 - 1 downto 0);

begin
    -- Connecting testbench signals with mux_3bit_4to1
    -- entity (Unit Under Test)
    uut_mux_3bit_4to1 : entity work.mux_3bit_4to1
        port map(
            a_i           => s_a,
            b_i           => s_b,
            c_i           => s_c,
            d_i           => s_d,
            sel_i         => s_sel,
            f_o           => s_f       
        );

    --------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------
   stim_process: process
        begin
            s_a<="000";
            s_b<="001";
            s_c<="010";
            s_d<="100";
            
        s_sel<="00";
        wait for 100ns;
        s_sel<="01";
        wait for 100ns;
        s_sel<="10";
        wait for 100ns;
        s_sel<="11";
        wait for 100ns;
        end process;
 
end Behavioral;
        
