XILINXBASE = /opt/Xilinx/10.1/ISE/vhdl/src

GHDL = ghdl

GHDLFLAGS = --ieee=synopsys -fexplicit -Wc,-m32 -Wa,--32 -Wl,-m32
WORK = --work=work

tb_uart: tb_uart.o

%: %.o
	$(GHDL) -e $(GHDLFLAGS) $(LIBS) $(WORK) $@

%.o: %.vhd
	$(GHDL) -a $(GHDLFLAGS) $(LIBS) $(WORK) $<

%.ghw: %
	./$< --wave=$@

export 

clean:
	rm -rf work-obj93.cf
	rm -rf *.o *.s

vpath %.vhd ../vhdl:../../shiftreg/vhdl:.

.PHONY: clean
.SUFFIXES:
.SUFFIXES: .vhd .o .ghw

tb_uart.o: uart_top_shell.o
uart_top_shell.o: clock_gen.o uart_receive.o uart_transmit.o
