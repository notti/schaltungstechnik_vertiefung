library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;

entity pwmUnit is
    generic(
       div : natural := 7
    );
	port(
		clk_10 : in  std_logic;
		rst    : in  std_logic;
		duty   : in  std_logic_vector(7 downto 0);
		outSig : out std_logic := '0'
	);
end entity pwmUnit;

-- Led frequency 1kHz 256 Steps
-- 50 Mhz / 128 = 390625 Hz / 256 Steps = 1526 Hz

architecture RTL of pwmUnit is
    signal freq_cnt : unsigned(div-1 downto 0);
    signal pwm_cnt : unsigned(7 downto 0);
    signal duty_reg : unsigned(7 downto 0);
begin

    clk_div: process(clk_10, rst)
    begin
        if rst = '1' then
            freq_cnt <= (others => '0');
        elsif rising_edge(clk_10) then
            freq_cnt <= freq_cnt + 1;
        end if;
    end process;

    pwm: process(clk_10, rst)
    begin
        if rst = '1' then
            pwm_cnt <= (others => '0');
        elsif rising_edge(clk_10) and freq_cnt = 0 then
            pwm_cnt <= pwm_cnt + 1;
        end if;
    end process;

    duty_register: process(clk_10, rst)
    begin
        if rst = '1' then
            duty_reg <= (others => '0');
        elsif rising_edge(clk_10) and pwm_cnt = 0 then
            duty_reg <= unsigned(duty);
        end if;
    end process;

    outSig <= '0' when duty_reg = 0 else
              '1' when pwm_cnt <= duty_reg else
              '0';

end architecture RTL;
