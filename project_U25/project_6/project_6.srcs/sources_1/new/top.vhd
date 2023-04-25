----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.04.2023 13:23:33
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
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    generic(
        DBIT    :   integer := 8;
        SB_TICK :   integer := 16;
        
        DVSR    :   integer := 65; -- 10M/16*9600
        DVSR_BIT:   integer :=8;
        FIFO_W  :   integer :=2     
    );
    
    port(
        CLK100MHZ     :   in std_logic;
        reset   :   in std_logic;
        rd_uart :   in std_logic;
        wr_uart :   in std_logic;
        rx      :   in std_logic;
        SW      :   in std_logic_vector(8-1 downto 0);
        tx_full :   out std_logic;
        rx_empty:   out std_logic;      
        r_data_i:   in std_logic_vector(8-1 downto 0);
        r_data_o:   out std_logic_vector(8-1 downto 0);        
        tx      :   out std_logic;
        CA      : out STD_LOGIC;
        CB      : out STD_LOGIC;
        CC      : out STD_LOGIC;
        CD      : out STD_LOGIC;
        CE      : out STD_LOGIC;
        CF      : out STD_LOGIC;
        CG      : out STD_LOGIC;
        DP      : out STD_LOGIC;
        AN      : out STD_LOGIC_VECTOR (7 downto 0)
    );
end top;

architecture Behavioral of top is
    signal tick                 :   std_logic;
    signal rx_done_tick         :   std_logic;
    signal tx_fifo_out          :   std_logic_vector(8-1 downto 0);
    signal rx_data_out          :   std_logic_vector(8-1 downto 0);
    signal tx_empty             :   std_logic;
    signal tx_fifo_not_empty    :   std_logic;
    signal tx_done_tick         :   std_logic; 
     
begin
    baud_gen_unit:  entity  work.mod_m_counter(arch)
        generic map (M => DVSR, N=> DVSR_BIT)
        port map(
           clk      =>CLK100MHZ,
           reset    =>reset, 
           q        =>open,
           max_tick =>tick
        ); 
        
    hex_7_seg   :   entity work.driver_7seg_4digits
    port map (
          seg(6) => CA,
          seg(5) => CB,
          seg(4) => CC,
          seg(3) => CD,
          seg(2) => CE,
          seg(1) => CF,
          seg(0) => CG,
          clk    => CLK100MHZ,
          rst  => reset, 
          
          data3(3) => SW(7),
          data3(2) => SW(6),
          data3(1) => SW(5),
          data3(0) => SW(4),  
          
          
          data2(3) => SW(3),
          data2(2) => SW(2),
          data2(1) => SW(1),
          data2(0) => SW(0),    
          
          data1(3) => r_data_i(7),
          data1(2) => r_data_i(6),
          data1(1) => r_data_i(5),
          data1(0) => r_data_i(4),
          
          data0(3) => r_data_i(3),
          data0(2) => r_data_i(2),
          data0(1) => r_data_i(1),
          data0(0) => r_data_i(0),  
          
          dp_vect => "0111",
          dp      => DP,
          dig(3 downto 0) => AN(3 downto 0)
    );    
    AN(7 downto 4) <= b"1111";
    uart_rx_unit:   entity work.uart_rx
    generic map(DBIT => DBIT, SB_TICK => SB_TICK)
    port map(
        clk             => CLK100MHZ,
        reset           => reset,
        rx              => rx,
        s_tick          => tick,
        rx_done_tick    => rx_done_tick,
        dout            => rx_data_out
    );
    r_data_o<=r_data_i;    
    
    fifo_rx_unit:   entity work.fifo(Behavioral)
    generic map(B=>DBIT, W=>FIFO_W)
    port map(
        clk         => CLK100MHZ,
        reset       => reset,
        rd          => rd_uart,
        wr          => rx_done_tick,
        w_data      => SW,
        empty       => rx_empty,
        full        => open,
        r_data      => r_data_o       
    );
    
    
    fifo_tx_unit:   entity work.fifo(Behavioral)
    generic map(B=>DBIT, W=>FIFO_W)
    port map(
        clk         => CLK100MHZ,
        reset       => reset,
        rd          => tx_done_tick,
        wr          => wr_uart,
        w_data      => SW,
        empty       => tx_empty,
        full        => tx_full,
        r_data      => tx_fifo_out       
    );
    uart_tx_unit:   entity work.uart_transmitter
    generic map(DBIT => DBIT, SB_TICK => SB_TICK)
    port map(
        clk             => CLK100MHZ,
        reset           => reset,
        tx_start        => tx_fifo_not_empty,
        s_tick          => tick,
        din             => tx_fifo_out, 
        tx_done_tick    => tx_done_tick,
        tx              => tx
    );    
    tx_fifo_not_empty <= tx_empty;
    

end Behavioral;
