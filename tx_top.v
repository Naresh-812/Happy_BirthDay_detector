//

module tx_top
	(
		input  i_clk,
		input  i_rst,
		input  i_tx_en_n ,   //when its low tx will start working 
		output o_seq_count
	);
	
	
	
	reg        tx_en_n_d;
	wire       tx_en_n_fall;
	wire       tx_done;
	wire [9:0] count;
	wire       count_valid;
	wire       o_serial_data;
	wire       o_sequence_detected
	
	
	
	always@(posedge clk)
		tx_en_n_d<=i_tx_en_n;	 	
		end
		assign tx_en_n_fall=(tx_en_n_d)&(~i_tx_en_n);   //falling edge detector 
		
		
		generator gen_inst(
							i_clk			 (i_clk),
							i_rst            (i_rst),
							i_count_valid    (count_valid),
	                        o_count          (count),
							
						  );
						  
		transmiter trans_inst(
							i_clk            (i_clk), 
							i_rst			 (i_rst),
							i_count_valid,              
							data
							o_seq_bit
							tx_done
		
		
		
		
endmodule