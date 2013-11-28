----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:03:34 10/01/2013 
-- Design Name: 
-- Module Name:    uart_receive - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_receive is
  port(
        rst_i : in std_logic;
		  clk_i : in std_logic;
		  Top16_i : std_logic;
		  TopRx_i : std_logic;
		  Dout_o  : out std_logic_vector(7 downto 0);
		  ClrDiv_o: out std_logic;
		  Rx_i    : in std_logic
	);   


end uart_receive;

architecture Behavioral of uart_receive is
type state_type is (idle, start_rx, edge_rx, shift_rx, stop_rx, rxovf);
--constant NDbits : std_logic_vector(2 downto 0) :=8;
signal RxFSM : state_type;

signal Rx_Reg    : std_logic_vector(7 downto 0);
signal RxBitCnt  : integer;
signal RxRdyi    : std_logic;
signal ClrDiv    : std_logic;
signal RxErr     : std_logic;



begin

-- ------------------------
-- RECEIVE State Machine
-- ------------------------

    Rx_FSM: process (rst_i, clk_i)
    begin

        if rst_i='1' then
            Rx_Reg <= (others => '0');
            Dout_o <= (others => '0');
            RxBitCnt <= 0;
            RxFSM <= Idle;
            ClrDiv <= '0';
        elsif rising_edge(clk_i) then
            case RxFSM is
                when Idle => 
                    if Top16_i = '1' and Rx_i = '0' then
                        RxFSM <= Start_Rx;
                        ClrDiv <= '1';
                        RxBitCnt <= 0;
                    end if;
                when Start_Rx =>
                    if TopRx_i = '1' then
                        if Rx_i = '1' then
                            RxFSM <= RxOVF;
                        else
                            RxFSM <= Edge_Rx;
                        end if;
                    end if;
                when Edge_Rx =>
                    if TopRx_i = '1' then
                        if RxBitCnt = 8 then
                            RxFSM <= Stop_Rx;
                        else
                            RxFSM <= Shift_Rx;
                        end if;
                    end if;
                when Shift_Rx => 
                    if TopRx_i = '1' then
                        RxFSM <= Edge_Rx;
                        Rx_Reg(RxBitCnt) <= Rx_i;
                        RxBitCnt <= RxBitCnt + 1;
                    end if;
                when Stop_Rx => 
                    if TopRx_i = '1' then
                        RxFSM <= Idle;
                        Dout_o <= Rx_Reg;
                    end if;
                when RxOVF => 
                    if Rx_i = '1' then
                        RxFSM <= Idle;
                    end if;
            end case;
        end if;
    end process Rx_FSM;

ClrDiv_o <= ClrDiv;
RxRdyi <= '1' when RxFSM = Idle else '0';
RxErr <= '1' when RxFSM = RxOVF else '0';

end Behavioral;

