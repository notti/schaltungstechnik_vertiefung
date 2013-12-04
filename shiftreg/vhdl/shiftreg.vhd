library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.all;

entity shiftreg is
port(
    rst     : in std_logic;
    clk     : in std_logic;
    leftShift : in std_logic;
    rightShift : in std_logic;
    leftIn  : in std_logic;
    rightIn : in std_logic;
    regOut  : out std_logic_vector(7 downto 0)
);
end shiftreg;

architecture Structural of shiftreg is
    signal value : std_logic_vector(7 downto 0);
begin

    assert not (leftShift = '1' and rightShift = '1') report "can't shift both directions!" severity note;

    shift: process(clk, rst)
    begin
        if rst = '1' then
            value <= (others => '0');
        elsif rising_edge(clk) then
            if leftShift = '1' then
                value <= rightIn & value(7 downto 1);
            elsif rightShift = '1' then
                value <= value(6 downto 0) & leftIn;
            end if;
        end if;
    end process shift;

    regOut <= value;

end Structural;

