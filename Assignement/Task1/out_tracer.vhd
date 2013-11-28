 library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_textio.all;
library std;
use std.textio.all;
use work.tb_package.all;

entity out_tracer is
    Port (
	 	 clk_i        : in std_logic;
       out_data_i  : in std_logic_vector(7 downto 0) 
       );
end out_tracer;

architecture Behavioral of out_tracer is

begin

p_main: process
--file emifb_tracer_file : text is OUT "$model_tech_tcl/../../../RTS_DSP/vhdl/Testcase/TC_RESET/TRACEFILES/emifb_trace.txt";
file out_tracer_file : text is OUT gen_filename&"/tracefiles/out_trace.txt";
variable v_line : line;

variable	v_read_data0_hex : string (2 downto 1);
variable v_trace_nr       : natural;
variable v_read_data0     : std_logic_vector(7 downto 0);


begin
write(v_line, string'(" ************************************************************** "));
writeline(out_tracer_file, v_line);
write(v_line, string'(" *** OUT Trace File                                      *** "));
writeline(out_tracer_file, v_line);
write(v_line, string'(" ************************************************************** "));
writeline(out_tracer_file, v_line);

write(v_line, string'("  NR"));
write(v_line, string'("   "));
write(v_line, string'("       TIME"));
write(v_line, string'("  "));
write(v_line, string'("   DATA"));
write(v_line, string'(" "));
writeline(out_tracer_file, v_line);
write(v_line, string'(" ---------------------------------------------------------------"));
writeline(out_tracer_file, v_line);
write(v_line, string'("    |              |        |"));
writeline(out_tracer_file, v_line);

while true loop

wait until out_data_i'EVENT;
   v_read_data0   :=out_data_i;
   write(v_line, v_trace_nr, justified => right, field => 4);
	write(v_line, string'("   "));
	write(v_line, now, justified => right, field => 12, unit => ns);
	write(v_line, string'("    "));
	v_read_data0_hex :=stdlogicvector_to_hexstring(v_read_data0);
	write(v_line, v_read_data0_hex);
	writeline(out_tracer_file, v_line);
	v_trace_nr := v_trace_nr+1;
end loop;

end process p_main;


end Behavioral;
