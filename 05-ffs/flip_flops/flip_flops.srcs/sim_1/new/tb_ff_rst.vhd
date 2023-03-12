library ieee;
  use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------
entity tb_ff_rst is
  -- Entity of testbench is always empty
end entity tb_ff_rst;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture testbench of tb_ff_rst is

    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    --Local signals
    signal sig_clk_100MHz : std_logic;
    signal sig_rst        : std_logic;
    signal sig_data       : std_logic;
    
    signal sig_d_q        : std_logic;
    signal sig_d_q_bar    : std_logic;
  
    signal sig_t_q        : std_logic;
    signal sig_t_q_bar    : std_logic;
    
    signal sig_data1      : std_logic;
    signal sig_data2      : std_logic;
    signal sig_JK_q       : std_logic;
    signal sig_JK_q_bar   : std_logic;

begin
    -- Connecting testbench signals with d_ff_rst entity
    -- (Unit Under Test)
    uut_d_ff_rst : entity work.d_ff_rst
        port map (
            clk   => sig_clk_100MHz,
            rst   => sig_rst,
            d     => sig_data,
            q     => sig_d_q,
            q_bar => sig_d_q_bar
        );
    -- Connecting testbench signals with d_ff_rst entity
    -- (Unit Under Test)
    uut_t_ff_rst : entity work.t_ff_rst
        port map (
            clk   => sig_clk_100MHz,
            rst   => sig_rst,
            t     => sig_data,
            q     => sig_t_q,
            q_bar => sig_t_q_bar     
        );
    -- Connecting testbench signals with d_ff_rst entity
    -- (Unit Under Test)        
    uut_jk_ff_rst : entity work.jk_ff_rst
        port map (
            clk   => sig_clk_100MHz,
            rst   => sig_rst,
            K     => sig_data1,
            J     => sig_data2,
            q     => sig_JK_q,
            q_bar => sig_JK_q_bar
        );    
    --------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 200 ns loop -- 20 periods of 100MHz clock
            sig_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            sig_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;                -- Process is suspended forever
    end process p_clk_gen;

    --------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------
    p_reset_gen : process
    begin
        sig_rst <= '0';

        -- ACTIVATE AND DEACTIVATE RESET HERE
        wait for 10 ns;
        sig_rst <= '1';
        wait for 10 ns;
        sig_rst <= '0';

        wait;
    end process p_reset_gen;

    --------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started";
        sig_data <='0'; wait for 13 ns;
        
        sig_data <='1'; wait for 25 ns;
        sig_data <='0'; wait for 18 ns;
        
        sig_data <='1'; wait for 17 ns;
        sig_data <='0'; wait for 34 ns;
        
        sig_data1 <='0'; sig_data2<='1'; wait for 16 ns;
        sig_data1 <='1'; sig_data2<='1'; wait for 16 ns;
        sig_data1 <='0'; sig_data2<='0'; wait for 16 ns;
        sig_data1 <='1'; sig_data2<='0'; wait for 16 ns;
        -- DEFINE YOUR INPUT DATA HERE

        report "Stimulus process finished";
        wait;
    end process p_stimulus;

end architecture testbench;