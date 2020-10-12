/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : O-2018.06
// Date      : Thu Apr 16 20:29:14 2020
/////////////////////////////////////////////////////////////


module cnn_toplevel ( clk, reset, enable, num_filter, num_kernel, 
        filter_length, num_total_conv, write_enable_b, mem_addr_b, conv, 
        mem_out, write_enable_a, outmem_addr );
  input [7:0] num_filter;
  input [7:0] num_kernel;
  input [7:0] filter_length;
  input [7:0] num_total_conv;
  output [63:0] mem_out;
  output [9:0] outmem_addr;
  input clk, reset, enable, write_enable_b, mem_addr_b;
  output conv, write_enable_a;

  tri   clk;
  tri   reset;
  tri   enable;
  tri   [7:0] num_filter;
  tri   [7:0] num_kernel;
  tri   [7:0] filter_length;
  tri   [7:0] num_total_conv;
  tri   write_enable_b;
  tri   mem_addr_b;
  tri   conv;
  tri   [63:0] mem_out;
  tri   write_enable_a;
  tri   [9:0] outmem_addr;
  tri   sys_start;
  tri   sum_timestep;
  tri   obuf_write_data_9_;
  tri   obuf_write_data_95_;
  tri   obuf_write_data_93_;
  tri   obuf_write_data_92_;
  tri   obuf_write_data_91_;
  tri   obuf_write_data_90_;
  tri   obuf_write_data_8_;
  tri   obuf_write_data_89_;
  tri   obuf_write_data_88_;
  tri   obuf_write_data_87_;
  tri   obuf_write_data_7_;
  tri   obuf_write_data_79_;
  tri   obuf_write_data_77_;
  tri   obuf_write_data_76_;
  tri   obuf_write_data_75_;
  tri   obuf_write_data_74_;
  tri   obuf_write_data_73_;
  tri   obuf_write_data_72_;
  tri   obuf_write_data_71_;
  tri   obuf_write_data_63_;
  tri   obuf_write_data_61_;
  tri   obuf_write_data_60_;
  tri   obuf_write_data_59_;
  tri   obuf_write_data_58_;
  tri   obuf_write_data_57_;
  tri   obuf_write_data_56_;
  tri   obuf_write_data_55_;
  tri   obuf_write_data_47_;
  tri   obuf_write_data_45_;
  tri   obuf_write_data_44_;
  tri   obuf_write_data_43_;
  tri   obuf_write_data_42_;
  tri   obuf_write_data_41_;
  tri   obuf_write_data_40_;
  tri   obuf_write_data_39_;
  tri   obuf_write_data_31_;
  tri   obuf_write_data_29_;
  tri   obuf_write_data_28_;
  tri   obuf_write_data_27_;
  tri   obuf_write_data_26_;
  tri   obuf_write_data_25_;
  tri   obuf_write_data_24_;
  tri   obuf_write_data_23_;
  tri   obuf_write_data_15_;
  tri   obuf_write_data_13_;
  tri   obuf_write_data_12_;
  tri   obuf_write_data_127_;
  tri   obuf_write_data_125_;
  tri   obuf_write_data_124_;
  tri   obuf_write_data_123_;
  tri   obuf_write_data_122_;
  tri   obuf_write_data_121_;
  tri   obuf_write_data_120_;
  tri   obuf_write_data_11_;
  tri   obuf_write_data_119_;
  tri   obuf_write_data_111_;
  tri   obuf_write_data_10_;
  tri   obuf_write_data_109_;
  tri   obuf_write_data_108_;
  tri   obuf_write_data_107_;
  tri   obuf_write_data_106_;
  tri   obuf_write_data_105_;
  tri   obuf_write_data_104_;
  tri   obuf_write_data_103_;
  tri   input_load;
  tri   ibuf_read_data_9_;
  tri   ibuf_read_data_99_;
  tri   ibuf_read_data_98_;
  tri   ibuf_read_data_97_;
  tri   ibuf_read_data_96_;
  tri   ibuf_read_data_95_;
  tri   ibuf_read_data_94_;
  tri   ibuf_read_data_93_;
  tri   ibuf_read_data_92_;
  tri   ibuf_read_data_91_;
  tri   ibuf_read_data_90_;
  tri   ibuf_read_data_8_;
  tri   ibuf_read_data_89_;
  tri   ibuf_read_data_88_;
  tri   ibuf_read_data_87_;
  tri   ibuf_read_data_86_;
  tri   ibuf_read_data_85_;
  tri   ibuf_read_data_84_;
  tri   ibuf_read_data_83_;
  tri   ibuf_read_data_82_;
  tri   ibuf_read_data_81_;
  tri   ibuf_read_data_80_;
  tri   ibuf_read_data_7_;
  tri   ibuf_read_data_79_;
  tri   ibuf_read_data_78_;
  tri   ibuf_read_data_77_;
  tri   ibuf_read_data_76_;
  tri   ibuf_read_data_75_;
  tri   ibuf_read_data_74_;
  tri   ibuf_read_data_73_;
  tri   ibuf_read_data_72_;
  tri   ibuf_read_data_71_;
  tri   ibuf_read_data_70_;
  tri   ibuf_read_data_6_;
  tri   ibuf_read_data_69_;
  tri   ibuf_read_data_68_;
  tri   ibuf_read_data_67_;
  tri   ibuf_read_data_66_;
  tri   ibuf_read_data_65_;
  tri   ibuf_read_data_64_;
  tri   ibuf_read_data_63_;
  tri   ibuf_read_data_62_;
  tri   ibuf_read_data_61_;
  tri   ibuf_read_data_60_;
  tri   ibuf_read_data_5_;
  tri   ibuf_read_data_59_;
  tri   ibuf_read_data_58_;
  tri   ibuf_read_data_57_;
  tri   ibuf_read_data_56_;
  tri   ibuf_read_data_55_;
  tri   ibuf_read_data_54_;
  tri   ibuf_read_data_53_;
  tri   ibuf_read_data_52_;
  tri   ibuf_read_data_51_;
  tri   ibuf_read_data_50_;
  tri   ibuf_read_data_4_;
  tri   ibuf_read_data_49_;
  tri   ibuf_read_data_48_;
  tri   ibuf_read_data_47_;
  tri   ibuf_read_data_46_;
  tri   ibuf_read_data_45_;
  tri   ibuf_read_data_44_;
  tri   ibuf_read_data_43_;
  tri   ibuf_read_data_42_;
  tri   ibuf_read_data_41_;
  tri   ibuf_read_data_40_;
  tri   ibuf_read_data_3_;
  tri   ibuf_read_data_39_;
  tri   ibuf_read_data_38_;
  tri   ibuf_read_data_37_;
  tri   ibuf_read_data_36_;
  tri   ibuf_read_data_35_;
  tri   ibuf_read_data_34_;
  tri   ibuf_read_data_33_;
  tri   ibuf_read_data_32_;
  tri   ibuf_read_data_31_;
  tri   ibuf_read_data_30_;
  tri   ibuf_read_data_2_;
  tri   ibuf_read_data_29_;
  tri   ibuf_read_data_28_;
  tri   ibuf_read_data_27_;
  tri   ibuf_read_data_26_;
  tri   ibuf_read_data_25_;
  tri   ibuf_read_data_24_;
  tri   ibuf_read_data_23_;
  tri   ibuf_read_data_22_;
  tri   ibuf_read_data_21_;
  tri   ibuf_read_data_20_;
  tri   ibuf_read_data_1_;
  tri   ibuf_read_data_19_;
  tri   ibuf_read_data_18_;
  tri   ibuf_read_data_17_;
  tri   ibuf_read_data_16_;
  tri   ibuf_read_data_15_;
  tri   ibuf_read_data_14_;
  tri   ibuf_read_data_13_;
  tri   ibuf_read_data_12_;
  tri   ibuf_read_data_127_;
  tri   ibuf_read_data_126_;
  tri   ibuf_read_data_125_;
  tri   ibuf_read_data_124_;
  tri   ibuf_read_data_123_;
  tri   ibuf_read_data_122_;
  tri   ibuf_read_data_121_;
  tri   ibuf_read_data_120_;
  tri   ibuf_read_data_11_;
  tri   ibuf_read_data_119_;
  tri   ibuf_read_data_118_;
  tri   ibuf_read_data_117_;
  tri   ibuf_read_data_116_;
  tri   ibuf_read_data_115_;
  tri   ibuf_read_data_114_;
  tri   ibuf_read_data_113_;
  tri   ibuf_read_data_112_;
  tri   ibuf_read_data_111_;
  tri   ibuf_read_data_110_;
  tri   ibuf_read_data_10_;
  tri   ibuf_read_data_109_;
  tri   ibuf_read_data_108_;
  tri   ibuf_read_data_107_;
  tri   ibuf_read_data_106_;
  tri   ibuf_read_data_105_;
  tri   ibuf_read_data_104_;
  tri   ibuf_read_data_103_;
  tri   ibuf_read_data_102_;
  tri   ibuf_read_data_101_;
  tri   ibuf_read_data_100_;
  tri   ibuf_read_data_0_;
  tri   filter_load;
  tri   filter_cnt_7_;
  tri   filter_cnt_6_;
  tri   filter_cnt_5_;
  tri   filter_cnt_4_;
  tri   filter_cnt_3_;
  tri   filter_cnt_2_;
  tri   filter_cnt_1_;
  tri   filter_cnt_0_;
  tri   filter_addr_9_;
  tri   filter_addr_8_;
  tri   filter_addr_7_;
  tri   filter_addr_6_;
  tri   filter_addr_63_;
  tri   filter_addr_62_;
  tri   filter_addr_61_;
  tri   filter_addr_60_;
  tri   filter_addr_5_;
  tri   filter_addr_59_;
  tri   filter_addr_58_;
  tri   filter_addr_57_;
  tri   filter_addr_56_;
  tri   filter_addr_55_;
  tri   filter_addr_54_;
  tri   filter_addr_53_;
  tri   filter_addr_52_;
  tri   filter_addr_51_;
  tri   filter_addr_50_;
  tri   filter_addr_4_;
  tri   filter_addr_49_;
  tri   filter_addr_48_;
  tri   filter_addr_47_;
  tri   filter_addr_46_;
  tri   filter_addr_45_;
  tri   filter_addr_44_;
  tri   filter_addr_43_;
  tri   filter_addr_42_;
  tri   filter_addr_41_;
  tri   filter_addr_40_;
  tri   filter_addr_3_;
  tri   filter_addr_39_;
  tri   filter_addr_38_;
  tri   filter_addr_37_;
  tri   filter_addr_36_;
  tri   filter_addr_35_;
  tri   filter_addr_34_;
  tri   filter_addr_33_;
  tri   filter_addr_32_;
  tri   filter_addr_31_;
  tri   filter_addr_30_;
  tri   filter_addr_2_;
  tri   filter_addr_29_;
  tri   filter_addr_28_;
  tri   filter_addr_27_;
  tri   filter_addr_26_;
  tri   filter_addr_25_;
  tri   filter_addr_24_;
  tri   filter_addr_23_;
  tri   filter_addr_22_;
  tri   filter_addr_21_;
  tri   filter_addr_20_;
  tri   filter_addr_1_;
  tri   filter_addr_19_;
  tri   filter_addr_18_;
  tri   filter_addr_17_;
  tri   filter_addr_16_;
  tri   filter_addr_15_;
  tri   filter_addr_14_;
  tri   filter_addr_13_;
  tri   filter_addr_12_;
  tri   filter_addr_11_;
  tri   filter_addr_10_;
  tri   filter_addr_0_;
  tri   data_addr_9_;
  tri   data_addr_8_;
  tri   data_addr_7_;
  tri   data_addr_6_;
  tri   data_addr_5_;
  tri   data_addr_4_;
  tri   data_addr_3_;
  tri   data_addr_2_;
  tri   data_addr_1_;
  tri   data_addr_0_;
  tri   n_input_load;
  tri   n_filter_addr_9_;
  tri   n_filter_addr_8_;
  tri   n_filter_addr_7_;
  tri   n_filter_addr_6_;
  tri   n_filter_addr_63_;
  tri   n_filter_addr_62_;
  tri   n_filter_addr_61_;
  tri   n_filter_addr_60_;
  tri   n_filter_addr_5_;
  tri   n_filter_addr_59_;
  tri   n_filter_addr_58_;
  tri   n_filter_addr_57_;
  tri   n_filter_addr_56_;
  tri   n_filter_addr_55_;
  tri   n_filter_addr_54_;
  tri   n_filter_addr_53_;
  tri   n_filter_addr_52_;
  tri   n_filter_addr_51_;
  tri   n_filter_addr_50_;
  tri   n_filter_addr_4_;
  tri   n_filter_addr_49_;
  tri   n_filter_addr_48_;
  tri   n_filter_addr_47_;
  tri   n_filter_addr_46_;
  tri   n_filter_addr_45_;
  tri   n_filter_addr_44_;
  tri   n_filter_addr_43_;
  tri   n_filter_addr_42_;
  tri   n_filter_addr_41_;
  tri   n_filter_addr_40_;
  tri   n_filter_addr_3_;
  tri   n_filter_addr_39_;
  tri   n_filter_addr_38_;
  tri   n_filter_addr_37_;
  tri   n_filter_addr_36_;
  tri   n_filter_addr_35_;
  tri   n_filter_addr_34_;
  tri   n_filter_addr_33_;
  tri   n_filter_addr_32_;
  tri   n_filter_addr_31_;
  tri   n_filter_addr_30_;
  tri   n_filter_addr_2_;
  tri   n_filter_addr_29_;
  tri   n_filter_addr_28_;
  tri   n_filter_addr_27_;
  tri   n_filter_addr_26_;
  tri   n_filter_addr_25_;
  tri   n_filter_addr_24_;
  tri   n_filter_addr_23_;
  tri   n_filter_addr_22_;
  tri   n_filter_addr_21_;
  tri   n_filter_addr_20_;
  tri   n_filter_addr_1_;
  tri   n_filter_addr_19_;
  tri   n_filter_addr_18_;
  tri   n_filter_addr_17_;
  tri   n_filter_addr_16_;
  tri   n_filter_addr_15_;
  tri   n_filter_addr_14_;
  tri   n_filter_addr_13_;
  tri   n_filter_addr_12_;
  tri   n_filter_addr_11_;
  tri   n_filter_addr_10_;
  tri   n_filter_addr_0_;
  tri   n1;
  tri   n2;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, 
        SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15, 
        SYNOPSYS_UNCONNECTED__16, SYNOPSYS_UNCONNECTED__17, 
        SYNOPSYS_UNCONNECTED__18, SYNOPSYS_UNCONNECTED__19, 
        SYNOPSYS_UNCONNECTED__20, SYNOPSYS_UNCONNECTED__21, 
        SYNOPSYS_UNCONNECTED__22, SYNOPSYS_UNCONNECTED__23, 
        SYNOPSYS_UNCONNECTED__24, SYNOPSYS_UNCONNECTED__25, 
        SYNOPSYS_UNCONNECTED__26, SYNOPSYS_UNCONNECTED__27, 
        SYNOPSYS_UNCONNECTED__28, SYNOPSYS_UNCONNECTED__29, 
        SYNOPSYS_UNCONNECTED__30, SYNOPSYS_UNCONNECTED__31, 
        SYNOPSYS_UNCONNECTED__32, SYNOPSYS_UNCONNECTED__33, 
        SYNOPSYS_UNCONNECTED__34, SYNOPSYS_UNCONNECTED__35, 
        SYNOPSYS_UNCONNECTED__36, SYNOPSYS_UNCONNECTED__37, 
        SYNOPSYS_UNCONNECTED__38, SYNOPSYS_UNCONNECTED__39, 
        SYNOPSYS_UNCONNECTED__40, SYNOPSYS_UNCONNECTED__41, 
        SYNOPSYS_UNCONNECTED__42, SYNOPSYS_UNCONNECTED__43, 
        SYNOPSYS_UNCONNECTED__44, SYNOPSYS_UNCONNECTED__45, 
        SYNOPSYS_UNCONNECTED__46, SYNOPSYS_UNCONNECTED__47, 
        SYNOPSYS_UNCONNECTED__48, SYNOPSYS_UNCONNECTED__49, 
        SYNOPSYS_UNCONNECTED__50, SYNOPSYS_UNCONNECTED__51, 
        SYNOPSYS_UNCONNECTED__52, SYNOPSYS_UNCONNECTED__53, 
        SYNOPSYS_UNCONNECTED__54, SYNOPSYS_UNCONNECTED__55, 
        SYNOPSYS_UNCONNECTED__56, SYNOPSYS_UNCONNECTED__57, 
        SYNOPSYS_UNCONNECTED__58, SYNOPSYS_UNCONNECTED__59, 
        SYNOPSYS_UNCONNECTED__60, SYNOPSYS_UNCONNECTED__61, 
        SYNOPSYS_UNCONNECTED__62, SYNOPSYS_UNCONNECTED__63;

  controller ctrl ( .clk(clk), .reset(reset), .enable(enable), .num_filter(
        num_filter), .num_kernel(num_kernel), .filter_length(filter_length), 
        .num_total_conv(num_total_conv), .filter_cnt({filter_cnt_7_, 
        filter_cnt_6_, filter_cnt_5_, filter_cnt_4_, filter_cnt_3_, 
        filter_cnt_2_, filter_cnt_1_, filter_cnt_0_}), .sys_start(sys_start), 
        .conv(conv), .filter_load(filter_load), .input_load(input_load), 
        .sum_timestep(sum_timestep), .data_addr({data_addr_9_, data_addr_8_, 
        data_addr_7_, data_addr_6_, data_addr_5_, data_addr_4_, data_addr_3_, 
        data_addr_2_, data_addr_1_, data_addr_0_}), .outmem_addr(outmem_addr), 
        .write_enable(write_enable_a) );
  pe_decoder pedr ( .filter_cnt({filter_cnt_7_, filter_cnt_6_, filter_cnt_5_, 
        filter_cnt_4_, filter_cnt_3_, filter_cnt_2_, filter_cnt_1_, 
        filter_cnt_0_}), .filter_load(filter_load), .num_filter(num_filter), 
        .num_kernel(num_kernel), .filter_addr({filter_addr_63_, 
        filter_addr_62_, filter_addr_61_, filter_addr_60_, filter_addr_59_, 
        filter_addr_58_, filter_addr_57_, filter_addr_56_, filter_addr_55_, 
        filter_addr_54_, filter_addr_53_, filter_addr_52_, filter_addr_51_, 
        filter_addr_50_, filter_addr_49_, filter_addr_48_, filter_addr_47_, 
        filter_addr_46_, filter_addr_45_, filter_addr_44_, filter_addr_43_, 
        filter_addr_42_, filter_addr_41_, filter_addr_40_, filter_addr_39_, 
        filter_addr_38_, filter_addr_37_, filter_addr_36_, filter_addr_35_, 
        filter_addr_34_, filter_addr_33_, filter_addr_32_, filter_addr_31_, 
        filter_addr_30_, filter_addr_29_, filter_addr_28_, filter_addr_27_, 
        filter_addr_26_, filter_addr_25_, filter_addr_24_, filter_addr_23_, 
        filter_addr_22_, filter_addr_21_, filter_addr_20_, filter_addr_19_, 
        filter_addr_18_, filter_addr_17_, filter_addr_16_, filter_addr_15_, 
        filter_addr_14_, filter_addr_13_, filter_addr_12_, filter_addr_11_, 
        filter_addr_10_, filter_addr_9_, filter_addr_8_, filter_addr_7_, 
        filter_addr_6_, filter_addr_5_, filter_addr_4_, filter_addr_3_, 
        filter_addr_2_, filter_addr_1_, filter_addr_0_}) );
  register_sync filter_addr_delay ( .p1(clk), .p2(reset), .p3(enable), .p4({
        filter_addr_63_, filter_addr_62_, filter_addr_61_, filter_addr_60_, 
        filter_addr_59_, filter_addr_58_, filter_addr_57_, filter_addr_56_, 
        filter_addr_55_, filter_addr_54_, filter_addr_53_, filter_addr_52_, 
        filter_addr_51_, filter_addr_50_, filter_addr_49_, filter_addr_48_, 
        filter_addr_47_, filter_addr_46_, filter_addr_45_, filter_addr_44_, 
        filter_addr_43_, filter_addr_42_, filter_addr_41_, filter_addr_40_, 
        filter_addr_39_, filter_addr_38_, filter_addr_37_, filter_addr_36_, 
        filter_addr_35_, filter_addr_34_, filter_addr_33_, filter_addr_32_, 
        filter_addr_31_, filter_addr_30_, filter_addr_29_, filter_addr_28_, 
        filter_addr_27_, filter_addr_26_, filter_addr_25_, filter_addr_24_, 
        filter_addr_23_, filter_addr_22_, filter_addr_21_, filter_addr_20_, 
        filter_addr_19_, filter_addr_18_, filter_addr_17_, filter_addr_16_, 
        filter_addr_15_, filter_addr_14_, filter_addr_13_, filter_addr_12_, 
        filter_addr_11_, filter_addr_10_, filter_addr_9_, filter_addr_8_, 
        filter_addr_7_, filter_addr_6_, filter_addr_5_, filter_addr_4_, 
        filter_addr_3_, filter_addr_2_, filter_addr_1_, filter_addr_0_}), .p5(
        {n_filter_addr_63_, n_filter_addr_62_, n_filter_addr_61_, 
        n_filter_addr_60_, n_filter_addr_59_, n_filter_addr_58_, 
        n_filter_addr_57_, n_filter_addr_56_, n_filter_addr_55_, 
        n_filter_addr_54_, n_filter_addr_53_, n_filter_addr_52_, 
        n_filter_addr_51_, n_filter_addr_50_, n_filter_addr_49_, 
        n_filter_addr_48_, n_filter_addr_47_, n_filter_addr_46_, 
        n_filter_addr_45_, n_filter_addr_44_, n_filter_addr_43_, 
        n_filter_addr_42_, n_filter_addr_41_, n_filter_addr_40_, 
        n_filter_addr_39_, n_filter_addr_38_, n_filter_addr_37_, 
        n_filter_addr_36_, n_filter_addr_35_, n_filter_addr_34_, 
        n_filter_addr_33_, n_filter_addr_32_, n_filter_addr_31_, 
        n_filter_addr_30_, n_filter_addr_29_, n_filter_addr_28_, 
        n_filter_addr_27_, n_filter_addr_26_, n_filter_addr_25_, 
        n_filter_addr_24_, n_filter_addr_23_, n_filter_addr_22_, 
        n_filter_addr_21_, n_filter_addr_20_, n_filter_addr_19_, 
        n_filter_addr_18_, n_filter_addr_17_, n_filter_addr_16_, 
        n_filter_addr_15_, n_filter_addr_14_, n_filter_addr_13_, 
        n_filter_addr_12_, n_filter_addr_11_, n_filter_addr_10_, 
        n_filter_addr_9_, n_filter_addr_8_, n_filter_addr_7_, n_filter_addr_6_, 
        n_filter_addr_5_, n_filter_addr_4_, n_filter_addr_3_, n_filter_addr_2_, 
        n_filter_addr_1_, n_filter_addr_0_}) );
  register_sync input_load_delay ( .p1(clk), .p2(reset), .p3(enable), .p4(
        input_load), .p5(n_input_load) );
  pe_array pea ( .clk(clk), .reset(reset), .enable(enable), .sys_start(
        sys_start), .filter_addr({n_filter_addr_63_, n_filter_addr_62_, 
        n_filter_addr_61_, n_filter_addr_60_, n_filter_addr_59_, 
        n_filter_addr_58_, n_filter_addr_57_, n_filter_addr_56_, 
        n_filter_addr_55_, n_filter_addr_54_, n_filter_addr_53_, 
        n_filter_addr_52_, n_filter_addr_51_, n_filter_addr_50_, 
        n_filter_addr_49_, n_filter_addr_48_, n_filter_addr_47_, 
        n_filter_addr_46_, n_filter_addr_45_, n_filter_addr_44_, 
        n_filter_addr_43_, n_filter_addr_42_, n_filter_addr_41_, 
        n_filter_addr_40_, n_filter_addr_39_, n_filter_addr_38_, 
        n_filter_addr_37_, n_filter_addr_36_, n_filter_addr_35_, 
        n_filter_addr_34_, n_filter_addr_33_, n_filter_addr_32_, 
        n_filter_addr_31_, n_filter_addr_30_, n_filter_addr_29_, 
        n_filter_addr_28_, n_filter_addr_27_, n_filter_addr_26_, 
        n_filter_addr_25_, n_filter_addr_24_, n_filter_addr_23_, 
        n_filter_addr_22_, n_filter_addr_21_, n_filter_addr_20_, 
        n_filter_addr_19_, n_filter_addr_18_, n_filter_addr_17_, 
        n_filter_addr_16_, n_filter_addr_15_, n_filter_addr_14_, 
        n_filter_addr_13_, n_filter_addr_12_, n_filter_addr_11_, 
        n_filter_addr_10_, n_filter_addr_9_, n_filter_addr_8_, 
        n_filter_addr_7_, n_filter_addr_6_, n_filter_addr_5_, n_filter_addr_4_, 
        n_filter_addr_3_, n_filter_addr_2_, n_filter_addr_1_, n_filter_addr_0_}), .input_load(n_input_load), .sum_timestep(sum_timestep), .num_filter(
        num_filter), .num_kernel(num_kernel), .ibuf_read_data({
        ibuf_read_data_127_, ibuf_read_data_126_, ibuf_read_data_125_, 
        ibuf_read_data_124_, ibuf_read_data_123_, ibuf_read_data_122_, 
        ibuf_read_data_121_, ibuf_read_data_120_, ibuf_read_data_119_, 
        ibuf_read_data_118_, ibuf_read_data_117_, ibuf_read_data_116_, 
        ibuf_read_data_115_, ibuf_read_data_114_, ibuf_read_data_113_, 
        ibuf_read_data_112_, ibuf_read_data_111_, ibuf_read_data_110_, 
        ibuf_read_data_109_, ibuf_read_data_108_, ibuf_read_data_107_, 
        ibuf_read_data_106_, ibuf_read_data_105_, ibuf_read_data_104_, 
        ibuf_read_data_103_, ibuf_read_data_102_, ibuf_read_data_101_, 
        ibuf_read_data_100_, ibuf_read_data_99_, ibuf_read_data_98_, 
        ibuf_read_data_97_, ibuf_read_data_96_, ibuf_read_data_95_, 
        ibuf_read_data_94_, ibuf_read_data_93_, ibuf_read_data_92_, 
        ibuf_read_data_91_, ibuf_read_data_90_, ibuf_read_data_89_, 
        ibuf_read_data_88_, ibuf_read_data_87_, ibuf_read_data_86_, 
        ibuf_read_data_85_, ibuf_read_data_84_, ibuf_read_data_83_, 
        ibuf_read_data_82_, ibuf_read_data_81_, ibuf_read_data_80_, 
        ibuf_read_data_79_, ibuf_read_data_78_, ibuf_read_data_77_, 
        ibuf_read_data_76_, ibuf_read_data_75_, ibuf_read_data_74_, 
        ibuf_read_data_73_, ibuf_read_data_72_, ibuf_read_data_71_, 
        ibuf_read_data_70_, ibuf_read_data_69_, ibuf_read_data_68_, 
        ibuf_read_data_67_, ibuf_read_data_66_, ibuf_read_data_65_, 
        ibuf_read_data_64_, ibuf_read_data_63_, ibuf_read_data_62_, 
        ibuf_read_data_61_, ibuf_read_data_60_, ibuf_read_data_59_, 
        ibuf_read_data_58_, ibuf_read_data_57_, ibuf_read_data_56_, 
        ibuf_read_data_55_, ibuf_read_data_54_, ibuf_read_data_53_, 
        ibuf_read_data_52_, ibuf_read_data_51_, ibuf_read_data_50_, 
        ibuf_read_data_49_, ibuf_read_data_48_, ibuf_read_data_47_, 
        ibuf_read_data_46_, ibuf_read_data_45_, ibuf_read_data_44_, 
        ibuf_read_data_43_, ibuf_read_data_42_, ibuf_read_data_41_, 
        ibuf_read_data_40_, ibuf_read_data_39_, ibuf_read_data_38_, 
        ibuf_read_data_37_, ibuf_read_data_36_, ibuf_read_data_35_, 
        ibuf_read_data_34_, ibuf_read_data_33_, ibuf_read_data_32_, 
        ibuf_read_data_31_, ibuf_read_data_30_, ibuf_read_data_29_, 
        ibuf_read_data_28_, ibuf_read_data_27_, ibuf_read_data_26_, 
        ibuf_read_data_25_, ibuf_read_data_24_, ibuf_read_data_23_, 
        ibuf_read_data_22_, ibuf_read_data_21_, ibuf_read_data_20_, 
        ibuf_read_data_19_, ibuf_read_data_18_, ibuf_read_data_17_, 
        ibuf_read_data_16_, ibuf_read_data_15_, ibuf_read_data_14_, 
        ibuf_read_data_13_, ibuf_read_data_12_, ibuf_read_data_11_, 
        ibuf_read_data_10_, ibuf_read_data_9_, ibuf_read_data_8_, 
        ibuf_read_data_7_, ibuf_read_data_6_, ibuf_read_data_5_, 
        ibuf_read_data_4_, ibuf_read_data_3_, ibuf_read_data_2_, 
        ibuf_read_data_1_, ibuf_read_data_0_}), .obuf_write_data({
        obuf_write_data_127_, SYNOPSYS_UNCONNECTED__0, obuf_write_data_125_, 
        obuf_write_data_124_, obuf_write_data_123_, obuf_write_data_122_, 
        obuf_write_data_121_, obuf_write_data_120_, obuf_write_data_119_, 
        SYNOPSYS_UNCONNECTED__1, SYNOPSYS_UNCONNECTED__2, 
        SYNOPSYS_UNCONNECTED__3, SYNOPSYS_UNCONNECTED__4, 
        SYNOPSYS_UNCONNECTED__5, SYNOPSYS_UNCONNECTED__6, 
        SYNOPSYS_UNCONNECTED__7, obuf_write_data_111_, SYNOPSYS_UNCONNECTED__8, 
        obuf_write_data_109_, obuf_write_data_108_, obuf_write_data_107_, 
        obuf_write_data_106_, obuf_write_data_105_, obuf_write_data_104_, 
        obuf_write_data_103_, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15, 
        obuf_write_data_95_, SYNOPSYS_UNCONNECTED__16, obuf_write_data_93_, 
        obuf_write_data_92_, obuf_write_data_91_, obuf_write_data_90_, 
        obuf_write_data_89_, obuf_write_data_88_, obuf_write_data_87_, 
        SYNOPSYS_UNCONNECTED__17, SYNOPSYS_UNCONNECTED__18, 
        SYNOPSYS_UNCONNECTED__19, SYNOPSYS_UNCONNECTED__20, 
        SYNOPSYS_UNCONNECTED__21, SYNOPSYS_UNCONNECTED__22, 
        SYNOPSYS_UNCONNECTED__23, obuf_write_data_79_, 
        SYNOPSYS_UNCONNECTED__24, obuf_write_data_77_, obuf_write_data_76_, 
        obuf_write_data_75_, obuf_write_data_74_, obuf_write_data_73_, 
        obuf_write_data_72_, obuf_write_data_71_, SYNOPSYS_UNCONNECTED__25, 
        SYNOPSYS_UNCONNECTED__26, SYNOPSYS_UNCONNECTED__27, 
        SYNOPSYS_UNCONNECTED__28, SYNOPSYS_UNCONNECTED__29, 
        SYNOPSYS_UNCONNECTED__30, SYNOPSYS_UNCONNECTED__31, 
        obuf_write_data_63_, SYNOPSYS_UNCONNECTED__32, obuf_write_data_61_, 
        obuf_write_data_60_, obuf_write_data_59_, obuf_write_data_58_, 
        obuf_write_data_57_, obuf_write_data_56_, obuf_write_data_55_, 
        SYNOPSYS_UNCONNECTED__33, SYNOPSYS_UNCONNECTED__34, 
        SYNOPSYS_UNCONNECTED__35, SYNOPSYS_UNCONNECTED__36, 
        SYNOPSYS_UNCONNECTED__37, SYNOPSYS_UNCONNECTED__38, 
        SYNOPSYS_UNCONNECTED__39, obuf_write_data_47_, 
        SYNOPSYS_UNCONNECTED__40, obuf_write_data_45_, obuf_write_data_44_, 
        obuf_write_data_43_, obuf_write_data_42_, obuf_write_data_41_, 
        obuf_write_data_40_, obuf_write_data_39_, SYNOPSYS_UNCONNECTED__41, 
        SYNOPSYS_UNCONNECTED__42, SYNOPSYS_UNCONNECTED__43, 
        SYNOPSYS_UNCONNECTED__44, SYNOPSYS_UNCONNECTED__45, 
        SYNOPSYS_UNCONNECTED__46, SYNOPSYS_UNCONNECTED__47, 
        obuf_write_data_31_, SYNOPSYS_UNCONNECTED__48, obuf_write_data_29_, 
        obuf_write_data_28_, obuf_write_data_27_, obuf_write_data_26_, 
        obuf_write_data_25_, obuf_write_data_24_, obuf_write_data_23_, 
        SYNOPSYS_UNCONNECTED__49, SYNOPSYS_UNCONNECTED__50, 
        SYNOPSYS_UNCONNECTED__51, SYNOPSYS_UNCONNECTED__52, 
        SYNOPSYS_UNCONNECTED__53, SYNOPSYS_UNCONNECTED__54, 
        SYNOPSYS_UNCONNECTED__55, obuf_write_data_15_, 
        SYNOPSYS_UNCONNECTED__56, obuf_write_data_13_, obuf_write_data_12_, 
        obuf_write_data_11_, obuf_write_data_10_, obuf_write_data_9_, 
        obuf_write_data_8_, obuf_write_data_7_, SYNOPSYS_UNCONNECTED__57, 
        SYNOPSYS_UNCONNECTED__58, SYNOPSYS_UNCONNECTED__59, 
        SYNOPSYS_UNCONNECTED__60, SYNOPSYS_UNCONNECTED__61, 
        SYNOPSYS_UNCONNECTED__62, SYNOPSYS_UNCONNECTED__63}) );
  CNN_ROM1 rom1 ( .CLK(clk), .Q({ibuf_read_data_127_, ibuf_read_data_126_, 
        ibuf_read_data_125_, ibuf_read_data_124_, ibuf_read_data_123_, 
        ibuf_read_data_122_, ibuf_read_data_121_, ibuf_read_data_120_, 
        ibuf_read_data_119_, ibuf_read_data_118_, ibuf_read_data_117_, 
        ibuf_read_data_116_, ibuf_read_data_115_, ibuf_read_data_114_, 
        ibuf_read_data_113_, ibuf_read_data_112_, ibuf_read_data_111_, 
        ibuf_read_data_110_, ibuf_read_data_109_, ibuf_read_data_108_, 
        ibuf_read_data_107_, ibuf_read_data_106_, ibuf_read_data_105_, 
        ibuf_read_data_104_, ibuf_read_data_103_, ibuf_read_data_102_, 
        ibuf_read_data_101_, ibuf_read_data_100_, ibuf_read_data_99_, 
        ibuf_read_data_98_, ibuf_read_data_97_, ibuf_read_data_96_, 
        ibuf_read_data_95_, ibuf_read_data_94_, ibuf_read_data_93_, 
        ibuf_read_data_92_, ibuf_read_data_91_, ibuf_read_data_90_, 
        ibuf_read_data_89_, ibuf_read_data_88_, ibuf_read_data_87_, 
        ibuf_read_data_86_, ibuf_read_data_85_, ibuf_read_data_84_, 
        ibuf_read_data_83_, ibuf_read_data_82_, ibuf_read_data_81_, 
        ibuf_read_data_80_, ibuf_read_data_79_, ibuf_read_data_78_, 
        ibuf_read_data_77_, ibuf_read_data_76_, ibuf_read_data_75_, 
        ibuf_read_data_74_, ibuf_read_data_73_, ibuf_read_data_72_, 
        ibuf_read_data_71_, ibuf_read_data_70_, ibuf_read_data_69_, 
        ibuf_read_data_68_, ibuf_read_data_67_, ibuf_read_data_66_, 
        ibuf_read_data_65_, ibuf_read_data_64_}), .A({data_addr_9_, 
        data_addr_8_, data_addr_7_, data_addr_6_, data_addr_5_, data_addr_4_, 
        data_addr_3_, data_addr_2_, data_addr_1_, data_addr_0_}), .CEN({1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}) );
  CNN_ROM2 rom2 ( .CLK(clk), .Q({ibuf_read_data_63_, ibuf_read_data_62_, 
        ibuf_read_data_61_, ibuf_read_data_60_, ibuf_read_data_59_, 
        ibuf_read_data_58_, ibuf_read_data_57_, ibuf_read_data_56_, 
        ibuf_read_data_55_, ibuf_read_data_54_, ibuf_read_data_53_, 
        ibuf_read_data_52_, ibuf_read_data_51_, ibuf_read_data_50_, 
        ibuf_read_data_49_, ibuf_read_data_48_, ibuf_read_data_47_, 
        ibuf_read_data_46_, ibuf_read_data_45_, ibuf_read_data_44_, 
        ibuf_read_data_43_, ibuf_read_data_42_, ibuf_read_data_41_, 
        ibuf_read_data_40_, ibuf_read_data_39_, ibuf_read_data_38_, 
        ibuf_read_data_37_, ibuf_read_data_36_, ibuf_read_data_35_, 
        ibuf_read_data_34_, ibuf_read_data_33_, ibuf_read_data_32_, 
        ibuf_read_data_31_, ibuf_read_data_30_, ibuf_read_data_29_, 
        ibuf_read_data_28_, ibuf_read_data_27_, ibuf_read_data_26_, 
        ibuf_read_data_25_, ibuf_read_data_24_, ibuf_read_data_23_, 
        ibuf_read_data_22_, ibuf_read_data_21_, ibuf_read_data_20_, 
        ibuf_read_data_19_, ibuf_read_data_18_, ibuf_read_data_17_, 
        ibuf_read_data_16_, ibuf_read_data_15_, ibuf_read_data_14_, 
        ibuf_read_data_13_, ibuf_read_data_12_, ibuf_read_data_11_, 
        ibuf_read_data_10_, ibuf_read_data_9_, ibuf_read_data_8_, 
        ibuf_read_data_7_, ibuf_read_data_6_, ibuf_read_data_5_, 
        ibuf_read_data_4_, ibuf_read_data_3_, ibuf_read_data_2_, 
        ibuf_read_data_1_, ibuf_read_data_0_}), .A({data_addr_9_, data_addr_8_, 
        data_addr_7_, data_addr_6_, data_addr_5_, data_addr_4_, data_addr_3_, 
        data_addr_2_, data_addr_1_, data_addr_0_}), .CEN({1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0}) );
  CNN_outMEM outMEM ( .CLKA(clk), .CENA({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0}), .WENA(write_enable_a), .AA(outmem_addr), .DA({
        obuf_write_data_127_, obuf_write_data_125_, obuf_write_data_124_, 
        obuf_write_data_123_, obuf_write_data_122_, obuf_write_data_121_, 
        obuf_write_data_120_, obuf_write_data_119_, obuf_write_data_111_, 
        obuf_write_data_109_, obuf_write_data_108_, obuf_write_data_107_, 
        obuf_write_data_106_, obuf_write_data_105_, obuf_write_data_104_, 
        obuf_write_data_103_, obuf_write_data_95_, obuf_write_data_93_, 
        obuf_write_data_92_, obuf_write_data_91_, obuf_write_data_90_, 
        obuf_write_data_89_, obuf_write_data_88_, obuf_write_data_87_, 
        obuf_write_data_79_, obuf_write_data_77_, obuf_write_data_76_, 
        obuf_write_data_75_, obuf_write_data_74_, obuf_write_data_73_, 
        obuf_write_data_72_, obuf_write_data_71_, obuf_write_data_63_, 
        obuf_write_data_61_, obuf_write_data_60_, obuf_write_data_59_, 
        obuf_write_data_58_, obuf_write_data_57_, obuf_write_data_56_, 
        obuf_write_data_55_, obuf_write_data_47_, obuf_write_data_45_, 
        obuf_write_data_44_, obuf_write_data_43_, obuf_write_data_42_, 
        obuf_write_data_41_, obuf_write_data_40_, obuf_write_data_39_, 
        obuf_write_data_31_, obuf_write_data_29_, obuf_write_data_28_, 
        obuf_write_data_27_, obuf_write_data_26_, obuf_write_data_25_, 
        obuf_write_data_24_, obuf_write_data_23_, obuf_write_data_15_, 
        obuf_write_data_13_, obuf_write_data_12_, obuf_write_data_11_, 
        obuf_write_data_10_, obuf_write_data_9_, obuf_write_data_8_, 
        obuf_write_data_7_}), .QB(mem_out), .CLKB(clk), .CENB({1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .WENB(write_enable_b), .AB(
        mem_addr_b) );
endmodule

