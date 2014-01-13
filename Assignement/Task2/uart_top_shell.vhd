----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:04:42 10/01/2013 
-- Design Name: 
-- Module Name:    uart_top_shell - Behavioral 
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

entity uart_top_shell is
  port(
        rst_i : in std_logic;
		  clk_i : in std_logic;
		  rx_i  : in std_logic;
		  tx_o  : out std_logic
	);

end uart_top_shell;

architecture Behavioral of uart_top_shell is
component clock_gen is
    port (
        rst_i : in std_logic;
		  clk_i : in std_logic;
		  ClrDiv_i : in std_logic;
		  TopRx : out std_logic;
		  TopTx : out std_logic;
		  Top16 : out std_logic;
		  Baud  : in std_logic_vector(2 downto 0)
		    );
end component clock_gen;

component uart_receive is
    port (
        rst_i : in std_logic;
		  clk_i : in std_logic;
		  ClrDiv_o : out std_logic;
		  Top16_i : std_logic;
		  TopRx_i : std_logic;
		  Dout_o  : out std_logic_vector(7 downto 0);
          Recvd   : out std_logic;
		  Rx_i    : in std_logic
		    );
end component uart_receive;

component uart_transmit is
    port (
        rst_i  : in std_logic;
		  clk_i  : in std_logic;
		  TopTX  : in std_logic;
		  Din_i  : in std_logic_vector(7 downto 0);
		  Tx_o   : out std_logic;
		  TxBusy_o: out std_logic;
		  LD_i   : in std_logic
		    );
end component uart_transmit;

constant c_baud : std_logic_vector(2 downto 0) := "000";
signal s_toprx : std_logic;
signal s_toptx : std_logic;
signal s_top16 : std_logic;
signal s_dout  : std_logic_vector(7 downto 0);
signal s_txbusy : std_logic;
signal s_clr_div : std_logic;
signal s_recvd  : std_logic;

begin

i_clock_gen : clock_gen
port map (
          rst_i => rst_i,
			 clk_i => clk_i,
			 ClrDiv_i => s_clr_div,
			 TopRx => s_toprx,
			 TopTx => s_toptx,
			 Top16 => s_top16,
			 Baud  => c_baud         
			 );

i_uart_rec : uart_receive
port map (
          rst_i => rst_i,
			 clk_i => clk_i,
			 ClrDiv_o => s_clr_div,
		    Top16_i => s_top16,
		    TopRx_i => s_toprx,
			 Dout_o => s_dout,
             Recvd => s_recvd,
			 Rx_i => rx_i
			 );

i_uart_tra : uart_transmit
port map (
          rst_i => rst_i,
			 clk_i => clk_i,
			 TopTX => s_toptx,
			 Din_i => s_dout,
			 Tx_o  => tx_o,
			 TxBusy_o => s_txbusy,
			 LD_i => s_recvd
			 );

end Behavioral;

