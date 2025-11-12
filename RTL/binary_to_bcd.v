	/*
      file name: binary_to_bcd.v
	  module name:binary_to_bcd
      specifications: This is binary_to_bcd converter
	  
					
	  Date of creation:05-11-2025
	  
*/

module bin_to_bcd
	(
    input   		  i_clk,   
	// input   		  i_reset,       
    input   		  i_valid,       
    input       [5:0] i_b_in,  
    output reg  [3:0] ones_valid=4'b0, 
    output reg  [3:0] tens_valid=4'b0
	);

  
    //block to convert binary into BCD
	
    reg [3:0] ones=4'b0;
	reg [3:0] tens=4'b0;
	//reg [3:0] ones_valid=4'b0;
	//reg [3:0] tens_valid=4'b0;
	
	
	

    always @(i_valid )
		begin
		//block to convert binary to bcd
		 if (i_valid)
			begin
				ones=i_b_in%10;
				tens=i_b_in/10;
			end
		//else
			//once=once_valid;
			//tens=tens_valid;
			
    end
	
	
	// assigning values at slow clock speed 
	always @(posedge i_clk)
		begin
		//assigning valid signals 
			ones_valid<=ones;
			tens_valid<=tens;
			
    end
	
    
	
	

endmodule


