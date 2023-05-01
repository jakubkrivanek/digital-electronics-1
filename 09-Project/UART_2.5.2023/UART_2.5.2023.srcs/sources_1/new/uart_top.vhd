library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity uart_top is
    generic (
        BAUD_RATE : integer := 9600
    );
    port (
        clk      : in  std_logic;
        reset    : in  std_logic;
        data_in  : in  std_logic_vector(7 downto 0);
        tx_start : in  std_logic;
        tx       : out std_logic;
        rx       : in  std_logic;
        data_out : out std_logic_vector(7 downto 0);
        rx_done  : out std_logic
    );
end entity;

architecture Behavioral of uart_top is

    component uart_tx is
        generic (
            BAUD_RATE : integer := 9600
        );
        port (
            clk      : in  std_logic;
            reset    : in  std_logic;
            data_in  : in  std_logic_vector(7 downto 0);
            tx_start : in  std_logic;
            tx       : out std_logic
        );
    end component;

    component uart_rx is
        port (
            clk      : in  std_logic;
            reset    : in  std_logic;
            rx       : in  std_logic;
            data_out : out std_logic_vector(7 downto 0);
            rx_done  : out std_logic
        );
    end component;

    signal tx_out : std_logic;

begin

    tx_inst : uart_tx
        generic map (
            BAUD_RATE => BAUD_RATE
        )
        port map (
            clk      => clk,
            reset    => reset,
            data_in  => data_in,
            tx_start => tx_start,
            tx       => tx
        );

    rx_inst : uart_rx
        port map (
            clk      => clk,
            reset    => reset,
            rx       => rx,
            data_out => data_out,
            rx_done  => rx_done
        );


end Behavioral;
