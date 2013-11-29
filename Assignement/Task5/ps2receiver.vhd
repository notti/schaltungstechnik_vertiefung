library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ps2Receiver is
    generic(
        TIMEOUT  = 5000 -- = 100us at 50Mhz
    );
	port(
		clk         : in  std_logic;
		rst         : in  std_logic;

		-- data 
		rxData      : out std_logic_vector(7 downto 0);

		-- module sync signals
		dataReady   : out std_logic;
		dataFetched : in  std_logic;

		-- ps2 pins
		ps2Data     : in  std_logic;
		ps2Clk      : in  std_logic
	);
end entity ps2Receiver;

architecture RTL of ps2Receiver is
    signal ps2Clk_sync : std_logic_vector(1 downto 0);
    signal ps2Clk_dly  : std_logic;
    signal ps2Clk_fall : std_logic;

    type state_type is (idle, wait_start, shift, check); 
    signal fsm : state_type;

    signal data : std_logic_vector(10 downto 0);
    signal bit_cnt : integer;


    signal timeout_cnt : integer;

begin
    ps2Clk_synchronizer: process(clk)
    begin
        if rising_edge(clk) then
            ps2Clk_sync <= ps2Clk & ps2Clk_sync(1);
        end if;
    end process ps2Clk_synchronizer;

    ps2Clk_delay: process(clk)
    begin
        if rising_edge(clk) then
            ps2Clk_dly <= ps2Clk_sync(0);
        end if;
    end process ps2Clk_delay;

    ps2Clk_fall <= (not ps2Clk_sync(0)) and ps2Clk_dly;

    timeout: process(clk, rst)
    begin
        if rst = '1' then
            timeout_cnt <= 0;
        elsif rising_edge(clk) then
            if ps2Clk_fall = '1' or timeout_cnt = TIMEOUT then
                timeout_cnt <= 0;
            else
                timeout_cnt <= timeout_cnt + 1;
            end if;
        end if;
    end process;

    fsm_p: process(clk, rst)
    begin
        if rst = '1' then
            fsm <= idle;
            bit_cnt <= 0;
            data <= (others => '1');
            rxData <= (others => '0');
        elsif rising_edge(clk) then
            case fsm is
                when idle =>
                    if dataFetched = '1' then
                        fsm <= wait_start;
                    end if;
                when wait_start =>
                    if ps2Clk_fall = '1' and ps2Data = '0' then
                        fsm <= shift;
                        bit_cnt <= 0;
                        data <= (10 => '0', others => '1')
                    end if;
                when shift => 
                    if timeout_cnt = TIMEOUT then
                        fsm <= idle;
                    end if;
                    if ps2Clk_fall = '1' then
                        bit_cnt <= bit_cnt + 1;
                        data <= ps2Data & data(10 downto 1);
                        if bit_cnt = 11 then
                            fsm <= check;
                        end if;
                    end if;
                when check =>
                    fsm <= idle;
                    if (xor data(9 downto 1)) = '1' and data(0) = '0' and data(10) = '1'  then
                        rxData <= data(9 downto 2);
                        dataReady <= '1';
                    end if;
            end case;
        end if;
    end process fsm_p;

end architecture RTL;
