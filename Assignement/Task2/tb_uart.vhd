library IEEE;
        use IEEE.STD_LOGIC_1164.ALL;
        use IEEE.NUMERIC_STD.ALL;
library std;
        use std.textio.all;
library work;
use work.all;

entity tb_uart is
end tb_uart;

architecture behav of tb_uart is
    signal rst_i : std_logic := '0';
    signal clk_i : std_logic := '0';
    signal Din_i : std_logic_vector(7 downto 0) := "00000000";
    signal rx_i  : std_logic := '0';
    signal tx_o  : std_logic := '0';
    signal ld_i  : std_logic := '0';

begin
    
    process
    begin
        clk_i <= '1', '0' after 166 ns;
        wait for 333 ns;
    end process;

    process
    begin
        wait for 1*333 ns;
        rst_i <= '1';
        wait for 3*333 ns;
        rst_i <= '0';
        wait for 1*333 ns;
        Din_i <= X"55";
        ld_i <= '1';
        wait for 1*333 ns;
        ld_i <= '0';
        wait for 50*333 ns;
        assert false report "done" severity failure;
        wait;
    end process;

    uart_i: entity work.uart_top_shell
    port map(
        rst_i => rst_i,
        clk_i => clk_i,
        Din_i => Din_i,
        rx_i  => rx_i,
        tx_o  => tx_o,
        ld_i  => ld_i
    );

    
end behav;
