library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use work.tb_package.all;



entity tb_master is
	Port ( 
	 		done_i   : in std_logic_vector(gen_number downto 0);
			command_o : out command_rec
	 		);
end tb_master;

architecture Behavioral of tb_master is

begin

p_main: process

file stimuli_file : text is in gen_filename&"/stimulate.txt";
variable v_line   : line;
variable blank    : string(1 to 1);
variable char     : string(1 to 1);
variable n        : integer:=1;
variable v_trans  : bit:='0';
variable v_gen_number : integer:=0;
variable v_event  : boolean;
variable generator    : string (1 to 14);
variable v_command    : string (1 to 10);
variable v_value1     : string (1 to 8);
variable v_value2     : string (1 to 8);
variable v_value3     : string (1 to 8);
variable v_value4     : string (1 to 8);
variable v_value5     : string (1 to 8);
variable v_value6     : string (1 to 8);
variable master_command : string (1 to 4);
variable help_done    : boolean := false;
variable compare_help : std_logic_vector(gen_number downto 0);
variable done_help    : std_logic_vector(gen_number downto 0);
variable v_time       : time;
variable time_value   : string (1 to 8);
begin

while true loop
while v_event = false and (not endfile(stimuli_file))loop 

	char := " ";
	done_help := (others =>'U');
	compare_help :=(others=>'0');
	readline(stimuli_file, v_line);
	while char /= "(" and char/="$" and char/="-" loop
		read(v_line,char);
		generator(n to n) := char;
		n:=n+1;		
	end loop;
	n:=1;
	if generator(1 to 1)="$" then
      read(v_line,master_command);
		if master_command(1 to 4)="quit" then
			assert false
			report"Simulation Complete (This is not a failure)"
			severity failure;
		elsif master_command(1 to 4)="wait" then
     		read(v_line,blank);		   
			n:=1;
			while char /= "s"	loop
				read(v_line,char);
				time_value(n to n) := char;
				n:=n+1;		
			end loop;
			v_time:=string_to_time(time_value(1 to n-1));
			wait for v_time;
			v_event:= false;
			n:=1;
		end if;		
	elsif generator(1 to 1)="-" then
		v_event:= false;
	else
		v_event:=true;
		read(v_line,v_command);
		read(v_line,blank);
		read(v_line,v_value1);
		read(v_line,blank);
		read(v_line,v_value2);
		read(v_line,blank);
		read(v_line,v_value3);
		read(v_line,blank);
		read(v_line,v_value4);
		read(v_line,blank);
		read(v_line,v_value5);
		read(v_line,blank);
		read(v_line,v_value6);
		read(v_line,blank);
	 end if;

	 if v_event then
		if generator(1 to 5) = "reset" then
			v_gen_number:=0;
		elsif generator(1 to 5) ="clock" then
			v_gen_number:=1;
		elsif generator(1 to 6) ="enable" then
			v_gen_number:=5;
           elsif generator(1 to 6) ="bit_in" then
			v_gen_number:=6;

		end if;
	 end if;

	 if v_event then
	 	v_trans := not v_trans;
		command_o.gen_number <= v_gen_number;
	 	command_o.mnemonic <= v_command;
		command_o.value1   <= v_value1;
		command_o.value2   <= v_value2;
		command_o.value3   <= v_value3;
		command_o.value4   <= v_value4;
		command_o.value5   <= v_value5;
		command_o.value6   <= v_value6;
		command_o.trans    <= v_trans;

	 end if;
	end loop;
		if done_i=done_help then
		wait for 1 ps;
		wait until (done_i'EVENT and done_i(gen_number downto 0)=compare_help) ;
		else
		wait until (done_i'EVENT and done_i(gen_number downto 0)=compare_help) ;		
		end if;
		v_event:=false;
	end loop;

end process p_main;

end Behavioral;
