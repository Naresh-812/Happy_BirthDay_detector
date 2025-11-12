/*
      file name: transmitter.v
	  module name:transmiter
      specifications:
					Each 10-bit value is transmitted one bit per clock cycle, starting with the least
                    significant bit (LSB).
	  Date of creation:01-11-2025
	  
*/

module transmiter (
    input      	i_clk,
	input 		i_rst,
    input      	i_count_valid,              
    input [9:0] i_data, 
    output  	o_seq_bit,
	output  	o_tx_done,
	output[9:0] o_count
);

    reg [9:0] temp_reg;  
	reg [3:0] count;

    always @(posedge i_clk)
		begin
       
			if (i_count_valid | i_rst)
				begin
					temp_reg <= i_data;
					count<=0;
				end
        else
			begin
				temp_reg <= {1'b0,temp_reg[9:1]};  ///right shifting
				count<=count+4'b1;
			end
    end
	assign o_tx_done =(count==4'd9);     //to indicate that transmission is done 
	assign o_seq_bit = temp_reg[0];  //to get value 
	assign o_count=i_data;

endmodule
