--------------------------------------------------------------------------
--      CONFIDENTIAL  AND  PROPRIETARY SOFTWARE OF ARM Physical IP, INC.
--      
--      Copyright (c) 1993-2020  ARM Physical IP, Inc.  All  Rights Reserved.
--      
--      Use of this Software is subject to the terms and conditions  of the
--      applicable license agreement with ARM Physical IP, Inc.  In addition,
--      this Software is protected by patents, copyright law and international
--      treaties.
--      
--      The copyright notice(s) in this Software does not indicate actual or
--      intended publication of this Software.
--      
--      name:			High Speed/Density Dual Port SRAM Generator
--           			IBM CMRF8SF-LPVT Process
--      version:		2009Q1V1
--      comment:		
--      configuration:	 -instname "Mem_cnnin2" -words 256 -bits 64 -frequency 1 -ring_width 4.0 -mux 4 -write_mask off -wp_size 8 -top_layer "met5-8" -power_type rings -horiz met3 -vert met4 -cust_comment "" -bus_notation on -left_bus_delim "[" -right_bus_delim "]" -pwr_gnd_rename "VDD:VDD,GND:VSS" -prefix "" -pin_space 0.0 -name_case upper -check_instname on -diodes on -inside_ring_type GND -drive 6 -dpccm on -asvm on -corners ff_1p32v_m40c,ff_1p65v_125c,tt_1p2v_25c,ss_1p08v_125c
--
--      VHDL model for Synchronous Dual-Port Ram
--
--      Instance:       Mem_cnnin2
--      Address Length: 256
--      Word Width:     64
--
--      Creation Date:  2020-04-01 15:08:50Z
--      Version:        2009Q1V1
--
--      Verified With:  Model Technology VCOM V-System VHDL
--			Version 5.2c
--
--      Modeling Assumptions: This model supports full gate-level simulaton
--          including proper x-handling and timing check behavior.  It is
--          VITAL_LEVEL1 compliant.  Unit delay timing is included in the
--          model. Back-annotation of SDF (v2.1) is supported.  SDF can be
--          created utilyzing the delay calculation views provided with this
--          generator and supported delay calculators.  For netlisting
--          simplicity, buses are not exploded.  All buses are modeled
--          [MSB:LSB].  To operate properly, this model must be used with the
--          Artisan's Vhdl packages.
--
--      Modeling Limitations: To be compatible with Synopsys/VSS in term of
--	    SDF back-annotation, this model has to be Vital Level0 compliant.
--	    This feature may result in degraded performances.
--
--      Known Bugs: None.
--
--      Known Work Arounds: N/A
--------------------------------------------------------------------------
LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use IEEE.std_logic_arith.all;
use STD.TEXTIO.ALL;
use STD.TextIO;
use WORK.vlibs.all;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_primitives.all;

  entity Mem_cnnin2 is
    generic(
        BITS : integer := 64;
        WORD_DEPTH : integer := 256;
        ADDR_WIDTH : integer := 8;
        WORDX : std_logic_vector := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        WORDXXX : std_logic_vector := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        WORD1 : std_logic_vector := "1111111111111111111111111111111111111111111111111111111111111111";
        ADDRX : std_logic_vector := "XXXXXXXX";
        ADDR1 : std_logic_vector := "11111111";
        WEN_WIDTH : integer := 1;
        WP_SIZE : integer :=  64;
        RCOLS : integer := 0;
        MASKX : std_logic_vector := "X";
        MASK1 : std_logic_vector := "1";
        MASK0 : std_logic_vector := "0";
        MUX : integer := 4;
        MUX_TIMES_4: integer := 16;
        COL_ADDR_WIDTH : integer := 2;
        RROWS : integer := 0;
        UPM_WIDTH : integer := 3;
        UPM0 : std_logic_vector := "000";
        RCA_WIDTH : integer := 1;
        RED_COLUMNS : integer := 2;

	tipd_CLKA: VitalDelayType01:=(0.000 ns, 0.000 ns);
	tipd_CENA: VitalDelayType01:=(0.000 ns, 0.000 ns);
	tipd_WENA: VitalDelayType01:=(0.000 ns, 0.000 ns);
	tipd_AA: VitalDelayArrayType01(7 downto 0):=(others=>(0.000 ns, 0.000 ns));
	tipd_DA: VitalDelayArrayType01(63 downto 0):=(others=>(0.000 ns, 0.000 ns));
	tipd_CLKB: VitalDelayType01:=(0.000 ns, 0.000 ns);
	tipd_CENB: VitalDelayType01:=(0.000 ns, 0.000 ns);
	tipd_WENB: VitalDelayType01:=(0.000 ns, 0.000 ns);
	tipd_AB: VitalDelayArrayType01(7 downto 0):=(others=>(0.000 ns, 0.000 ns));
	tipd_DB: VitalDelayArrayType01(63 downto 0):=(others=>(0.000 ns, 0.000 ns));
	tisd_CENA_CLKA: VitalDelayType:=0.000 ns;
	tisd_WENA_CLKA: VitalDelayType:=0.000 ns;
	tisd_AA0_CLKA: VitalDelayType:=0.000 ns;
	tisd_AA1_CLKA: VitalDelayType:=0.000 ns;
	tisd_AA2_CLKA: VitalDelayType:=0.000 ns;
	tisd_AA3_CLKA: VitalDelayType:=0.000 ns;
	tisd_AA4_CLKA: VitalDelayType:=0.000 ns;
	tisd_AA5_CLKA: VitalDelayType:=0.000 ns;
	tisd_AA6_CLKA: VitalDelayType:=0.000 ns;
	tisd_AA7_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA0_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA1_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA2_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA3_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA4_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA5_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA6_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA7_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA8_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA9_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA10_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA11_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA12_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA13_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA14_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA15_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA16_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA17_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA18_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA19_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA20_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA21_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA22_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA23_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA24_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA25_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA26_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA27_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA28_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA29_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA30_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA31_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA32_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA33_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA34_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA35_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA36_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA37_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA38_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA39_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA40_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA41_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA42_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA43_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA44_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA45_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA46_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA47_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA48_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA49_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA50_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA51_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA52_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA53_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA54_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA55_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA56_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA57_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA58_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA59_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA60_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA61_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA62_CLKA: VitalDelayType:=0.000 ns;
	tisd_DA63_CLKA: VitalDelayType:=0.000 ns;
	tperiod_CLKA  : VitalDelayType := 3.000 ns;
	tpw_CLKA_negedge: VitalDelayType := 1.000 ns;
	tpw_CLKA_posedge: VitalDelayType := 1.000 ns;
	ticd_CLKA: VitalDelayType:=0.000 ns;
	tsetup_CENA_CLKA_posedge_posedge: VitalDelayType:=1.000 ns;
	tsetup_CENA_CLKA_negedge_posedge: VitalDelayType:=1.000 ns;
	tsetup_WENA_CLKA_posedge_posedge: VitalDelayType:=1.000 ns;
	tsetup_WENA_CLKA_negedge_posedge: VitalDelayType:=1.000 ns;
	tsetup_AA_CLKA_posedge_posedge: VitalDelayArrayType(7 downto 0):=(others=>(1.000 ns));
	tsetup_AA_CLKA_negedge_posedge: VitalDelayArrayType(7 downto 0):=(others=>(1.000 ns));
	tsetup_DA_CLKA_posedge_posedge: VitalDelayArrayType(63 downto 0):=(others=>(1.000 ns));
	tsetup_DA_CLKA_negedge_posedge: VitalDelayArrayType(63 downto 0):=(others=>(1.000 ns));
	thold_CENA_CLKA_posedge_posedge: VitalDelayType:=0.500 ns;
	thold_CENA_CLKA_negedge_posedge: VitalDelayType:=0.500 ns;
	thold_WENA_CLKA_posedge_posedge: VitalDelayType:=0.500 ns;
	thold_WENA_CLKA_negedge_posedge: VitalDelayType:=0.500 ns;
	thold_AA_CLKA_posedge_posedge: VitalDelayArrayType(7 downto 0):=(others=>(0.500 ns));
	thold_AA_CLKA_negedge_posedge: VitalDelayArrayType(7 downto 0):=(others=>(0.500 ns));
	thold_DA_CLKA_posedge_posedge: VitalDelayArrayType(63 downto 0):=(others=>(0.500 ns));
	thold_DA_CLKA_negedge_posedge: VitalDelayArrayType(63 downto 0):=(others=>(0.500 ns));
	tpd_CLKA_QA: VitalDelayArrayType01(63 downto 0) := (others => (1.000 ns, 1.000 ns));
	tisd_CENB_CLKB: VitalDelayType:=0.000 ns;
	tisd_WENB_CLKB: VitalDelayType:=0.000 ns;
	tisd_AB0_CLKB: VitalDelayType:=0.000 ns;
	tisd_AB1_CLKB: VitalDelayType:=0.000 ns;
	tisd_AB2_CLKB: VitalDelayType:=0.000 ns;
	tisd_AB3_CLKB: VitalDelayType:=0.000 ns;
	tisd_AB4_CLKB: VitalDelayType:=0.000 ns;
	tisd_AB5_CLKB: VitalDelayType:=0.000 ns;
	tisd_AB6_CLKB: VitalDelayType:=0.000 ns;
	tisd_AB7_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB0_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB1_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB2_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB3_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB4_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB5_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB6_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB7_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB8_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB9_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB10_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB11_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB12_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB13_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB14_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB15_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB16_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB17_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB18_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB19_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB20_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB21_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB22_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB23_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB24_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB25_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB26_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB27_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB28_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB29_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB30_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB31_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB32_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB33_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB34_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB35_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB36_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB37_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB38_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB39_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB40_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB41_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB42_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB43_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB44_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB45_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB46_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB47_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB48_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB49_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB50_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB51_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB52_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB53_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB54_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB55_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB56_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB57_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB58_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB59_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB60_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB61_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB62_CLKB: VitalDelayType:=0.000 ns;
	tisd_DB63_CLKB: VitalDelayType:=0.000 ns;
	tperiod_CLKB  : VitalDelayType := 3.000 ns;
	tpw_CLKB_negedge: VitalDelayType := 1.000 ns;
	tpw_CLKB_posedge: VitalDelayType := 1.000 ns;
	ticd_CLKB: VitalDelayType:=0.000 ns;
	tsetup_CENB_CLKB_posedge_posedge: VitalDelayType:=1.000 ns;
	tsetup_CENB_CLKB_negedge_posedge: VitalDelayType:=1.000 ns;
	tsetup_WENB_CLKB_posedge_posedge: VitalDelayType:=1.000 ns;
	tsetup_WENB_CLKB_negedge_posedge: VitalDelayType:=1.000 ns;
	tsetup_AB_CLKB_posedge_posedge: VitalDelayArrayType(7 downto 0):=(others=>(1.000 ns));
	tsetup_AB_CLKB_negedge_posedge: VitalDelayArrayType(7 downto 0):=(others=>(1.000 ns));
	tsetup_DB_CLKB_posedge_posedge: VitalDelayArrayType(63 downto 0):=(others=>(1.000 ns));
	tsetup_DB_CLKB_negedge_posedge: VitalDelayArrayType(63 downto 0):=(others=>(1.000 ns));
	thold_CENB_CLKB_posedge_posedge: VitalDelayType:=0.500 ns;
	thold_CENB_CLKB_negedge_posedge: VitalDelayType:=0.500 ns;
	thold_WENB_CLKB_posedge_posedge: VitalDelayType:=0.500 ns;
	thold_WENB_CLKB_negedge_posedge: VitalDelayType:=0.500 ns;
	thold_AB_CLKB_posedge_posedge: VitalDelayArrayType(7 downto 0):=(others=>(0.500 ns));
	thold_AB_CLKB_negedge_posedge: VitalDelayArrayType(7 downto 0):=(others=>(0.500 ns));
	thold_DB_CLKB_posedge_posedge: VitalDelayArrayType(63 downto 0):=(others=>(0.500 ns));
	thold_DB_CLKB_negedge_posedge: VitalDelayArrayType(63 downto 0):=(others=>(0.500 ns));
	tpd_CLKB_QB: VitalDelayArrayType01(63 downto 0) := (others => (1.000 ns, 1.000 ns));
	tsetup_CLKA_CLKB_posedge_posedge: VitalDelayType:=3.000 ns;
	tsetup_CLKB_CLKA_posedge_posedge: VitalDelayType:=3.000 ns;

        XOn : Boolean := TRUE;
        MsgOn : Boolean := TRUE;
        MsgSeverity : SEVERITY_LEVEL := WARNING;
        InstancePath : STRING := "*";
	NO_SDTC: BOOLEAN := FALSE;
	TimingChecksOn: BOOLEAN := TRUE
    );
    port ( 
	QA: out std_logic_vector(63 downto 0);
	QB: out std_logic_vector(63 downto 0);
	CLKA: in std_logic;
	CENA: in std_logic;
	WENA: in std_logic;
	AA: in std_logic_vector(7 downto 0);
	DA: in std_logic_vector(63 downto 0);
	CLKB: in std_logic;
	CENB: in std_logic;
	WENB: in std_logic;
	AB: in std_logic_vector(7 downto 0);
	DB: in std_logic_vector(63 downto 0)
    );
    attribute VITAL_LEVEL0 of Mem_cnnin2 : entity is TRUE;
end Mem_cnnin2;

-----------------------------------------------------------------------------
architecture Behavioral of Mem_cnnin2 is
 attribute VITAL_LEVEL0 of behavioral : architecture is TRUE;
        subtype MEM_BITS is integer range 65 downto 0;
        subtype MEM_WORDS is integer range 255 downto 0;
        subtype ROW_WORDS is integer range 15 downto 0;
        subtype MEM_WORD is std_logic_vector(MEM_BITS);
        type MEM_TYPE is array(MEM_WORDS) of MEM_WORD;
        type ROW_TYPE is array(ROW_WORDS) of MEM_WORD;
        signal CLKA_ipd :std_logic;
        signal CLKA_dly :std_logic;
        signal CENA_ipd :std_logic;
        signal CENA_dly :std_logic;
        signal WENA_ipd :std_logic;
        signal WENA_dly :std_logic;
        signal WENA_dlyb :std_logic_vector(0 to 0);
        signal AA_ipd :std_logic_vector(7 downto 0);
        signal AA_dly :std_logic_vector(7 downto 0);
        signal DA_ipd :std_logic_vector(63 downto 0);
        signal DA_dly :std_logic_vector(63 downto 0);
        signal TDA_dly : std_logic_vector(BITS-1 downto 0) := (others => '1');
        signal TAA_dly : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '1');
        signal TCENA_dly : std_logic := '0';
        signal TENA_dly : std_logic := '1';
        signal BENA_dly : std_logic := '1';
        signal TWENA_dlyb : std_logic_vector(0 downto 0) := (others => '0');
        signal EMAA_dly : std_logic_vector(1 downto 0) := (others => '0');
        signal ARTNA_dly : std_logic := '0';
        signal CRENA_dly: std_logic_vector(BITS-1 downto 0):= (others => '1');
        signal RCAA_dly : std_logic := '1';
        signal RRENA_dly : std_logic := '1';
        signal RRAA_dly : std_logic := '1';
        signal tisd_AA_CLKA : VitalDelayArrayType(ADDR_WIDTH-1 downto 0) := (
                  tisd_AA7_CLKA,
                  tisd_AA6_CLKA,
                  tisd_AA5_CLKA,
                  tisd_AA4_CLKA,
                  tisd_AA3_CLKA,
                  tisd_AA2_CLKA,
                  tisd_AA1_CLKA,
                  tisd_AA0_CLKA);
        signal tisd_DA_CLKA : VitalDelayArrayType(BITS-1 downto 0) := (
                  tisd_DA63_CLKA,
                  tisd_DA62_CLKA,
                  tisd_DA61_CLKA,
                  tisd_DA60_CLKA,
                  tisd_DA59_CLKA,
                  tisd_DA58_CLKA,
                  tisd_DA57_CLKA,
                  tisd_DA56_CLKA,
                  tisd_DA55_CLKA,
                  tisd_DA54_CLKA,
                  tisd_DA53_CLKA,
                  tisd_DA52_CLKA,
                  tisd_DA51_CLKA,
                  tisd_DA50_CLKA,
                  tisd_DA49_CLKA,
                  tisd_DA48_CLKA,
                  tisd_DA47_CLKA,
                  tisd_DA46_CLKA,
                  tisd_DA45_CLKA,
                  tisd_DA44_CLKA,
                  tisd_DA43_CLKA,
                  tisd_DA42_CLKA,
                  tisd_DA41_CLKA,
                  tisd_DA40_CLKA,
                  tisd_DA39_CLKA,
                  tisd_DA38_CLKA,
                  tisd_DA37_CLKA,
                  tisd_DA36_CLKA,
                  tisd_DA35_CLKA,
                  tisd_DA34_CLKA,
                  tisd_DA33_CLKA,
                  tisd_DA32_CLKA,
                  tisd_DA31_CLKA,
                  tisd_DA30_CLKA,
                  tisd_DA29_CLKA,
                  tisd_DA28_CLKA,
                  tisd_DA27_CLKA,
                  tisd_DA26_CLKA,
                  tisd_DA25_CLKA,
                  tisd_DA24_CLKA,
                  tisd_DA23_CLKA,
                  tisd_DA22_CLKA,
                  tisd_DA21_CLKA,
                  tisd_DA20_CLKA,
                  tisd_DA19_CLKA,
                  tisd_DA18_CLKA,
                  tisd_DA17_CLKA,
                  tisd_DA16_CLKA,
                  tisd_DA15_CLKA,
                  tisd_DA14_CLKA,
                  tisd_DA13_CLKA,
                  tisd_DA12_CLKA,
                  tisd_DA11_CLKA,
                  tisd_DA10_CLKA,
                  tisd_DA9_CLKA,
                  tisd_DA8_CLKA,
                  tisd_DA7_CLKA,
                  tisd_DA6_CLKA,
                  tisd_DA5_CLKA,
                  tisd_DA4_CLKA,
                  tisd_DA3_CLKA,
                  tisd_DA2_CLKA,
                  tisd_DA1_CLKA,
                  tisd_DA0_CLKA);
        signal CLKB_ipd :std_logic;
        signal CLKB_dly :std_logic;
        signal CENB_ipd :std_logic;
        signal CENB_dly :std_logic;
        signal WENB_ipd :std_logic;
        signal WENB_dly :std_logic;
        signal WENB_dlyb :std_logic_vector(0 to 0);
        signal AB_ipd :std_logic_vector(7 downto 0);
        signal AB_dly :std_logic_vector(7 downto 0);
        signal DB_ipd :std_logic_vector(63 downto 0);
        signal DB_dly :std_logic_vector(63 downto 0);
        signal TDB_dly : std_logic_vector(BITS-1 downto 0) := (others => '1');
        signal TAB_dly : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '1');
        signal TCENB_dly : std_logic := '0';
        signal TENB_dly : std_logic := '1';
        signal BENB_dly : std_logic := '1';
        signal TWENB_dlyb : std_logic_vector(0 downto 0) := (others => '0');
        signal EMAB_dly : std_logic_vector(1 downto 0) := (others => '0');
        signal ARTNB_dly : std_logic := '0';
        signal CRENB_dly: std_logic_vector(BITS-1 downto 0):= (others => '1');
        signal RCAB_dly : std_logic := '1';
        signal RRENB_dly : std_logic := '1';
        signal RRAB_dly : std_logic := '1';
        signal tisd_AB_CLKB : VitalDelayArrayType(ADDR_WIDTH-1 downto 0) := (
                  tisd_AB7_CLKB,
                  tisd_AB6_CLKB,
                  tisd_AB5_CLKB,
                  tisd_AB4_CLKB,
                  tisd_AB3_CLKB,
                  tisd_AB2_CLKB,
                  tisd_AB1_CLKB,
                  tisd_AB0_CLKB);
        signal tisd_DB_CLKB : VitalDelayArrayType(BITS-1 downto 0) := (
                  tisd_DB63_CLKB,
                  tisd_DB62_CLKB,
                  tisd_DB61_CLKB,
                  tisd_DB60_CLKB,
                  tisd_DB59_CLKB,
                  tisd_DB58_CLKB,
                  tisd_DB57_CLKB,
                  tisd_DB56_CLKB,
                  tisd_DB55_CLKB,
                  tisd_DB54_CLKB,
                  tisd_DB53_CLKB,
                  tisd_DB52_CLKB,
                  tisd_DB51_CLKB,
                  tisd_DB50_CLKB,
                  tisd_DB49_CLKB,
                  tisd_DB48_CLKB,
                  tisd_DB47_CLKB,
                  tisd_DB46_CLKB,
                  tisd_DB45_CLKB,
                  tisd_DB44_CLKB,
                  tisd_DB43_CLKB,
                  tisd_DB42_CLKB,
                  tisd_DB41_CLKB,
                  tisd_DB40_CLKB,
                  tisd_DB39_CLKB,
                  tisd_DB38_CLKB,
                  tisd_DB37_CLKB,
                  tisd_DB36_CLKB,
                  tisd_DB35_CLKB,
                  tisd_DB34_CLKB,
                  tisd_DB33_CLKB,
                  tisd_DB32_CLKB,
                  tisd_DB31_CLKB,
                  tisd_DB30_CLKB,
                  tisd_DB29_CLKB,
                  tisd_DB28_CLKB,
                  tisd_DB27_CLKB,
                  tisd_DB26_CLKB,
                  tisd_DB25_CLKB,
                  tisd_DB24_CLKB,
                  tisd_DB23_CLKB,
                  tisd_DB22_CLKB,
                  tisd_DB21_CLKB,
                  tisd_DB20_CLKB,
                  tisd_DB19_CLKB,
                  tisd_DB18_CLKB,
                  tisd_DB17_CLKB,
                  tisd_DB16_CLKB,
                  tisd_DB15_CLKB,
                  tisd_DB14_CLKB,
                  tisd_DB13_CLKB,
                  tisd_DB12_CLKB,
                  tisd_DB11_CLKB,
                  tisd_DB10_CLKB,
                  tisd_DB9_CLKB,
                  tisd_DB8_CLKB,
                  tisd_DB7_CLKB,
                  tisd_DB6_CLKB,
                  tisd_DB5_CLKB,
                  tisd_DB4_CLKB,
                  tisd_DB3_CLKB,
                  tisd_DB2_CLKB,
                  tisd_DB1_CLKB,
                  tisd_DB0_CLKB);

Begin
WIREDELAY : BLOCK
BEGIN
          VitalWireDelay( CENA_ipd, CENA, tipd_CENA );
          VitalWireDelay( CLKA_ipd, CLKA, tipd_CLKA );

         AAipd : FOR i IN AA'range GENERATE
          VitalWireDelay (AA_ipd(i), AA(i), tipd_AA(i));
         END GENERATE AAipd;

         DAipd : FOR i IN BITS-1 downto 0 GENERATE
          VitalWireDelay (DA_ipd(i), DA(i), tipd_DA(i));
         END GENERATE DAipd;

          VitalWireDelay (WENA_ipd, WENA, tipd_WENA );

          VitalWireDelay( CENB_ipd, CENB, tipd_CENB );
          VitalWireDelay( CLKB_ipd, CLKB, tipd_CLKB );

         ABipd : FOR i IN AB'range GENERATE
          VitalWireDelay (AB_ipd(i), AB(i), tipd_AB(i));
         END GENERATE ABipd;

         DBipd : FOR i IN BITS-1 downto 0 GENERATE
          VitalWireDelay (DB_ipd(i), DB(i), tipd_DB(i));
         END GENERATE DBipd;

          VitalWireDelay (WENB_ipd, WENB, tipd_WENB );


END BLOCK;

SIGNALDELAY : BLOCK
BEGIN
          VitalSignalDelay( CENA_dly, CENA_ipd, tisd_CENA_CLKA );
          VitalSignalDelay( CLKA_dly, CLKA_ipd, ticd_CLKA );

          VitalSignalDelay( WENA_dly, WENA_ipd, tisd_WENA_CLKA );
          VitalSignalDelay( WENA_dlyb(0), WENA_ipd, tisd_WENA_CLKA );

         AA_Delay : FOR i IN AA_dly'range GENERATE
           VitalSignalDelay (AA_dly(i), AA_ipd(i), tisd_AA_CLKA(i));
         END GENERATE AA_Delay;

         DA_Delay : FOR i IN BITS-1 downto 0 GENERATE
            VitalSignalDelay (DA_dly(i), DA_ipd(i), tisd_DA_CLKA(i));
         END GENERATE DA_Delay;

          VitalSignalDelay( CENB_dly, CENB_ipd, tisd_CENB_CLKB );
          VitalSignalDelay( CLKB_dly, CLKB_ipd, ticd_CLKB );

          VitalSignalDelay( WENB_dly, WENB_ipd, tisd_WENB_CLKB );
          VitalSignalDelay( WENB_dlyb(0), WENB_ipd, tisd_WENB_CLKB );

         AB_Delay : FOR i IN AB_dly'range GENERATE
           VitalSignalDelay (AB_dly(i), AB_ipd(i), tisd_AB_CLKB(i));
         END GENERATE AB_Delay;

         DB_Delay : FOR i IN BITS-1 downto 0 GENERATE
            VitalSignalDelay (DB_dly(i), DB_ipd(i), tisd_DB_CLKB(i));
         END GENERATE DB_Delay;

END BLOCK;


PROCESS( 
         CLKA_dly, CENA_dly, WENA_dly, AA_dly, 
         DA_dly, 
         CLKB_dly, CENB_dly, WENB_dly, AB_dly, 
         DB_dly) 

--- Memory declaration
  variable MEM: MEM_TYPE;
  variable ROWS: ROW_TYPE;
  variable LAST_STATUS: ROW_TYPE;


   variable LATCHED_CENA: std_logic;
   variable LATCHED_WENA: std_logic;
   variable LATCHED_AA: std_logic_vector(ADDR_WIDTH-1 downto 0);
   variable LATCHED_DA: std_logic_vector(BITS-1 downto 0);
   variable LATCHED_CENB: std_logic;
   variable LATCHED_WENB: std_logic;
   variable LATCHED_AB: std_logic_vector(ADDR_WIDTH-1 downto 0);
   variable LATCHED_DB: std_logic_vector(BITS-1 downto 0);

  variable CLKA_INT : std_logic := '0';
  variable RdA, WrA : std_logic:='0';
  variable AddIA  : std_logic_vector (ADDR_WIDTH-1 downto 0) ;
  variable DataIA  : std_logic_vector (BITS-1 downto 0) ;
  variable ValidDummyPinsA : std_ulogic;
  variable XlsbA : std_ulogic;
  variable CheckData0: Boolean := False;
  variable CheckTData0: Boolean := False;

  variable WENAVio : std_logic := '0';
  variable TWENAVio : std_logic := '0';
  variable QAi: std_logic_vector(BITS-1 downto 0);
  variable QAout: std_logic_vector(BITS-1 downto 0);
  variable CLKAViol : X01 := '0';
  variable CENAViol : X01 := '0';
  variable WENAViol : X01 := '0';
  variable WENAViolation : X01 := '0';
  variable DAViol : X01ArrayT(BITS-1 downto 0) := (others => '0');
  variable AAViol : X01ArrayT(ADDR_WIDTH-1 downto 0) := (others => '0');
  variable DAVio : std_logic_vector(BITS-1 downto 0) := (others => '0');
  variable AAVio : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
  variable EMAAVio : std_logic_vector(2 downto 0) := (others => '0');
  variable TENAViol : X01 := '0';
  variable TCENAViol : X01 := '0';
  variable TWENAViol : X01 := '0';
  variable TWENAViolation : X01 := '0';
  variable TDAViol : X01ArrayT(BITS-1 downto 0) := (others => '0');
  variable TAAViol : X01ArrayT(ADDR_WIDTH-1 downto 0) := (others => '0');
  variable TDAVio : std_logic_vector(BITS-1 downto 0) := (others => '0');
  variable TAAVio : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
  variable CRENAViol : X01ArrayT(BITS-1 downto 0) := (others => '0');
  variable CRENAVio :  std_logic_vector(BITS-1 downto 0) := (others => '0');
  variable RCAAViol : X01 := '0';
  variable ARTNAViol : X01 := '0';
  variable RRENAViol : X01 := '0';
  variable RRAAViol : X01 := '0';
  variable LAST_CLKA : X01 := '0';
  variable valid_cycleA : std_logic_vector(WEN_WIDTH-1 downto 0);

  variable PeriodCheckInfo_CLKA : VitalPeriodDataType;
  variable TimingDataInfo_CENA_CLKA : VitalTimingDataType;
  variable TimingDataInfo_WENA_CLKA : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TWENA_CLKA : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA0 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA0 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA0 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA0 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA1 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA1 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA1 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA1 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA2 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA2 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA2 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA2 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA3 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA3 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA3 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA3 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA4 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA4 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA4 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA4 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA5 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA5 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA5 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA5 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA6 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA6 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA6 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA6 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA7 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA7 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA7 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA7 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA8 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA8 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA8 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA8 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA9 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA9 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA9 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA9 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA10 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA10 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA10 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA10 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA11 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA11 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA11 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA11 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA12 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA12 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA12 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA12 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA13 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA13 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA13 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA13 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA14 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA14 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA14 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA14 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA15 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA15 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA15 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA15 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA16 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA16 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA16 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA16 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA17 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA17 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA17 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA17 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA18 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA18 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA18 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA18 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA19 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA19 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA19 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA19 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA20 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA20 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA20 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA20 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA21 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA21 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA21 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA21 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA22 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA22 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA22 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA22 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA23 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA23 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA23 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA23 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA24 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA24 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA24 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA24 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA25 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA25 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA25 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA25 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA26 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA26 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA26 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA26 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA27 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA27 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA27 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA27 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA28 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA28 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA28 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA28 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA29 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA29 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA29 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA29 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA30 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA30 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA30 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA30 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA31 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA31 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA31 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA31 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA32 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA32 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA32 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA32 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA33 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA33 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA33 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA33 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA34 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA34 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA34 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA34 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA35 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA35 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA35 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA35 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA36 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA36 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA36 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA36 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA37 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA37 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA37 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA37 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA38 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA38 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA38 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA38 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA39 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA39 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA39 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA39 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA40 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA40 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA40 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA40 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA41 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA41 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA41 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA41 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA42 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA42 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA42 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA42 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA43 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA43 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA43 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA43 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA44 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA44 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA44 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA44 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA45 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA45 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA45 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA45 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA46 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA46 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA46 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA46 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA47 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA47 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA47 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA47 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA48 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA48 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA48 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA48 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA49 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA49 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA49 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA49 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA50 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA50 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA50 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA50 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA51 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA51 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA51 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA51 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA52 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA52 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA52 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA52 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA53 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA53 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA53 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA53 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA54 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA54 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA54 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA54 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA55 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA55 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA55 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA55 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA56 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA56 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA56 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA56 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA57 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA57 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA57 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA57 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA58 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA58 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA58 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA58 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA59 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA59 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA59 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA59 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA60 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA60 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA60 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA60 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA61 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA61 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA61 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA61 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA62 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA62 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA62 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA62 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DA_CLKA63 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENA_CLKA63 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDA_CLKA63 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQA_CLKA63 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_AA_CLKA0 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TAA_CLKA0 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_AA_CLKA1 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TAA_CLKA1 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_AA_CLKA2 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TAA_CLKA2 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_AA_CLKA3 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TAA_CLKA3 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_AA_CLKA4 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TAA_CLKA4 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_AA_CLKA5 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TAA_CLKA5 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_AA_CLKA6 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TAA_CLKA6 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_AA_CLKA7 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TAA_CLKA7 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TCENA_CLKA : VitalTimingDataType;
  variable TimingDataInfo_ARTNA_CLKA : VitalTimingDataType;
  variable TimingDataInfo_RRENA_CLKA : VitalTimingDataType;
  variable TimingDataInfo_RRAA_CLKA : VitalTimingDataType;
  variable TimingDataInfo_TENA_CLKA : VitalTimingDataType;
  variable TimingDataInfo_BENA_CLKA : VitalTimingDataType;
  variable TimingDataInfo_RCAA_CLKA : VitalTimingDataType;

  variable QAo : std_logic_vector(BITS-1 downto 0);
  variable DYA_zd : std_logic_vector(BITS-1 downto 0);
  variable AYA_zd : std_logic_vector(ADDR_WIDTH-1 downto 0);
  variable WENYA_zd : std_logic;
  variable CENYA_zd : std_ulogic;
  variable CENYA_GlitchData : VitalGlitchDataType;
  variable WENYA_GlitchData : VitalGlitchDataType;
  variable QA0_GlitchData : VitalGlitchDataType;
  variable QA1_GlitchData : VitalGlitchDataType;
  variable QA2_GlitchData : VitalGlitchDataType;
  variable QA3_GlitchData : VitalGlitchDataType;
  variable QA4_GlitchData : VitalGlitchDataType;
  variable QA5_GlitchData : VitalGlitchDataType;
  variable QA6_GlitchData : VitalGlitchDataType;
  variable QA7_GlitchData : VitalGlitchDataType;
  variable QA8_GlitchData : VitalGlitchDataType;
  variable QA9_GlitchData : VitalGlitchDataType;
  variable QA10_GlitchData : VitalGlitchDataType;
  variable QA11_GlitchData : VitalGlitchDataType;
  variable QA12_GlitchData : VitalGlitchDataType;
  variable QA13_GlitchData : VitalGlitchDataType;
  variable QA14_GlitchData : VitalGlitchDataType;
  variable QA15_GlitchData : VitalGlitchDataType;
  variable QA16_GlitchData : VitalGlitchDataType;
  variable QA17_GlitchData : VitalGlitchDataType;
  variable QA18_GlitchData : VitalGlitchDataType;
  variable QA19_GlitchData : VitalGlitchDataType;
  variable QA20_GlitchData : VitalGlitchDataType;
  variable QA21_GlitchData : VitalGlitchDataType;
  variable QA22_GlitchData : VitalGlitchDataType;
  variable QA23_GlitchData : VitalGlitchDataType;
  variable QA24_GlitchData : VitalGlitchDataType;
  variable QA25_GlitchData : VitalGlitchDataType;
  variable QA26_GlitchData : VitalGlitchDataType;
  variable QA27_GlitchData : VitalGlitchDataType;
  variable QA28_GlitchData : VitalGlitchDataType;
  variable QA29_GlitchData : VitalGlitchDataType;
  variable QA30_GlitchData : VitalGlitchDataType;
  variable QA31_GlitchData : VitalGlitchDataType;
  variable QA32_GlitchData : VitalGlitchDataType;
  variable QA33_GlitchData : VitalGlitchDataType;
  variable QA34_GlitchData : VitalGlitchDataType;
  variable QA35_GlitchData : VitalGlitchDataType;
  variable QA36_GlitchData : VitalGlitchDataType;
  variable QA37_GlitchData : VitalGlitchDataType;
  variable QA38_GlitchData : VitalGlitchDataType;
  variable QA39_GlitchData : VitalGlitchDataType;
  variable QA40_GlitchData : VitalGlitchDataType;
  variable QA41_GlitchData : VitalGlitchDataType;
  variable QA42_GlitchData : VitalGlitchDataType;
  variable QA43_GlitchData : VitalGlitchDataType;
  variable QA44_GlitchData : VitalGlitchDataType;
  variable QA45_GlitchData : VitalGlitchDataType;
  variable QA46_GlitchData : VitalGlitchDataType;
  variable QA47_GlitchData : VitalGlitchDataType;
  variable QA48_GlitchData : VitalGlitchDataType;
  variable QA49_GlitchData : VitalGlitchDataType;
  variable QA50_GlitchData : VitalGlitchDataType;
  variable QA51_GlitchData : VitalGlitchDataType;
  variable QA52_GlitchData : VitalGlitchDataType;
  variable QA53_GlitchData : VitalGlitchDataType;
  variable QA54_GlitchData : VitalGlitchDataType;
  variable QA55_GlitchData : VitalGlitchDataType;
  variable QA56_GlitchData : VitalGlitchDataType;
  variable QA57_GlitchData : VitalGlitchDataType;
  variable QA58_GlitchData : VitalGlitchDataType;
  variable QA59_GlitchData : VitalGlitchDataType;
  variable QA60_GlitchData : VitalGlitchDataType;
  variable QA61_GlitchData : VitalGlitchDataType;
  variable QA62_GlitchData : VitalGlitchDataType;
  variable QA63_GlitchData : VitalGlitchDataType;
  variable AYA0_GlitchData : VitalGlitchDataType;
  variable AYA1_GlitchData : VitalGlitchDataType;
  variable AYA2_GlitchData : VitalGlitchDataType;
  variable AYA3_GlitchData : VitalGlitchDataType;
  variable AYA4_GlitchData : VitalGlitchDataType;
  variable AYA5_GlitchData : VitalGlitchDataType;
  variable AYA6_GlitchData : VitalGlitchDataType;
  variable AYA7_GlitchData : VitalGlitchDataType;
  variable DYA0_GlitchData : VitalGlitchDataType;
  variable DYA1_GlitchData : VitalGlitchDataType;
  variable DYA2_GlitchData : VitalGlitchDataType;
  variable DYA3_GlitchData : VitalGlitchDataType;
  variable DYA4_GlitchData : VitalGlitchDataType;
  variable DYA5_GlitchData : VitalGlitchDataType;
  variable DYA6_GlitchData : VitalGlitchDataType;
  variable DYA7_GlitchData : VitalGlitchDataType;
  variable DYA8_GlitchData : VitalGlitchDataType;
  variable DYA9_GlitchData : VitalGlitchDataType;
  variable DYA10_GlitchData : VitalGlitchDataType;
  variable DYA11_GlitchData : VitalGlitchDataType;
  variable DYA12_GlitchData : VitalGlitchDataType;
  variable DYA13_GlitchData : VitalGlitchDataType;
  variable DYA14_GlitchData : VitalGlitchDataType;
  variable DYA15_GlitchData : VitalGlitchDataType;
  variable DYA16_GlitchData : VitalGlitchDataType;
  variable DYA17_GlitchData : VitalGlitchDataType;
  variable DYA18_GlitchData : VitalGlitchDataType;
  variable DYA19_GlitchData : VitalGlitchDataType;
  variable DYA20_GlitchData : VitalGlitchDataType;
  variable DYA21_GlitchData : VitalGlitchDataType;
  variable DYA22_GlitchData : VitalGlitchDataType;
  variable DYA23_GlitchData : VitalGlitchDataType;
  variable DYA24_GlitchData : VitalGlitchDataType;
  variable DYA25_GlitchData : VitalGlitchDataType;
  variable DYA26_GlitchData : VitalGlitchDataType;
  variable DYA27_GlitchData : VitalGlitchDataType;
  variable DYA28_GlitchData : VitalGlitchDataType;
  variable DYA29_GlitchData : VitalGlitchDataType;
  variable DYA30_GlitchData : VitalGlitchDataType;
  variable DYA31_GlitchData : VitalGlitchDataType;
  variable DYA32_GlitchData : VitalGlitchDataType;
  variable DYA33_GlitchData : VitalGlitchDataType;
  variable DYA34_GlitchData : VitalGlitchDataType;
  variable DYA35_GlitchData : VitalGlitchDataType;
  variable DYA36_GlitchData : VitalGlitchDataType;
  variable DYA37_GlitchData : VitalGlitchDataType;
  variable DYA38_GlitchData : VitalGlitchDataType;
  variable DYA39_GlitchData : VitalGlitchDataType;
  variable DYA40_GlitchData : VitalGlitchDataType;
  variable DYA41_GlitchData : VitalGlitchDataType;
  variable DYA42_GlitchData : VitalGlitchDataType;
  variable DYA43_GlitchData : VitalGlitchDataType;
  variable DYA44_GlitchData : VitalGlitchDataType;
  variable DYA45_GlitchData : VitalGlitchDataType;
  variable DYA46_GlitchData : VitalGlitchDataType;
  variable DYA47_GlitchData : VitalGlitchDataType;
  variable DYA48_GlitchData : VitalGlitchDataType;
  variable DYA49_GlitchData : VitalGlitchDataType;
  variable DYA50_GlitchData : VitalGlitchDataType;
  variable DYA51_GlitchData : VitalGlitchDataType;
  variable DYA52_GlitchData : VitalGlitchDataType;
  variable DYA53_GlitchData : VitalGlitchDataType;
  variable DYA54_GlitchData : VitalGlitchDataType;
  variable DYA55_GlitchData : VitalGlitchDataType;
  variable DYA56_GlitchData : VitalGlitchDataType;
  variable DYA57_GlitchData : VitalGlitchDataType;
  variable DYA58_GlitchData : VitalGlitchDataType;
  variable DYA59_GlitchData : VitalGlitchDataType;
  variable DYA60_GlitchData : VitalGlitchDataType;
  variable DYA61_GlitchData : VitalGlitchDataType;
  variable DYA62_GlitchData : VitalGlitchDataType;
  variable DYA63_GlitchData : VitalGlitchDataType;

  variable AAint : std_logic_vector(ADDR_WIDTH-1 downto 0);
  variable DAint : std_logic_vector(BITS-1 downto 0);
  variable WENAint : std_logic_vector(0 downto 0);
  variable CENAint : std_logic;
  variable RRENAint : std_logic:='1';
  variable RRAAint : std_logic:='1';
  variable ARTNAint : std_logic:='1';
  variable RCAAint : std_logic:='0';
  variable CRENAint : std_logic_vector(BITS-1 downto 0):= (others=>'1');
  variable EMAAint : std_logic_vector(2 downto 0):= (others=>'1');
  variable CLKB_INT : std_logic := '0';
  variable RdB, WrB : std_logic:='0';
  variable AddIB  : std_logic_vector (ADDR_WIDTH-1 downto 0) ;
  variable DataIB  : std_logic_vector (BITS-1 downto 0) ;
  variable ValidDummyPinsB : std_ulogic;
  variable XlsbB : std_ulogic;
  variable CheckData1: Boolean := False;
  variable CheckTData1: Boolean := False;

  variable WENBVio : std_logic := '0';
  variable TWENBVio : std_logic := '0';
  variable QBi: std_logic_vector(BITS-1 downto 0);
  variable QBout: std_logic_vector(BITS-1 downto 0);
  variable CLKBViol : X01 := '0';
  variable CENBViol : X01 := '0';
  variable WENBViol : X01 := '0';
  variable WENBViolation : X01 := '0';
  variable DBViol : X01ArrayT(BITS-1 downto 0) := (others => '0');
  variable ABViol : X01ArrayT(ADDR_WIDTH-1 downto 0) := (others => '0');
  variable DBVio : std_logic_vector(BITS-1 downto 0) := (others => '0');
  variable ABVio : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
  variable EMABVio : std_logic_vector(2 downto 0) := (others => '0');
  variable TENBViol : X01 := '0';
  variable TCENBViol : X01 := '0';
  variable TWENBViol : X01 := '0';
  variable TWENBViolation : X01 := '0';
  variable TDBViol : X01ArrayT(BITS-1 downto 0) := (others => '0');
  variable TABViol : X01ArrayT(ADDR_WIDTH-1 downto 0) := (others => '0');
  variable TDBVio : std_logic_vector(BITS-1 downto 0) := (others => '0');
  variable TABVio : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
  variable CRENBViol : X01ArrayT(BITS-1 downto 0) := (others => '0');
  variable CRENBVio :  std_logic_vector(BITS-1 downto 0) := (others => '0');
  variable RCABViol : X01 := '0';
  variable ARTNBViol : X01 := '0';
  variable RRENBViol : X01 := '0';
  variable RRABViol : X01 := '0';
  variable LAST_CLKB : X01 := '0';
  variable valid_cycleB : std_logic_vector(WEN_WIDTH-1 downto 0);

  variable PeriodCheckInfo_CLKB : VitalPeriodDataType;
  variable TimingDataInfo_CENB_CLKB : VitalTimingDataType;
  variable TimingDataInfo_WENB_CLKB : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TWENB_CLKB : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB0 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB0 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB0 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB0 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB1 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB1 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB1 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB1 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB2 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB2 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB2 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB2 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB3 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB3 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB3 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB3 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB4 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB4 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB4 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB4 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB5 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB5 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB5 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB5 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB6 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB6 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB6 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB6 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB7 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB7 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB7 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB7 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB8 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB8 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB8 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB8 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB9 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB9 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB9 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB9 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB10 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB10 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB10 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB10 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB11 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB11 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB11 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB11 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB12 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB12 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB12 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB12 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB13 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB13 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB13 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB13 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB14 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB14 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB14 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB14 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB15 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB15 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB15 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB15 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB16 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB16 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB16 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB16 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB17 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB17 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB17 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB17 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB18 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB18 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB18 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB18 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB19 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB19 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB19 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB19 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB20 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB20 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB20 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB20 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB21 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB21 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB21 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB21 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB22 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB22 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB22 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB22 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB23 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB23 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB23 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB23 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB24 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB24 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB24 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB24 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB25 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB25 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB25 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB25 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB26 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB26 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB26 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB26 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB27 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB27 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB27 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB27 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB28 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB28 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB28 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB28 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB29 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB29 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB29 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB29 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB30 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB30 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB30 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB30 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB31 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB31 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB31 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB31 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB32 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB32 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB32 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB32 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB33 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB33 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB33 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB33 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB34 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB34 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB34 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB34 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB35 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB35 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB35 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB35 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB36 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB36 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB36 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB36 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB37 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB37 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB37 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB37 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB38 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB38 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB38 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB38 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB39 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB39 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB39 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB39 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB40 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB40 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB40 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB40 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB41 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB41 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB41 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB41 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB42 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB42 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB42 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB42 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB43 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB43 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB43 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB43 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB44 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB44 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB44 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB44 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB45 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB45 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB45 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB45 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB46 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB46 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB46 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB46 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB47 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB47 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB47 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB47 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB48 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB48 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB48 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB48 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB49 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB49 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB49 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB49 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB50 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB50 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB50 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB50 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB51 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB51 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB51 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB51 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB52 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB52 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB52 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB52 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB53 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB53 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB53 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB53 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB54 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB54 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB54 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB54 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB55 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB55 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB55 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB55 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB56 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB56 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB56 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB56 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB57 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB57 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB57 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB57 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB58 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB58 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB58 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB58 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB59 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB59 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB59 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB59 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB60 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB60 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB60 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB60 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB61 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB61 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB61 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB61 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB62 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB62 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB62 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB62 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_DB_CLKB63 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_CRENB_CLKB63 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TDB_CLKB63 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TQB_CLKB63 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_AB_CLKB0 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TAB_CLKB0 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_AB_CLKB1 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TAB_CLKB1 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_AB_CLKB2 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TAB_CLKB2 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_AB_CLKB3 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TAB_CLKB3 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_AB_CLKB4 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TAB_CLKB4 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_AB_CLKB5 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TAB_CLKB5 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_AB_CLKB6 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TAB_CLKB6 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_AB_CLKB7 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TAB_CLKB7 : VitalTimingDataType := VitalTimingDataInit;
  variable TimingDataInfo_TCENB_CLKB : VitalTimingDataType;
  variable TimingDataInfo_ARTNB_CLKB : VitalTimingDataType;
  variable TimingDataInfo_RRENB_CLKB : VitalTimingDataType;
  variable TimingDataInfo_RRAB_CLKB : VitalTimingDataType;
  variable TimingDataInfo_TENB_CLKB : VitalTimingDataType;
  variable TimingDataInfo_BENB_CLKB : VitalTimingDataType;
  variable TimingDataInfo_RCAB_CLKB : VitalTimingDataType;

  variable QBo : std_logic_vector(BITS-1 downto 0);
  variable DYB_zd : std_logic_vector(BITS-1 downto 0);
  variable AYB_zd : std_logic_vector(ADDR_WIDTH-1 downto 0);
  variable WENYB_zd : std_logic;
  variable CENYB_zd : std_ulogic;
  variable CENYB_GlitchData : VitalGlitchDataType;
  variable WENYB_GlitchData : VitalGlitchDataType;
  variable QB0_GlitchData : VitalGlitchDataType;
  variable QB1_GlitchData : VitalGlitchDataType;
  variable QB2_GlitchData : VitalGlitchDataType;
  variable QB3_GlitchData : VitalGlitchDataType;
  variable QB4_GlitchData : VitalGlitchDataType;
  variable QB5_GlitchData : VitalGlitchDataType;
  variable QB6_GlitchData : VitalGlitchDataType;
  variable QB7_GlitchData : VitalGlitchDataType;
  variable QB8_GlitchData : VitalGlitchDataType;
  variable QB9_GlitchData : VitalGlitchDataType;
  variable QB10_GlitchData : VitalGlitchDataType;
  variable QB11_GlitchData : VitalGlitchDataType;
  variable QB12_GlitchData : VitalGlitchDataType;
  variable QB13_GlitchData : VitalGlitchDataType;
  variable QB14_GlitchData : VitalGlitchDataType;
  variable QB15_GlitchData : VitalGlitchDataType;
  variable QB16_GlitchData : VitalGlitchDataType;
  variable QB17_GlitchData : VitalGlitchDataType;
  variable QB18_GlitchData : VitalGlitchDataType;
  variable QB19_GlitchData : VitalGlitchDataType;
  variable QB20_GlitchData : VitalGlitchDataType;
  variable QB21_GlitchData : VitalGlitchDataType;
  variable QB22_GlitchData : VitalGlitchDataType;
  variable QB23_GlitchData : VitalGlitchDataType;
  variable QB24_GlitchData : VitalGlitchDataType;
  variable QB25_GlitchData : VitalGlitchDataType;
  variable QB26_GlitchData : VitalGlitchDataType;
  variable QB27_GlitchData : VitalGlitchDataType;
  variable QB28_GlitchData : VitalGlitchDataType;
  variable QB29_GlitchData : VitalGlitchDataType;
  variable QB30_GlitchData : VitalGlitchDataType;
  variable QB31_GlitchData : VitalGlitchDataType;
  variable QB32_GlitchData : VitalGlitchDataType;
  variable QB33_GlitchData : VitalGlitchDataType;
  variable QB34_GlitchData : VitalGlitchDataType;
  variable QB35_GlitchData : VitalGlitchDataType;
  variable QB36_GlitchData : VitalGlitchDataType;
  variable QB37_GlitchData : VitalGlitchDataType;
  variable QB38_GlitchData : VitalGlitchDataType;
  variable QB39_GlitchData : VitalGlitchDataType;
  variable QB40_GlitchData : VitalGlitchDataType;
  variable QB41_GlitchData : VitalGlitchDataType;
  variable QB42_GlitchData : VitalGlitchDataType;
  variable QB43_GlitchData : VitalGlitchDataType;
  variable QB44_GlitchData : VitalGlitchDataType;
  variable QB45_GlitchData : VitalGlitchDataType;
  variable QB46_GlitchData : VitalGlitchDataType;
  variable QB47_GlitchData : VitalGlitchDataType;
  variable QB48_GlitchData : VitalGlitchDataType;
  variable QB49_GlitchData : VitalGlitchDataType;
  variable QB50_GlitchData : VitalGlitchDataType;
  variable QB51_GlitchData : VitalGlitchDataType;
  variable QB52_GlitchData : VitalGlitchDataType;
  variable QB53_GlitchData : VitalGlitchDataType;
  variable QB54_GlitchData : VitalGlitchDataType;
  variable QB55_GlitchData : VitalGlitchDataType;
  variable QB56_GlitchData : VitalGlitchDataType;
  variable QB57_GlitchData : VitalGlitchDataType;
  variable QB58_GlitchData : VitalGlitchDataType;
  variable QB59_GlitchData : VitalGlitchDataType;
  variable QB60_GlitchData : VitalGlitchDataType;
  variable QB61_GlitchData : VitalGlitchDataType;
  variable QB62_GlitchData : VitalGlitchDataType;
  variable QB63_GlitchData : VitalGlitchDataType;
  variable AYB0_GlitchData : VitalGlitchDataType;
  variable AYB1_GlitchData : VitalGlitchDataType;
  variable AYB2_GlitchData : VitalGlitchDataType;
  variable AYB3_GlitchData : VitalGlitchDataType;
  variable AYB4_GlitchData : VitalGlitchDataType;
  variable AYB5_GlitchData : VitalGlitchDataType;
  variable AYB6_GlitchData : VitalGlitchDataType;
  variable AYB7_GlitchData : VitalGlitchDataType;
  variable DYB0_GlitchData : VitalGlitchDataType;
  variable DYB1_GlitchData : VitalGlitchDataType;
  variable DYB2_GlitchData : VitalGlitchDataType;
  variable DYB3_GlitchData : VitalGlitchDataType;
  variable DYB4_GlitchData : VitalGlitchDataType;
  variable DYB5_GlitchData : VitalGlitchDataType;
  variable DYB6_GlitchData : VitalGlitchDataType;
  variable DYB7_GlitchData : VitalGlitchDataType;
  variable DYB8_GlitchData : VitalGlitchDataType;
  variable DYB9_GlitchData : VitalGlitchDataType;
  variable DYB10_GlitchData : VitalGlitchDataType;
  variable DYB11_GlitchData : VitalGlitchDataType;
  variable DYB12_GlitchData : VitalGlitchDataType;
  variable DYB13_GlitchData : VitalGlitchDataType;
  variable DYB14_GlitchData : VitalGlitchDataType;
  variable DYB15_GlitchData : VitalGlitchDataType;
  variable DYB16_GlitchData : VitalGlitchDataType;
  variable DYB17_GlitchData : VitalGlitchDataType;
  variable DYB18_GlitchData : VitalGlitchDataType;
  variable DYB19_GlitchData : VitalGlitchDataType;
  variable DYB20_GlitchData : VitalGlitchDataType;
  variable DYB21_GlitchData : VitalGlitchDataType;
  variable DYB22_GlitchData : VitalGlitchDataType;
  variable DYB23_GlitchData : VitalGlitchDataType;
  variable DYB24_GlitchData : VitalGlitchDataType;
  variable DYB25_GlitchData : VitalGlitchDataType;
  variable DYB26_GlitchData : VitalGlitchDataType;
  variable DYB27_GlitchData : VitalGlitchDataType;
  variable DYB28_GlitchData : VitalGlitchDataType;
  variable DYB29_GlitchData : VitalGlitchDataType;
  variable DYB30_GlitchData : VitalGlitchDataType;
  variable DYB31_GlitchData : VitalGlitchDataType;
  variable DYB32_GlitchData : VitalGlitchDataType;
  variable DYB33_GlitchData : VitalGlitchDataType;
  variable DYB34_GlitchData : VitalGlitchDataType;
  variable DYB35_GlitchData : VitalGlitchDataType;
  variable DYB36_GlitchData : VitalGlitchDataType;
  variable DYB37_GlitchData : VitalGlitchDataType;
  variable DYB38_GlitchData : VitalGlitchDataType;
  variable DYB39_GlitchData : VitalGlitchDataType;
  variable DYB40_GlitchData : VitalGlitchDataType;
  variable DYB41_GlitchData : VitalGlitchDataType;
  variable DYB42_GlitchData : VitalGlitchDataType;
  variable DYB43_GlitchData : VitalGlitchDataType;
  variable DYB44_GlitchData : VitalGlitchDataType;
  variable DYB45_GlitchData : VitalGlitchDataType;
  variable DYB46_GlitchData : VitalGlitchDataType;
  variable DYB47_GlitchData : VitalGlitchDataType;
  variable DYB48_GlitchData : VitalGlitchDataType;
  variable DYB49_GlitchData : VitalGlitchDataType;
  variable DYB50_GlitchData : VitalGlitchDataType;
  variable DYB51_GlitchData : VitalGlitchDataType;
  variable DYB52_GlitchData : VitalGlitchDataType;
  variable DYB53_GlitchData : VitalGlitchDataType;
  variable DYB54_GlitchData : VitalGlitchDataType;
  variable DYB55_GlitchData : VitalGlitchDataType;
  variable DYB56_GlitchData : VitalGlitchDataType;
  variable DYB57_GlitchData : VitalGlitchDataType;
  variable DYB58_GlitchData : VitalGlitchDataType;
  variable DYB59_GlitchData : VitalGlitchDataType;
  variable DYB60_GlitchData : VitalGlitchDataType;
  variable DYB61_GlitchData : VitalGlitchDataType;
  variable DYB62_GlitchData : VitalGlitchDataType;
  variable DYB63_GlitchData : VitalGlitchDataType;

  variable ABint : std_logic_vector(ADDR_WIDTH-1 downto 0);
  variable DBint : std_logic_vector(BITS-1 downto 0);
  variable WENBint : std_logic_vector(0 downto 0);
  variable CENBint : std_logic;
  variable RRENBint : std_logic:='1';
  variable RRABint : std_logic:='1';
  variable ARTNBint : std_logic:='1';
  variable RCABint : std_logic:='0';
  variable CRENBint : std_logic_vector(BITS-1 downto 0):= (others=>'1');
  variable EMABint : std_logic_vector(2 downto 0):= (others=>'1');
  variable TimingDataInfo_CLKA_CLKB_posedge_posedge : VitalTimingDataType;
  variable TimingDataInfo_CLKB_CLKA_posedge_posedge : VitalTimingDataType;
  variable viol_CLKA_CLKB_posedge_posedge : X01 := '0';
  variable viol_CLKB_CLKA_posedge_posedge : X01 := '0';
  variable TimingDataInfo_sim_clocks : VitalTimingDataType;
  variable CLKACLKBViol : X01 := '0';
  variable CLKBCLKAViol : X01 := '0';
  variable CLKCLKViol : X01 := '0';
  variable viol_sim_clocks : X01 := '0';
  variable cont_flag: Boolean  := False;
  variable cont_ckAckB_flag: Boolean  := False;
  variable cont_ckBckA_flag: Boolean  := False;
 
-- add procedure and function definitions here --
function to_slv(a: in std_logic) return std_logic_vector is
   variable result: std_logic_vector(0 to 0);
begin
   result(0) := a;
   return result;
end;

function to_rr_address (bank_address: in std_logic;
                        radd: in std_logic;
                        a: in std_logic_vector;
                        size: in integer) return std_logic_vector is
   variable result: std_logic_vector(size downto 0);
begin
   if (size > 1) then
      result(size-2 downto 0) := a(size-2 downto 0);
   end if;
   result(size-1) := radd;
   result(size) := bank_address;
   return result;
end;

function bool_to_std_logic (a: in boolean) return std_logic is
begin
   if (a) then
      return '1';
   else
      return '0';
   end if;
end;


function selector (a,b,sel: in std_logic) return std_logic is
begin
   if (sel = '0') then
      return a;
   elsif (sel = '1') then
      return b;
   elsif (a = b) then
      return a;
   else
      return 'X';
   end if;
end;

function selector (a,b: in std_logic_vector; sel: in std_logic; width: in integer) return std_logic_vector is
   variable c: std_logic_vector(width downto 0);
begin
   for n in width downto 0 loop
      c(n) := selector(a(n),b(n),sel);
   end loop;
   return c;
end;

function selector (a,b: in std_logic_vector; sel: in std_logic; width: in integer; high: in integer; low: in integer) return std_logic_vector is
   variable c: std_logic_vector(width downto 0);
begin
   for n in high downto low loop
      c(n-low) := selector(a(n),b(n),sel);
   end loop;
   return c;
end;

function valid_address(a: std_logic_vector;
                       rren: std_logic;
                       radd: std_logic) return boolean is
begin
   if (rren = '1') then
      return not(is_x(a));
   elsif(rren = '0') then
      return is_x(radd) nor is_x(a(COL_ADDR_WIDTH-1 downto 0));
   else
      return False;
   end if;
end;

function shift_right (a: in std_logic_vector) return std_logic_vector is
   variable b: std_logic_vector(a'range);
begin
   for n in a'left downto 0 loop
      if (n = a'left) then
         b(n) := '0';
      else
         b(n) := a(n+1);
      end if;   
   end loop;
   return b;
end;

function valid_cren(cren: std_logic_vector) return boolean is
   variable data : std_logic_vector(cren'range);
begin
   data := cren;
   while (data(0) = '1') loop
     data := shift_right(data);
   end loop;
   if (all_0(data)) then
     return true;
   else
     return false;
   end if;
end;

function is_contention (aa: in std_logic_vector;
                        ab: in std_logic_vector;
                        taa: in std_logic_vector;
                        tab: in std_logic_vector;
                        rrena: in std_logic;
                        rrenb: in std_logic;
                        tena: in std_logic;
                        tenb: in std_logic;
                        rraa: in std_logic;
                        rrab: in std_logic;
                        crena: in std_logic_vector;
                        crenb: in std_logic_vector;
                        rcaa: in std_logic;
                        rcab: in std_logic;
                        wena: in std_logic_vector;
                        wenb: in std_logic_vector;
                        twena: in std_logic_vector;
                        twenb: in std_logic_vector;
                        cena: in std_logic;
                        cenb: in std_logic;
                        tcena: in std_logic;
                        tcenb: in std_logic;
                        artna: in std_logic;
                        artnb: in std_logic) return boolean is
   variable adda: std_logic_vector(7 downto 0);
   variable addb: std_logic_vector(7 downto 0);
   variable col_adda: std_logic_vector(1 downto 0);
   variable col_addb: std_logic_vector(1 downto 0);
   variable row_adda: std_logic_vector(7 downto 2);
   variable row_addb: std_logic_vector(7 downto 2);
   variable add_colision: boolean;
   variable col_add_colision: boolean;
   variable row_add_colision: boolean;
   variable rra_colision: boolean;
   variable rca_colision: boolean;
   variable both_ports_reading: boolean;
   variable wenai: std_logic_vector(0 downto 0);
   variable wenbi: std_logic_vector(0 downto 0);
   variable result: boolean;
   variable crenai: std_logic_vector(63 downto 0);
   variable crenbi: std_logic_vector(63 downto 0);
begin
   wenai := selector(twena,wena,tena,WEN_WIDTH-1);
   wenbi := selector(twenb,wenb,tenb,WEN_WIDTH-1);
   if ( (artna /= '1') and (not(is_same(wenai,MASK1))) and not(is_same(wenai,MASK0)) ) then
      wenai := MASKX;
   end if;
   if ( (artnb /= '1') and (not(is_same(wenbi,MASK1))) and not(is_same(wenbi,MASK0)) ) then
      wenbi := MASKX;
   end if;
   if (not(valid_cren(crena))) then
      crenai := WORDX;
   else
      crenai := crena;   
   end if;
   if (not(valid_cren(crenb))) then
      crenbi := WORDX;
   else
      crenbi := crenb;
   end if;

   col_adda := selector(taa,aa,tena,COL_ADDR_WIDTH-1);
   col_addb := selector(tab,ab,tenb,COL_ADDR_WIDTH-1);
   col_add_colision := is_samex(col_adda,col_addb);
   rra_colision := is_samex(rraa,rrab);
   adda := selector(taa,aa,tena,ADDR_WIDTH-1);
   addb := selector(tab,ab,tenb,ADDR_WIDTH-1);
   add_colision := is_samex(adda,addb);
           
   row_adda := selector(taa,aa,tena,((ADDR_WIDTH-1)-COL_ADDR_WIDTH),ADDR_WIDTH-1,COL_ADDR_WIDTH);
   row_addb := selector(tab,ab,tenb,((ADDR_WIDTH-1)-COL_ADDR_WIDTH),ADDR_WIDTH-1,COL_ADDR_WIDTH);
   row_add_colision := is_samex(row_adda,row_addb);
   rca_colision := is_samex(rcaa,rcab);
   both_ports_reading := (wenai = MASK1) and 
                         (wenbi = MASK1);

   result :=
      -- if either rrena or rrenb are unkown the whole memory is corrupted.
      (((rrena = 'X') or
	(rrenb = 'X') or
        -- in redundant row array
        ((rrena /= '1') and (rrenb /= '1') and ((rraa = 'X') or (rrab = 'X'))) or
        ((rrena /= '1') and (rrenb /= '1') and col_add_colision and rra_colision) or
        -- in normal array
        ((rrena /= '0') and (rrenb /= '0') and add_colision) or
        -- redundant column in normal array
        ((rrena /= '0') and (rrenb /= '0') and row_add_colision and
	 (crenai(BITS-1) /= '1') and (crenbi(BITS-1) /= '1') and rca_colision) or
        -- redundant column in rednundant row
        ((rrena /= '1') and (rrenb /= '1') and rra_colision and
	 (crenai(BITS-1) /= '1') and (crenbi(BITS-1) /= '1') and 
	 ((wenai(WEN_WIDTH-1) /= '1') or (wenbi(WEN_WIDTH-1) /= '1')) and 
	 rca_colision)) and
       not(both_ports_reading) and
       (selector(tcena,cena,tena) /= '1') and
       (selector(tcenb,cenb,tenb) /= '1')) or
      -- in redundant row array
      ((((rrena /= '1') and (rrenb /= '1') and col_add_colision and rra_colision and (crenai(0) /= '1' or crenbi(0) /= '1')) or
	-- in normal array
	((rrena /= '0') and (rrenb /= '0') and add_colision and (crenai(0) /= '1' or crenbi(0) /= '1'))) and
       (selector(tcena,cena,tena) /= '1') and
       (selector(tcenb,cenb,tenb) /= '1'));

   return result;
   
end;

procedure latch_Ainputs is
   begin
      LATCHED_CENA := CENA_dly;
      LATCHED_WENA := WENA_dly;
      LATCHED_AA := AA_dly;
      LATCHED_DA := DA_dly;
end latch_Ainputs;
procedure latch_Binputs is
   begin
      LATCHED_CENB := CENB_dly;
      LATCHED_WENB := WENB_dly;
      LATCHED_AB := AB_dly;
      LATCHED_DB := DB_dly;
end latch_Binputs;

procedure x_Ainputs is
   variable n : integer;
   begin
	 if (is_x(CENAViol)) then  LATCHED_CENA := 'X'; end if;
	 if (is_x(WENAViol)) then  LATCHED_WENA := 'X'; end if;
         for n in 0 to ADDR_WIDTH-1 loop
            if (is_x(AAViol(n))) then  LATCHED_AA(n) := 'X'; end if;
	 end loop;
         for n in 0 to BITS-1 loop
            if (is_x(DAViol(n))) then  LATCHED_DA(n) := 'X'; end if;
	 end loop;
end x_Ainputs;
procedure x_Binputs is
   variable n : integer;
   begin
	 if (is_x(CENBViol)) then  LATCHED_CENB := 'X'; end if;
	 if (is_x(WENBViol)) then  LATCHED_WENB := 'X'; end if;
         for n in 0 to ADDR_WIDTH-1 loop
            if (is_x(ABViol(n))) then  LATCHED_AB(n) := 'X'; end if;
	 end loop;
         for n in 0 to BITS-1 loop
            if (is_x(DBViol(n))) then  LATCHED_DB(n) := 'X'; end if;
	 end loop;
end x_Binputs;

procedure update_status (val: in std_logic_vector;
                         portname: in std_logic) is
   variable tmpdata: std_logic_vector(65 downto 0);
   variable tmpaddr: std_logic_vector(COL_ADDR_WIDTH downto 0);
   variable n: integer;
begin
   for n in 0 to MUX-1 loop
      tmpaddr := conv_std_logic_vector(n,COL_ADDR_WIDTH+1);
      tmpaddr(COL_ADDR_WIDTH) := portname;
      tmpdata := last_status(conv_unsigned_integer(tmpaddr));
      tmpdata(BITS+RED_COLUMNS-1 downto BITS) := val(BITS+RED_COLUMNS-1 downto BITS);
      last_status(conv_unsigned_integer(tmpaddr)) := tmpdata;
   end loop;
end update_status;

procedure clear_status (portname: in std_logic) is
   variable tmpaddr: std_logic_vector(COL_ADDR_WIDTH downto 0);
   variable n: integer;
begin
   for n in 0 to MUX-1 loop
      tmpaddr := conv_std_logic_vector(n,COL_ADDR_WIDTH+1);
      tmpaddr(COL_ADDR_WIDTH) := portname;
      last_status(conv_unsigned_integer(tmpaddr)) := WORDXXX;
   end loop;
end clear_status;

procedure replace_bit_in_mem (a: in std_logic_vector;	 
                              pos: in integer;
                              data: in std_logic) is
   variable tmpdata: std_logic_vector(BITS+RED_COLUMNS-1 downto 0);
   variable tmpaddr: std_logic_vector(ADDR_WIDTH-1 downto 0);
begin
   tmpdata := mem(conv_unsigned_integer(a));
   tmpdata(pos) := data;
   mem(conv_unsigned_integer(a)) := tmpdata;
   -- copy the redundent columns to all all combinations of ymux addresses
   if (pos >= BITS) then
      for n in 0 to MUX-1 loop
         tmpaddr := conv_std_logic_vector(n,ADDR_WIDTH);
         tmpaddr(ADDR_WIDTH-1 downto COL_ADDR_WIDTH) := a(ADDR_WIDTH-1 downto COL_ADDR_WIDTH);
         tmpdata := mem(conv_unsigned_integer(tmpaddr));
         tmpdata(pos) := data;
         mem(conv_unsigned_integer(tmpaddr)) := tmpdata;
      end loop;
   end if;
end replace_bit_in_mem;

procedure replace_bit_in_rows (a: in std_logic_vector;	 
                               pos: in integer;
                               data: in std_logic;
                               radd: in std_logic;
                               bank_address: in std_logic) is
   variable tmpdata: std_logic_vector(BITS+RED_COLUMNS-1 downto 0);
   variable tmpaddr: std_logic_vector(COL_ADDR_WIDTH+1 downto 0);
begin
   tmpdata := rows(conv_unsigned_integer(to_rr_address(bank_address,radd,a,COL_ADDR_WIDTH+1)));
   tmpdata(pos) := data;
   rows(conv_unsigned_integer(to_rr_address(bank_address,radd,a,COL_ADDR_WIDTH+1))) := tmpdata;
   -- copy the redundent columns to all all combinations of ymux addresses
   if (pos >= BITS) then
      for n in 0 to MUX-1 loop
         tmpaddr := conv_std_logic_vector(n,COL_ADDR_WIDTH+2);
         tmpaddr(COL_ADDR_WIDTH) := radd;
         tmpaddr(COL_ADDR_WIDTH+1) := bank_address;
         tmpdata := rows(conv_unsigned_integer(tmpaddr));
         tmpdata(pos) := data;
         rows(conv_unsigned_integer(tmpaddr)) := tmpdata;
      end loop;
   end if;
end replace_bit_in_rows;

procedure x_mem is
   variable n: integer;
begin
   for n in WORD_DEPTH-1 downto 0 loop
      mem(n) := WORDXXX; -- add 2 bits for column redundancy
   end loop;
end x_mem;

procedure x_rows is
   variable n: integer;
begin
   for n in MUX_TIMES_4-1 downto 0 loop
      rows(n) := WORDXXX; -- add 2 bits for column redundancy
   end loop;
end x_rows;

procedure x_row (radd: in std_logic;
                 bank_address: in std_logic) is
   variable n: integer;
   variable tmpaddr: std_logic_vector(7 downto 0);
begin
   for n in MUX-1 downto 0 loop
      tmpaddr := conv_std_logic_vector(n,ADDR_WIDTH);
      tmpaddr(COL_ADDR_WIDTH) := radd;
      tmpaddr(COL_ADDR_WIDTH+1) := bank_address;
      rows(conv_unsigned_integer(tmpaddr)) := WORDXXX; -- add 2 bits for column redundancy
   end loop;
end x_row;

procedure read_mem (q: inout std_logic_vector;
                    other_q: inout std_logic_vector;
                    a: in std_logic_vector;	 
		    d: in std_logic_vector;	 
		    rren: in std_logic;
		    radd: in std_logic; 
		    cren: in std_logic_vector;
                    rca: in std_logic_vector;
                    msb: in integer;
                    lsb: in integer;
                    xout: in boolean;
                    contention: in boolean;
                    portname: in std_logic) is 
   variable tmpdata: std_logic_vector(65 downto 0);
   variable other_status: std_logic_vector(65 downto 0);
   variable status: std_logic_vector(65 downto 0);
   variable m: integer;
   variable n: integer;
begin
   if (rren = 'X') then 
      for n in lsb to msb loop q(n) := 'X'; end loop;
      x_mem;
      x_rows;
   else
      if (not(valid_address(a,rren,radd))) then
         for n in lsb to msb loop q(n) := 'X'; end loop;
      else
         if (rren = '1') then
            tmpdata := mem(conv_unsigned_integer(a));
         elsif (rren = '0') then
            tmpdata := rows(conv_unsigned_integer(to_rr_address('0',radd,a,COL_ADDR_WIDTH+1)));
         end if;
         status := last_status(conv_unsigned_integer(to_rr_address('0',portname,a,COL_ADDR_WIDTH+1)));
         other_status := last_status(conv_unsigned_integer(to_rr_address('0',not(portname),a,COL_ADDR_WIDTH+1)));
         for n in lsb to msb loop
            if (cren(n) = '1') then
               if ((other_status(n) = '0') and contention) then
                  q(n) := 'X';
               else
                  if (xout) then q(n) := 'X'; else q(n) := tmpdata(n); end if;
                  status(n) := '1';
               end if;
            elsif (cren(n) = '0') then
               if ((n = BITS-1) and (not(is_x(rca)))) then
                  if ((other_status(n+conv_unsigned_integer(rca)+1) = '0') and contention) then
                     q(n) := 'X';
                  else
                     if (xout) then q(n) := 'X'; else q(n) := tmpdata(n+conv_unsigned_integer(rca)+1); end if;
                     status(n+conv_unsigned_integer(rca)+1) := '1';
                  end if;
               elsif ((n = BITS-1) and (is_x(rca))) then
                  for m in 0 to RED_COLUMNS-1 loop
                     status(n+m+1) := '1';
                  end loop;
                  q(n) := 'X';
               else
                  if ((other_status(n+1) = '0') and contention) then
                     q(n) := 'X';
                  else
                     if (xout) then q(n) := 'X'; else q(n) := tmpdata(n+1); end if;
                     status(n+1) := '1';
                  end if;
               end if;
            else
               if ((n = BITS-1) and (not(is_x(rca)))) then
                  status(n) := '1';
                  status(n+conv_unsigned_integer(rca)+1) := '1';
                  q(n) := 'X';
               elsif ((n = BITS-1) and (is_x(rca))) then
                  for m in 0 to RED_COLUMNS-1 loop
                     status(n+m+1) := '1';
                  end loop;
                  q(n) := 'X';
               else
                  q(n) := 'X';
                  status(n) := '1';
                  status(n+1) := '1';
               end if;  
            end if;  
         end loop;
         if (rren = '1') then
            mem(conv_unsigned_integer(a)) := tmpdata;
         elsif (rren = '0') then
            rows(conv_unsigned_integer(to_rr_address('0',radd,a,COL_ADDR_WIDTH+1))) := tmpdata;
         end if;
         last_status(conv_unsigned_integer(to_rr_address('0',portname,a,COL_ADDR_WIDTH+1))) := status;
         -- copy the redundent columns to all all combinations of ymux addresses
         if (msb = BITS-1) then
            if (rren = '1') then
               for m in 0 to RED_COLUMNS-1 loop
                  replace_bit_in_mem(a,BITS+m,tmpdata(BITS+m));
               end loop;
            elsif (rren = '0') then
               for m in 0 to RED_COLUMNS-1 loop
                  replace_bit_in_rows(a,BITS+m,tmpdata(BITS+m),radd,'0');
               end loop;
            end if;
            update_status(status,portname);
         end if;
      end if;
   end if;
end read_mem;

procedure write_mem (other_q: inout std_logic_vector;
                     a: in std_logic_vector;	 
		     d: in std_logic_vector;	 
		     rren: in std_logic;
		     radd: in std_logic; 
		     cren: in std_logic_vector;
                     rca: in std_logic_vector;
                     msb: in integer;
                     lsb: in integer;
                     xout: in boolean;
                     contention: in boolean;
		     other_cren: in std_logic_vector;
                     portname: in std_logic) is 
   variable tmpdata: std_logic_vector(65 downto 0);
   variable other_status: std_logic_vector(65 downto 0);
   variable status: std_logic_vector(65 downto 0);
   variable tmpaddr: std_logic_vector(7 downto 0);
   variable n: integer;
begin
   if (rren = 'X') then 
      x_mem;
      x_rows;
   else
      if (not(valid_address(a,rren,radd))) then
         if (rren = '1') then
            x_mem;
         elsif (rren = '0') then
            if (is_x(radd)) and ( is_x('0') ) then
               x_rows;
            elsif (is_x(radd)) then
               x_row('0','0');
               x_row('1','0');
            elsif ( is_x('0') ) then
               x_row(radd,'0');
               x_row(radd,'1');
            else
               x_row(radd,'0');
            end if;
         end if;
      else
         if (rren = '1') then
            tmpdata := mem(conv_unsigned_integer(a));
         elsif (rren = '0') then
            tmpdata := rows(conv_unsigned_integer(to_rr_address('0',radd,a,COL_ADDR_WIDTH+1)));
         end if;
         status := last_status(conv_unsigned_integer(to_rr_address('0',portname,a,COL_ADDR_WIDTH+1)));
         other_status := last_status(conv_unsigned_integer(to_rr_address('0',not(portname),a,COL_ADDR_WIDTH+1)));
         for n in lsb to msb loop
            if (cren(n) = '1') then
               if ((other_status(n) = '0') and contention) then
                  tmpdata(n) := 'X';
               elsif ((other_status(n) = '1') and contention) then
                  if (other_cren(n) = '1') then
                     other_q(n) := 'X';
                  elsif (other_cren(n-1) = '0') then
                     other_q(n-1) := 'X';
                  end if;
               else
                  if (xout) then tmpdata(n) := 'X'; else tmpdata(n) := d(n); end if;
                  status(n) := '0';
               end if;
               if ((n < BITS-1) and (cren(n+1) = '0')) then
                  if ((other_status(n+1) = '0') and contention) then
                     tmpdata(n+1) := 'X';
                  elsif ((other_status(n+1) = '1') and contention) then
                     if (other_cren(n) = '0') then
                        other_q(n) := 'X';
                     elsif (other_cren(n+1) = '1') then
                        other_q(n+1) := 'X';
                     end if;
                  else
                     if (xout) then tmpdata(n+1) := 'X'; else tmpdata(n+1) := d(n); end if;
                     status(n+1) := '0';
                  end if;
               elsif ((n < BITS-1) and (cren(n+1) = 'X')) then
                  tmpdata(n+1) := 'X';
                  status(n+1) := '0';
                  if ((other_status(n+1) = '1') and contention) then
                     if (other_cren(n) = '0') then
                        other_q(n) := 'X';
                     elsif (other_cren(n+1) = '1') then
                        other_q(n+1) := 'X';
                     end if;
                  end if;
               end if;
            elsif (cren(n) = '0') then
               if ((n = BITS-1) and (not(is_x(rca)))) then
                  if ((other_status(n+conv_unsigned_integer(rca)+1) = '0') and contention) then
                     tmpdata(n+conv_unsigned_integer(rca)+1) := 'X';
                  elsif ((other_status(n+conv_unsigned_integer(rca)+1) = '1') and contention) then
                     if (other_cren(n) = '0') then
                        other_q(n) := 'X';
                     end if;
                  else
                     if (xout) then tmpdata(n+conv_unsigned_integer(rca)+1) := 'X'; else tmpdata(n+conv_unsigned_integer(rca)+1) := d(n); end if;
                     status(n+conv_unsigned_integer(rca)+1) := '0';
                  end if;
              elsif ((n = BITS-1) and (is_x(rca))) then
                  for m in 0 to RED_COLUMNS-1 loop
                     tmpdata(n+m+1) := 'X';
                     status(n+m+1) := '0';
                     if ((other_status(n+m+1) = '1') and contention) then
                        if (other_cren(n) = '0') then
                           other_q(n) := 'X';
                        end if;
                     end if;
                  end loop;
               else
                  if ((other_status(n+1) = '0') and contention) then
                     tmpdata(n+1) := 'X';
                  elsif ((other_status(n+1) = '1') and contention) then
                     if (other_cren(n) = '0') then
                        other_q(n) := 'X';
                     elsif (other_cren(n+1) = '1') then
                        other_q(n+1) := 'X';
                     end if;
                  else
                     if (xout) then tmpdata(n+1) := 'X'; else tmpdata(n+1) := d(n); end if;
                     status(n+1) := '0';
                  end if;
               end if;
               if (n = 0) then
                  if ((other_status(0) = '0') and contention) then
                     tmpdata(0) := 'X';
                  elsif ((other_status(0) = '1') and contention) then
                     if (other_cren(0) = '1') then
                        other_q(0) := 'X';
                     end if;
                  else
                     if (xout) then tmpdata(0) := 'X'; else tmpdata(0) := '0'; end if;
                     status(0) := '0';
                  end if;
               end if;
            else
               if ((n = BITS-1) and (not(is_x(rca)))) then
                  tmpdata(n) := 'X';
                  tmpdata(n+conv_unsigned_integer(rca)+1) := 'X';
                  status(n) := '0';
                  status(n+conv_unsigned_integer(rca)+1) := '0';
                  if ((other_status(n) = '1') and contention) then
                     if (other_cren(n) = '1') then
                        other_q(n) := 'X';
                     elsif (other_cren(n-1) = '0') then
                        other_q(n-1) := 'X';
                     end if;
                  end if;
                  if ((other_status(n+conv_unsigned_integer(rca)+1) = '1') and contention) then
                     other_q(n) := 'X';
                  end if;
               elsif ((n = BITS-1) and (is_x(rca))) then
                  tmpdata(n) := 'X';
                  status(n) := '0';
                  for m in 0 to RED_COLUMNS-1 loop
                     tmpdata(n+m+1) := 'X';
                     status(n+m+1) := '0';
                     if ((other_status(n+m+1) = '1') and contention) then
                        other_q(n) := 'X';
                     end if;
                  end loop;
                  if ((other_status(n) = '1') and contention) then
                     if (other_cren(n) = '1') then
                        other_q(n) := 'X';
                     elsif (other_cren(n-1) = '0') then
                        other_q(n-1) := 'X';
                     end if;
                  end if;
               else
                  tmpdata(n) := 'X';
                  tmpdata(n+1) := 'X';
                  status(n) := '0';
                  status(n+1) := '0';
                  if ((other_status(n) = '1') and contention) then
                     if (other_cren(n) = '1') then
                        other_q(n) := 'X';
                     elsif (other_cren(n-1) = '0') then
                        other_q(n-1) := 'X';
                     end if;
                  end if;
                  if ((other_status(n+1) = '1') and contention) then
                     if (other_cren(n+1) = '1') then
                        other_q(n+1) := 'X';
                     elsif (other_cren(n) = '0') then
                        other_q(n) := 'X';
                     end if;
                  end if;
               end if;
            end if;
         end loop;
         if (rren = '1') then
            mem(conv_unsigned_integer(a)) := tmpdata;
         elsif (rren = '0') then
            rows(conv_unsigned_integer(to_rr_address('0',radd,a,COL_ADDR_WIDTH+1))) := tmpdata;
         end if;
         last_status(conv_unsigned_integer(to_rr_address('0',portname,a,COL_ADDR_WIDTH+1))) := status;
         -- copy the redundent columns to all all combinations of ymux addresses
         if (msb = BITS-1) then
            if (rren = '1') then
               for m in 0 to RED_COLUMNS-1 loop
                  replace_bit_in_mem(a,BITS+m,tmpdata(BITS+m));
               end loop;
            elsif (rren = '0') then
               for m in 0 to RED_COLUMNS-1 loop
                  replace_bit_in_rows(a,BITS+m,tmpdata(BITS+m),radd,'0');
               end loop;
            end if;
            update_status(status,portname);
         end if;
      end if;
   end if;
end write_mem;

procedure write_thru (q: inout std_logic_vector;
                      a: in std_logic_vector;
		      d: in std_logic_vector;	 
		      rren: in std_logic;
		      radd: in std_logic; 
		      cren: in std_logic_vector;
                      rca: in std_logic_vector;
                      msb: in integer;
                      lsb: in integer;
                      xout: in boolean) is 
   variable n: integer;
begin
   if (not(is_x(cren))) then
      for n in lsb to msb loop
         if (xout) then q(n) := 'X'; else q(n) := d(n); end if;
      end loop;
   else
      for n in lsb to msb loop
         q(n) := 'X';
      end loop;
   end if;
end write_thru;

procedure mem_cycle (q: inout std_logic_vector;
                     other_q: inout std_logic_vector;
                     cen: in std_logic;
                     wen: in std_logic_vector;
                     a: in std_logic_vector;	 
		     d: in std_logic_vector;	 
		     ema: in std_logic_vector; 
		     artn: in std_logic;
		     ten: in std_logic; 
		     ben: in std_logic; 
		     tcen: in std_logic;
		     twen: in std_logic_vector;
		     ta: in std_logic_vector;	 
		     td: in std_logic_vector;	 
		     rren: in std_logic;
		     rra: in std_logic; 
		     cren: in std_logic_vector;
                     rca: in std_logic;
                     contention_flag: in boolean;
                     other_cren: in std_logic_vector;
                     portname: in std_logic) is 
   variable mask_section: integer;
   variable lsb: integer;
   variable msb: integer;
   variable CENi: std_logic;
   variable WENi: std_logic_vector(WEN_WIDTH-1 downto 0);
   variable Ai: std_logic_vector(ADDR_WIDTH-1 downto 0);
   variable Di: std_logic_vector(BITS-1 downto 0);
   variable ValidDummyPinsi: boolean;
   variable creni: std_logic_vector(BITS-1 downto 0);

   begin
      CENi := selector(tcen,cen,ten);
      Ai := selector(ta,a,ten,ADDR_WIDTH-1);
      WENi := selector(twen,wen,ten,WEN_WIDTH-1);
      Di := selector(td,d,ten,BITS-1);
      ValidDummyPinsi := not(is_x(ema) or is_x(artn));
      creni := cren;

      if ( (artn /= '1') and (not(is_same(WENi,MASK1))) and not(is_same(WENi,MASK0)) ) then
	 print("ARTN is active and all bits of WEN are not active or inactive");
	 print("Setting WEN bus to x");
         WENi := MASKX;
      end if;
      if (not(valid_cren(creni))) then
         print("CREN is in an invalid state");
         print("Setting CREN bus to x");
	 creni := WORDX;
      end if;

      for mask_section in 0 to WEN_WIDTH-1 loop
         lsb := mask_section * WP_SIZE ;
         if ((lsb+WP_SIZE-1) >= BITS) then
            msb := BITS - 1;
         else
            msb := lsb+WP_SIZE-1;
         end if;

         if ((WENi(mask_section) = '1') and (CENi = '0') and (ValidDummyPinsi = true)) then
            read_mem(q,other_q,Ai,Di,rren,rra,creni,to_std_logic_vector(rca,1),msb,lsb,false,contention_flag,portname);
         elsif ((WENi(mask_section) = '0') and (CENi = '0') and (ValidDummyPinsi = true)) then
	    write_mem(other_q,Ai,Di,rren,rra,creni,to_std_logic_vector(rca,1),msb,lsb,false,contention_flag,other_cren,portname);
	    write_thru(q,Ai,Di,rren,rra,creni,to_std_logic_vector(rca,1),msb,lsb,false);
         elsif (CENi = '1') then
            null;
         elsif (((WENi(mask_section) = '1') and (CENi = '0')) or
                ((WENi(mask_section) = '1') and (CENi = 'X'))) then
	    read_mem(q,other_q,Ai,Di,rren,rra,creni,to_std_logic_vector(rca,1),msb,lsb,true,contention_flag,portname);
         elsif (((WENi(mask_section) = '0') and (CENi = '0')) or
                ((WENi(mask_section) = '0') and (CENi = 'X'))) then
	    write_mem(other_q,Ai,Di,rren,rra,creni,to_std_logic_vector(rca,1),msb,lsb,true,contention_flag,other_cren,portname);
            write_thru(q,Ai,Di,rren,rra,creni,to_std_logic_vector(rca,1),msb,lsb,true);
         elsif (((WENi(mask_section) = 'X') and (CENi = '0')) or
                ((WENi(mask_section) = 'X') and (CENi = 'X'))) then
	    write_mem(other_q,Ai,Di,rren,rra,creni,to_std_logic_vector(rca,1),msb,lsb,true,contention_flag,other_cren,portname);
            read_mem(q,other_q,Ai,Di,rren,rra,creni,to_std_logic_vector(rca,1),msb,lsb,true,contention_flag,portname);
         end if;
      end loop;
end mem_cycle;

procedure process_violationsA is
   variable cont_flag: boolean;
begin
   -- port B triggers first, then port A
   if (CLKBCLKAViol = 'X') then
      cont_flag := true;
   else
      cont_flag := false;
   end if;
   if (CLKAViol = 'X') then
      if (LATCHED_CENA /= '1') then
         x_mem;
         QAi := WORDX;
      end if;
   else
      x_Ainputs;
      mem_cycle(QAi,
                QBi,
                LATCHED_CENA,
	      	to_slv(LATCHED_WENA),
                LATCHED_AA,
                LATCHED_DA,
		UPM0,
		'1',
                '1',
                '1',
                '1',
                MASK1,
                ADDR1,
                WORD1,
                '1',
                '1',
                WORD1,
                '1',
                cont_flag,
                WORD1,
                '0'
		);
   end if;
end process_violationsA;

procedure process_violationsB is
   variable cont_flag: boolean;
begin
   -- port A triggers first, then port B
   if (CLKACLKBViol = 'X') then
      cont_flag := true;
   else
      cont_flag := false;
   end if;
   if (CLKBViol = 'X') then
      if (LATCHED_CENB /= '1') then
         x_mem;
         QBi := WORDX;
      end if;
   else
      x_Binputs;
      mem_cycle(QBi,
                QAi,
                LATCHED_CENB,
	      	to_slv(LATCHED_WENB),
                LATCHED_AB,
                LATCHED_DB,
		UPM0,
		'1',
                '1',
                '1',
                '1',
                MASK1,
                ADDR1,
                WORD1,
                '1',
                '1',
                WORD1,
                '1',
                cont_flag,
                WORD1,
                '1'
		);
   end if;
end process_violationsB;



     BEGIN
          ---------------------------------------------------
          -- Timing checks section
          ---------------------------------------------------
          IF (TimingChecksOn) THEN

          cont_flag := is_contention(AA_dly,
                                    AB_dly,
                                    ADDR1,
                                    ADDR1,
                                    '1',
                                    '1',
                                    '1',
                                    '1',
                                    '1',
                                    '1',
                                    WORD1,
                                    WORD1,
                                    '1',
                                    '1',
	      	                    to_std_logic_vector(WENA_dly,1),
	      	                    to_std_logic_vector(WENB_dly,1),
                                    MASK1,
                                    MASK1,
                                    CENA_dly,
                                    CENB_dly,
                                    '1',
                                    '1',
                                    '1',
                                    '1');


          cont_ckBckA_flag := is_contention(AA_dly,
                                    LATCHED_AB,
                                    ADDR1,
                                    ADDR1,
                                    '1',
                                    '1',
                                    '1',
                                    '1',
                                    '1',
                                    '1',
                                    WORD1,
                                    WORD1,
                                    '1',
                                    '1',
	      	                    to_std_logic_vector(WENA_dly,1),
	      	                    to_std_logic_vector(LATCHED_WENB,1),
                                    MASK1,
                                    MASK1,
                                    CENA_dly,
                                    LATCHED_CENB,
                                    '1',
                                    '1',
                                    '1',
                                    '1');

          cont_ckAckB_flag := is_contention(LATCHED_AA,
                                    AB_dly,
                                    ADDR1,
                                    ADDR1,
                                    '1',
                                    '1',
                                    '1',
                                    '1',
                                    '1',
                                    '1',
                                    WORD1,
                                    WORD1,
                                    '1',
                                    '1',
	      	                    to_std_logic_vector(LATCHED_WENA,1),
	      	                    to_std_logic_vector(WENB_dly,1),
                                    MASK1,
                                    MASK1,
                                    LATCHED_CENA,
                                    CENB_dly,
                                    '1',
                                    '1',
                                    '1',
                                    '1');

               VitalPeriodPulseCheck (
                   TestSignal     => CLKA_dly,
                   TestSignalName => "CLKA",
                   Period         => tperiod_CLKA,
                   PulseWidthHigh => tpw_CLKA_posedge,
                   PulseWidthLow  => tpw_CLKA_negedge,
                   PeriodData     => PeriodCheckInfo_CLKA,
                   Violation      => CLKAViol,
                   HeaderMsg      => InstancePath & "/Mem_cnnin2",
                   CheckEnabled   => TRUE,
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );


               VitalSetupHoldCheck (
                   TestSignal     => CENA_dly,
                   TestSignalName => "CENA",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_CENA_CLKA_posedge_posedge,
                   SetupLow       => tsetup_CENA_CLKA_negedge_posedge,
                   HoldHigh       => thold_CENA_CLKA_negedge_posedge,
                   HoldLow        => thold_CENA_CLKA_posedge_posedge,
                   CheckEnabled   => TRUE,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_CENA_CLKA,
                   Violation      => CENAViol,
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => WENA_dly,
                   TestSignalName => "WENA",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_WENA_CLKA_posedge_posedge,
                   SetupLow       => tsetup_WENA_CLKA_negedge_posedge,
                   HoldHigh       => thold_WENA_CLKA_negedge_posedge,
                   HoldLow        => thold_WENA_CLKA_posedge_posedge,
                   CheckEnabled   => (To_X01(CENA_dly) /= '1'),
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_WENA_CLKA,
                   Violation      => WENAViolation,
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(0),
                   TestSignalName => "DA(0)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(0),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(0),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(0),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(0),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA0,
                   Violation      => DAViol(0),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(1),
                   TestSignalName => "DA(1)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(1),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(1),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(1),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(1),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA1,
                   Violation      => DAViol(1),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(2),
                   TestSignalName => "DA(2)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(2),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(2),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(2),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(2),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA2,
                   Violation      => DAViol(2),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(3),
                   TestSignalName => "DA(3)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(3),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(3),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(3),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(3),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA3,
                   Violation      => DAViol(3),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(4),
                   TestSignalName => "DA(4)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(4),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(4),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(4),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(4),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA4,
                   Violation      => DAViol(4),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(5),
                   TestSignalName => "DA(5)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(5),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(5),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(5),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(5),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA5,
                   Violation      => DAViol(5),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(6),
                   TestSignalName => "DA(6)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(6),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(6),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(6),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(6),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA6,
                   Violation      => DAViol(6),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(7),
                   TestSignalName => "DA(7)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(7),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(7),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(7),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(7),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA7,
                   Violation      => DAViol(7),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(8),
                   TestSignalName => "DA(8)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(8),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(8),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(8),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(8),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA8,
                   Violation      => DAViol(8),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(9),
                   TestSignalName => "DA(9)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(9),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(9),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(9),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(9),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA9,
                   Violation      => DAViol(9),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(10),
                   TestSignalName => "DA(10)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(10),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(10),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(10),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(10),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA10,
                   Violation      => DAViol(10),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(11),
                   TestSignalName => "DA(11)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(11),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(11),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(11),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(11),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA11,
                   Violation      => DAViol(11),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(12),
                   TestSignalName => "DA(12)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(12),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(12),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(12),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(12),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA12,
                   Violation      => DAViol(12),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(13),
                   TestSignalName => "DA(13)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(13),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(13),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(13),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(13),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA13,
                   Violation      => DAViol(13),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(14),
                   TestSignalName => "DA(14)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(14),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(14),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(14),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(14),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA14,
                   Violation      => DAViol(14),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(15),
                   TestSignalName => "DA(15)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(15),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(15),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(15),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(15),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA15,
                   Violation      => DAViol(15),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(16),
                   TestSignalName => "DA(16)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(16),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(16),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(16),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(16),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA16,
                   Violation      => DAViol(16),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(17),
                   TestSignalName => "DA(17)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(17),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(17),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(17),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(17),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA17,
                   Violation      => DAViol(17),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(18),
                   TestSignalName => "DA(18)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(18),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(18),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(18),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(18),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA18,
                   Violation      => DAViol(18),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(19),
                   TestSignalName => "DA(19)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(19),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(19),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(19),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(19),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA19,
                   Violation      => DAViol(19),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(20),
                   TestSignalName => "DA(20)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(20),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(20),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(20),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(20),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA20,
                   Violation      => DAViol(20),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(21),
                   TestSignalName => "DA(21)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(21),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(21),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(21),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(21),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA21,
                   Violation      => DAViol(21),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(22),
                   TestSignalName => "DA(22)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(22),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(22),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(22),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(22),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA22,
                   Violation      => DAViol(22),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(23),
                   TestSignalName => "DA(23)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(23),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(23),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(23),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(23),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA23,
                   Violation      => DAViol(23),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(24),
                   TestSignalName => "DA(24)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(24),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(24),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(24),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(24),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA24,
                   Violation      => DAViol(24),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(25),
                   TestSignalName => "DA(25)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(25),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(25),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(25),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(25),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA25,
                   Violation      => DAViol(25),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(26),
                   TestSignalName => "DA(26)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(26),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(26),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(26),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(26),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA26,
                   Violation      => DAViol(26),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(27),
                   TestSignalName => "DA(27)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(27),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(27),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(27),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(27),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA27,
                   Violation      => DAViol(27),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(28),
                   TestSignalName => "DA(28)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(28),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(28),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(28),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(28),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA28,
                   Violation      => DAViol(28),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(29),
                   TestSignalName => "DA(29)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(29),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(29),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(29),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(29),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA29,
                   Violation      => DAViol(29),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(30),
                   TestSignalName => "DA(30)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(30),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(30),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(30),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(30),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA30,
                   Violation      => DAViol(30),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(31),
                   TestSignalName => "DA(31)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(31),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(31),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(31),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(31),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA31,
                   Violation      => DAViol(31),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(32),
                   TestSignalName => "DA(32)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(32),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(32),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(32),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(32),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA32,
                   Violation      => DAViol(32),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(33),
                   TestSignalName => "DA(33)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(33),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(33),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(33),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(33),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA33,
                   Violation      => DAViol(33),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(34),
                   TestSignalName => "DA(34)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(34),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(34),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(34),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(34),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA34,
                   Violation      => DAViol(34),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(35),
                   TestSignalName => "DA(35)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(35),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(35),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(35),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(35),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA35,
                   Violation      => DAViol(35),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(36),
                   TestSignalName => "DA(36)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(36),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(36),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(36),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(36),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA36,
                   Violation      => DAViol(36),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(37),
                   TestSignalName => "DA(37)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(37),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(37),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(37),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(37),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA37,
                   Violation      => DAViol(37),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(38),
                   TestSignalName => "DA(38)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(38),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(38),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(38),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(38),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA38,
                   Violation      => DAViol(38),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(39),
                   TestSignalName => "DA(39)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(39),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(39),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(39),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(39),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA39,
                   Violation      => DAViol(39),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(40),
                   TestSignalName => "DA(40)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(40),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(40),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(40),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(40),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA40,
                   Violation      => DAViol(40),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(41),
                   TestSignalName => "DA(41)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(41),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(41),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(41),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(41),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA41,
                   Violation      => DAViol(41),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(42),
                   TestSignalName => "DA(42)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(42),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(42),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(42),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(42),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA42,
                   Violation      => DAViol(42),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(43),
                   TestSignalName => "DA(43)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(43),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(43),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(43),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(43),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA43,
                   Violation      => DAViol(43),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(44),
                   TestSignalName => "DA(44)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(44),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(44),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(44),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(44),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA44,
                   Violation      => DAViol(44),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(45),
                   TestSignalName => "DA(45)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(45),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(45),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(45),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(45),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA45,
                   Violation      => DAViol(45),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(46),
                   TestSignalName => "DA(46)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(46),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(46),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(46),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(46),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA46,
                   Violation      => DAViol(46),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(47),
                   TestSignalName => "DA(47)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(47),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(47),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(47),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(47),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA47,
                   Violation      => DAViol(47),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(48),
                   TestSignalName => "DA(48)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(48),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(48),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(48),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(48),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA48,
                   Violation      => DAViol(48),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(49),
                   TestSignalName => "DA(49)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(49),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(49),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(49),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(49),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA49,
                   Violation      => DAViol(49),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(50),
                   TestSignalName => "DA(50)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(50),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(50),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(50),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(50),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA50,
                   Violation      => DAViol(50),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(51),
                   TestSignalName => "DA(51)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(51),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(51),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(51),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(51),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA51,
                   Violation      => DAViol(51),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(52),
                   TestSignalName => "DA(52)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(52),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(52),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(52),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(52),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA52,
                   Violation      => DAViol(52),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(53),
                   TestSignalName => "DA(53)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(53),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(53),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(53),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(53),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA53,
                   Violation      => DAViol(53),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(54),
                   TestSignalName => "DA(54)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(54),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(54),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(54),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(54),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA54,
                   Violation      => DAViol(54),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(55),
                   TestSignalName => "DA(55)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(55),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(55),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(55),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(55),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA55,
                   Violation      => DAViol(55),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(56),
                   TestSignalName => "DA(56)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(56),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(56),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(56),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(56),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA56,
                   Violation      => DAViol(56),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(57),
                   TestSignalName => "DA(57)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(57),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(57),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(57),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(57),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA57,
                   Violation      => DAViol(57),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(58),
                   TestSignalName => "DA(58)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(58),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(58),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(58),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(58),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA58,
                   Violation      => DAViol(58),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(59),
                   TestSignalName => "DA(59)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(59),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(59),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(59),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(59),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA59,
                   Violation      => DAViol(59),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(60),
                   TestSignalName => "DA(60)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(60),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(60),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(60),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(60),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA60,
                   Violation      => DAViol(60),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(61),
                   TestSignalName => "DA(61)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(61),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(61),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(61),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(61),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA61,
                   Violation      => DAViol(61),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(62),
                   TestSignalName => "DA(62)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(62),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(62),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(62),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(62),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA62,
                   Violation      => DAViol(62),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DA_dly(63),
                   TestSignalName => "DA(63)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_DA_CLKA_posedge_posedge(63),
                   SetupLow       => tsetup_DA_CLKA_negedge_posedge(63),
                   HoldHigh       => thold_DA_CLKA_negedge_posedge(63),
                   HoldLow        => thold_DA_CLKA_posedge_posedge(63),
                   CheckEnabled   => CheckData0,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DA_CLKA63,
                   Violation      => DAViol(63),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => AA_dly(0),
                   TestSignalName => "AA(0)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_AA_CLKA_posedge_posedge(0),
                   SetupLow       => tsetup_AA_CLKA_negedge_posedge(0),
                   HoldHigh       => thold_AA_CLKA_negedge_posedge(0),
                   HoldLow        => thold_AA_CLKA_posedge_posedge(0),
                   CheckEnabled   => (To_X01(CENA_dly) /= '1'),
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_AA_CLKA0,
                   Violation      => AAViol(0),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => AA_dly(1),
                   TestSignalName => "AA(1)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_AA_CLKA_posedge_posedge(1),
                   SetupLow       => tsetup_AA_CLKA_negedge_posedge(1),
                   HoldHigh       => thold_AA_CLKA_negedge_posedge(1),
                   HoldLow        => thold_AA_CLKA_posedge_posedge(1),
                   CheckEnabled   => (To_X01(CENA_dly) /= '1'),
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_AA_CLKA1,
                   Violation      => AAViol(1),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => AA_dly(2),
                   TestSignalName => "AA(2)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_AA_CLKA_posedge_posedge(2),
                   SetupLow       => tsetup_AA_CLKA_negedge_posedge(2),
                   HoldHigh       => thold_AA_CLKA_negedge_posedge(2),
                   HoldLow        => thold_AA_CLKA_posedge_posedge(2),
                   CheckEnabled   => (To_X01(CENA_dly) /= '1'),
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_AA_CLKA2,
                   Violation      => AAViol(2),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => AA_dly(3),
                   TestSignalName => "AA(3)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_AA_CLKA_posedge_posedge(3),
                   SetupLow       => tsetup_AA_CLKA_negedge_posedge(3),
                   HoldHigh       => thold_AA_CLKA_negedge_posedge(3),
                   HoldLow        => thold_AA_CLKA_posedge_posedge(3),
                   CheckEnabled   => (To_X01(CENA_dly) /= '1'),
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_AA_CLKA3,
                   Violation      => AAViol(3),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => AA_dly(4),
                   TestSignalName => "AA(4)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_AA_CLKA_posedge_posedge(4),
                   SetupLow       => tsetup_AA_CLKA_negedge_posedge(4),
                   HoldHigh       => thold_AA_CLKA_negedge_posedge(4),
                   HoldLow        => thold_AA_CLKA_posedge_posedge(4),
                   CheckEnabled   => (To_X01(CENA_dly) /= '1'),
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_AA_CLKA4,
                   Violation      => AAViol(4),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => AA_dly(5),
                   TestSignalName => "AA(5)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_AA_CLKA_posedge_posedge(5),
                   SetupLow       => tsetup_AA_CLKA_negedge_posedge(5),
                   HoldHigh       => thold_AA_CLKA_negedge_posedge(5),
                   HoldLow        => thold_AA_CLKA_posedge_posedge(5),
                   CheckEnabled   => (To_X01(CENA_dly) /= '1'),
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_AA_CLKA5,
                   Violation      => AAViol(5),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => AA_dly(6),
                   TestSignalName => "AA(6)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_AA_CLKA_posedge_posedge(6),
                   SetupLow       => tsetup_AA_CLKA_negedge_posedge(6),
                   HoldHigh       => thold_AA_CLKA_negedge_posedge(6),
                   HoldLow        => thold_AA_CLKA_posedge_posedge(6),
                   CheckEnabled   => (To_X01(CENA_dly) /= '1'),
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_AA_CLKA6,
                   Violation      => AAViol(6),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => AA_dly(7),
                   TestSignalName => "AA(7)",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => tsetup_AA_CLKA_posedge_posedge(7),
                   SetupLow       => tsetup_AA_CLKA_negedge_posedge(7),
                   HoldHigh       => thold_AA_CLKA_negedge_posedge(7),
                   HoldLow        => thold_AA_CLKA_posedge_posedge(7),
                   CheckEnabled   => (To_X01(CENA_dly) /= '1'),
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_AA_CLKA7,
                   Violation      => AAViol(7),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalPeriodPulseCheck (
                   TestSignal     => CLKB_dly,
                   TestSignalName => "CLKB",
                   Period         => tperiod_CLKB,
                   PulseWidthHigh => tpw_CLKB_posedge,
                   PulseWidthLow  => tpw_CLKB_negedge,
                   PeriodData     => PeriodCheckInfo_CLKB,
                   Violation      => CLKBViol,
                   HeaderMsg      => InstancePath & "/Mem_cnnin2",
                   CheckEnabled   => TRUE,
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );


               VitalSetupHoldCheck (
                   TestSignal     => CENB_dly,
                   TestSignalName => "CENB",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_CENB_CLKB_posedge_posedge,
                   SetupLow       => tsetup_CENB_CLKB_negedge_posedge,
                   HoldHigh       => thold_CENB_CLKB_negedge_posedge,
                   HoldLow        => thold_CENB_CLKB_posedge_posedge,
                   CheckEnabled   => TRUE,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_CENB_CLKB,
                   Violation      => CENBViol,
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => WENB_dly,
                   TestSignalName => "WENB",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_WENB_CLKB_posedge_posedge,
                   SetupLow       => tsetup_WENB_CLKB_negedge_posedge,
                   HoldHigh       => thold_WENB_CLKB_negedge_posedge,
                   HoldLow        => thold_WENB_CLKB_posedge_posedge,
                   CheckEnabled   => (To_X01(CENB_dly) /= '1'),
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_WENB_CLKB,
                   Violation      => WENBViolation,
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(0),
                   TestSignalName => "DB(0)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(0),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(0),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(0),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(0),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB0,
                   Violation      => DBViol(0),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(1),
                   TestSignalName => "DB(1)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(1),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(1),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(1),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(1),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB1,
                   Violation      => DBViol(1),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(2),
                   TestSignalName => "DB(2)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(2),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(2),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(2),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(2),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB2,
                   Violation      => DBViol(2),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(3),
                   TestSignalName => "DB(3)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(3),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(3),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(3),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(3),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB3,
                   Violation      => DBViol(3),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(4),
                   TestSignalName => "DB(4)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(4),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(4),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(4),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(4),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB4,
                   Violation      => DBViol(4),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(5),
                   TestSignalName => "DB(5)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(5),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(5),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(5),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(5),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB5,
                   Violation      => DBViol(5),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(6),
                   TestSignalName => "DB(6)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(6),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(6),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(6),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(6),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB6,
                   Violation      => DBViol(6),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(7),
                   TestSignalName => "DB(7)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(7),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(7),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(7),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(7),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB7,
                   Violation      => DBViol(7),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(8),
                   TestSignalName => "DB(8)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(8),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(8),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(8),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(8),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB8,
                   Violation      => DBViol(8),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(9),
                   TestSignalName => "DB(9)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(9),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(9),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(9),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(9),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB9,
                   Violation      => DBViol(9),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(10),
                   TestSignalName => "DB(10)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(10),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(10),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(10),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(10),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB10,
                   Violation      => DBViol(10),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(11),
                   TestSignalName => "DB(11)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(11),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(11),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(11),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(11),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB11,
                   Violation      => DBViol(11),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(12),
                   TestSignalName => "DB(12)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(12),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(12),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(12),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(12),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB12,
                   Violation      => DBViol(12),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(13),
                   TestSignalName => "DB(13)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(13),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(13),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(13),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(13),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB13,
                   Violation      => DBViol(13),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(14),
                   TestSignalName => "DB(14)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(14),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(14),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(14),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(14),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB14,
                   Violation      => DBViol(14),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(15),
                   TestSignalName => "DB(15)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(15),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(15),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(15),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(15),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB15,
                   Violation      => DBViol(15),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(16),
                   TestSignalName => "DB(16)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(16),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(16),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(16),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(16),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB16,
                   Violation      => DBViol(16),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(17),
                   TestSignalName => "DB(17)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(17),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(17),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(17),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(17),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB17,
                   Violation      => DBViol(17),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(18),
                   TestSignalName => "DB(18)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(18),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(18),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(18),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(18),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB18,
                   Violation      => DBViol(18),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(19),
                   TestSignalName => "DB(19)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(19),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(19),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(19),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(19),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB19,
                   Violation      => DBViol(19),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(20),
                   TestSignalName => "DB(20)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(20),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(20),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(20),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(20),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB20,
                   Violation      => DBViol(20),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(21),
                   TestSignalName => "DB(21)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(21),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(21),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(21),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(21),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB21,
                   Violation      => DBViol(21),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(22),
                   TestSignalName => "DB(22)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(22),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(22),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(22),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(22),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB22,
                   Violation      => DBViol(22),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(23),
                   TestSignalName => "DB(23)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(23),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(23),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(23),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(23),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB23,
                   Violation      => DBViol(23),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(24),
                   TestSignalName => "DB(24)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(24),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(24),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(24),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(24),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB24,
                   Violation      => DBViol(24),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(25),
                   TestSignalName => "DB(25)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(25),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(25),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(25),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(25),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB25,
                   Violation      => DBViol(25),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(26),
                   TestSignalName => "DB(26)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(26),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(26),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(26),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(26),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB26,
                   Violation      => DBViol(26),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(27),
                   TestSignalName => "DB(27)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(27),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(27),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(27),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(27),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB27,
                   Violation      => DBViol(27),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(28),
                   TestSignalName => "DB(28)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(28),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(28),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(28),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(28),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB28,
                   Violation      => DBViol(28),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(29),
                   TestSignalName => "DB(29)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(29),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(29),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(29),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(29),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB29,
                   Violation      => DBViol(29),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(30),
                   TestSignalName => "DB(30)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(30),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(30),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(30),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(30),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB30,
                   Violation      => DBViol(30),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(31),
                   TestSignalName => "DB(31)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(31),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(31),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(31),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(31),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB31,
                   Violation      => DBViol(31),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(32),
                   TestSignalName => "DB(32)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(32),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(32),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(32),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(32),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB32,
                   Violation      => DBViol(32),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(33),
                   TestSignalName => "DB(33)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(33),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(33),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(33),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(33),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB33,
                   Violation      => DBViol(33),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(34),
                   TestSignalName => "DB(34)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(34),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(34),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(34),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(34),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB34,
                   Violation      => DBViol(34),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(35),
                   TestSignalName => "DB(35)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(35),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(35),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(35),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(35),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB35,
                   Violation      => DBViol(35),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(36),
                   TestSignalName => "DB(36)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(36),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(36),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(36),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(36),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB36,
                   Violation      => DBViol(36),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(37),
                   TestSignalName => "DB(37)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(37),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(37),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(37),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(37),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB37,
                   Violation      => DBViol(37),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(38),
                   TestSignalName => "DB(38)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(38),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(38),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(38),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(38),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB38,
                   Violation      => DBViol(38),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(39),
                   TestSignalName => "DB(39)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(39),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(39),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(39),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(39),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB39,
                   Violation      => DBViol(39),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(40),
                   TestSignalName => "DB(40)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(40),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(40),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(40),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(40),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB40,
                   Violation      => DBViol(40),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(41),
                   TestSignalName => "DB(41)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(41),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(41),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(41),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(41),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB41,
                   Violation      => DBViol(41),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(42),
                   TestSignalName => "DB(42)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(42),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(42),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(42),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(42),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB42,
                   Violation      => DBViol(42),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(43),
                   TestSignalName => "DB(43)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(43),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(43),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(43),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(43),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB43,
                   Violation      => DBViol(43),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(44),
                   TestSignalName => "DB(44)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(44),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(44),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(44),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(44),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB44,
                   Violation      => DBViol(44),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(45),
                   TestSignalName => "DB(45)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(45),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(45),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(45),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(45),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB45,
                   Violation      => DBViol(45),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(46),
                   TestSignalName => "DB(46)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(46),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(46),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(46),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(46),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB46,
                   Violation      => DBViol(46),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(47),
                   TestSignalName => "DB(47)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(47),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(47),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(47),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(47),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB47,
                   Violation      => DBViol(47),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(48),
                   TestSignalName => "DB(48)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(48),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(48),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(48),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(48),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB48,
                   Violation      => DBViol(48),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(49),
                   TestSignalName => "DB(49)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(49),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(49),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(49),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(49),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB49,
                   Violation      => DBViol(49),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(50),
                   TestSignalName => "DB(50)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(50),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(50),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(50),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(50),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB50,
                   Violation      => DBViol(50),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(51),
                   TestSignalName => "DB(51)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(51),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(51),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(51),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(51),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB51,
                   Violation      => DBViol(51),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(52),
                   TestSignalName => "DB(52)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(52),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(52),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(52),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(52),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB52,
                   Violation      => DBViol(52),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(53),
                   TestSignalName => "DB(53)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(53),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(53),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(53),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(53),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB53,
                   Violation      => DBViol(53),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(54),
                   TestSignalName => "DB(54)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(54),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(54),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(54),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(54),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB54,
                   Violation      => DBViol(54),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(55),
                   TestSignalName => "DB(55)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(55),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(55),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(55),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(55),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB55,
                   Violation      => DBViol(55),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(56),
                   TestSignalName => "DB(56)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(56),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(56),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(56),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(56),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB56,
                   Violation      => DBViol(56),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(57),
                   TestSignalName => "DB(57)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(57),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(57),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(57),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(57),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB57,
                   Violation      => DBViol(57),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(58),
                   TestSignalName => "DB(58)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(58),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(58),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(58),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(58),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB58,
                   Violation      => DBViol(58),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(59),
                   TestSignalName => "DB(59)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(59),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(59),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(59),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(59),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB59,
                   Violation      => DBViol(59),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(60),
                   TestSignalName => "DB(60)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(60),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(60),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(60),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(60),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB60,
                   Violation      => DBViol(60),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(61),
                   TestSignalName => "DB(61)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(61),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(61),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(61),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(61),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB61,
                   Violation      => DBViol(61),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(62),
                   TestSignalName => "DB(62)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(62),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(62),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(62),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(62),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB62,
                   Violation      => DBViol(62),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => DB_dly(63),
                   TestSignalName => "DB(63)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_DB_CLKB_posedge_posedge(63),
                   SetupLow       => tsetup_DB_CLKB_negedge_posedge(63),
                   HoldHigh       => thold_DB_CLKB_negedge_posedge(63),
                   HoldLow        => thold_DB_CLKB_posedge_posedge(63),
                   CheckEnabled   => CheckData1,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_DB_CLKB63,
                   Violation      => DBViol(63),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => AB_dly(0),
                   TestSignalName => "AB(0)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_AB_CLKB_posedge_posedge(0),
                   SetupLow       => tsetup_AB_CLKB_negedge_posedge(0),
                   HoldHigh       => thold_AB_CLKB_negedge_posedge(0),
                   HoldLow        => thold_AB_CLKB_posedge_posedge(0),
                   CheckEnabled   => (To_X01(CENB_dly) /= '1'),
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_AB_CLKB0,
                   Violation      => ABViol(0),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => AB_dly(1),
                   TestSignalName => "AB(1)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_AB_CLKB_posedge_posedge(1),
                   SetupLow       => tsetup_AB_CLKB_negedge_posedge(1),
                   HoldHigh       => thold_AB_CLKB_negedge_posedge(1),
                   HoldLow        => thold_AB_CLKB_posedge_posedge(1),
                   CheckEnabled   => (To_X01(CENB_dly) /= '1'),
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_AB_CLKB1,
                   Violation      => ABViol(1),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => AB_dly(2),
                   TestSignalName => "AB(2)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_AB_CLKB_posedge_posedge(2),
                   SetupLow       => tsetup_AB_CLKB_negedge_posedge(2),
                   HoldHigh       => thold_AB_CLKB_negedge_posedge(2),
                   HoldLow        => thold_AB_CLKB_posedge_posedge(2),
                   CheckEnabled   => (To_X01(CENB_dly) /= '1'),
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_AB_CLKB2,
                   Violation      => ABViol(2),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => AB_dly(3),
                   TestSignalName => "AB(3)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_AB_CLKB_posedge_posedge(3),
                   SetupLow       => tsetup_AB_CLKB_negedge_posedge(3),
                   HoldHigh       => thold_AB_CLKB_negedge_posedge(3),
                   HoldLow        => thold_AB_CLKB_posedge_posedge(3),
                   CheckEnabled   => (To_X01(CENB_dly) /= '1'),
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_AB_CLKB3,
                   Violation      => ABViol(3),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => AB_dly(4),
                   TestSignalName => "AB(4)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_AB_CLKB_posedge_posedge(4),
                   SetupLow       => tsetup_AB_CLKB_negedge_posedge(4),
                   HoldHigh       => thold_AB_CLKB_negedge_posedge(4),
                   HoldLow        => thold_AB_CLKB_posedge_posedge(4),
                   CheckEnabled   => (To_X01(CENB_dly) /= '1'),
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_AB_CLKB4,
                   Violation      => ABViol(4),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => AB_dly(5),
                   TestSignalName => "AB(5)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_AB_CLKB_posedge_posedge(5),
                   SetupLow       => tsetup_AB_CLKB_negedge_posedge(5),
                   HoldHigh       => thold_AB_CLKB_negedge_posedge(5),
                   HoldLow        => thold_AB_CLKB_posedge_posedge(5),
                   CheckEnabled   => (To_X01(CENB_dly) /= '1'),
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_AB_CLKB5,
                   Violation      => ABViol(5),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => AB_dly(6),
                   TestSignalName => "AB(6)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_AB_CLKB_posedge_posedge(6),
                   SetupLow       => tsetup_AB_CLKB_negedge_posedge(6),
                   HoldHigh       => thold_AB_CLKB_negedge_posedge(6),
                   HoldLow        => thold_AB_CLKB_posedge_posedge(6),
                   CheckEnabled   => (To_X01(CENB_dly) /= '1'),
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_AB_CLKB6,
                   Violation      => ABViol(6),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => AB_dly(7),
                   TestSignalName => "AB(7)",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => tsetup_AB_CLKB_posedge_posedge(7),
                   SetupLow       => tsetup_AB_CLKB_negedge_posedge(7),
                   HoldHigh       => thold_AB_CLKB_negedge_posedge(7),
                   HoldLow        => thold_AB_CLKB_posedge_posedge(7),
                   CheckEnabled   => (To_X01(CENB_dly) /= '1'),
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_AB_CLKB7,
                   Violation      => ABViol(7),
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => CLKB_dly,
                   TestSignalName => "CLKB",
                   RefSignal      => CLKA_dly,
                   RefSignalName  => "CLKA",
                   SetupHigh      => 0 ns,
                   SetupLow       => 0 ns,
                   HoldHigh       => 0 ns,
                   HoldLow        => tsetup_CLKA_CLKB_posedge_posedge,
                   CheckEnabled   => cont_ckAckB_flag,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_CLKA_CLKB_posedge_posedge,
                   Violation      => viol_CLKA_CLKB_posedge_posedge,
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => CLKA_dly,
                   TestSignalName => "CLKA",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => 0 ns,
                   SetupLow       => 0 ns,
                   HoldHigh       => 0 ns,
                   HoldLow        => tsetup_CLKB_CLKA_posedge_posedge,
                   CheckEnabled   => cont_ckBckA_flag,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_CLKB_CLKA_posedge_posedge,
                   Violation      => viol_CLKB_CLKA_posedge_posedge,
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

               VitalSetupHoldCheck (
                   TestSignal     => CLKA_dly,
                   TestSignalName => "CLKA",
                   RefSignal      => CLKB_dly,
                   RefSignalName  => "CLKB",
                   SetupHigh      => 1 ps,
                   SetupLow       => 0 ns,
                   HoldHigh       => 0 ns,
                   HoldLow        => 0 ns,
                   CheckEnabled   => cont_flag,
                   RefTransition  => 'R',
                   HeaderMsg      => InstancePath & "Mem_cnnin2",
                   TimingData     => TimingDataInfo_sim_clocks,
                   Violation      => viol_sim_clocks,
                   XOn            => XOn,
                   MsgOn          => MsgOn,
                   MsgSeverity    => MsgSeverity );

          END IF;
       ----------------------------------------------------------------
       --Set flags for violation checking
       CheckData0 := (((CENA_dly nor WENA_dly) = '1') and (To_X01(TENA_dly) /= '0'));
       CheckData1 := (((CENB_dly nor WENB_dly) = '1') and (To_X01(TENB_dly) /= '0'));


       -- Test Mux Outputs
       CENYA_zd := CENA_dly;
       
       -- Set Violation Vectors
            WENAVio:= WENAviolation;
            WENAViol:= WENAviolation;

       AA_vio : FOR i IN AA_dly'range LOOP
            AAVio(i):= AAviol(i);
       END LOOP AA_vio;

       DA_vio : FOR i IN DA_dly'range LOOP
            DAVio(i):= DAviol(i);
       END LOOP DA_vio;

       CENYB_zd := CENB_dly;
       
       -- Set Violation Vectors
            WENBVio:= WENBviolation;
            WENBViol:= WENBviolation;

       AB_vio : FOR i IN AB_dly'range LOOP
            ABVio(i):= ABviol(i);
       END LOOP AB_vio;

       DB_vio : FOR i IN DB_dly'range LOOP
            DBVio(i):= DBviol(i);
       END LOOP DB_vio;

       if (
           is_x(viol_sim_clocks) or
           is_x(viol_CLKA_CLKB_posedge_posedge)) then
         CLKACLKBViol := 'X';
      else
         CLKACLKBViol := '0';
      end if;
       if (
           is_x(viol_CLKB_CLKA_posedge_posedge)) then
         CLKBCLKAViol := 'X';
      else
         CLKBCLKAViol := '0';
      end if;

       if (CLKBCLKAViol='X') or (CLKACLKBViol='X') then CLKCLKViol:='X';
       else CLKCLKViol := '0';
       end if;


       if (CLKA_dly'event ) then
          if ((LAST_CLKA = '0') and (CLKA_dly = '1')) then
	     latch_Ainputs;
             clear_status('0');
             mem_cycle(QAi,
                       QBi,
                       LATCHED_CENA,
	      	       to_slv(LATCHED_WENA),
                       LATCHED_AA,
                       LATCHED_DA,
		       UPM0,
		       '1',
                       '1',
                       '1',
                       '1',
                       MASK1,
                       ADDR1,
                       WORD1,
                       '1',
                       '1',
                       WORD1,
                       '1',
                       false,
                       WORD1,
                       '0'
		      );

          elsif (((LAST_CLKA = '1') and (CLKA_dly = '0')) or
                 (LAST_CLKA = 'X') or
                 ((LAST_CLKA = '0') and (CLKA_dly = '0')) or
                 ((LAST_CLKA = '1') and (CLKA_dly = '1'))) then
                 null; -- nothing
          elsif (CLKA_dly = 'X') then
             x_mem;
             QAi := WORDX;
	  end if;
          LAST_CLKA := CLKA_dly;
       end if;
       if (CLKB_dly'event ) then
          if ((LAST_CLKB = '0') and (CLKB_dly = '1')) then
	     latch_Binputs;
             clear_status('1');
             mem_cycle(QBi,
                       QAi,
                       LATCHED_CENB,
	      	       to_slv(LATCHED_WENB),
                       LATCHED_AB,
                       LATCHED_DB,
		       UPM0,
		       '1',
                       '1',
                       '1',
                       '1',
                       MASK1,
                       ADDR1,
                       WORD1,
                       '1',
                       '1',
                       WORD1,
                       '1',
                       false,
                       WORD1,
                       '1'
		      );

          elsif (((LAST_CLKB = '1') and (CLKB_dly = '0')) or
                 (LAST_CLKB = 'X') or
                 ((LAST_CLKB = '0') and (CLKB_dly = '0')) or
                 ((LAST_CLKB = '1') and (CLKB_dly = '1'))) then
                 null; -- nothing
          elsif (CLKB_dly = 'X') then
             x_mem;
             QBi := WORDX;
	  end if;
          LAST_CLKB := CLKB_dly;
       end if;

       if (
            is_x(CENAViol) or
            is_x(WENAViol) or
            is_x(AAVio) or
            is_x(DAVio) or
           is_x(CLKBCLKAViol) or
           is_x(CLKAViol)) then
          process_violationsA;
       end if;
       if (
            is_x(CENBViol) or
            is_x(WENBViol) or
            is_x(ABVio) or
            is_x(DBVio) or
           is_x(CLKACLKBViol) or
           is_x(CLKBViol)) then
          process_violationsB;
       end if;

       for j in BITS-1 downto 0 LOOP
          QAout(j) := QAi(j);
       end LOOP;
       for j in BITS-1 downto 0 LOOP
          QBout(j) := QBi(j);
       end LOOP;

    -----------------
    -- Path Delays --
    -----------------
       VitalPathDelay01(
          OutSignal => QA(0),
          OutSignalName => "QA(0)",
          OutTemp => QAout(0),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(0),
                           TRUE)
                    ),
          GlitchData => QA0_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(1),
          OutSignalName => "QA(1)",
          OutTemp => QAout(1),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(1),
                           TRUE)
                    ),
          GlitchData => QA1_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(2),
          OutSignalName => "QA(2)",
          OutTemp => QAout(2),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(2),
                           TRUE)
                    ),
          GlitchData => QA2_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(3),
          OutSignalName => "QA(3)",
          OutTemp => QAout(3),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(3),
                           TRUE)
                    ),
          GlitchData => QA3_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(4),
          OutSignalName => "QA(4)",
          OutTemp => QAout(4),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(4),
                           TRUE)
                    ),
          GlitchData => QA4_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(5),
          OutSignalName => "QA(5)",
          OutTemp => QAout(5),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(5),
                           TRUE)
                    ),
          GlitchData => QA5_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(6),
          OutSignalName => "QA(6)",
          OutTemp => QAout(6),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(6),
                           TRUE)
                    ),
          GlitchData => QA6_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(7),
          OutSignalName => "QA(7)",
          OutTemp => QAout(7),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(7),
                           TRUE)
                    ),
          GlitchData => QA7_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(8),
          OutSignalName => "QA(8)",
          OutTemp => QAout(8),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(8),
                           TRUE)
                    ),
          GlitchData => QA8_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(9),
          OutSignalName => "QA(9)",
          OutTemp => QAout(9),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(9),
                           TRUE)
                    ),
          GlitchData => QA9_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(10),
          OutSignalName => "QA(10)",
          OutTemp => QAout(10),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(10),
                           TRUE)
                    ),
          GlitchData => QA10_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(11),
          OutSignalName => "QA(11)",
          OutTemp => QAout(11),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(11),
                           TRUE)
                    ),
          GlitchData => QA11_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(12),
          OutSignalName => "QA(12)",
          OutTemp => QAout(12),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(12),
                           TRUE)
                    ),
          GlitchData => QA12_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(13),
          OutSignalName => "QA(13)",
          OutTemp => QAout(13),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(13),
                           TRUE)
                    ),
          GlitchData => QA13_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(14),
          OutSignalName => "QA(14)",
          OutTemp => QAout(14),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(14),
                           TRUE)
                    ),
          GlitchData => QA14_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(15),
          OutSignalName => "QA(15)",
          OutTemp => QAout(15),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(15),
                           TRUE)
                    ),
          GlitchData => QA15_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(16),
          OutSignalName => "QA(16)",
          OutTemp => QAout(16),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(16),
                           TRUE)
                    ),
          GlitchData => QA16_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(17),
          OutSignalName => "QA(17)",
          OutTemp => QAout(17),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(17),
                           TRUE)
                    ),
          GlitchData => QA17_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(18),
          OutSignalName => "QA(18)",
          OutTemp => QAout(18),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(18),
                           TRUE)
                    ),
          GlitchData => QA18_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(19),
          OutSignalName => "QA(19)",
          OutTemp => QAout(19),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(19),
                           TRUE)
                    ),
          GlitchData => QA19_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(20),
          OutSignalName => "QA(20)",
          OutTemp => QAout(20),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(20),
                           TRUE)
                    ),
          GlitchData => QA20_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(21),
          OutSignalName => "QA(21)",
          OutTemp => QAout(21),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(21),
                           TRUE)
                    ),
          GlitchData => QA21_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(22),
          OutSignalName => "QA(22)",
          OutTemp => QAout(22),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(22),
                           TRUE)
                    ),
          GlitchData => QA22_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(23),
          OutSignalName => "QA(23)",
          OutTemp => QAout(23),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(23),
                           TRUE)
                    ),
          GlitchData => QA23_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(24),
          OutSignalName => "QA(24)",
          OutTemp => QAout(24),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(24),
                           TRUE)
                    ),
          GlitchData => QA24_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(25),
          OutSignalName => "QA(25)",
          OutTemp => QAout(25),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(25),
                           TRUE)
                    ),
          GlitchData => QA25_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(26),
          OutSignalName => "QA(26)",
          OutTemp => QAout(26),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(26),
                           TRUE)
                    ),
          GlitchData => QA26_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(27),
          OutSignalName => "QA(27)",
          OutTemp => QAout(27),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(27),
                           TRUE)
                    ),
          GlitchData => QA27_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(28),
          OutSignalName => "QA(28)",
          OutTemp => QAout(28),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(28),
                           TRUE)
                    ),
          GlitchData => QA28_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(29),
          OutSignalName => "QA(29)",
          OutTemp => QAout(29),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(29),
                           TRUE)
                    ),
          GlitchData => QA29_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(30),
          OutSignalName => "QA(30)",
          OutTemp => QAout(30),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(30),
                           TRUE)
                    ),
          GlitchData => QA30_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(31),
          OutSignalName => "QA(31)",
          OutTemp => QAout(31),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(31),
                           TRUE)
                    ),
          GlitchData => QA31_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(32),
          OutSignalName => "QA(32)",
          OutTemp => QAout(32),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(32),
                           TRUE)
                    ),
          GlitchData => QA32_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(33),
          OutSignalName => "QA(33)",
          OutTemp => QAout(33),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(33),
                           TRUE)
                    ),
          GlitchData => QA33_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(34),
          OutSignalName => "QA(34)",
          OutTemp => QAout(34),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(34),
                           TRUE)
                    ),
          GlitchData => QA34_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(35),
          OutSignalName => "QA(35)",
          OutTemp => QAout(35),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(35),
                           TRUE)
                    ),
          GlitchData => QA35_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(36),
          OutSignalName => "QA(36)",
          OutTemp => QAout(36),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(36),
                           TRUE)
                    ),
          GlitchData => QA36_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(37),
          OutSignalName => "QA(37)",
          OutTemp => QAout(37),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(37),
                           TRUE)
                    ),
          GlitchData => QA37_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(38),
          OutSignalName => "QA(38)",
          OutTemp => QAout(38),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(38),
                           TRUE)
                    ),
          GlitchData => QA38_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(39),
          OutSignalName => "QA(39)",
          OutTemp => QAout(39),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(39),
                           TRUE)
                    ),
          GlitchData => QA39_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(40),
          OutSignalName => "QA(40)",
          OutTemp => QAout(40),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(40),
                           TRUE)
                    ),
          GlitchData => QA40_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(41),
          OutSignalName => "QA(41)",
          OutTemp => QAout(41),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(41),
                           TRUE)
                    ),
          GlitchData => QA41_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(42),
          OutSignalName => "QA(42)",
          OutTemp => QAout(42),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(42),
                           TRUE)
                    ),
          GlitchData => QA42_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(43),
          OutSignalName => "QA(43)",
          OutTemp => QAout(43),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(43),
                           TRUE)
                    ),
          GlitchData => QA43_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(44),
          OutSignalName => "QA(44)",
          OutTemp => QAout(44),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(44),
                           TRUE)
                    ),
          GlitchData => QA44_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(45),
          OutSignalName => "QA(45)",
          OutTemp => QAout(45),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(45),
                           TRUE)
                    ),
          GlitchData => QA45_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(46),
          OutSignalName => "QA(46)",
          OutTemp => QAout(46),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(46),
                           TRUE)
                    ),
          GlitchData => QA46_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(47),
          OutSignalName => "QA(47)",
          OutTemp => QAout(47),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(47),
                           TRUE)
                    ),
          GlitchData => QA47_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(48),
          OutSignalName => "QA(48)",
          OutTemp => QAout(48),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(48),
                           TRUE)
                    ),
          GlitchData => QA48_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(49),
          OutSignalName => "QA(49)",
          OutTemp => QAout(49),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(49),
                           TRUE)
                    ),
          GlitchData => QA49_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(50),
          OutSignalName => "QA(50)",
          OutTemp => QAout(50),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(50),
                           TRUE)
                    ),
          GlitchData => QA50_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(51),
          OutSignalName => "QA(51)",
          OutTemp => QAout(51),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(51),
                           TRUE)
                    ),
          GlitchData => QA51_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(52),
          OutSignalName => "QA(52)",
          OutTemp => QAout(52),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(52),
                           TRUE)
                    ),
          GlitchData => QA52_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(53),
          OutSignalName => "QA(53)",
          OutTemp => QAout(53),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(53),
                           TRUE)
                    ),
          GlitchData => QA53_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(54),
          OutSignalName => "QA(54)",
          OutTemp => QAout(54),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(54),
                           TRUE)
                    ),
          GlitchData => QA54_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(55),
          OutSignalName => "QA(55)",
          OutTemp => QAout(55),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(55),
                           TRUE)
                    ),
          GlitchData => QA55_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(56),
          OutSignalName => "QA(56)",
          OutTemp => QAout(56),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(56),
                           TRUE)
                    ),
          GlitchData => QA56_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(57),
          OutSignalName => "QA(57)",
          OutTemp => QAout(57),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(57),
                           TRUE)
                    ),
          GlitchData => QA57_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(58),
          OutSignalName => "QA(58)",
          OutTemp => QAout(58),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(58),
                           TRUE)
                    ),
          GlitchData => QA58_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(59),
          OutSignalName => "QA(59)",
          OutTemp => QAout(59),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(59),
                           TRUE)
                    ),
          GlitchData => QA59_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(60),
          OutSignalName => "QA(60)",
          OutTemp => QAout(60),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(60),
                           TRUE)
                    ),
          GlitchData => QA60_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(61),
          OutSignalName => "QA(61)",
          OutTemp => QAout(61),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(61),
                           TRUE)
                    ),
          GlitchData => QA61_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(62),
          OutSignalName => "QA(62)",
          OutTemp => QAout(62),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(62),
                           TRUE)
                    ),
          GlitchData => QA62_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QA(63),
          OutSignalName => "QA(63)",
          OutTemp => QAout(63),
          Paths => (
                    0 => ( CLKA_dly'LAST_EVENT,
                           tpd_CLKA_QA(63),
                           TRUE)
                    ),
          GlitchData => QA63_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(0),
          OutSignalName => "QB(0)",
          OutTemp => QBout(0),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(0),
                           TRUE)
                    ),
          GlitchData => QB0_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(1),
          OutSignalName => "QB(1)",
          OutTemp => QBout(1),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(1),
                           TRUE)
                    ),
          GlitchData => QB1_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(2),
          OutSignalName => "QB(2)",
          OutTemp => QBout(2),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(2),
                           TRUE)
                    ),
          GlitchData => QB2_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(3),
          OutSignalName => "QB(3)",
          OutTemp => QBout(3),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(3),
                           TRUE)
                    ),
          GlitchData => QB3_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(4),
          OutSignalName => "QB(4)",
          OutTemp => QBout(4),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(4),
                           TRUE)
                    ),
          GlitchData => QB4_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(5),
          OutSignalName => "QB(5)",
          OutTemp => QBout(5),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(5),
                           TRUE)
                    ),
          GlitchData => QB5_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(6),
          OutSignalName => "QB(6)",
          OutTemp => QBout(6),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(6),
                           TRUE)
                    ),
          GlitchData => QB6_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(7),
          OutSignalName => "QB(7)",
          OutTemp => QBout(7),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(7),
                           TRUE)
                    ),
          GlitchData => QB7_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(8),
          OutSignalName => "QB(8)",
          OutTemp => QBout(8),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(8),
                           TRUE)
                    ),
          GlitchData => QB8_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(9),
          OutSignalName => "QB(9)",
          OutTemp => QBout(9),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(9),
                           TRUE)
                    ),
          GlitchData => QB9_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(10),
          OutSignalName => "QB(10)",
          OutTemp => QBout(10),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(10),
                           TRUE)
                    ),
          GlitchData => QB10_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(11),
          OutSignalName => "QB(11)",
          OutTemp => QBout(11),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(11),
                           TRUE)
                    ),
          GlitchData => QB11_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(12),
          OutSignalName => "QB(12)",
          OutTemp => QBout(12),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(12),
                           TRUE)
                    ),
          GlitchData => QB12_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(13),
          OutSignalName => "QB(13)",
          OutTemp => QBout(13),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(13),
                           TRUE)
                    ),
          GlitchData => QB13_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(14),
          OutSignalName => "QB(14)",
          OutTemp => QBout(14),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(14),
                           TRUE)
                    ),
          GlitchData => QB14_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(15),
          OutSignalName => "QB(15)",
          OutTemp => QBout(15),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(15),
                           TRUE)
                    ),
          GlitchData => QB15_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(16),
          OutSignalName => "QB(16)",
          OutTemp => QBout(16),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(16),
                           TRUE)
                    ),
          GlitchData => QB16_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(17),
          OutSignalName => "QB(17)",
          OutTemp => QBout(17),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(17),
                           TRUE)
                    ),
          GlitchData => QB17_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(18),
          OutSignalName => "QB(18)",
          OutTemp => QBout(18),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(18),
                           TRUE)
                    ),
          GlitchData => QB18_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(19),
          OutSignalName => "QB(19)",
          OutTemp => QBout(19),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(19),
                           TRUE)
                    ),
          GlitchData => QB19_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(20),
          OutSignalName => "QB(20)",
          OutTemp => QBout(20),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(20),
                           TRUE)
                    ),
          GlitchData => QB20_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(21),
          OutSignalName => "QB(21)",
          OutTemp => QBout(21),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(21),
                           TRUE)
                    ),
          GlitchData => QB21_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(22),
          OutSignalName => "QB(22)",
          OutTemp => QBout(22),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(22),
                           TRUE)
                    ),
          GlitchData => QB22_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(23),
          OutSignalName => "QB(23)",
          OutTemp => QBout(23),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(23),
                           TRUE)
                    ),
          GlitchData => QB23_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(24),
          OutSignalName => "QB(24)",
          OutTemp => QBout(24),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(24),
                           TRUE)
                    ),
          GlitchData => QB24_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(25),
          OutSignalName => "QB(25)",
          OutTemp => QBout(25),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(25),
                           TRUE)
                    ),
          GlitchData => QB25_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(26),
          OutSignalName => "QB(26)",
          OutTemp => QBout(26),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(26),
                           TRUE)
                    ),
          GlitchData => QB26_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(27),
          OutSignalName => "QB(27)",
          OutTemp => QBout(27),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(27),
                           TRUE)
                    ),
          GlitchData => QB27_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(28),
          OutSignalName => "QB(28)",
          OutTemp => QBout(28),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(28),
                           TRUE)
                    ),
          GlitchData => QB28_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(29),
          OutSignalName => "QB(29)",
          OutTemp => QBout(29),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(29),
                           TRUE)
                    ),
          GlitchData => QB29_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(30),
          OutSignalName => "QB(30)",
          OutTemp => QBout(30),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(30),
                           TRUE)
                    ),
          GlitchData => QB30_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(31),
          OutSignalName => "QB(31)",
          OutTemp => QBout(31),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(31),
                           TRUE)
                    ),
          GlitchData => QB31_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(32),
          OutSignalName => "QB(32)",
          OutTemp => QBout(32),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(32),
                           TRUE)
                    ),
          GlitchData => QB32_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(33),
          OutSignalName => "QB(33)",
          OutTemp => QBout(33),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(33),
                           TRUE)
                    ),
          GlitchData => QB33_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(34),
          OutSignalName => "QB(34)",
          OutTemp => QBout(34),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(34),
                           TRUE)
                    ),
          GlitchData => QB34_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(35),
          OutSignalName => "QB(35)",
          OutTemp => QBout(35),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(35),
                           TRUE)
                    ),
          GlitchData => QB35_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(36),
          OutSignalName => "QB(36)",
          OutTemp => QBout(36),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(36),
                           TRUE)
                    ),
          GlitchData => QB36_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(37),
          OutSignalName => "QB(37)",
          OutTemp => QBout(37),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(37),
                           TRUE)
                    ),
          GlitchData => QB37_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(38),
          OutSignalName => "QB(38)",
          OutTemp => QBout(38),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(38),
                           TRUE)
                    ),
          GlitchData => QB38_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(39),
          OutSignalName => "QB(39)",
          OutTemp => QBout(39),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(39),
                           TRUE)
                    ),
          GlitchData => QB39_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(40),
          OutSignalName => "QB(40)",
          OutTemp => QBout(40),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(40),
                           TRUE)
                    ),
          GlitchData => QB40_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(41),
          OutSignalName => "QB(41)",
          OutTemp => QBout(41),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(41),
                           TRUE)
                    ),
          GlitchData => QB41_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(42),
          OutSignalName => "QB(42)",
          OutTemp => QBout(42),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(42),
                           TRUE)
                    ),
          GlitchData => QB42_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(43),
          OutSignalName => "QB(43)",
          OutTemp => QBout(43),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(43),
                           TRUE)
                    ),
          GlitchData => QB43_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(44),
          OutSignalName => "QB(44)",
          OutTemp => QBout(44),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(44),
                           TRUE)
                    ),
          GlitchData => QB44_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(45),
          OutSignalName => "QB(45)",
          OutTemp => QBout(45),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(45),
                           TRUE)
                    ),
          GlitchData => QB45_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(46),
          OutSignalName => "QB(46)",
          OutTemp => QBout(46),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(46),
                           TRUE)
                    ),
          GlitchData => QB46_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(47),
          OutSignalName => "QB(47)",
          OutTemp => QBout(47),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(47),
                           TRUE)
                    ),
          GlitchData => QB47_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(48),
          OutSignalName => "QB(48)",
          OutTemp => QBout(48),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(48),
                           TRUE)
                    ),
          GlitchData => QB48_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(49),
          OutSignalName => "QB(49)",
          OutTemp => QBout(49),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(49),
                           TRUE)
                    ),
          GlitchData => QB49_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(50),
          OutSignalName => "QB(50)",
          OutTemp => QBout(50),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(50),
                           TRUE)
                    ),
          GlitchData => QB50_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(51),
          OutSignalName => "QB(51)",
          OutTemp => QBout(51),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(51),
                           TRUE)
                    ),
          GlitchData => QB51_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(52),
          OutSignalName => "QB(52)",
          OutTemp => QBout(52),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(52),
                           TRUE)
                    ),
          GlitchData => QB52_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(53),
          OutSignalName => "QB(53)",
          OutTemp => QBout(53),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(53),
                           TRUE)
                    ),
          GlitchData => QB53_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(54),
          OutSignalName => "QB(54)",
          OutTemp => QBout(54),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(54),
                           TRUE)
                    ),
          GlitchData => QB54_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(55),
          OutSignalName => "QB(55)",
          OutTemp => QBout(55),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(55),
                           TRUE)
                    ),
          GlitchData => QB55_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(56),
          OutSignalName => "QB(56)",
          OutTemp => QBout(56),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(56),
                           TRUE)
                    ),
          GlitchData => QB56_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(57),
          OutSignalName => "QB(57)",
          OutTemp => QBout(57),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(57),
                           TRUE)
                    ),
          GlitchData => QB57_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(58),
          OutSignalName => "QB(58)",
          OutTemp => QBout(58),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(58),
                           TRUE)
                    ),
          GlitchData => QB58_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(59),
          OutSignalName => "QB(59)",
          OutTemp => QBout(59),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(59),
                           TRUE)
                    ),
          GlitchData => QB59_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(60),
          OutSignalName => "QB(60)",
          OutTemp => QBout(60),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(60),
                           TRUE)
                    ),
          GlitchData => QB60_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(61),
          OutSignalName => "QB(61)",
          OutTemp => QBout(61),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(61),
                           TRUE)
                    ),
          GlitchData => QB61_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(62),
          OutSignalName => "QB(62)",
          OutTemp => QBout(62),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(62),
                           TRUE)
                    ),
          GlitchData => QB62_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

       VitalPathDelay01(
          OutSignal => QB(63),
          OutSignalName => "QB(63)",
          OutTemp => QBout(63),
          Paths => (
                    0 => ( CLKB_dly'LAST_EVENT,
                           tpd_CLKB_QB(63),
                           TRUE)
                    ),
          GlitchData => QB63_GlitchData,
          Mode =>OnEvent,
          XOn => XOn,
          MsgOn => MsgOn,
          MsgSeverity => WARNING);

end process;
End Behavioral;
