/*
      file name: generator.v
	  module name:generator
      specifications:
					Generator: A 10-bit counter acts as the data source, producing values from 0 to 1023.
					The counter increments once per completed transmission, ensuring that a new
                    10-bit word is generated only after the previous one has been sent
	  Date of creation:01-11-2025
	  
*/

module generator
				(    //inputs outputs 
					input 		     i_clk,
					input 		     i_rst,
					input 			 i_enable,
					output            o_count_valid,
					output reg [9:0] o_count
				);
				
	always@(posedge i_clk)
		begin
			if(i_rst)
				o_count<=10'b0;   //reset condition
			else if (i_enable)
				o_count<=o_count+10'b1;   //incrementing one  when enable is high
		end
		assign o_count_valid=i_enable;   //directly conecting enable to valid 
endmodule