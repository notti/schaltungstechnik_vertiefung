library ieee;
use ieee.numeric_std.all;

use ieee.std_logic_1164.all;

entity pwmUnit is
	port(
		clk_10 : in  std_logic;
		rst    : in  std_logic;
		duty   : in  std_logic_vector(7 downto 0);
		outSig : out std_logic := '0'
	);
end entity pwmUnit;

architecture RTL of pwmUnit is
begin
	
-- Implement the PWM process here !

-- cover the reset signal asycronously
-- Pay attention on covering all possible input values correctly 
-- Use a counter register and compare the counter to your duty input vector
-- New duty cycle values are cathed after a counter overflow


end architecture RTL;