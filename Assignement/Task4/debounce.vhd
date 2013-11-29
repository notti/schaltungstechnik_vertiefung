library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity debounce is
generic(
	CNT			: integer := 1500000;	-- 30 ms at 50 MHz
	CNT_WDT		: integer := 21
);
port(
	clk_50	: in std_logic;
    input    : in  std_logic;
    output   : out std_logic;
    riseedge : out std_logic;
    falledge : out std_logic
);
end debounce;

architecture behavioural of debounce is
	signal scnt		: unsigned(CNT_WDT-1 downto 0) := (others => '0');
    signal values   : std_logic_vector(3 downto 0) := (others => '0');
    signal io_out   : std_logic;
    signal io_out_dly : std_logic;
begin

io_out <= '1' when values(2 downto 0) = "111" else
          '0';

output <= io_out;
riseedge <= io_out and (not io_out_dly);
falledge <= (not io_out) and io_out_dly;

io_dly: process(clk_50)
begin
    if rising_edge(clk_50) then
        io_out_dly <= io_out;
    end if;
end process;

shift_in: process(clk_50, scnt)
begin
    if rising_edge(clk_50) and scnt = CNT then
        values <= input & values(3 downto 1);
    end if;
end process;

delay_cnt : process(clk_50)
begin
	if rising_edge(clk_50) then
        if scnt = CNT then
            scnt <= (others=>'0');
        else
            scnt <= scnt + 1;
        end if;
	end if;
end process;

end behavioural;
