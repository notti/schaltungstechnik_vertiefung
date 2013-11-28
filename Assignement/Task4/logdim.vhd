library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use IEEE.numeric_std.all;

entity logDim is
	port(
		pwmIn  : in  std_logic_vector(5 downto 0);
		logPwm : out std_logic_vector(7 downto 0)
	);
end entity logDim;

architecture RTL of logDim is
	type rom_array is array (natural range 0 to 63) of std_logic_vector(7 downto 0);

	-- constant array definition to cover the logarithmic caracteristic
	constant rom_data : rom_array := (
		conv_std_logic_vector(0, 8),
		conv_std_logic_vector(1, 8),
		conv_std_logic_vector(2, 8),
		conv_std_logic_vector(3, 8),
		conv_std_logic_vector(4, 8),
		conv_std_logic_vector(5, 8),
		conv_std_logic_vector(6, 8),
		conv_std_logic_vector(7, 8),
		conv_std_logic_vector(8, 8),
		conv_std_logic_vector(9, 8),
		conv_std_logic_vector(10, 8),
		conv_std_logic_vector(11, 8),
		conv_std_logic_vector(12, 8),
		conv_std_logic_vector(13, 8),
		conv_std_logic_vector(14, 8),
		conv_std_logic_vector(16, 8),
		conv_std_logic_vector(18, 8),
		conv_std_logic_vector(20, 8),
		conv_std_logic_vector(22, 8),
		conv_std_logic_vector(25, 8),
		conv_std_logic_vector(28, 8),
		conv_std_logic_vector(30, 8),
		conv_std_logic_vector(33, 8),
		conv_std_logic_vector(36, 8),
		conv_std_logic_vector(39, 8),
		conv_std_logic_vector(42, 8),
		conv_std_logic_vector(46, 8),
		conv_std_logic_vector(49, 8),
		conv_std_logic_vector(53, 8),
		conv_std_logic_vector(56, 8),
		conv_std_logic_vector(60, 8),
		conv_std_logic_vector(64, 8),
		conv_std_logic_vector(68, 8),
		conv_std_logic_vector(72, 8),
		conv_std_logic_vector(77, 8),
		conv_std_logic_vector(81, 8),
		conv_std_logic_vector(86, 8),
		conv_std_logic_vector(90, 8),
		conv_std_logic_vector(95, 8),
		conv_std_logic_vector(100, 8),
		conv_std_logic_vector(105, 8),
		conv_std_logic_vector(110, 8),
		conv_std_logic_vector(116, 8),
		conv_std_logic_vector(121, 8),
		conv_std_logic_vector(127, 8),
		conv_std_logic_vector(132, 8),
		conv_std_logic_vector(138, 8),
		conv_std_logic_vector(144, 8),
		conv_std_logic_vector(150, 8),
		conv_std_logic_vector(156, 8),
		conv_std_logic_vector(163, 8),
		conv_std_logic_vector(169, 8),
		conv_std_logic_vector(176, 8),
		conv_std_logic_vector(182, 8),
		conv_std_logic_vector(189, 8),
		conv_std_logic_vector(196, 8),
		conv_std_logic_vector(203, 8),
		conv_std_logic_vector(210, 8),
		conv_std_logic_vector(218, 8),
		conv_std_logic_vector(225, 8),
		conv_std_logic_vector(233, 8),
		conv_std_logic_vector(240, 8),
		conv_std_logic_vector(246, 8),
		conv_std_logic_vector(255, 8)
	);
begin
	-- write output
	logPwm <= rom_data(conv_integer(unsigned(pwmIn)));
end architecture RTL;
