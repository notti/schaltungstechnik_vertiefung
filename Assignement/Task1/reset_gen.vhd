library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.tb_package.all;
--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.

entity reset_gen is
    Port ( command_i : in command_rec;
           reset_o   : out std_logic;
           done_o    : out std_logic_vector(gen_number downto 0)
			  );
end reset_gen;

architecture Behavioral of reset_gen is
signal duration : time;
signal start    : boolean:=false;
signal s_done_o : std_logic;

begin
-- signal assignement
done_o(0) <= s_done_o;
done_o(1) <= 'Z';
done_o(2) <= 'Z';
done_o(3) <= 'Z';
done_o(4) <= 'Z';
done_o(5) <= 'Z';
done_o(6) <= 'Z';
-- signal assignement

p_main: process
--variable duration : time;
variable value1   : string(1 to 8);

begin
s_done_o <= '0';
--reset_o <= '0';
wait on command_i;

if command_i.gen_number=0 then
--	done_o(0) <= '1';
	if command_i.mnemonic(1 to 5)="start" then
		value1:= command_i.value1;
   	     duration<=string_to_time(value1);
		start <= true; -- new
	  wait until start'EVENT and start=true;
		start <= false; -- new
	     s_done_o <= '1';
       wait on s_done_o;
	end if;
end if;

end process p_main;

p_reset: process
variable reset_length : time;
begin
       reset_o <= '0';
	  wait until start'EVENT and start=true;
	  reset_length := duration;
	  reset_o <= '1';
	  wait for reset_length;
end process p_reset;

end Behavioral;
