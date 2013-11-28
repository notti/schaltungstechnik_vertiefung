-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;
  use work.tb_package.all;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

	COMPONENT tb_master
	PORT(
		 done_i          : IN std_logic_vector(gen_number downto 0);          
		 command_o       : OUT command_rec
		);
	END COMPONENT;

	COMPONENT reset_gen
   Port (  
	    command_i      : in command_rec;
       reset_o        : out std_logic;
       done_o         : out std_logic_vector(gen_number downto 0)
		);
	END COMPONENT;

	COMPONENT clock_gen
   Port (  
	    command_i      : in command_rec;
       clk_o          : out std_logic;
       done_o         : out std_logic_vector(gen_number downto 0)
		);
	END COMPONENT;

	COMPONENT enable_gen
   Port (  
	    command_i      : in command_rec;
       enable_o       : out std_logic;
       done_o         : out std_logic_vector(gen_number downto 0)
		);		     
	END COMPONENT;

	COMPONENT bit_in_gen
   Port (  
	    command_i      : in command_rec;
       enable_o       : out std_logic;
       done_o         : out std_logic_vector(gen_number downto 0)
		);		     
	END COMPONENT;

	COMPONENT out_tracer
   Port (  
	 	 clk_i        : in std_logic;
       out_data_i  : in std_logic_vector(7 downto 0) 
		);
	END COMPONENT;

-- *************************************************************
-- D U T
-- *************************************************************
	COMPONENT shiftreg
   Port (  
		clk        : in  std_logic;
		rst        : in  std_logic;
		leftShift  : in  std_logic;
		rightShift : in  std_logic;
		leftIn     : in  std_logic;
		rightIn    : in  std_logic;
		regOut     : out std_logic_vector(7 downto 0) := (others => '0')
		);
	END COMPONENT;

signal done_i		        : std_logic_vector(gen_number downto 0);
signal command_o       : command_rec;
signal s_reset         : std_logic;
signal s_not_reset     : std_logic;
signal s_clk           : std_logic;
signal s_enable        : std_logic;
signal s_not_enable    : std_logic;
signal s_bit_in        : std_logic;
signal s_not_bit_in    : std_logic;
signal s_out_data_o    : std_logic_vector(7 downto 0);

  BEGIN

	i_tb_master: tb_master PORT MAP(
	 done_i => done_i,
	 command_o => command_o
	);

	i_reset_gen: reset_gen PORT MAP(
    command_i => command_o,
    reset_o   => s_reset,
    done_o    => done_i
	);

	i_clock_gen: clock_gen PORT MAP(
    command_i => command_o,
    clk_o     => s_clk,
    done_o    => done_i
	);

	i_enable_gen: enable_gen PORT MAP(
    command_i => command_o,
    enable_o  => s_enable,
    done_o    => done_i
	);

	i_bit_in_gen: bit_in_gen PORT MAP(
    command_i => command_o,
    enable_o  => s_bit_in,
    done_o    => done_i
	);


	i_out_tracer: out_tracer PORT MAP(
    clk_i       => s_clk,
    out_data_i => s_out_data_o 
   	);

-- *************************************************************
-- D U T
-- *************************************************************
	i_shiftreg: shiftreg PORT MAP(
	 	   clk	        => s_clk,				  
		   rst      	  => s_reset,
		   leftShift   => s_enable,
       rightShift  => s_not_enable,
       leftIn      => s_not_bit_in,
       rightIn     => s_bit_in,
		   regOut      => s_out_data_o
	);

-- *************************************************************
-- assignements
-- *************************************************************
  done_i(2)       <= '0';
  done_i(3)       <= '0';
  done_i(4)       <= '0';

  done_i(0)       <= 'Z';
  done_i(1)       <= 'Z';
  done_i(5)       <= 'Z';
  done_i(6)       <= 'Z';

  s_not_reset     <= not s_reset;
  s_not_enable    <= not s_enable;
  s_not_bit_in    <= not s_bit_in;
  END;
