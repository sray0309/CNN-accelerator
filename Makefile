STD_CELLS = /afs/umich.edu/class/eecs627/ibm13/artisan/2005q3v1/aci/sc-x/verilog/ibm13_neg.v
TESTBENCH = toplevel_tb.v
SIM_FILES = sys_defs.vh controller.v pe_decoder.v pe_array.v cnn_toplevel.v
WAVE_FILE = toplevel.dump

all: sim simvision

VV = vcs
VVOPTS     = -o $@ +v2k +vc -sverilog -timescale=1ns/1ps +vcs+lic+wait +multisource_int_delays \
				+neg_tchk +incdir+$(VERIF) +plusarg_save +overlap +warn=noSDFCOM_UHICD,noSDFCOM_IWSBA,noSDFCOM_IANE,noSDFCOM_PONF -full64 -cc gcc +libext+.v+.vlib+.vh +lint=TFIPC-L +define+DEBUG

sim:
	cd testbench; $(VV) $(VVOPTS) $(SIM_FILES) $(TESTBENCH); ./$@;

simvision:
	cd testbench; simvision $(WAVE_FILE)

synth:
	cd syn; dc_shell -tcl_mode -xg_mode -f cnn.syn.tcl