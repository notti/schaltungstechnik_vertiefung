
library ieee;
use ieee.std_logic_1164.all;

entity clk_res_gen is
	port(
		clk_50 : out std_logic;
		rst    : out std_logic
	);
end entity clk_res_gen;

architecture RTL of clk_res_gen is
begin

	-- This process generates a 50MHz clock signal 
	p_clk_generate : process
	begin
		while TRUE loop
			clk_50 <= '0';
			wait for 10 ns;
			clk_50 <= '1';
			wait for 10 ns;
		end loop;
	end process p_clk_generate;
	
	p_report_sim_progress : process
	
	variable sim_time : integer := 0;
	begin
		while TRUE loop
			--report "Simulation time in ns is " & integer'image(sim_time);
			wait for 10 ns;
			sim_time := sim_time + 10;
		end loop;
	end process p_report_sim_progress;
		
	-- This process generate a test reset signal and enables the design after 15 ns
	p_res_generate : process
	begin
		rst <= '1';
		wait for 15 ns;
		rst <= '0';
		wait for 5000 ms;
	end process p_res_generate;

end architecture RTL;
