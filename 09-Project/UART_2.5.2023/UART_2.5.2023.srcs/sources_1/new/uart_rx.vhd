library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_rx is
    Port ( clk      : in  STD_LOGIC;    
           reset    : in  STD_LOGIC;
           rx       : in  STD_LOGIC;    --vstupni signal prijmace
           data_out : out STD_LOGIC_VECTOR(7 downto 0);     --vystuni data z prijmace
           rx_done  : out STD_LOGIC -- indikator dokonceni prijmu
         );
end uart_rx;

architecture Behavioral of uart_rx is
    type state_type is (idle, start_bit, data_bits, stop_bit);
    signal current_state : state_type;  --aktualni stav prijimace
    signal bit_counter   : integer range 0 to 7 := 0;   --poctadlo bitu
    signal data_reg      : std_logic_vector(7 downto 0);    --registr dat
    signal next_state    : state_type;      --nasledujci stav prijmace
begin
    process(clk, reset, rx)
    begin
        if reset = '1' then -- aktivni reset => vynuluje vse a stav iddle
            current_state <= idle;
            bit_counter   <= 0;
            data_reg      <= (others => '0');
            rx_done       <= '0';
        elsif (clk'event and clk ='1') then -- jinak nasledujci stav
            current_state <= next_state;
            case current_state is 
                when idle =>    --pokud byl detekovan start_bit
                    if rx = '0' then
                        next_state  <= start_bit;
                        bit_counter <= 0; --resetuj pocitadlo
                    else
                        next_state <= idle;
                    end if;
                when start_bit =>
                    if bit_counter < 7 then -- pokud neprichazi jeste posledni datoy bit
                        bit_counter <= bit_counter + 1;
                        data_reg(bit_counter) <= rx; --prijaty bit x se ulozi na pozici bit_cnt
                        next_state <= data_bits;
                    else
                        bit_counter <= 0;
                        next_state  <= stop_bit;
                    end if;
                when data_bits =>
                    if bit_counter < 7 then -- stale prenasi data
                        bit_counter <= bit_counter + 1; --inkrementace aby byl posunut na dalsi bit
                        data_reg(bit_counter) <= rx; 
                    else
                        bit_counter <= 0;
                        next_state  <= stop_bit;
                    end if;
                when stop_bit =>
                    if rx = '1' then -- byl prijat poslendi bit
                        data_out <= data_reg; -- data v reg ulozime do data out   
                        rx_done  <= '1'; -- prenos byl ukoncen
                        next_state <= idle;
                    else
                        next_state <= start_bit;
                    end if;
            end case;
        end if;
    end process;
end Behavioral;
