library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- This is the controller entity 
entity controller is
	port(
		clk_50     : in  std_logic;
		rst        : in  std_logic;

		-- Input events
		leftEvent  : in  std_logic;
		rightEvent : in  std_logic;
		pushEvent  : in  std_logic;
		
		-- PWM registers
		pwm0       : out std_logic_vector(5 downto 0);
		pwm1       : out std_logic_vector(5 downto 0);
		pwm2       : out std_logic_vector(5 downto 0);
		pwm3       : out std_logic_vector(5 downto 0);
		pwm4       : out std_logic_vector(5 downto 0);
		pwm5       : out std_logic_vector(5 downto 0);
		pwm6       : out std_logic_vector(5 downto 0);
		pwm7       : out std_logic_vector(5 downto 0)
	);
end entity controller;

architecture RTL of controller is

	-- output registers
	signal reg_pwm0 : unsigned(5 downto 0) := "000000";
	signal reg_pwm1 : unsigned(5 downto 0) := "000000";
	signal reg_pwm2 : unsigned(5 downto 0) := "000000";
	signal reg_pwm3 : unsigned(5 downto 0) := "000000";
	signal reg_pwm4 : unsigned(5 downto 0) := "000000";
	signal reg_pwm5 : unsigned(5 downto 0) := "000000";
	signal reg_pwm6 : unsigned(5 downto 0) := "000000";
	signal reg_pwm7 : unsigned(5 downto 0) := "000000";

	-- channel selector
	signal channel : unsigned(2 downto 0) := "000";
	type direction is (UP, DOWN);

	signal rEv_old : std_logic := '0';
	signal lEv_old : std_logic := '0';

	procedure inc_dec(dir             : in    direction;
		              signal reg_pwm0 : inout unsigned(5 downto 0);
		              signal reg_pwm1 : inout unsigned(5 downto 0);
		              signal reg_pwm2 : inout unsigned(5 downto 0);
		              signal reg_pwm3 : inout unsigned(5 downto 0);
		              signal reg_pwm4 : inout unsigned(5 downto 0);
		              signal reg_pwm5 : inout unsigned(5 downto 0);
		              signal reg_pwm6 : inout unsigned(5 downto 0);
		              signal reg_pwm7 : inout unsigned(5 downto 0)) is
	begin
		-- channel register increase or destease with saturation
		case channel is
			when "000" => if (dir = UP) then
					if (reg_pwm0 = "111111") then
						reg_pwm0 <= "111111";
					else
						reg_pwm0 <= reg_pwm0 + "1";
					end if;
				else
					if (reg_pwm0 = "000000") then
						reg_pwm0 <= "000000";
					else
						reg_pwm0 <= reg_pwm0 - "1";
					end if;
				end if;
			when "001" => if (dir = UP) then
					if (reg_pwm1 = "111111") then
						reg_pwm1 <= "111111";
					else
						reg_pwm1 <= reg_pwm1 + "1";
					end if;
				else
					if (reg_pwm1 = "000000") then
						reg_pwm1 <= "000000";
					else
						reg_pwm1 <= reg_pwm1 - "1";
					end if;
				end if;
			when "010" => if (dir = UP) then
					if (reg_pwm2 = "111111") then
						reg_pwm2 <= "111111";
					else
						reg_pwm2 <= reg_pwm2 + "1";
					end if;
				else
					if (reg_pwm2 = "000000") then
						reg_pwm2 <= "000000";
					else
						reg_pwm2 <= reg_pwm2 - "1";
					end if;
				end if;

			when "011" => if (dir = UP) then
					if (reg_pwm3 = "111111") then
						reg_pwm3 <= "111111";
					else
						reg_pwm3 <= reg_pwm3 + "1";
					end if;
				else
					if (reg_pwm3 = "000000") then
						reg_pwm3 <= "000000";
					else
						reg_pwm3 <= reg_pwm3 - "1";
					end if;
				end if;
			when "100" => if (dir = UP) then
					if (reg_pwm4 = "111111") then
						reg_pwm4 <= "111111";
					else
						reg_pwm4 <= reg_pwm4 + "1";
					end if;
				else
					if (reg_pwm4 = "000000") then
						reg_pwm4 <= "000000";
					else
						reg_pwm4 <= reg_pwm4 - "1";
					end if;
				end if;
			when "101" => if (dir = UP) then
					if (reg_pwm5 = "111111") then
						reg_pwm5 <= "111111";
					else
						reg_pwm5 <= reg_pwm5 + "1";
					end if;
				else
					if (reg_pwm5 = "000000") then
						reg_pwm5 <= "000000";
					else
						reg_pwm5 <= reg_pwm5 - "1";
					end if;
				end if;
			when "110" => if (dir = UP) then
					if (reg_pwm6 = "111111") then
						reg_pwm6 <= "111111";
					else
						reg_pwm6 <= reg_pwm6 + "1";
					end if;
				else
					if (reg_pwm6 = "000000") then
						reg_pwm6 <= "000000";
					else
						reg_pwm6 <= reg_pwm6 - "1";
					end if;
				end if;
			when "111" => if (dir = UP) then
					if (reg_pwm7 = "111111") then
						reg_pwm7 <= "111111";
					else
						reg_pwm7 <= reg_pwm7 + "1";
					end if;
				else
					if (reg_pwm7 = "000000") then
						reg_pwm7 <= "000000";
					else
						reg_pwm7 <= reg_pwm7 - "1";
					end if;
				end if;
			when others =>
		end case;
	end procedure inc_dec;

begin
	p_intensityUpDown : process(clk_50, rst)
		variable catREv : std_logic_vector(1 downto 0);
		variable catLEv : std_logic_vector(1 downto 0);
	begin
		if (rst = '1') then
			reg_pwm0 <= "000000";
			reg_pwm1 <= "000000";
			reg_pwm2 <= "000000";
			reg_pwm3 <= "000000";
			reg_pwm4 <= "000000";
			reg_pwm5 <= "000000";
			reg_pwm6 <= "000000";
			reg_pwm7 <= "000000";

		else
			if (clk_50'event and clk_50 = '1') then
				catREv := rightEvent & rEv_old;
				catLEv := leftEvent & lEv_old;
				
				-- cover a right twist event
				case (catREv) is
					when "10"   => inc_dec(UP, reg_pwm0, reg_pwm1, reg_pwm2, reg_pwm3, reg_pwm4, reg_pwm5, reg_pwm6, reg_pwm7);
					--report "UP for channel";
					when others =>
				end case;

				-- cover a left twist event
				case (catLEv) is
					when "10"   => inc_dec(DOWN, reg_pwm0, reg_pwm1, reg_pwm2, reg_pwm3, reg_pwm4, reg_pwm5, reg_pwm6, reg_pwm7);
					--report "DOWN for channel";
					when others =>
				end case;
				rEv_old <= rightEvent;
				lEv_old <= leftEvent;

			end if;
		end if;

	end process p_intensityUpDown;

	p_channelSelector : process(pushEvent, rst)
	begin
		if (rst = '1') then
			channel <= "000";
		else
			if (pushEvent'event and pushEvent = '1') then
				channel <= channel + "1";
			end if;
		end if;
	end process p_channelSelector;

	-- write to output ports
	pwm0 <= std_logic_vector(reg_pwm0);
	pwm1 <= std_logic_vector(reg_pwm1);
	pwm2 <= std_logic_vector(reg_pwm2);
	pwm3 <= std_logic_vector(reg_pwm3);
	pwm4 <= std_logic_vector(reg_pwm4);
	pwm5 <= std_logic_vector(reg_pwm5);
	pwm6 <= std_logic_vector(reg_pwm6);
	pwm7 <= std_logic_vector(reg_pwm7);

end architecture RTL;

