library ieee;
use ieee.std_logic_1164.all;

entity tb_uart_rx is
end tb_uart_rx;

architecture testbench of tb_uart_rx is
    -- entity declaration for the DUT
    entity uart_rx is
        generic(
            DBIT: integer:=8;
            SB_TICK : integer:=16
        );
        port(
            clk, reset : in std_logic;
            rx: in std_logic;
            s_tick: in std_logic;
            rx_done_tick: out std_logic;
            dout: out std_logic_vector (7 downto 0)
        );
    end entity;

    -- signals to be connected to the DUT
    signal clk_sig, reset_sig, rx_sig, s_tick_sig: std_logic;
    signal rx_done_tick_sig: std_logic;
    signal dout_sig: std_logic_vector(7 downto 0);

begin
    -- instantiation of the DUT
    dut: uart_rx generic map (DBIT => 8, SB_TICK => 16)
        port map (
            clk => clk_sig,
            reset => reset_sig,
            rx => rx_sig,
            s_tick => s_tick_sig,
            rx_done_tick => rx_done_tick_sig,
            dout => dout_sig
        );

    -- clock generation
    clk_gen: process
    begin
        clk_sig <= '0';
        wait for 5 ns;
        clk_sig <= '1';
        wait for 5 ns;
    end process;

    -- reset generation
    reset_gen: process
    begin
        reset_sig <= '1';
        wait for 10 ns;
        reset_sig <= '0';
        wait for 200 ns;
        reset_sig <= '1';
        wait;
    end process;

    -- stimulus process
    stim_proc: process
    begin
        -- wait for reset to deassert
        wait until reset_sig = '0';

        -- send start bit
        rx_sig <= '0';
        s_tick_sig <= '0';
        wait for 10 ns;
        s_tick_sig <= '1';
        wait for 10 ns;

        -- send data bits
        for i in 0 to 7 loop
            rx_sig <= '1';
            s_tick_sig <= '0';
            wait for 10 ns;
            s_tick_sig <= '1';
            wait for 10 ns;
        end loop;

        -- send stop bit
        rx_sig <= '1';
        s_tick_sig <= '0';
        wait for 10 ns;
        s_tick_sig <= '1';
        wait for 10 ns;

        -- wait for rx_done_tick to assert
        wait for 100 ns;
        assert rx_done_tick_sig = '1'
            report "Error: rx_done_tick didn't assert" severity failure;

        wait;
    end process;

end testbench;
