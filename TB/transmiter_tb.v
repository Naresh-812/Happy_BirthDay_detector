/*
      file name: transmiter_tb.v
	  module name:transmiter_tb
      specifications: testbench for the transmiter  block 
					
	  Date of creation:01-11-2025
	  
*/
`timescale 1ns/1ps

module transmiter_tb();
	reg			clk;
	reg 		rst;
	reg			count_valid;
	reg[9:0]	data;
	wire		seq_bit;
	wire		tx_done;
	
	
	//DUT initilization
    transmiter DUT
		(
		.i_clk			(clk),
		.i_rst			(rst),
		.i_count_valid	(count_valid),              
		.i_data         (data), 
		.o_seq_bit      (seq_bit),
		.o_tx_done      (tx_done)
		);
	
	
	//clock generation
	initial begin
		           clk=0;
		forever #5 clk=~clk;
		
	end
	
	//
	initial begin
	   data=15;
		rst=1;
		#10;
		rst=0;
		
		
		#10;
		
		
		
		
		
		//$finish;
		
	end






endmodule