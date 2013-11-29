library IEEE;
        use IEEE.STD_LOGIC_1164.ALL;
        USE ieee.math_real.ALL;
        use IEEE.NUMERIC_STD.ALL;
library std;
        use std.textio.all;
library work;
use work.all;

entity tb_ps2 is
end tb_ps2;

architecture behav of tb_ps2 is
component clk_res_gen is
	port(
		clk_50 : out std_logic;
		rst    : out std_logic
	);
end component clk_res_gen;
component keyboardSig is
	port(
		ps2c : out std_logic;
		ps2d : out std_logic
	);
end component keyboardSig;
component ps2Receiver is
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
end component ps2Receiver;
		signal clk         : std_logic := '0';
		signal rst         : std_logic := '0';
		signal rxData      : std_logic_vector(7 downto 0) := (others => '0');
		signal dataReady   : std_logic := '0';
		signal dataFetched : std_logic := '1';
		signal ps2Data     : std_logic := '0';
		signal ps2Clk      : std_logic := '0';
begin
    
    process
    begin
        wait for 7 ms;
        assert false report "done" severity failure;
        wait;
    end process;

    clk_res: clk_res_gen
    port map(
        clk_50 => clk,
        rst    => rst
    );
    keyboard: keyboardSig 
    port map(
        ps2c => ps2Clk,
        ps2d => ps2Data
    );


    rec: ps2Receiver
    port map(
		clk         => clk,
		rst         => rst,
		rxData      => rxData,
		dataReady   => dataReady,
		dataFetched => dataFetched,
		ps2Data     => ps2Data,
		ps2Clk      => ps2Clk
    );

    
end behav;
