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
    
      RxRdyi <= '0';
    
      ClrDiv <= '0';
    
      RxErr <= '0';
  
    elsif rising_edge(clk_i) then
    
        
      case RxFSM is
       
        when Idle => 
 
        
        when Start_Rx => 

        when Edge_Rx => 

        when Shift_Rx => 

        when Stop_Rx => 

        when RxOVF => 

ClrDiv_o <= ClrDiv;

end Behavioral;

