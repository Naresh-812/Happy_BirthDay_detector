/*
      file name: tx_top_tb.v
	  module name:tx_top_tb
      specifications: testbench for the transmiter top module  block 
					
	  Date of creation:05-11-2025
	  
*/


module tx_top_tb();

	reg 	clk;
	reg 	rst;
	reg 	tx_en_n;
	wire    seq_count;




	//DUT initilization 
	tx_top DUT
		(
			.i_clk			(clk),
			.i_rst			(rst),
			.i_tx_en_n 		(tx_en_n),
			.o_seq_count	(seq_count)
		);
	
	//clock generation 
	initial begin
		clk=0;
		forever #5 clk=~clk;
	end
	
	//stimulus
	initial begin
		rst=1;
		tx_en_n=1;
		
		#15;
		rst=0;
		#25;
		tx_en_n=0;
		
		
		#1000;
		$finish;
	end
	
	
	
	
	
endmodule