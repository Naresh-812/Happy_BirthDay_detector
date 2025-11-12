/*
      file name: clk_100mhz_to_10khz
	  module name:clk_100mhz_to_10khz
      specifications: clock devider from 100 mhz to 10 khz
					
	  Date of creation:05-11-2025
	  
	  
*/

module clk_100mhz_to_10khz
		(
			input 	i_system_clk,   //on fpga we have 100mhz clock
			input 	i_rst,
			output 	clk_10KHz
			
		);
		
		reg [12:0] i_clock_count;      //i need to count upto 4999 so taken 13 bit reg 
		reg slow_clock;
		
		always@(posedge i_system_clk)
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
		assign clk_10KHz=slow_clock;    //assigning slow_clock to clk_1Hz
		
		
		
endmodule