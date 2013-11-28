library IEEE;
        use IEEE.STD_LOGIC_1164.ALL;
        use IEEE.NUMERIC_STD.ALL;
library std;
        use std.textio.all;
library work;
use work.all;

entity tb_shiftreg is
end tb_shiftreg;

architecture behav of tb_shiftreg is
    signal rst : std_logic := '0';
    signal clk : std_logic := '0';
    signal leftShift : std_logic := '0';
    signal rightShift : std_logic := '0';
    signal leftIn : std_logic := '0';
    signal rightIn : std_logic := '0';
    signal regOut : std_logic_vector(7 downto 0) := "00000000";

begin
    
    process
    begin
        clk <= '1', '0' after 5 ns;
        wait for 10 ns;
    end process;

    process
    begin
        wait for 10 ns;
        rst <= '1' after 12 ns;
        wait for 20 ns;
        rst <= '0';
        wait for 10 ns;
        leftShift <= '1';
        rightIn <= '1';
        wait for 30 ns;
        leftShift <= '0';
        wait for 30 ns;
        rightShift <= '1';
        wait for 50 ns;
        leftShift <= '1';
        wait for 50 ns;
        assert false report "done" severity failure;
        wait;
    end process;

    shiftreg_i: entity work.shiftreg
    port map(
        rst        => rst,
        clk        => clk,
        leftShift  => leftShift,
        rightShift => rightShift,
        leftIn     => leftIn,
        rightIn    => rightIn,
        regOut     => regOut
    );

    
end behav;
