library IEEE;
        use IEEE.STD_LOGIC_1164.ALL;
        USE ieee.math_real.ALL;
        use IEEE.NUMERIC_STD.ALL;
library std;
        use std.textio.all;
library work;
use work.all;

entity tb_pwm is
end tb_pwm;

architecture behav of tb_pwm is
	signal clk_10 : std_logic := '0';
	signal rst    : std_logic := '0';
	signal duty   : std_logic_vector(7 downto 0) := "00000000";
	signal outSig : std_logic := '0';

begin
    
    process
    begin
        clk_10 <= '1', '0' after 10 ns;
        wait for 20 ns;
    end process;


    process
    begin
        wait for 205 ns;
        rst <= '1';
        wait for 205 ns;
        rst <= '0';
        wait for 10 ns;

        wait for 5 ms;
        duty <= X"64";
        wait for 5 ms;
        duty <= X"FF";
        wait for 5 ms;
        assert false report "done" severity failure;
        wait;
    end process;

    pwm: entity work.pwmUnit
    port map(
		clk_10 =>clk_10,
		rst    =>rst,
		duty   =>duty,
		outSig =>outSig
    );

    
end behav;
