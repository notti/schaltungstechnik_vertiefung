XILINXBASE = /opt/Xilinx/10.1/ISE/vhdl/src

GHDL = ghdl

GHDLFLAGS = --ieee=synopsys -fexplicit -Wc,-m32 -Wa,--32 -Wl,-m32
WORK = --work=work

testbench: testbench.o

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

testbench.o: bit_in.o  clock_gen.o  enable.o  out_tracer.o  reset_gen.o  tb_master.o  tb_package.o shiftreg.o
bit_in.o: tb_package.o
clock_gen.o: tb_package.o
enable.o : tb_package.o
out_tracer.o : tb_package.o
reset_gen.o : tb_package.o
tb_master.o : tb_package.o
shiftreg.o: tb_package.o
tb_shiftreg.o: shiftreg.o
