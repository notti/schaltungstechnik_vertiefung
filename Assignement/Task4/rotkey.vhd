library ieee;
use ieee.std_logic_1164.all;

entity rotKey is
	port(
		clk_50        : in  std_logic;

		rotA          : in  std_logic;
		rotB          : in  std_logic;
		rotPush       : in  std_logic;

		rotRightEvent : out std_logic;
		rotLeftEvent  : out std_logic;
		rotPushEvent  : out std_logic
	);
end entity rotKey;

architecture RTL of rotKey is

	-- Declaration of the  debounce component
	component debounce
		port(clk_50   : in  std_logic;
			 input    : in  std_logic;
			 output   : out std_logic;
			 riseedge : out std_logic;
			 falledge : out std_logic);
	end component debounce;

-- Implement a process here to cover the singal from the rotatory encoder

-- Instantiate needed debounce modules
-- Analyze the input signals according to the specification

begin
	
end architecture RTL;
