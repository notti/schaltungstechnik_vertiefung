library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ps2Receiver is
	port(
		clk         : in  std_logic;
		rst         : in  std_logic;

		-- data 
		rxData      : out std_logic_vector(7 downto 0);

		-- module sync signals
		dataReady   : out std_logic;
		dataFetched : in  std_logic;

		-- ps2 pins
		ps2Data     : in  std_logic;
		ps2Clk      : in  std_logic
	);
end entity ps2Receiver;

architecture RTL of ps2Receiver is
	

begin

-- Implement the FSM of the receiver here !
-- Asyncronous reset
-- Capture falling edges of th clock signal
-- Implement an accurate receive timeout
-- Set syncronization signals for the communication with other modules


end architecture RTL;
