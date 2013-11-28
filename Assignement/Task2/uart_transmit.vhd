----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:03:53 10/01/2013 
-- Design Name: 
-- Module Name:    uart_transmit - Behavioral 
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

entity uart_transmit is
  port(
        rst_i  : in std_logic;
		  clk_i  : in std_logic;
		  TopTX  : in std_logic;
		  Din_i  : in std_logic_vector(7 downto 0);
		  Tx_o   : out std_logic;
		  TxBusy_o: out std_logic;
		  LD_i   : in std_logic
	);

end uart_transmit;

architecture Behavioral of uart_transmit is
type state_type is (idle, load_tx, shift_tx, stop_tx);
signal Tx_Reg : std_logic_vector(9 downto 0);
signal RegDin : std_logic_vector(7 downto 0);
signal TxBitCnt : natural;
signal TxFSM : state_type;

begin

-- --------------------------
-- Transmit State Machine
-- --------------------------
TX_o <= Tx_Reg(0);

Tx_FSM: process (rst_i, clk_i)
  begin
    if rst_i='1' then
      Tx_Reg <= (others => '1');
      TxBitCnt <= 0;
      TxFSM <= idle;
      TxBusy_o <= '0';
      RegDin <= (others=>'0');
    elsif rising_edge(clk_i) then
      
      case TxFSM is
        when Idle =>
            if Ld_i = '1' then
                TxFSM <= Load_tx;
                RegDin <= Din_i;
                TxBusy_o <= '1';
            end if;
        when Load_Tx =>
            if TopTX = '1' then
                TxFSM <= Shift_tx;
                TxBitCnt <= 10;
                Tx_Reg <= '1' & RegDin & '0';
            end if;
        when Shift_Tx =>
            if TopTX = '1' and TXBitCnt = 1 then
                TxFSM <= Stop_tx;
            end if;
            TxBitCnt <= TxBitCnt - 1;
            Tx_Reg <= '1' & Tx_Reg(8 downto 1);
        when Stop_Tx =>
            if TopTX = '1' then
                TxFSM <= Idle;
                TxBusy_o <= '0';
            end if;
        when others =>
          TxFSM <= Idle;
      end case;
    end if;
end process;

end Behavioral;

