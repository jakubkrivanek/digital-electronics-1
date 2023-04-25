----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.04.2023 11:37:15
-- Design Name: 
-- Module Name: Transmitter - Behavioral
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

entity Transmitter is
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
end Transmitter;

architecture Behavioral of Transmitter is
    -- definice stavoveho automatu a jeho stavy
     type t_SM_Main is (s_idle, s_StartBit_tx, s_DataBits_tx,
                     s_StopBit_tx, s_clear);  
     signal r_SM_Main      :   t_SM_Main := s_idle;--signal pro ukladani aktualniho stavu
    
     signal s_ClkCount     :   integer range 0 to Clk_per_bit-1 := 0;  -- Poèítadlo hodinových cyklù
     signal s_indexBitA    :   integer range 0 to 7 := 0;  -- Index aktuálnì pøijatého bitu (z 8)
     signal s_data         :   std_logic_vector(7 downto 0) := (others => '0');  -- ukladani odesilanych dat
     signal s_end          :   std_logic := '0';  -- oznaceni dokoceni odesilani dat                     
begin
UART_Transmitter : process(Clk)
begin
    if Clk'event and Clk ='1' then
        case r_SM_Main is
            when s_idle =>
            -- nastaveni pocatecnich hodnot
                    tx_A <='0';--vysilac neni aktivni
                    tx_serial <='1';--vysilac je v rezimu idle, data nejsou vysilana
                    s_end <='1';--pripraveno k odesilani dalsich bytu
                    s_ClkCount <= 0;--promena pro pocitani nasich cyklu 
                    s_indexBitA<=0;--promenna pro urceni indexu bytu
                    -- pokud mame stav aktivni, pripravi data k odesilani a prepneme automat na zacatek
                    if tx_data_valid ='0' then
                        s_data <=  tx_byte;--ulozime byt, ktery se bude vysilat do s_data
                        r_SM_Main <= s_StartBit_tx;
                    else
                         r_SM_Main <= s_idle;
                    end if;
              when  s_StartBit_tx =>
              --odesilani start+bitu, kde startbit=0
                    tx_A <='1';--vysilac je nyn9 aktivni
                    tx_serial<='0';--vysila se startovaci byt
                    if(s_ClkCount < Clk_per_bit - 1) then -- nebylo dosazeni max pocty hod. cyklu
                        s_ClkCount <= s_ClkCount +1;--inkrementace 
                        r_SM_Main <= s_StartBit_tx;-- zmena stavu na startbit
                    else
                        s_ClkCount <=0;
                        r_SM_Main <=s_DataBits_tx; -- zmana stavu (priprva na odesilani datovych bytu)
                    end if;      
               when s_DataBits_tx =>
                    tx_serial <=s_data(s_indexBitA);-- vystupni signal pro vysiilani na aktualni datovej byt
                    if s_ClkCount < Clk_per_bit - 1 then
                        s_ClkCount <= s_ClkCount +1;
                        r_SM_Main <= s_DataBits_tx; -- pokracovani odesilani datovych bitu
                    else
                        s_ClkCount <= 0; -- reset clk    
                        if s_indexBitA <7 then -- pokud nebyly odeslany vsehcny byty
                            s_indexBitA <=s_indexBitA +1;--inkrementace bitoveho indexu
                            r_SM_Main <= s_DataBits_tx; 
                        else -- pokud byly vsechny odeslany
                             s_indexBitA <= 0; -- reset bztoveho indexu
                             r_SM_Main <= s_StopBit_tx; -- zmena stavu na stop bit                         
                        end if;
                    end if;
              when s_StopBit_tx =>
                    tx_serial <= '1'; --vysila se stop bit
                    if s_ClkCount < Clk_per_bit-1 then
                        s_ClkCOunt <= s_ClkCount +1;
                        r_SM_Main <= s_StopBit_tx;
                    else
                        s_end <= '1';--vysilani bylo dokonceno
                        s_ClkCount <=0;--reset clk
                        r_SM_Main <= s_clear;--zmena stavu    
                    end if;
              when s_clear =>
                        tx_A<='0';
                        s_end <='1';
                        r_SM_Main <= s_idle;
              when others =>
                        r_SM_Main <= s_idle;          
        end case;            
    end if;                  
end process;
tx_end <= s_end;
end Behavioral;
