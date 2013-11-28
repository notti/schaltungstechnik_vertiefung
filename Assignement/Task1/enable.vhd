library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.tb_package.all;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity enable_gen is
    Port ( command_i : in command_rec;
           enable_o  : out std_logic;
           done_o    : out std_logic_vector(gen_number downto 0)
			  );

end enable_gen;

architecture Behavioral of enable_gen is
signal s_enable : std_logic:='0';
signal s_done_o : std_logic;

begin
done_o(0) <= 'Z';
done_o(1) <= 'Z';
done_o(2) <= 'Z';
done_o(3) <= 'Z';
done_o(4) <= 'Z';
done_o(5) <= s_done_o;
done_o(6) <= 'Z';

enable_o <= s_enable;
p_main: process

variable value1   : string(1 to 8);

begin
s_done_o <= '0';

wait on command_i;

if command_i.gen_number=5 then
	if command_i.mnemonic(1 to 6)="enable" then
		if command_i.value1(8)='1' then
			s_enable <= '1';
		else
			s_enable <= '0';
		end if;
	elsif command_i.mnemonic(1 to 4)="stop" then
--		start <= false;
	end if;
	s_done_o <= '1';
     wait on s_done_o;
end if;

end process p_main;

end Behavioral;
