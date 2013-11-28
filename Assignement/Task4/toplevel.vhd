library ieee;
use ieee.std_logic_1164.all;

entity toplevel is
	port(
		-- input pins
		IN_clk_50   : in  std_logic;
		IN_rst      : in  std_logic;

		IN_RotA     : in  std_logic;
		IN_RotB     : in  std_logic;
		IN_RotPush  : in  std_logic;

		-- output pins
		OUT_LED_ch0 : out std_logic := '0';
		OUT_LED_ch1 : out std_logic := '0';
		OUT_LED_ch2 : out std_logic := '0';
		OUT_LED_ch3 : out std_logic := '0';
		OUT_LED_ch4 : out std_logic := '0';
		OUT_LED_ch5 : out std_logic := '0';
		OUT_LED_ch6 : out std_logic := '0';
		OUT_LED_ch7 : out std_logic := '0'
	);
end entity toplevel;

architecture RTL of toplevel is

	-- component declarations
	component rotKey
		port(clk_50        : in  std_logic;
			 rotA          : in  std_logic;
			 rotB          : in  std_logic;
			 rotPush       : in  std_logic;
			 rotRightEvent : out std_logic;
			 rotLeftEvent  : out std_logic;
			 rotPushEvent  : out std_logic);
	end component rotKey;

	component controller
		port(clk_50     : in  std_logic;
			 rst        : in  std_logic;
			 leftEvent  : in  std_logic;
			 rightEvent : in  std_logic;
			 pushEvent  : in  std_logic;
			 pwm0       : out std_logic_vector(5 downto 0);
			 pwm1       : out std_logic_vector(5 downto 0);
			 pwm2       : out std_logic_vector(5 downto 0);
			 pwm3       : out std_logic_vector(5 downto 0);
			 pwm4       : out std_logic_vector(5 downto 0);
			 pwm5       : out std_logic_vector(5 downto 0);
			 pwm6       : out std_logic_vector(5 downto 0);
			 pwm7       : out std_logic_vector(5 downto 0));
	end component controller;

	component logDim
		port(pwmIn  : in  std_logic_vector(5 downto 0);
			 logPwm : out std_logic_vector(7 downto 0));
	end component logDim;

	component pwmUnit
		port(clk_10 : in  std_logic;
			 rst    : in  std_logic;
			 duty   : in  std_logic_vector(7 downto 0);
			 outSig : out std_logic := '0');
	end component pwmUnit;

	-- signal declarations

	signal sig_rotRightEvent : std_logic;
	signal sig_rotLeftEvent  : std_logic;
	signal sig_rotPushEvent  : std_logic;

	signal sig_duty0 : std_logic_vector(5 downto 0);
	signal sig_duty1 : std_logic_vector(5 downto 0);
	signal sig_duty2 : std_logic_vector(5 downto 0);
	signal sig_duty3 : std_logic_vector(5 downto 0);
	signal sig_duty4 : std_logic_vector(5 downto 0);
	signal sig_duty5 : std_logic_vector(5 downto 0);
	signal sig_duty6 : std_logic_vector(5 downto 0);
	signal sig_duty7 : std_logic_vector(5 downto 0);

	signal sig_pwm0 : std_logic_vector(7 downto 0);
	signal sig_pwm1 : std_logic_vector(7 downto 0);
	signal sig_pwm2 : std_logic_vector(7 downto 0);
	signal sig_pwm3 : std_logic_vector(7 downto 0);
	signal sig_pwm4 : std_logic_vector(7 downto 0);
	signal sig_pwm5 : std_logic_vector(7 downto 0);
	signal sig_pwm6 : std_logic_vector(7 downto 0);
	signal sig_pwm7 : std_logic_vector(7 downto 0);

begin
	-- create instances and route signals

	inst_rotKey : rotKey
		port map(clk_50        => IN_clk_50,
			     rotA          => IN_rotA,
			     rotB          => IN_rotB,
			     rotPush       => IN_rotPush,
			     rotRightEvent => sig_rotRightEvent,
			     rotLeftEvent  => sig_rotLeftEvent,
			     rotPushEvent  => sig_rotPushEvent);

	inst_controller : controller
		port map(clk_50     => IN_clk_50,
			     rst        => IN_rst,
			     leftEvent  => sig_rotLeftEvent,
			     rightEvent => sig_rotRightEvent,
			     pushEvent  => sig_rotPushEvent,
			     pwm0       => sig_duty0,
			     pwm1       => sig_duty1,
			     pwm2       => sig_duty2,
			     pwm3       => sig_duty3,
			     pwm4       => sig_duty4,
			     pwm5       => sig_duty5,
			     pwm6       => sig_duty6,
			     pwm7       => sig_duty7);

	inst_log0 : logDim
		port map(pwmIn  => sig_duty0,
			     logPwm => sig_pwm0);

	inst_pwm0 : pwmUnit
		port map(clk_10 => IN_clk_50,
			     rst    => IN_rst,
			     duty   => sig_pwm0,
			     outSig => OUT_LED_ch0);

	inst_log1 : logDim
		port map(pwmIn  => sig_duty1,
			     logPwm => sig_pwm1);

	inst_pwm1 : pwmUnit
		port map(clk_10 => IN_clk_50,
			     rst    => IN_rst,
			     duty   => sig_pwm1,
			     outSig => OUT_LED_ch1);

	inst_log2 : logDim
		port map(pwmIn  => sig_duty2,
			     logPwm => sig_pwm2);

	inst_pwm2 : pwmUnit
		port map(clk_10 => IN_clk_50,
			     rst    => IN_rst,
			     duty   => sig_pwm2,
			     outSig => OUT_LED_ch2);

	inst_log3 : logDim
		port map(pwmIn  => sig_duty3,
			     logPwm => sig_pwm3);

	inst_pwm3 : pwmUnit
		port map(clk_10 => IN_clk_50,
			     rst    => IN_rst,
			     duty   => sig_pwm3,
			     outSig => OUT_LED_ch3);

	inst_log4 : logDim
		port map(pwmIn  => sig_duty4,
			     logPwm => sig_pwm4);

	inst_pwm4 : pwmUnit
		port map(clk_10 => IN_clk_50,
			     rst    => IN_rst,
			     duty   => sig_pwm4,
			     outSig => OUT_LED_ch4);

	inst_log5 : logDim
		port map(pwmIn  => sig_duty5,
			     logPwm => sig_pwm5);

	inst_pwm5 : pwmUnit
		port map(clk_10 => IN_clk_50,
			     rst    => IN_rst,
			     duty   => sig_pwm5,
			     outSig => OUT_LED_ch5);

	inst_log6 : logDim
		port map(pwmIn  => sig_duty6,
			     logPwm => sig_pwm6);

	inst_pwm6 : pwmUnit
		port map(clk_10 => IN_clk_50,
			     rst    => IN_rst,
			     duty   => sig_pwm6,
			     outSig => OUT_LED_ch6);

	inst_log7 : logDim
		port map(pwmIn  => sig_duty7,
			     logPwm => sig_pwm7);

	inst_pwm7 : pwmUnit
		port map(clk_10 => IN_clk_50,
			     rst    => IN_rst,
			     duty   => sig_pwm7,
			     outSig => OUT_LED_ch7);

end architecture RTL;