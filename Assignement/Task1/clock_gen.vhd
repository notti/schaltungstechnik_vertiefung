library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.tb_package.all;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.

entity clock_gen is
    Port ( command_i : in command_rec;
           clk_o : out std_logic;
           done_o : out std_logic_vector(gen_number downto 0)
			  );
end clock_gen;

architecture Behavioral of clock_gen is
signal start : boolean := false;
signal s_clk_o : std_logic:='0';
signal width    : time;
signal s_done_o : std_logic;

begin

clk_o <= s_clk_o;
done_o(0) <= 'Z';
done_o(1) <= s_done_o;
done_o(2) <= 'Z';
done_o(3) <= 'Z';
done_o(4) <= 'Z';
done_o(5) <= 'Z';
done_o(6) <= 'Z';
p_main: process

variable value1   : string(1 to 8);

begin
s_done_o <= '0';

wait on command_i;

if command_i.gen_number=1 then
	if command_i.mnemonic(1 to 5)="start" then
		value1:= command_i.value1;
   	     width <=string_to_time(value1);
		start <= true;
	elsif command_i.mnemonic(1 to 4)="stop" then
		start <= false;
	end if;
	s_done_o <= '1';
     wait on s_done_o;
else
     s_done_o <= '0';
	start <= start;
end if;

end process p_main;

p_clock: process
begin
	wait on start;
	s_clk_o <='0';
	while start loop
		s_clk_o <= not s_clk_o;
		wait for (width/2);
	end loop;
end process p_clock;

end Behavioral;
