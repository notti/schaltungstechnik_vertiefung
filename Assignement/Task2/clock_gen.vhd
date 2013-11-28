----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:04:12 10/01/2013 
-- Design Name: 
-- Module Name:    clock_gen - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_gen is
  port(
        rst_i : in std_logic;
		  clk_i : in std_logic;
		  ClrDiv_i : in std_logic;
		  TopRx : out std_logic;
		  TopTx : out std_logic;
		  Top16 : out std_logic;
		  Baud  : in std_logic_vector(2 downto 0)
	);
end clock_gen;

architecture Behavioral of clock_gen is

signal Divisor : natural;
signal s_Top16 : std_logic;
signal Div16 : integer;
signal ClkDiv : natural;
signal RxDiv  : natural;

begin
-- --------------------------
-- Baud rate selection
-- --------------------------
process (rst_i, clk_i)
begin
  if rst_i='1' then
    Divisor <= 0;
  elsif rising_edge(clk_i) then
    case Baud is
      when "000" => Divisor <= 26; -- 115.200
      when "001" => Divisor <= 52; -- 57.600
      when "010" => Divisor <= 93; -- 38.400
      when "011" => Divisor <= 160; -- 19.200
      when "100" => Divisor <= 322; -- 9.600
      when "101" => Divisor <= 646; -- 4.800
      when "110" => Divisor <= 1294; -- 2.400
      when "111" => Divisor <= 2590; -- 1.200
      when others => Divisor <= 26; -- n.u.
    end case;
  end if;
end process;

-- --------------------------
-- Clk16 Clock Generation
-- --------------------------
process (rst_i, clk_i)
begin
  if rst_i='1' then
    s_Top16 <= '0';
    Div16 <= 0;
  elsif rising_edge(clk_i) then
    s_Top16 <= '0';
    if Div16 = Divisor then
      Div16 <= 0;
      s_Top16 <= '1';
    else
      Div16 <= Div16 + 1;
    end if;
  end if;
end process;

-- --------------------------
-- Tx Clock Generation
-- --------------------------
process (rst_i, clk_i)
begin
  if rst_i='1' then
    TopTx <= '0';
    ClkDiv <= 0;
  elsif rising_edge(clk_i) then
    TopTx <= '0';
    if s_Top16='1' then
      ClkDiv <= ClkDiv + 1;
      if ClkDiv = 15 then
        TopTx <= '1';
		  ClkDiv<=0;
      end if;
    end if;
    
end if;
end process;

-- ------------------------------
-- Rx Sampling Clock Generation
-- ------------------------------
process (rst_i, clk_i)
begin
  if rst_i='1' then
    TopRx <= '0';
    RxDiv <= 0;
  elsif rising_edge(clk_i) then
    TopRx <= '0';
    if ClrDiv_i='1' then
      RxDiv <= 0;
    elsif s_Top16='1' then
      if RxDiv = 7 then
        RxDiv <= 0;
        TopRx <= '1';
      else
        RxDiv <= RxDiv + 1;
      end if;
	 end if;
  end if;
end process;

Top16 <= s_Top16;

end Behavioral;

