/*
      file name: system_top_tb.v
	  module name:system_top_tb
      specifications: testbench for the transmiter top module  block 
					
	  Date of creation:05-11-2025
	  
*/

module system_top_tb();

		//reg      	i_system_clk;
		reg         i_clk;
		reg      	i_rst;
		reg      	i_tx_en_n;
		wire [5:0]  o_hit_count;
		wire      	o_hit_valid;
		wire [1:0]	digit_sel;
		wire [6:0]  seven_sig;
	
	//DUT instatiation

		system_top DUT
				(
				
					//.i_system_clk	(i_system_clk),
					.i_clk           (i_clk),
					.i_rst			(i_rst),
					.i_tx_en_n		(i_tx_en_n),
					.o_hit_count    (o_hit_count),
					.o_hit_valid    (o_hit_valid),
					.digit_sel      (digit_sel),
					.seven_sig      (seven_sig)
											
				);
	//clock generation
		
		initial begin
			i_clk=0;
			forever #5 i_clk=~i_clk;
		end
	
		
	//stimulus
	initial begin
		i_rst=1;
		i_tx_en_n=1;
		#15;
		i_rst=0;
		#25;
		i_tx_en_n=0;
		
		
	
		
		
	end



endmodule