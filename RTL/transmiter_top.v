/*
      file name: transmiter_top.v
	  module name:tx_top
      specifications:
					RECEIVER
						birthday pattern (Month + Date).
						The Receiver Block monitors the incoming serial data stream and detects a fixed 9-bit
						Each successful detection increments a counter, whose value is displayed once per second.
	  Date of creation:30-10-2025
	  
*/

module tx_top
	(
		input  i_clk,
		input  i_rst,
		input  i_tx_en_n ,   //when its low tx will start working 
		output o_seq_count,
		output[9:0] o_count_for_rx
	);
	
	
	
	reg        tx_en_n_d;
	wire       tx_en_n_fall;
	wire       tx_done;
	wire [9:0] count;
	wire       count_valid;
	//wire       o_serial_data;
	//wire       o_sequence_detected;
	wire       tx_start_flag;
	
	
	//delaying one clk cycle of  i_tx_en_n
	always@(posedge i_clk)
		begin
			tx_en_n_d<=i_tx_en_n;	 	
		end
		
	assign tx_en_n_fall=(tx_en_n_d)&(~i_tx_en_n);   //falling edge detector 
	assign tx_start_flag=tx_done|tx_en_n_fall;    //To aviod paradox of tx_done and transmission 
   
		generator gen_inst(
							.i_clk			  (i_clk),
							.i_rst            (i_rst),
							.i_enable         (tx_start_flag),   //generator will active either at falling edge detected  or tx_done 
	                        .o_count_valid    (count_valid),     //it will given to trans
							.o_count          (count)
							
						  );
						  
						  

						  
		transmiter trans_inst(
							.i_clk            (i_clk), 
							.i_rst			  (i_rst),
							.i_count_valid    (count_valid),           
							.i_data           (count),
							.o_seq_bit        (o_seq_count),
							.o_tx_done        (tx_done),
							.o_count          (o_count_for_rx)
							);
		


		
endmodule