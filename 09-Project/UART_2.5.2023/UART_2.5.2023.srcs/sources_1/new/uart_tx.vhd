library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_tx is
    Generic (
        BAUD_RATE : INTEGER := 9600;    --  baud rate  9600
        CLK_FREQ : INTEGER := 10_000_000 --  clock frequency  10 MHz
    );
    Port (
        clk      : in STD_LOGIC;
        reset    : in STD_LOGIC;
        tx       : out STD_LOGIC; -- vystup pro odesilani dat
        data_in  : in STD_LOGIC_VECTOR(7 downto 0); 
        tx_start : in STD_LOGIC;    -- pro spousteni vysilani dat
        tx_done  : out STD_LOGIC    --zda byla odelsana data
    );
end uart_tx;

architecture Behavioral of uart_tx is

    constant BIT_PERIOD        : time := 1 sec / BAUD_RATE;   -- doba trvani jednoho bitu
    constant HALF_BIT_PERIOD   : time := BIT_PERIOD / 2;      -- polovina teto doby

    signal baud_clk            : std_logic := '0';            -- synchronizace prenosu jednotlivych bitu
    signal bit_count           : integer range 0 to 10 := 0;  -- aktualne prenaseny bit
    signal tx_reg              : std_logic_vector(9 downto 0) := (others => '1');  -- posuvny registr pro odesilani dat
    signal tx_busy             : std_logic := '0';            -- zda prave probiha odsilani dat

begin

    -- baud clock generator
    baud_clk_process: process (clk)
    begin
        if (clk'event and clk='1') then
            if reset = '1' then
                baud_clk <= '0';
            else
                baud_clk <= not baud_clk; -- meni se na opacnou hodnotu vzestune hrany = per. signal
            end if;
        end if;
    end process;

    -- shift register
    tx_reg_process: process (baud_clk)
    begin
        if (baud_clk'event and baud_clk='1') then
            if tx_busy = '1' then -- probiha odesilani dat
                if bit_count < 9 then
                    tx_reg(9 downto 1) <= tx_reg(8 downto 0); -- posuniti vsech bitu doprava o jednu pozici = pripravim misto pro dalsi bit
                    tx_reg(0) <= '0';                        -- startovaci bit na pzoici 0
                    tx_reg(8 downto 1) <= data_in;            --pridani 8 bitu
                else    -- jakmile je psolano vsehc 10 bitu (start+data+stop)
                    tx_reg <= (others => '1'); -- aby se vsechny bity poslaly jako stopovaci
                    tx_busy <= '0';
                    bit_count <= 0;
                    tx_done <= '1';
                end if;
            end if;
        end if;
    end process;

    -- transmitter
    tx_process: process (tx_start, tx_busy)
    begin
        if tx_start = '1' and tx_busy = '0' then --proces je pripraven 
            tx_reg  <= (others => '0'); --vynulejeme obsah reg
            tx_busy <= '1'; 
            tx_done <= '0';
        end if;

        if tx_busy = '1' then -- zda probiha process
            if bit_count = 0 then   -- jedna o start bit, kteru je vzdy 0
                tx <= '0';      -- odeslani start bitu
            else
                tx <= tx_reg(0); --nebo na hodnotu na nejnizsim bitu psouvneho reg
            end if;
        else
            tx <= '1';  -- zadny process neni zpracovan
        end if;
    end process;

end Behavioral;
