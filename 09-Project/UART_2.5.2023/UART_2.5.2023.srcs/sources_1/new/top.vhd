library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_project is
    generic (
        BAUD_RATE : integer := 9600
    );
    port (
        clk     :   in std_logic;
        reset   :   in std_logic;
        
        SW : in STD_LOGIC_VECTOR (7 downto 0);
        CA : out STD_LOGIC;
        CB : out STD_LOGIC;
        CC : out STD_LOGIC;
        CD : out STD_LOGIC;
        CE : out STD_LOGIC;
        CF : out STD_LOGIC;
        CG : out STD_LOGIC;
        DP : out std_logic;
        AN : out STD_LOGIC_VECTOR (7 downto 0);
           
        tx_start    : in std_logic;
        tx          : out std_logic;
        rx          : in std_logic;
        data_out    : out std_logic_vector(7 downto 0);
        rx_done     : out std_logic
    );
end top_project;

architecture Behavioral of top_project is
    signal segment : std_logic_vector(7 downto 0); -- signal pro vystup na segmentov
begin
    driver_seg : entity work.driver_7seg_4digits
        port map(
            clk       => clk,
            rst       => reset,
          
            data0(3)  => SW(3),
            data0(2)  => SW(2),
            data0(1)  => SW(1),
            data0(0)  => SW(0),
          
            data1(3)  => SW(7),
            data1(2)  => SW(6),
            data1(1)  => SW(5),
            data1(0)  => SW(4), 
          
            data2(3)  => segment(7),
            data2(2)  => segment(6),
            data2(1)  => segment(5),
            data2(0)  => segment(4),
                     
            data3(3)  => segment(3),
            data3(2)  => segment(2),
            data3(1)  => segment(1),
            data3(0)  => segment(0),        
         
            seg(6)    => CA,
            seg(5)    => CB,
            seg(4)    => CC,
            seg(3)    => CD,
            seg(2)    => CE,
            seg(1)    => CF,
            seg(0)    => CG,
            dp       => DP,
            dp_vect  => "0111",
            dig(3 downto 0) => AN(3 downto 0)
        );
    AN(7 downto 4) <= b"1111";

    uart : entity work.uart_top
        generic map (
            BAUD_RATE => BAUD_RATE
        )
        port map (
            clk       => clk,
            reset     => reset,
            data_in   => SW,
            tx_start  => tx_start,
            tx        => tx,
            rx        => rx,
            data_out  => segment,
            rx_done   => rx_done
        );
        data_out <= segment;
end Behavioral;