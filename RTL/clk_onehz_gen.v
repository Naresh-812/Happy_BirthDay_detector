/*
      file name: clk_onehz_gen.v
	  module name:clk_10k_to_1hz
      specifications: clock generation for one hz
					
	  Date of creation:05-11-2025
	  
*/

module clk_10k_to_1hz
		(
			input 	i_clk,
			input 	i_rst,
			output 	clk_1Hz
			
		);
		
		reg [12:0] i_clock_count;      //i need to count upto 4999 so taken 13 bit reg 
		reg slow_clock;
		
		always@(posedge i_clk)
			begin
				//reset condition
				if(i_rst)
					begin
						i_clock_count<=0;
						slow_clock   <=0;
					end
				else
					begin
						//clock toggling 
						if(i_clock_count==13'd4999)
							begin
								i_clock_count<=0;
								slow_clock<=~slow_clock;
							end
						//count increment
						else
							i_clock_count<=i_clock_count+1;
					end
			end
		assign clk_1Hz=slow_clock;    //assigning slow_clock to clk_1Hz
		
		
		
endmodule