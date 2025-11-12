/*
      file name: system_top.v
	  module name:system_top
      specifications: This is the system top for our Happy Birthday sequence detector 
	  
					
	  Date of creation:05-11-2025
	  
*/
`timescale 10us/1ns
module system_top
		(
			//input            i_system_clk,  //for fpga
			input		     i_clk,
			input		     i_rst,
			input		     i_tx_en_n,
			output [5:0]	 o_hit_count,
			output		     o_hit_valid,
			output [1:0]	 digit_sel,
			output [6:0]     seven_sig
			
		);
		
	//wire 			i_clk;     //for fpga 
	wire 			seq_count;  //to connect tx and rx
	wire 			seq_detected;
	wire  [9:0] 	o_count_for_rx;
	wire 			clk_1hz;
	wire  [3:0] 	ones_valid; 
    wire  [3:0] 	tens_valid;
	
	//wire  [1:0]	digit_sel;
	//wire  [6:0] seven_sig;

	
	
//	clk_100mhz_to_10khz  clk10khz_inst           //this is only for FPGA
//		(
//			.i_system_clk	(i_system_clk),
//			.i_rst			(i_rst),
//			.clk_10KHz		(i_clk)
			
//		);
		
	
	
	
	
	//transmiter block 
	
	 tx_top tx_inst
		(
		
		.i_clk			(i_clk),
		.i_rst			(i_rst),
		.i_tx_en_n 		(i_tx_en_n),				   
		.o_seq_count    (seq_count),
		.o_count_for_rx  (o_count_for_rx)
		
		);
		
		//reciver block
		
	reciver rx_inst
		(
		
			.i_clk		 	 (i_clk),
			.i_rst		 	 (i_rst),
			.i_bit_seq	 	 (seq_count),
			.i_count_for_rx  (o_count_for_rx),        
			.o_seq_detected  (seq_detected) ,
			.o_seq_det_count (o_hit_count),
			.o_hit_valid     (o_hit_valid)

			
		);
		
	
	bin_to_bcd bin_bcd_inst
	(
			.i_clk   		(i_clk),         
			.i_valid		(o_hit_valid),       
			.i_b_in			(o_hit_count),  
			.ones_valid 	(ones_valid),
			.tens_valid		(tens_valid)
	);
	
	seven_sig sig_inst
	(
			.i_clk			(i_clk),	
			.i_rst			(i_rst),
			.ones			(ones_valid),
			.tens			(tens_valid),
			.digit_sel      (digit_sel),
			.seven_sig      (seven_sig)
	);

		
		
		
		
endmodule