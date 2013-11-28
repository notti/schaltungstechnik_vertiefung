library ieee;
use ieee.std_logic_1164.all;

-- Module simulation a PS2 communication
entity keyboardSig is
	port(
		ps2c : out std_logic;
		ps2d : out std_logic
	);
end entity keyboardSig;

architecture RTL of keyboardSig is
	signal TxData : std_logic_vector(7 downto 0);

-- Procedure for sending one dedicated data packet
	procedure PS2Send(signal din  : in  std_logic_vector(7 downto 0);
		              signal ps2c : OUT std_logic;
		              signal ps2d : OUT std_logic) is
		variable parity : std_logic := '1';
	begin
		wait for 1 ns;
		ps2c <= '1';
		ps2d <= '1';
		wait for 5 us;
		ps2d <= '0';                    -- startbit
		wait for 20 us;
		ps2c <= '0';
		wait for 40 us;
		ps2c <= '1';
		wait for 20 us;

		parity := '1';
		for i in 0 to 7 loop
			ps2d <= din(i);
			if (din(i) = '1') then
				parity := not parity;
			end if;
			wait for 20 us;
			ps2c <= '0';
			wait for 40 us;
			ps2c <= '1';
			wait for 20 us;
		end loop;

		ps2d <= parity;                 -- parity
		wait for 20 us;
		ps2c <= '0';
		wait for 40 us;
		ps2c <= '1';
		wait for 20 us;

		ps2d <= '1';                    -- stopbit
		wait for 20 us;
		ps2c <= '0';
		wait for 40 us;
		ps2c <= '1';
		wait for 20 us;
	end procedure;

begin

	-- Simulus process which sends some dummy data 
	stim_proc : process
	begin
		wait for 100 ns;

		TXData <= x"AA";
		PS2Send(TXData, ps2c, ps2d);
		wait for 100 us;

		TXData <= x"55";
		PS2Send(TXData, ps2c, ps2d);
		wait for 100 us;

		TXData <= x"11";
		PS2Send(TXData, ps2c, ps2d);
		wait for 100 us;

		TXData <= x"80";
		PS2Send(TXData, ps2c, ps2d);
		wait for 100 us;

		TXData <= x"01";
		PS2Send(TXData, ps2c, ps2d);
		wait for 100 us;

		TXData <= x"C3";
		PS2Send(TXData, ps2c, ps2d);
		wait for 100 us;

		wait;

	end process;
end architecture RTL;
