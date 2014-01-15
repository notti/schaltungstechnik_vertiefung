library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library work;

entity toplevel is
	port(
		clk     : in  std_logic;
		rst     : in  std_logic;

		ps2Data : in  std_logic;
		ps2Clk  : in  std_logic;

		lcd_e   : out std_logic;
		lcd_rs  : out std_logic;
		lcd_rw  : out std_logic;
		lcd_db  : out std_logic_vector(7 downto 0)
	);
end entity toplevel;

architecture RTL of toplevel is

    signal rxData : std_logic_vector(7 downto 0);
    signal asciiData : std_logic_vector(7 downto 0);
    signal asciiDataBig : std_logic_vector(7 downto 0);
    signal dataReady : std_logic;
    signal dataReadydly : std_logic;
    signal dataFetched : std_logic;
    signal released : std_logic;
    signal line_buffer : std_logic_vector(255 downto 0);
    signal pos : natural;
    signal shifta : std_logic;
    signal shiftb : std_logic;

begin

    inst_ps2Recv : entity work.ps2Receiver 
		port map(
		clk         => clk,
		rst         => rst,
		rxData      => rxData,
		dataReady   => dataReady,
		dataFetched => dataFetched,
		ps2Data     => ps2Data,
		ps2Clk      => ps2Clk);

    dataFetched <= '1';

    inst_lcd : entity work.lcd16x2_ctrl 
        port map(
        clk          => clk,
        rst          => rst,
        lcd_e        => lcd_e,
        lcd_rs       => lcd_rs,
        lcd_rw       => lcd_rw,
        lcd_db       => lcd_db(7 downto 4),
        line1_buffer => line_buffer(255 downto 128),
        line2_buffer => line_buffer(127 downto 0));

    lcd_db(3 downto 0) <= (others => '1');

    pos_counter: process(clk, rst)
    begin
        if rst = '1' then
            pos <= 31;
            released <= '0';
            line_buffer <= X"2020202020202020202020202020202020202020202020202020202020202020";
            shifta <= '0';
            shiftb <= '0';
        elsif rising_edge(clk) then
            dataReadydly <= dataReady;
            if dataReady = '1' and dataReadydly = '0' then
                if rxData = X"F0" then
                      released <= '1';
                elsif released = '1' then
                    if rxData = X"12" then
                        shifta <= '0';
                    elsif rxData = X"59" then
                        shiftb <= '0';
                    end if;
                    released <= '0';
                else
                    if rxData = X"12" then
                        shifta <= '1';
                    elsif rxData = X"59" then
                        shiftb <= '1';
                    else                        
                        line_buffer((pos*8)+7 downto pos*8) <= asciiDataBig;
                        if pos = 0 then
                            pos <= 32;
                        else
                            pos <= pos - 1;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process pos_counter;

    asciiData <=
        X"61" when rxData = X"1C" else --a
        X"62" when rxData = X"32" else
        X"63" when rxData = X"21" else
        X"64" when rxData = X"23" else
        X"65" when rxData = X"24" else
        X"66" when rxData = X"2B" else
        X"67" when rxData = X"34" else
        X"68" when rxData = X"33" else
        X"69" when rxData = X"43" else
        X"6A" when rxData = X"3B" else
        X"6B" when rxData = X"42" else
        X"6C" when rxData = X"4B" else
        X"6D" when rxData = X"3A" else
        X"6E" when rxData = X"31" else
        X"6F" when rxData = X"44" else
        X"70" when rxData = X"4D" else
        X"71" when rxData = X"15" else
        X"72" when rxData = X"2D" else
        X"73" when rxData = X"1B" else
        X"74" when rxData = X"2C" else
        X"75" when rxData = X"3C" else
        X"76" when rxData = X"2A" else
        X"77" when rxData = X"1D" else
        X"78" when rxData = X"22" else
        X"79" when rxData = X"35" else
        X"7A" when rxData = X"1A" else
           
        X"30" when rxData = X"45" else --0
        X"31" when rxData = X"16" else
        X"32" when rxData = X"1E" else
        X"33" when rxData = X"26" else
        X"34" when rxData = X"25" else
        X"35" when rxData = X"2E" else
        X"36" when rxData = X"36" else
        X"37" when rxData = X"3D" else
        X"38" when rxData = X"3E" else
        X"39" when rxData = X"46" else
        X"20" when rxData = X"29" else
        X"FF";
        
        asciiDataBig <= asciiData - X"20" when shifta = '1' or shiftb = '1' else
                        asciiData;
end architecture RTL;
