library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity debounce is
generic(
	CNT			: integer := 1500000;	-- 30 ms at 50 MHz
	CNT_WDT		: integer := 21
);
port(
	io_in	: in std_logic;
	io_out	: out std_logic;
	clk		: in std_logic
);
end debounce;

architecture behavioural of debounce is
	signal scnt		: unsigned(CNT_WDT-1 downto 0) := (others => '0');
    signal values   : std_logic_vector(3 downto 0) := (others => '0');
begin

io_out <= '1' when values(2 downto 0) = "111" else
          '0';

shift_in: process(clk, scnt)
begin
    if rising_edge(clk) and scnt = CNT then
        values <= io_in & values(3 downto 1);
    end if;
end process;

delay_cnt : process(clk)
begin
	if rising_edge(clk) then
        if scnt = CNT then
            scnt <= (others=>'0');
        else
            scnt <= scnt + 1;
        end if;
	end if;
end process;

end behavioural;
