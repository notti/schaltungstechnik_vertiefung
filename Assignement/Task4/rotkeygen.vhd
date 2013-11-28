library ieee;
use ieee.std_logic_1164.all;

-- Simulates the A and B signal of the rotatory key encoder
entity rotKeyGen is
	port (
		A: out std_logic;
		B: out std_logic;
		Push : out std_logic
	);
end entity rotKeyGen;

architecture RTL of rotKeyGen is
	
begin

	-- This process generates the A and B signals
	-- YOU may modify this for your own test cases !

	process
	begin
		while TRUE loop
			A<='0';
			B<='0';
			wait for 300 ns;
			
			A<='1';
			B<='0';	
			wait for 10 ns;
			A<='0';
			B<='0';	
			wait for 10 ns;
			A<='1';
			B<='0';	
			
			wait for 200 ns;
			
			A<='1';
			B<='1';
			wait for 10 ns;
			A<='1';
			B<='0';
			wait for 10 ns;
			A<='1';
			B<='1';
			
			wait for 1 us;
			
			A<='0';
			B<='1';	
			wait for 10 ns;
			A<='1';
			B<='1';	
			wait for 10 ns;
			A<='0';
			B<='1';	
			
			wait for 200 ns;
			
			A<='0';
			B<='0';	
			wait for 10 ns;
			A<='0';
			B<='1';	
			wait for 10 ns;
			A<='0';
			B<='0';
			
			wait for 500 ns;
			
			wait for 200 ns;
			A<='0';
			B<='1';
			wait for 200 ns;
			A<='1';
			B<='1';
			wait for 1 us;
			A<='1';
			B<='0';
			wait for 200 ns;
			A<='0';
			B<='0';
			

			wait for 100 ms;
		end loop;
	end process;
end architecture RTL;
