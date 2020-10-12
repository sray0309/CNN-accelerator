//
//      CONFIDENTIAL  AND  PROPRIETARY SOFTWARE OF ARM Physical IP, INC.
//      
//      Copyright (c) 1993-2020  ARM Physical IP, Inc.  All  Rights Reserved.
//      
//      Use of this Software is subject to the terms and conditions  of the
//      applicable license agreement with ARM Physical IP, Inc.  In addition,
//      this Software is protected by patents, copyright law and international
//      treaties.
//      
//      The copyright notice(s) in this Software does not indicate actual or
//      intended publication of this Software.
//      
//      name:			High-Speed/Density Via ROM Generator
//           			IBM CMRF8SF-LPVT Process
//      version:		2007Q2V1
//      comment:		
//      configuration:	 -instname "CNN_ROM1" -words 256 -bits 64 -frequency 1 -ring_width 4.0 -code_file "CNN1_1.txt" -mux 16 -top_layer met4 -power_type rings -horiz met3 -vert met4 -cust_comment "" -left_bus_delim "[" -right_bus_delim "]" -pwr_gnd_rename "VDD:VDD,GND:VSS" -prefix "" -pin_space 0.0 -name_case upper -check_instname on -diodes on -inside_ring_type GND -drive 6 -corners ff_1p32v_m55c,ff_1p65v_125c,tt_1p2v_25c,ss_1p08v_m55c
//
//      Verilog model for Synchronous Single-Port Rom
//
//      Instance Name:              CNN_ROM1
//      Words:                      256
//      Bits:                       64
//      Mux:                        16
//      Drive:                      6
//      Write Mask:                 Off
//      Extra Margin Adjustment:    Off
//      Accelerated Retention Test: Off
//      Redundant Rows:             0
//      Redundant Columns:          0
//      Test Muxes                  Off
//
//      Creation Date:  2020-02-17 01:34:48Z
//      Version: 	2007Q2V1
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All buses are modeled [MSB:LSB].  All 
//          ports are padded with Verilog primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
  module CNN_ROM1 (
                Q,
                CLK,
                CEN,
                A
                );
   parameter                BITS = 64;
   parameter                WORD_DEPTH = 256;
   parameter                ADDR_WIDTH = 8;
   parameter                WORDX = {BITS{1'bx}};
   parameter                WORD1 = {BITS{1'b1}};
   parameter                ADDRX = {ADDR_WIDTH{1'bx}};
   parameter                ADDR1 = {ADDR_WIDTH{1'b1}};
   parameter                WEN_WIDTH = 1;
   parameter                WP_SIZE    = 64 ;
   parameter                RCOLS = 0;
   parameter                MASKX = {WEN_WIDTH{1'bx}};
   parameter                MASK1 = {WEN_WIDTH{1'b1}};
   parameter                MASK0 = {WEN_WIDTH{1'b0}};
   parameter                MUX = 16;
   parameter                COL_ADDR_WIDTH = 4;
   parameter                RROWS = 0;
   parameter                UPM_WIDTH = 3;
   parameter                UPM0 = {UPM_WIDTH{1'b0}};
   parameter                RCA_WIDTH = 1;
   parameter                RED_COLUMNS = 2;
	
   output [63:0]            Q;
   input                    CLK;
   input                    CEN;
   input [7:0]              A;

   reg [BITS+RED_COLUMNS-1:0]             mem [0:WORD_DEPTH-1];
   reg [BITS+RED_COLUMNS-1:0]             rows [(MUX*4)-1:0];   // added 2 bits for column redundancy


   reg                      NOT_CEN;
   reg                      NOT_A7;
   reg                      NOT_A6;
   reg                      NOT_A5;
   reg                      NOT_A4;
   reg                      NOT_A3;
   reg                      NOT_A2;
   reg                      NOT_A1;
   reg                      NOT_A0;
   reg [ADDR_WIDTH-1:0]     NOT_A;

   reg                      NOT_CLK_PER;
   reg                      NOT_CLK_MINH;
   reg                      NOT_CLK_MINL;

   reg                      LAST_NOT_CEN;
   reg [ADDR_WIDTH-1:0]     LAST_NOT_A;

   reg                      LAST_NOT_CLK_PER;
   reg                      LAST_NOT_CLK_MINH;
   reg                      LAST_NOT_CLK_MINL;
   wire [BITS-1:0]          _Q;
   wire                     _CLK;
   wire                     _CEN;
   wire [ADDR_WIDTH-1:0]    _A;

   wire                     CEN_flag;
   wire                     TCEN_flag;
   wire                     flag;
   wire                     D_flag;

   reg                      LATCHED_CEN;
   reg [ADDR_WIDTH-1:0]     LATCHED_A;

   reg [BITS-1:0]           Qi;
   reg [BITS-1:0]           LAST_Qi;

   reg [BITS-1:0]           dummy_qb;

   reg                      LAST_CLK;

   reg [BITS+RED_COLUMNS-1:0]           last_status [(MUX*2)-1:0];

   initial 
     begin
	$readmemb("../CNN1_1.rcf", mem );
	adjust_mem;
     end

   task adjust_mem;
      integer n;
      integer m;
      reg [BITS+RED_COLUMNS-1:0] tmp;
      begin
	 for (n=0; n<WORD_DEPTH; n=n+1)
	 begin
	    tmp = mem[n];
            for (m=0; m<RED_COLUMNS; m=m+1)
               tmp[BITS+m] = 1'bx;
	    mem[n] = tmp;
	 end
      end
   endtask // adjust_mem

   task update_notifier_buses;
   begin
      NOT_A = {
               NOT_A7,
               NOT_A6,
               NOT_A5,
               NOT_A4,
               NOT_A3,
               NOT_A2,
               NOT_A1,
               NOT_A0};
   end
   endtask


   task mem_cycle;
      inout [BITS-1:0] 	            q;
      inout [BITS-1:0] 	            other_q;
      input 			    cen;
      input [WEN_WIDTH-1:0] 	    wen;
      input [ADDR_WIDTH-1:0]        a;
      input [BITS-1:0]              d;
      input [UPM_WIDTH-1:0]         ema;
      input                         artn;
      input                         ten;
      input                         ben;
      input                         tcen;
      input [WEN_WIDTH-1:0]         twen;
      input [ADDR_WIDTH-1:0]        ta;
      input [BITS-1:0]              td;
      input                         rren;
      input                         rra;
      input [BITS-1:0]              cren;
      input [RCA_WIDTH-1:0]         rca;
      input                         contention_flag;
      input [BITS-1:0]              other_cren;
      input                         port;  // 0 for A port, 1 for B port
      
      integer 		    mask_section ;
      integer 		    lsb ;
      integer 		    msb ;
      reg 		    CENi;
      reg [WEN_WIDTH-1:0]   WENi;
      reg [ADDR_WIDTH-1:0]  Ai;
      reg [BITS-1:0] 	    Di;
      reg 		    ValidDummyPinsi;

      begin
	 CENi = ten ? cen : tcen;
	 Ai = ten ? a : ta;
	 WENi = ten ? wen : twen;
	 Di = ten ? d : td;
	 ValidDummyPinsi = (^({ema,artn}) !== 1'bx);
	 
	 if ( (artn !== 1'b1) & (WENi !== MASK1) & (WENi !== MASK0))
           begin
              $display("ARTN is active and all bits of WEN are not active or inactive");
              $display("Setting WEN bus to x");
	      WENi = MASKX;
	   end
	 if (!valid_cren(cren))
	   begin
              $display("CREN is in an invalid state");
              $display("Setting CREN bus to x");
	      cren = WORDX;
	   end

	 for (mask_section=0;mask_section<WEN_WIDTH; mask_section=mask_section+1)
	 begin
	    lsb = (mask_section)*(WP_SIZE) ;
	    msb = BITS <= (lsb+WP_SIZE-1) ? (BITS-1) : (lsb+WP_SIZE-1) ;
	    casez({WENi[mask_section],CENi,ValidDummyPinsi})
	      3'b101: begin
		 read_mem(q,other_q,Ai,Di,rren,rra,cren,rca,
                          msb,lsb,0,contention_flag,port);
	      end
	      3'b001: begin
		 write_mem(other_q,Ai,Di,rren,rra,cren,rca,
                           msb,lsb,0,contention_flag,other_cren,port);
		 write_thru(q,Ai,Di,rren,rra,cren,rca,
                            msb,lsb,0);
	      end
	      3'b?1?: ;
              3'b10?,
	      3'b1x?: begin
		 read_mem(q,other_q,Ai,Di,rren,rra,cren,rca,
                          msb,lsb,1,contention_flag,port);
	      end
              3'b00?,
	      3'b0x?: begin
		 write_mem(other_q,Ai,Di,rren,rra,cren,rca,
                           msb,lsb,1,contention_flag,other_cren,port);
		 write_thru(q,Ai,Di,rren,rra,cren,rca,
                            msb,lsb,1);
	      end
              3'bx0?,
	      3'bxx?: begin
		 write_mem(other_q,Ai,Di,rren,rra,cren,rca,
                           msb,lsb,1,contention_flag,other_cren,port);
		 read_mem(q,other_q,Ai,Di,rren,rra,cren,rca,
                          msb,lsb,1,contention_flag,port);
	      end
	    endcase 
	 end
      end
   endtask

   task read_mem;
      inout [BITS-1:0] q;
      inout [BITS-1:0] other_q;
      input [ADDR_WIDTH-1:0] a;
      input [BITS-1:0] d;
      input rren;
      input radd;
      input [BITS-1:0] cren;
      input [RCA_WIDTH-1:0] rca;
      input msb;
      input lsb;
      input xout;
      input contention;
      input port;
      integer msb;
      integer lsb;
      reg [BITS+RED_COLUMNS-1:0] tmpdata;
      reg [BITS+RED_COLUMNS-1:0] other_status;
      reg [BITS+RED_COLUMNS-1:0] status;
      integer m;
      integer n;
      begin
	 if (rren === 1'bx)
	   begin
	      for (n=lsb; n<=msb; n=n+1) q[n] = 1'bx ;
              x_mem;
              x_rows;
	   end
	 else
	   begin
	      if (!valid_address(a,rren,radd))
		begin
		   for (n=lsb; n<=msb; n=n+1) q[n] = 1'bx ;
		end
	      else
		begin
		   if (rren === 1'b1)
		     tmpdata = mem[a];
		   else if (rren === 1'b0)
		     tmpdata = rows[{1'b0,radd,a[COL_ADDR_WIDTH-1:0]}];
		   status = last_status[{port,a[COL_ADDR_WIDTH-1:0]}];
		   other_status = last_status[{!port,a[COL_ADDR_WIDTH-1:0]}];
		   for (n=lsb; n<=msb; n=n+1)
		   begin
		      if (cren[n] === 1'b1)
			begin
			   if ((other_status[n] === 1'b0) & contention)
			     begin
				tmpdata[n] = 1'bx;
				q[n] = 1'bx;
			     end
			   else
			     begin
				q[n] = xout ? 1'bx : tmpdata[n];
				status[n] = 1'b1;
			     end
			end
		      else if (cren[n] === 1'b0)
			begin
                           if ((n == BITS-1) & (^(rca) !== 1'bx))
                             begin
				if ((other_status[n+rca+1] === 1'b0) & contention)
				  begin
				     tmpdata[n+rca+1] = 1'bx;
			             q[n] = 1'bx;
				  end
				else
				  begin
			             q[n] = xout ? 1'bx : tmpdata[n+rca+1];
				     status[n+rca+1] = 1'b1;
				  end
                             end
                           else if ((n == BITS-1) & (^(rca) === 1'bx))
                             begin
				for (m=0; m<RED_COLUMNS; m=m+1)
				begin
				   if ((other_status[n+m+1] === 1'b0) & contention)
				     tmpdata[n+m+1] = 1'bx;
				   status[n+m+1] = 1'b1;
				end
			        q[n] = 1'bx;
                             end
                           else
                             begin
				if ((other_status[n+1] === 1'b0) & contention)
				  begin
				     tmpdata[n+1] = 1'bx;
			             q[n] = 1'bx;
				  end
				else
				  begin
			             q[n] = xout ? 1'bx : tmpdata[n+1];
				     status[n+1] = 1'b1;
				  end
                             end
			end
		      else
			begin
                           if ((n == BITS-1) & (^(rca) !== 1'bx))
                             begin
				if ((other_status[n] === 1'b0) & contention)
				  tmpdata[n] = 1'bx;
				if ((other_status[n+rca+1] === 1'b0) & contention)
				  tmpdata[n+rca+1] = 1'bx;
				status[n] = 1'b1;
				status[n+rca+1] = 1'b1;
				q[n] = 1'bx;
                             end
                           else if ((n == BITS-1) & (^(rca) === 1'bx))
			     begin
				if ((other_status[n] === 1'b0) & contention)
				  tmpdata[n] = 1'bx;
				for (m=0; m<RED_COLUMNS; m=m+1)
				begin
				   if ((other_status[n+m+1] === 1'b0) & contention)
				     tmpdata[n+m+1] = 1'bx;
				   status[n+m+1] = 1'b1;
				end
				status[n] = 1'b1;
				q[n] = 1'bx;
			     end 
			   else
			     begin
				if ((other_status[n] === 1'b0) & contention)
				  tmpdata[n] = 1'bx;
				if ((other_status[n+1] === 1'b0) & contention)
				  tmpdata[n+1] = 1'bx;
				q[n] = 1'bx;
				status[n] = 1'b1;
				status[n+1] = 1'b1;
			     end
			end
		   end
		   if (rren === 1'b1)
		     mem[a] = tmpdata;
		   else if (rren === 1'b0)
		     rows[{1'b0,radd,a[COL_ADDR_WIDTH-1:0]}] = tmpdata;
		   last_status[{port,a[COL_ADDR_WIDTH-1:0]}] = status;
		   if (msb == BITS-1)
		     begin
			if (rren === 1'b1)
                          begin
			     for (m=0; m<RED_COLUMNS; m=m+1)
			     begin
				replace_bit_in_mem(a,BITS+m,tmpdata[BITS+m]);
                             end
                          end
			else if (rren === 1'b0)
                          begin
			     for (m=0; m<RED_COLUMNS; m=m+1)
			     begin
				replace_bit_in_rows(a,BITS+m,tmpdata[BITS+m],radd,1'b0);
                             end
                          end
			update_status(status,port);
		     end
		end
	   end
      end	      
   endtask

   task write_mem;
      inout [BITS-1:0] other_q;
      input [ADDR_WIDTH-1:0] a;
      input [BITS-1:0] d;
      input rren;
      input radd;
      input [BITS-1:0] cren;
      input [RCA_WIDTH-1:0] rca;
      input msb;
      input lsb;
      input xout;
      input contention;
      input [BITS-1:0] other_cren;
      input port;
      integer msb;
      integer lsb;
      integer m;
      integer n;
      reg [BITS+RED_COLUMNS-1:0] tmpdata;
      reg [BITS+RED_COLUMNS-1:0] other_status;
      reg [BITS+RED_COLUMNS-1:0] status;
      reg [ADDR_WIDTH-1:0] tmpaddr;
      begin
	 if (rren === 1'bx)
	   begin
	      x_mem;
	      x_rows;
	   end
	 else
	   begin
	      if (!valid_address(a,rren,radd))
		begin
		   if (rren === 1'b1)
		     begin
			x_mem;
		     end
		   else if (rren === 1'b0)
		     begin
                        casez({radd,1'b0})
                           2'bxx: x_rows;
                           2'bx?: begin
                                    x_row(0,1'b0);
                                    x_row(1,1'b0);
                                  end
                           2'b?x: begin
                                    x_row(radd,0);
                                    x_row(radd,1);
                                  end
                           default:
			          x_row(radd,1'b0);
                        endcase
		     end
		end
	      else
		begin
		   if (rren === 1'b1)
		     tmpdata = mem[a];
		   else if (rren === 1'b0)
		     tmpdata = rows[{1'b0,radd,a[COL_ADDR_WIDTH-1:0]}];
		   status = last_status[{port,a[COL_ADDR_WIDTH-1:0]}];
		   other_status = last_status[{!port,a[COL_ADDR_WIDTH-1:0]}];
		   for (n=lsb; n<=msb; n=n+1)
		   begin
		      if (cren[n] === 1'b1)
			begin
			   if ((other_status[n] === 1'b0) & contention)
			     tmpdata[n] = 1'bx;
			   else if ((other_status[n] === 1'b1) & contention)
			     begin
				tmpdata[n] = 1'bx;
				if (other_cren[n] === 1'b1)
				  other_q[n] = 1'bx;
				else if (other_cren[n-1] === 1'b0)
				  other_q[n-1] = 1'bx;
			     end
			   else
			     begin
				tmpdata[n] = xout ? 1'bx : d[n];
				status[n] = 1'b0;
			     end
			   if ((n < BITS-1) & (cren[n+1] === 1'b0))
                             begin
				if ((other_status[n+1] === 1'b0) & contention)
				  tmpdata[n+1] = 1'bx;
				else if ((other_status[n+1] === 1'b1) & contention)
				  begin
				     tmpdata[n+1] = 1'bx;
				     if (other_cren[n] === 1'b0)
				       other_q[n] = 1'bx;
				     else if (other_cren[n+1] === 1'b1)
				       other_q[n+1] = 1'bx;
				  end
				else
				  begin
                                     tmpdata[n+1] = xout ? 1'bx : d[n];
				     status[n+1] = 1'b0;
				  end
                             end
			   else if ((n < BITS-1) & (cren[n+1] === 1'bx))
                             begin
                                tmpdata[n+1] = 1'bx;
				status[n+1] = 1'b0;
				if ((other_status[n+1] === 1'b1) & contention)
				  if (other_cren[n] === 1'b0)
				    other_q[n] = 1'bx;
				  else if (other_cren[n+1] === 1'b1)
				    other_q[n+1] = 1'bx;
                             end
			end
		      else if (cren[n] === 1'b0)
			begin
                           if ((n == BITS-1) & (^(rca) !== 1'bx))
                             begin
				if ((other_status[n+rca+1] === 1'b0) & contention)
				  tmpdata[n+rca+1] = 1'bx;
				else if ((other_status[n+rca+1] === 1'b1) & contention)
				  begin
				     tmpdata[n+rca+1] = 1'bx;
				     if (other_cren[n] === 1'b0)
				       other_q[n] = 1'bx;
				  end
				else
				  begin
                                     tmpdata[n+rca+1] = xout ? 1'bx : d[n];
				     status[n+rca+1] = 1'b0;
				  end
                             end
                           else if ((n == BITS-1) & (^(rca) === 1'bx))
                             begin
				for (m=0; m<RED_COLUMNS; m=m+1)
				begin
                                   tmpdata[n+m+1] = 1'bx;
				   status[n+m+1] = 1'b0;
				   if ((other_status[n+m+1] === 1'b1) & contention)
				     if (other_cren[n] === 1'b0)
				       other_q[n] = 1'bx;
				end
                             end
                           else
                             begin
				if ((other_status[n+1] === 1'b0) & contention)
				  tmpdata[n+1] = 1'bx;
				else if ((other_status[n+1] === 1'b1) & contention)
				  begin
				     tmpdata[n+1] = 1'bx;
				     if (other_cren[n] === 1'b0)
				       other_q[n] = 1'bx;
				     else if (other_cren[n+1] === 1'b1)
				       other_q[n+1] = 1'bx;
				  end
				else
				  begin
                                     tmpdata[n+1] = xout ? 1'bx : d[n];
				     status[n+1] = 1'b0;
				  end
                             end
			   if (n === 0)
                             begin
				if ((other_status[0] === 1'b0) & contention)
				  tmpdata[0] = 1'bx;
				else if ((other_status[0] === 1'b1) & contention)
				  begin
				     tmpdata[0] = 1'bx;
				     if (other_cren[0] === 1'b1)
				       other_q[0] = 1'bx;
				  end
				else
				  begin
                                     tmpdata[0] = xout ? 1'bx : 1'b0;
				     status[0] = 1'b0;
				  end
			     end
		        end
		      else
			begin
                           if ((n == BITS-1) & (^(rca) !== 1'bx))
                             begin
                                tmpdata[n] = 1'bx;
                                tmpdata[n+rca+1] = 1'bx;
				status[n] = 1'b0;
				status[n+rca+1] = 1'b0;
				if ((other_status[n] === 1'b1) & contention)
				  if (other_cren[n] === 1'b1)
				    other_q[n] = 1'bx;
				  else if (other_cren[n-1] === 1'b0)
				    other_q[n-1] = 1'bx;
				if ((other_status[n+rca+1] === 1'b1) & contention)
				  other_q[n] = 1'bx;
                             end
                           else if ((n == BITS-1) & (^(rca) === 1'bx))
                             begin
                                tmpdata[n] = 1'bx;
				status[n] = 1'b0;
				for (m=0; m<RED_COLUMNS; m=m+1)
				begin
                                   tmpdata[n+m+1] = 1'bx;
				   status[n+m+1] = 1'b0;
                                   if ((other_status[n+m+1] === 1'b1) & contention)
				     other_q[n] = 1'bx;
				end
				if ((other_status[n] === 1'b1) & contention)
				  if (other_cren[n] === 1'b1)
				    other_q[n] = 1'bx;
				  else if (other_cren[n-1] === 1'b0)
				    other_q[n-1] = 1'bx;
                             end
                           else
                             begin
                                tmpdata[n] = 1'bx;
                                tmpdata[n+1] = 1'bx;
				status[n] = 1'b0;
				status[n+1] = 1'b0;
				if ((other_status[n] === 1'b1) & contention)
				  if (other_cren[n] === 1'b1)
				    other_q[n] = 1'bx;
				  else if (other_cren[n-1] === 1'b0)
				    other_q[n-1] = 1'bx;
				if ((other_status[n+1] === 1'b1) & contention)
				  if (other_cren[n+1] === 1'b1)
				    other_q[n+1] = 1'bx;
				  else if (other_cren[n] === 1'b0)
				    other_q[n] = 1'bx;
                             end
			end
		   end
		   if (rren === 1'b1)
		     mem[a]=tmpdata;
		   else if (rren === 1'b0)
		     rows[{1'b0,radd,a[COL_ADDR_WIDTH-1:0]}] = tmpdata;
		   last_status[{port,a[COL_ADDR_WIDTH-1:0]}] = status;
		   // copy the redundent columns to all all combinations of ymux addresses
		   if (msb == BITS-1)
		     begin
			if (rren === 1'b1)
                          begin
			     for (m=0; m<RED_COLUMNS; m=m+1)
			     begin
				replace_bit_in_mem(a,BITS+m,tmpdata[BITS+m]);
                             end
                          end
			else if (rren === 1'b0)
                          begin
			     for (m=0; m<RED_COLUMNS; m=m+1)
			     begin
				replace_bit_in_rows(a,BITS+m,tmpdata[BITS+m],radd,1'b0);
                             end
                          end
			update_status(status,port);
		     end		     
		end
	   end
      end
   endtask

   task write_thru;
      inout [BITS-1:0] q;
      input [ADDR_WIDTH-1:0] a;
      input [BITS-1:0] d;
      input rren;
      input radd;
      input [BITS-1:0] cren;
      input [RCA_WIDTH-1:0] rca;
      input msb;
      input lsb;
      input xout;
      integer msb;
      integer lsb;
      integer n;
      begin
         if (^cren !== 1'bx)
	   for (n=lsb;n<=msb;n=n+1) q[n] = xout ? 1'bx : d[n] ;
         else
	   for (n=lsb;n<=msb;n=n+1) q[n] = 1'bx ;
      end
   endtask

   task update_last_notifiers;
   begin
      LAST_NOT_CEN = NOT_CEN;
      LAST_NOT_A = NOT_A;
      LAST_NOT_CLK_PER = NOT_CLK_PER;
      LAST_NOT_CLK_MINH = NOT_CLK_MINH;
      LAST_NOT_CLK_MINL = NOT_CLK_MINL;
   end
   endtask

   task latch_inputs;
   begin
      LATCHED_CEN = _CEN;
      LATCHED_A = _A;
   end
   endtask

   task x_inputs;
      integer n;
   begin
	 LATCHED_CEN = (NOT_CEN!==LAST_NOT_CEN) ? 1'bx : LATCHED_CEN ;
	 for (n=0; n<ADDR_WIDTH; n=n+1)
	 begin
	    LATCHED_A[n] = (NOT_A[n]!==LAST_NOT_A[n]) ? 1'bx : LATCHED_A[n] ;
	 end
   end
   endtask

   task update_status;
      input [BITS+RED_COLUMNS-1:0] val;
      input port;
      reg [BITS+RED_COLUMNS-1:0] tmpdata;
      reg [COL_ADDR_WIDTH-1:0] tmpaddr;
      integer n;
      begin
	 for (n=0; n<=MUX-1; n=n+1)
	 begin
	    tmpaddr = n;
	    tmpdata = last_status[{port,tmpaddr}];
	    tmpdata[BITS+RED_COLUMNS-1:BITS] = val[BITS+RED_COLUMNS-1:BITS];
	    last_status[{port,tmpaddr}] = tmpdata;
	 end
      end
   endtask // update_status

   task clear_status;
      input port;
      reg [COL_ADDR_WIDTH:0] tmpaddr;
      integer n;
      begin
	 for (n=0; n<=MUX-1; n=n+1)
	 begin
	    tmpaddr = n;
	    tmpaddr[COL_ADDR_WIDTH] = port;
	    last_status[tmpaddr] = {WORDX,{RED_COLUMNS{1'bx}}};
	 end
      end
   endtask // clear_status

   task replace_bit_in_mem;
      input [ADDR_WIDTH-1:0] a;
      input pos;
      input data;
      integer pos;
      reg [BITS+RED_COLUMNS-1:0] tmpdata;
      reg [ADDR_WIDTH-1:0] tmpaddr;
      integer n;
      begin
	 tmpdata = mem[a];
	 tmpdata[pos] = data;
	 mem[a] = tmpdata;
	 // copy the redundent columns to all all combinations of ymux addresses
	 if (pos >= BITS)
	   begin
	      for (n=0; n<MUX; n=n+1)
	      begin
		 tmpaddr = n;
		 tmpaddr[ADDR_WIDTH-1:COL_ADDR_WIDTH] = a[ADDR_WIDTH-1:COL_ADDR_WIDTH];
		 tmpdata = mem[tmpaddr];
		 tmpdata[pos] = data;
		 mem[tmpaddr] = tmpdata;
	      end
	   end
      end
   endtask // replace_bit_in_mem


   task replace_bit_in_rows;
      input [ADDR_WIDTH-1:0] a;
      input pos;
      input data;
      input radd;
      input bank_address;
      integer pos;
      reg [BITS+RED_COLUMNS-1:0] tmpdata;
      reg [COL_ADDR_WIDTH-1:0] tmpaddr;
      integer n;
      begin
	 tmpdata = rows[{bank_address,radd,a[COL_ADDR_WIDTH-1:0]}];
	 tmpdata[pos] = data;
	 rows[{bank_address,radd,a[COL_ADDR_WIDTH-1:0]}] = tmpdata;
	 // copy the redundent columns to all all combinations of ymux addresses
	 if (pos >= BITS)
	   begin
	      for (n=0; n<MUX; n=n+1)
	      begin
		 tmpaddr = n;
		 tmpdata = rows[{bank_address,radd,tmpaddr}];
		 tmpdata[pos] = data;
		 rows[{bank_address,radd,tmpaddr}] = tmpdata;
	      end
	   end
      end
   endtask // replace_bit_in_rows

   task x_mem;
      integer n;
   begin
      for (n=0; n<WORD_DEPTH; n=n+1)
	 mem[n]={WORDX,{RED_COLUMNS{1'bx}}}; // add 2 bits for column redundancy
   end
   endtask

   task x_rows;
      integer n;
   begin
      for (n=0; n<MUX*4; n=n+1)
	 rows[n]={WORDX,{RED_COLUMNS{1'bx}}}; // add 2 bits for column redundancy
   end
   endtask

   task x_row;
      input radd;
      input bank_address;
      integer n;
      reg [COL_ADDR_WIDTH+1:0] tmpaddr;
      begin
	 for (n=0; n<MUX; n=n+1)
	 begin
	    tmpaddr = n;
	    tmpaddr[COL_ADDR_WIDTH] = radd;
            tmpaddr[COL_ADDR_WIDTH+1] = bank_address;
	    rows[tmpaddr]={WORDX,{RED_COLUMNS{1'bx}}}; // add 2 bit for column redundancy
	 end
      end
   endtask // x_rows

   task process_violations;
   begin
      if ((NOT_CLK_PER!==LAST_NOT_CLK_PER) ||
	  (NOT_CLK_MINH!==LAST_NOT_CLK_MINH) ||
	  (NOT_CLK_MINL!==LAST_NOT_CLK_MINL))
	 begin
            if (LATCHED_CEN !== 1'b1)
               begin
                  Qi = WORDX ;
	       end
	 end
      else
	 begin
	    update_notifier_buses;
	    x_inputs;
            mem_cycle(Qi,
                      dummy_qb,
                      LATCHED_CEN,
	      	      MASK1,
                      LATCHED_A,
                      WORD1,
		      UPM0,
		      1'b1,
                      1'b1,
                      1'b1,
                      1'b1,
                      MASK1,
                      ADDR1,
                      WORD1,
                      1'b1,
                      1'b1,
                      WORD1,
                      1'b1,
                      1'b0,
                      WORD1,
                      0
                      );

	 end
      update_last_notifiers;
   end
   endtask

   function valid_address;
      input [ADDR_WIDTH-1:0] a;
      input rren;
      input radd;
   begin
      if (rren === 1'b1)
	valid_address = (^(a) !== 1'bx);
      else if (rren === 1'b0)
	valid_address = (^{radd,a[COL_ADDR_WIDTH-1:0]} !== 1'bx);
      else
	valid_address = 0;
   end
   endfunction

   function valid_cren;
      input [BITS-1:0] cren;
      reg [BITS-1:0] data;
      begin
         data = cren;
         while (data[0] == 1'b1)
           data = data >> 1;
	 if (~|data === 1'b1)
	   valid_cren = 1;
	 else
	   valid_cren = 0;
      end
   endfunction // valid_cren

   function is_contention;
      input [ADDR_WIDTH-1:0] aa;
      input [ADDR_WIDTH-1:0] ab;
      input [ADDR_WIDTH-1:0] taa;
      input [ADDR_WIDTH-1:0] tab;
      input rrena;
      input rrenb;
      input tena;
      input tenb;
      input rraa;
      input rrab;
      input [BITS-1:0] crena;
      input [BITS-1:0] crenb;
      input [RCA_WIDTH-1:0] rcaa;
      input [RCA_WIDTH-1:0] rcab;
      input [WEN_WIDTH-1:0] wena;
      input [WEN_WIDTH-1:0] wenb;
      input [WEN_WIDTH-1:0] twena;
      input [WEN_WIDTH-1:0] twenb;
      input cena;
      input cenb;
      input tcena;
      input tcenb;
      input artna;
      input artnb;
      reg [ADDR_WIDTH-1:0] adda;
      reg [ADDR_WIDTH-1:0] addb;
      reg [COL_ADDR_WIDTH-1:0] col_adda;
      reg [COL_ADDR_WIDTH-1:0] col_addb;
      reg [ADDR_WIDTH-1:COL_ADDR_WIDTH] row_adda;
      reg [ADDR_WIDTH-1:COL_ADDR_WIDTH] row_addb;
      reg add_colision;
      reg col_add_colision;
      reg row_add_colision;
      reg rra_colision;
      reg rca_colision;
      reg both_ports_reading;
      reg [WEN_WIDTH-1:0] wenai;
      reg [WEN_WIDTH-1:0] wenbi;
			    
      begin
	 wenai = (tena ? wena : twena);
	 wenbi = (tenb ? wenb : twenb);
	 if ( (artna !== 1'b1) & (wenai !== MASK1) & (wenai !== MASK0))
	   wenai = MASKX;
	 if ( (artnb !== 1'b1) & (wenbi !== MASK1) & (wenbi !== MASK0))
	   wenbi = MASKX;
	 if (!valid_cren(crena))
	   crena = WORDX;
	 if (!valid_cren(crenb))
	   crenb = WORDX;

	 col_adda = (tena ? aa[COL_ADDR_WIDTH-1:0] : taa[COL_ADDR_WIDTH-1:0]);
	 col_addb = (tenb ? ab[COL_ADDR_WIDTH-1:0] : tab[COL_ADDR_WIDTH-1:0]);
	 col_add_colision = (col_adda == col_addb) | (^col_adda === 1'bx) | (^col_addb === 1'bx);
	 rra_colision = (rraa == rrab) | ((rraa == rrab) === 1'bx);
	 adda = (tena ? aa : taa);
	 addb = (tenb ? ab : tab);
	 add_colision = (adda == addb) | (^adda === 1'bx) | (^addb === 1'bx);
	 
	 row_adda = (tena ? aa[ADDR_WIDTH-1:COL_ADDR_WIDTH] : taa[ADDR_WIDTH-1:COL_ADDR_WIDTH]);
	 row_addb = (tenb ? ab[ADDR_WIDTH-1:COL_ADDR_WIDTH] : tab[ADDR_WIDTH-1:COL_ADDR_WIDTH]);
	 row_add_colision = (row_adda == row_addb) | (^row_adda === 1'bx) | (^row_addb === 1'bx);
	 rca_colision = (rcaa == rcab) | (^rcaa === 1'bx) | (^rcab === 1'bx);
	 both_ports_reading = (wenai === MASK1) & 
			      (wenbi === MASK1);

	 is_contention =
			// if either rrena or rrenb are unkown the whole memory is corrupted.
			(((rrena === 1'bx) |
			  (rrenb === 1'bx) |
			  // in redundant row array
			  ((rrena !== 1'b1) & (rrenb !== 1'b1) & ((rraa === 1'bx) | (rrab === 1'bx))) |
			  ((rrena !== 1'b1) & (rrenb !== 1'b1) & col_add_colision & rra_colision) |
			  // in normal array
			  ((rrena !== 1'b0) & (rrenb !== 1'b0) & add_colision) |
			  // redundant column in normal array
			  ((rrena !== 1'b0) & (rrenb !== 1'b0) & row_add_colision &
			   (crena[BITS-1] !== 1'b1) & (crenb[BITS-1] !== 1'b1) & rca_colision) |
			  // redundant column in rednundant row
			  ((rrena !== 1'b1) & (rrenb !== 1'b1) & rra_colision &
			   (crena[BITS-1] !== 1'b1) & (crenb[BITS-1] !== 1'b1) & 
			   ((wenai[WEN_WIDTH-1] !== 1'b1) | (wenbi[WEN_WIDTH-1] !== 1'b1)) & 
			   rca_colision)) &
			 !both_ports_reading &
			 ((tena ? cena : tcena) !== 1'b1) &
			 ((tenb ? cenb : tcenb) !== 1'b1)) ;
      end
   endfunction

   buf (Q[63], _Q[63]);
   buf (Q[62], _Q[62]);
   buf (Q[61], _Q[61]);
   buf (Q[60], _Q[60]);
   buf (Q[59], _Q[59]);
   buf (Q[58], _Q[58]);
   buf (Q[57], _Q[57]);
   buf (Q[56], _Q[56]);
   buf (Q[55], _Q[55]);
   buf (Q[54], _Q[54]);
   buf (Q[53], _Q[53]);
   buf (Q[52], _Q[52]);
   buf (Q[51], _Q[51]);
   buf (Q[50], _Q[50]);
   buf (Q[49], _Q[49]);
   buf (Q[48], _Q[48]);
   buf (Q[47], _Q[47]);
   buf (Q[46], _Q[46]);
   buf (Q[45], _Q[45]);
   buf (Q[44], _Q[44]);
   buf (Q[43], _Q[43]);
   buf (Q[42], _Q[42]);
   buf (Q[41], _Q[41]);
   buf (Q[40], _Q[40]);
   buf (Q[39], _Q[39]);
   buf (Q[38], _Q[38]);
   buf (Q[37], _Q[37]);
   buf (Q[36], _Q[36]);
   buf (Q[35], _Q[35]);
   buf (Q[34], _Q[34]);
   buf (Q[33], _Q[33]);
   buf (Q[32], _Q[32]);
   buf (Q[31], _Q[31]);
   buf (Q[30], _Q[30]);
   buf (Q[29], _Q[29]);
   buf (Q[28], _Q[28]);
   buf (Q[27], _Q[27]);
   buf (Q[26], _Q[26]);
   buf (Q[25], _Q[25]);
   buf (Q[24], _Q[24]);
   buf (Q[23], _Q[23]);
   buf (Q[22], _Q[22]);
   buf (Q[21], _Q[21]);
   buf (Q[20], _Q[20]);
   buf (Q[19], _Q[19]);
   buf (Q[18], _Q[18]);
   buf (Q[17], _Q[17]);
   buf (Q[16], _Q[16]);
   buf (Q[15], _Q[15]);
   buf (Q[14], _Q[14]);
   buf (Q[13], _Q[13]);
   buf (Q[12], _Q[12]);
   buf (Q[11], _Q[11]);
   buf (Q[10], _Q[10]);
   buf (Q[9], _Q[9]);
   buf (Q[8], _Q[8]);
   buf (Q[7], _Q[7]);
   buf (Q[6], _Q[6]);
   buf (Q[5], _Q[5]);
   buf (Q[4], _Q[4]);
   buf (Q[3], _Q[3]);
   buf (Q[2], _Q[2]);
   buf (Q[1], _Q[1]);
   buf (Q[0], _Q[0]);
   buf (_CLK, CLK);
   buf (_CEN, CEN);
   buf (_A[7], A[7]);
   buf (_A[6], A[6]);
   buf (_A[5], A[5]);
   buf (_A[4], A[4]);
   buf (_A[3], A[3]);
   buf (_A[2], A[2]);
   buf (_A[1], A[1]);
   buf (_A[0], A[0]);

   assign _Q = Qi ;
   assign CEN_flag = 1'b1;          // use this for cen
   assign flag = !_CEN;             // use this for normal mission-mode inputs


   always @(
	    NOT_CLK_PER or
	    NOT_CLK_MINH or
	    NOT_CLK_MINL
	    )
      begin
         process_violations;
      end

   always @( _CLK )
      begin
         casez({LAST_CLK,_CLK})
	   2'b01: begin
	      latch_inputs;
              clear_status(0);
              mem_cycle(Qi,
                        dummy_qb,
                        LATCHED_CEN,
	      	        MASK1,
                        LATCHED_A,
                        WORD1,
		        UPM0,
		        1'b1,
                        1'b1,
                        1'b1,
                        1'b1,
                        MASK1,
                        ADDR1,
                        WORD1,
                        1'b1,
                        1'b1,
                        WORD1,
                        1'b1,
                        1'b0,
                        WORD1,
                        0
                       );
	   end

	   2'b10,
	   2'bx?,
	   2'b00,
	   2'b11: ;

	   2'b?x: begin
              Qi = WORDX ;
	   end
	   
	 endcase
	 LAST_CLK = _CLK;
      end


   specify
      $setuphold(posedge CLK &&& CEN_flag, posedge CEN, 1.000, 0.500, NOT_CEN);
      $setuphold(posedge CLK &&& CEN_flag, negedge CEN, 1.000, 0.500, NOT_CEN);
      $setuphold(posedge CLK &&& flag, posedge A[7], 1.000, 0.500, NOT_A7);
      $setuphold(posedge CLK &&& flag, negedge A[7], 1.000, 0.500, NOT_A7);
      $setuphold(posedge CLK &&& flag, posedge A[6], 1.000, 0.500, NOT_A6);
      $setuphold(posedge CLK &&& flag, negedge A[6], 1.000, 0.500, NOT_A6);
      $setuphold(posedge CLK &&& flag, posedge A[5], 1.000, 0.500, NOT_A5);
      $setuphold(posedge CLK &&& flag, negedge A[5], 1.000, 0.500, NOT_A5);
      $setuphold(posedge CLK &&& flag, posedge A[4], 1.000, 0.500, NOT_A4);
      $setuphold(posedge CLK &&& flag, negedge A[4], 1.000, 0.500, NOT_A4);
      $setuphold(posedge CLK &&& flag, posedge A[3], 1.000, 0.500, NOT_A3);
      $setuphold(posedge CLK &&& flag, negedge A[3], 1.000, 0.500, NOT_A3);
      $setuphold(posedge CLK &&& flag, posedge A[2], 1.000, 0.500, NOT_A2);
      $setuphold(posedge CLK &&& flag, negedge A[2], 1.000, 0.500, NOT_A2);
      $setuphold(posedge CLK &&& flag, posedge A[1], 1.000, 0.500, NOT_A1);
      $setuphold(posedge CLK &&& flag, negedge A[1], 1.000, 0.500, NOT_A1);
      $setuphold(posedge CLK &&& flag, posedge A[0], 1.000, 0.500, NOT_A0);
      $setuphold(posedge CLK &&& flag, negedge A[0], 1.000, 0.500, NOT_A0);


      $width(posedge CLK, 1.000, 0, NOT_CLK_MINH);
      $width(negedge CLK, 1.000, 0, NOT_CLK_MINL);
      $period(posedge CLK, 3.000, NOT_CLK_PER);

      (CLK => Q[63])=(1.000, 1.000);
      (CLK => Q[62])=(1.000, 1.000);
      (CLK => Q[61])=(1.000, 1.000);
      (CLK => Q[60])=(1.000, 1.000);
      (CLK => Q[59])=(1.000, 1.000);
      (CLK => Q[58])=(1.000, 1.000);
      (CLK => Q[57])=(1.000, 1.000);
      (CLK => Q[56])=(1.000, 1.000);
      (CLK => Q[55])=(1.000, 1.000);
      (CLK => Q[54])=(1.000, 1.000);
      (CLK => Q[53])=(1.000, 1.000);
      (CLK => Q[52])=(1.000, 1.000);
      (CLK => Q[51])=(1.000, 1.000);
      (CLK => Q[50])=(1.000, 1.000);
      (CLK => Q[49])=(1.000, 1.000);
      (CLK => Q[48])=(1.000, 1.000);
      (CLK => Q[47])=(1.000, 1.000);
      (CLK => Q[46])=(1.000, 1.000);
      (CLK => Q[45])=(1.000, 1.000);
      (CLK => Q[44])=(1.000, 1.000);
      (CLK => Q[43])=(1.000, 1.000);
      (CLK => Q[42])=(1.000, 1.000);
      (CLK => Q[41])=(1.000, 1.000);
      (CLK => Q[40])=(1.000, 1.000);
      (CLK => Q[39])=(1.000, 1.000);
      (CLK => Q[38])=(1.000, 1.000);
      (CLK => Q[37])=(1.000, 1.000);
      (CLK => Q[36])=(1.000, 1.000);
      (CLK => Q[35])=(1.000, 1.000);
      (CLK => Q[34])=(1.000, 1.000);
      (CLK => Q[33])=(1.000, 1.000);
      (CLK => Q[32])=(1.000, 1.000);
      (CLK => Q[31])=(1.000, 1.000);
      (CLK => Q[30])=(1.000, 1.000);
      (CLK => Q[29])=(1.000, 1.000);
      (CLK => Q[28])=(1.000, 1.000);
      (CLK => Q[27])=(1.000, 1.000);
      (CLK => Q[26])=(1.000, 1.000);
      (CLK => Q[25])=(1.000, 1.000);
      (CLK => Q[24])=(1.000, 1.000);
      (CLK => Q[23])=(1.000, 1.000);
      (CLK => Q[22])=(1.000, 1.000);
      (CLK => Q[21])=(1.000, 1.000);
      (CLK => Q[20])=(1.000, 1.000);
      (CLK => Q[19])=(1.000, 1.000);
      (CLK => Q[18])=(1.000, 1.000);
      (CLK => Q[17])=(1.000, 1.000);
      (CLK => Q[16])=(1.000, 1.000);
      (CLK => Q[15])=(1.000, 1.000);
      (CLK => Q[14])=(1.000, 1.000);
      (CLK => Q[13])=(1.000, 1.000);
      (CLK => Q[12])=(1.000, 1.000);
      (CLK => Q[11])=(1.000, 1.000);
      (CLK => Q[10])=(1.000, 1.000);
      (CLK => Q[9])=(1.000, 1.000);
      (CLK => Q[8])=(1.000, 1.000);
      (CLK => Q[7])=(1.000, 1.000);
      (CLK => Q[6])=(1.000, 1.000);
      (CLK => Q[5])=(1.000, 1.000);
      (CLK => Q[4])=(1.000, 1.000);
      (CLK => Q[3])=(1.000, 1.000);
      (CLK => Q[2])=(1.000, 1.000);
      (CLK => Q[1])=(1.000, 1.000);
      (CLK => Q[0])=(1.000, 1.000);

   endspecify

endmodule
`endcelldefine
