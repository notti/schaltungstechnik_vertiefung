XILINXBASE = /opt/Xilinx/10.1/ISE/vhdl/src

GHDL = ghdl

GHDLFLAGS = --ieee=synopsys -fexplicit -Wc,-m32 -Wa,--32 -Wl,-m32
WORK = --work=work

tb_debounce: tb_debounce.o
tb_rotkey: tb_rotkey.o
tb_pwm: tb_pwm.o

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

tb_debounce.o: debounce.o
tb_rotkey.o: rotkey.o
tb_pwm.o: pwm.o
rotkey.o: debounce.o
