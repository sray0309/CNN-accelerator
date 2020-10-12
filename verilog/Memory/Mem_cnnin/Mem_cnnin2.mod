/*
 *      CONFIDENTIAL  AND  PROPRIETARY SOFTWARE OF ARM Physical IP, INC.
 *      
 *      Copyright (c) 1993-2020  ARM Physical IP, Inc.  All  Rights Reserved.
 *      
 *      Use of this Software is subject to the terms and conditions  of the
 *      applicable license agreement with ARM Physical IP, Inc.  In addition,
 *      this Software is protected by patents, copyright law and international
 *      treaties.
 *      
 *      The copyright notice(s) in this Software does not indicate actual or
 *      intended publication of this Software.
 *      
 *      name:			High Speed/Density Dual Port SRAM Generator
 *           			IBM CMRF8SF-LPVT Process
 *      version:		2009Q1V1
 *      comment:		
 *      configuration:	 -instname "Mem_cnnin2" -words 256 -bits 64 -frequency 1 -ring_width 4.0 -mux 4 -write_mask off -wp_size 8 -top_layer "met5-8" -power_type rings -horiz met3 -vert met4 -cust_comment "" -bus_notation on -left_bus_delim "[" -right_bus_delim "]" -pwr_gnd_rename "VDD:VDD,GND:VSS" -prefix "" -pin_space 0.0 -name_case upper -check_instname on -diodes on -inside_ring_type GND -drive 6 -dpccm on -asvm on -corners ff_1p32v_m40c,ff_1p65v_125c,tt_1p2v_25c,ss_1p08v_125c
 *
 *      Synopsys model for Synchronous Dual-Port Ram
 *
 *      Library Name:   aci
 *      Instance Name:  Mem_cnnin2
 *      Words:          256
 *      Word Width:     64
 *      Mux:            4
 *
 *      Creation Date:  2020-04-01 15:08:55Z
 *      Version:        2009Q1V1
 *
 *      Verified With: Synopsys Primetime
 *
 *      Modeling Assumptions: This library contains a black box description
 *          for a memory element.  At the library level, a
 *          default_max_transition constraint is set to the maximum
 *          characterized input slew.  Each output has a max_capacitance
 *          constraint set to the highest characterized output load.
 *          Different modes are defined in order to disable false path
 *          during the specific mode activation when doing static timing analysis. 
 *
 *
 *      Modeling Limitations: This stamp does not include power information.
 *          Due to limitations of the stamp modeling, some data reduction was
 *          necessary.  When reducing data, minimum values were chosen for the
 *          fast case corner and maximum values were used for the typical and
 *          best case corners.  It is recommended that critical timing and
 *          setup and hold times be checked at all corners.
 *
 *      Known Bugs: None.
 *
 *      Known Work Arounds: N/A
 *
 */

MODEL
MODEL_VERSION "1.0";
DESIGN "Mem_cnnin2";
INPUT AA[7:0];
INPUT DA[63:0];
INPUT WENA;
INPUT CENA;
INPUT CLKA;
OUTPUT QA[63:0];
INPUT AB[7:0];
INPUT DB[63:0];
INPUT WENB;
INPUT CENB;
INPUT CLKB;
OUTPUT QB[63:0];
MODE mem_mode_2_A =
                        ChipEnabled_A  COND(CENA==0),
                        DMYChipEnabled_A  COND(!(CENA==0));
MODE mem_mode_5_A =
                        ChipEnabled_WEN_0_A COND((CENA==0) && 
                        (WENA==0) 
                        ),
                        DMYChipEnabled_WEN_0_A COND(!((CENA==0) && 
                        (WENA==0) 
                        ));
MODE mem_mode_2_B =
                        ChipEnabled_B  COND(CENB==0),
                        DMYChipEnabled_B  COND(!(CENB==0));
MODE mem_mode_5_B =
                        ChipEnabled_WEN_0_B COND((CENB==0) && 
                        (WENB==0) 
                        ),
                        DMYChipEnabled_WEN_0_B COND(!((CENB==0) && 
                        (WENB==0) 
                        ));
setup_a_A: SETUP(POSEDGE) AA CLKA MODE(mem_mode_2_A=ChipEnabled_A);
hold_a_A:  HOLD(POSEDGE) AA CLKA MODE(mem_mode_2_A=ChipEnabled_A);

setup_cen_A: SETUP(POSEDGE) CENA CLKA ;
hold_cen_A:  HOLD(POSEDGE) CENA CLKA ;

setup_d_A: SETUP(POSEDGE) DA CLKA MODE(mem_mode_5_A=ChipEnabled_WEN_0_A);
hold_d_A:  HOLD(POSEDGE) DA CLKA MODE(mem_mode_5_A=ChipEnabled_WEN_0_A);

setup_wen_A: SETUP(POSEDGE) WENA CLKA MODE(mem_mode_2_A=ChipEnabled_A);
hold_wen_A:  HOLD(POSEDGE) WENA CLKA MODE(mem_mode_2_A=ChipEnabled_A);




period_clk_0_A: PERIOD(POSEDGE) CLKA;
pulsewidth_clk_h_0_A: WIDTH(POSEDGE) CLKA;
pulsewidth_clk_l_0_A: WIDTH(NEGEDGE) CLKA;

dly_clk_q_0_A: DELAY(POSEDGE) CLKA QA ;

setup_a_B: SETUP(POSEDGE) AB CLKB MODE(mem_mode_2_B=ChipEnabled_B);
hold_a_B:  HOLD(POSEDGE) AB CLKB MODE(mem_mode_2_B=ChipEnabled_B);

setup_cen_B: SETUP(POSEDGE) CENB CLKB ;
hold_cen_B:  HOLD(POSEDGE) CENB CLKB ;

setup_d_B: SETUP(POSEDGE) DB CLKB MODE(mem_mode_5_B=ChipEnabled_WEN_0_B);
hold_d_B:  HOLD(POSEDGE) DB CLKB MODE(mem_mode_5_B=ChipEnabled_WEN_0_B);

setup_wen_B: SETUP(POSEDGE) WENB CLKB MODE(mem_mode_2_B=ChipEnabled_B);
hold_wen_B:  HOLD(POSEDGE) WENB CLKB MODE(mem_mode_2_B=ChipEnabled_B);




period_clk_0_B: PERIOD(POSEDGE) CLKB;
pulsewidth_clk_h_0_B: WIDTH(POSEDGE) CLKB;
pulsewidth_clk_l_0_B: WIDTH(NEGEDGE) CLKB;

dly_clk_q_0_B: DELAY(POSEDGE) CLKB QB ;

cont_cc_A: SETUP(POSEDGE) CLKA CLKB ;
cont_cc_B: SETUP(POSEDGE) CLKB CLKA ;
ENDMODEL
