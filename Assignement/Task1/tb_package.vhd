--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 


library IEEE;
use IEEE.STD_LOGIC_1164.all;

package tb_package is
	 constant gen_number : integer:= 6;
    constant gen_filename : string:= "/home/notti/uni/schaltungstech_vert/Assignement/Task1/testcase";
	 constant mc_width   : integer:= 31;

    type command_rec is record
	 		gen_number  : integer;
			Mnemonic    : string (1 to 10);
			value1      : string (1 to 8);
			value2      : string (1 to 8);
			value3      : string (1 to 8);
			value4      : string (1 to 8);
			value5      : string (1 to 8);
			value6      : string (1 to 8);
         		trans       : bit;
			end record;

	function string_to_integer (string_in:string) return integer;
	function string_to_time    (string_in:string) return time;
	function string_to_stdlogicvector (string_in : string; width : natural) return std_logic_vector;
	function stdlogicvector_to_hexstring (vector_in:std_logic_vector) return string;

end tb_package;


package body tb_package is

	function string_to_integer (string_in:string) return integer is
	variable value : integer := 0;
	variable temp  : integer := 0;
	
	begin
	for i in 1 to string_in'length loop
		case string_in(i) is
			when '0' => value :=0;
			when '1' => value :=1;
			when '2' => value :=2;
			when '3' => value :=3;
			when '4' => value :=4;
			when '5' => value :=5;
			when '6' => value :=6;			
			when '7' => value :=7;			
			when '8' => value :=8;
			when '9' => value :=9;
			when 'A' => value :=10;
			when 'a' => value :=10;
			when 'B' => value :=11;
			when 'b' => value :=11;
			when 'C' => value :=12;
			when 'c' => value :=12;
			when 'D' => value :=13;
			when 'd' => value :=13;
			when 'E' => value :=14;
			when 'e' => value :=14;
			when 'F' => value :=15;
			when 'f' => value :=15;
         when others => report "Integer not recognized";
		end case;
      temp:= temp+((16**(string_in'length-i))*value);
	end loop;
   return temp;
   end;
 
	function string_to_time (string_in:string) return time is
	variable temp  : time;
	variable temp0 : integer:=0;
	variable value : integer:=0;
	variable value1: integer:=0;
	variable value2: integer:=0;

	begin
		for i in 1 to string_in'length-2 loop
			case string_in(i) is
				when '0' => value :=0;
				when '1' => value :=1;
				when '2' => value :=2;
				when '3' => value :=3;
				when '4' => value :=4;
				when '5' => value :=5;
				when '6' => value :=6;
				when '7' => value :=7;
				when '8' => value :=8;
				when '9' => value :=9;
				when others => report "Integer Time not recognized";
			end case;
			temp0:=temp0+((10**(string_in'length-i-2))*value);
		end loop;
		
		value1:= string_in'length-1;
		value2:= string_in'length;

		case string_in(value1) is
			when 'f' => temp	:= temp0*(1 fs);
			when 'p' => temp	:= temp0*(1 ps);
			when 'n' => temp	:= temp0*(1 ns);
			when 'u' => temp	:= temp0*(1 us);
			when 'm' => temp	:= temp0*(1 ms);
			when others => report "Time base not recognized";
		end case;

	return temp;
	end;

	function string_to_stdlogicvector (string_in:string; width:natural) return std_logic_vector is
	variable temp : std_logic_vector(width-1 downto 0);
	variable value: std_logic_vector(3 downto 0);
	variable j    : natural;
	begin
	temp:=(others =>'0');
	for i in (width/4) downto 1 loop
		j:=j+1;
		case string_in(j) is
			when'0' => value:="0000";
			when'1' => value:="0001";
			when'2' => value:="0010";
			when'3' => value:="0011";
			when'4' => value:="0100";
			when'5' => value:="0101";
			when'6' => value:="0110";
			when'7' => value:="0111";
			when'8' => value:="1000";
			when'9' => value:="1001";
			when'A' => value:="1010";
			when'a' => value:="1010";
			when'B' => value:="1011";
			when'b' => value:="1011";
			when'C' => value:="1100";
			when'c' => value:="1100";
			when'D' => value:="1101";
			when'd' => value:="1101";
			when'E' => value:="1110";
			when'e' => value:="1110";
			when'F' => value:="1111";
			when'f' => value:="1111";
			when others => report "wrong stdlogicvector representation";
		end case;
		temp((((i-1)*4)+3) downto (i-1)*4) := value;
		end loop;
		return temp;
	end;

	function stdlogicvector_to_hexstring (vector_in:std_logic_vector) return string is
	variable temp  : string((vector_in'length/4) downto 1);
	variable char  : string(1 downto 1);
	variable help_vector : std_logic_vector(3 downto 0);

	begin
		for i in (vector_in'length/4) downto 1 loop
		help_vector := vector_in((i*4)-1 downto ((i*4)-4));
			case help_vector is
				when "0000" => char :="0";
				when "0001" => char :="1";
				when "0010" => char :="2";
				when "0011" => char :="3";
				when "0100" => char :="4";
				when "0101" => char :="5";
				when "0110" => char :="6";
				when "0111" => char :="7";
				when "1000" => char :="8";
				when "1001" => char :="9";
				when "1010" => char :="A";
				when "1011" => char :="B";
				when "1100" => char :="C";
				when "1101" => char :="D";
				when "1110" => char :="E";
				when "1111" => char :="F";
				when others => report "hexstring not recognized";
			end case;
			temp(i downto i):=char;
		end loop;
		
	return temp;
	end;


end tb_package;
