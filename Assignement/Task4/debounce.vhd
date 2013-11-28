library ieee;
use ieee.std_logic_1164.all;

entity debounce is
	port(
		clk_50      : in  std_logic;
		input    : in  std_logic;
		output   : out std_logic:='0';
		riseedge : out std_logic:='0';
		falledge : out std_logic:='0');
end entity debounce;

architecture RTL of debounce is
begin
	
-- Implement the debounce algorithm here !

-- Use a counter register to realize the sampling period
-- Shift the covered values into a register
-- according to the sampled logical levels manipulate the output signals of the module

end architecture RTL;


