/*
      file name: reciver.v
	  module name:reciver
      specifications:
					RECEIVER
						The Receiver Block monitors the incoming serial data stream and detects a fixed 9-bit
						birthday pattern (Month + Date).
						Each successful detection increments a counter, whose value is displayed once per second.
	  Date of creation:30-10-2025
	  
*/
`timescale 1ns/1ps

module reciver
			(
				input   	i_clk,
				input   	i_rst,
				input   	i_bit_seq,
				input [9:0] i_count_for_rx,         //input 
				output      o_seq_detected,   //output
				output reg [5:0] o_seq_det_count,
				output       o_hit_valid
			);
			//parameters declaration
			parameter S0=4'b0000;
			parameter S1=4'b0001;
			parameter S2=4'b0010;
			parameter S3=4'b0011;
			parameter S4=4'b0100;
			parameter S5=4'b0101;
			parameter S6=4'b0110;
			parameter S7=4'b0111;
			parameter S8=4'b1000;
			
			
			//state and next state declereation 
			reg [3:0]state,next_state;
			
			//firstly write the output logic here
			always@(*)
				begin
					case(state)
					S0:begin
						next_state=(i_bit_seq)?S0:S1;
					   end
					S1:begin
						next_state=(i_bit_seq)?S2:S0;
					   end
					S2:begin
						next_state=(i_bit_seq)?S3:S1;
					   end
					S3:begin
						next_state=(i_bit_seq)?S4:S1;
					   end
					S4:begin
						next_state=(i_bit_seq)?S0:S5;
					   end
					S5:begin
						next_state=(i_bit_seq)?S6:S1;
					   end
					S6:begin
						next_state=(i_bit_seq)?S3:S7;
					   end
					S7:begin
						next_state=(i_bit_seq)?S8:S1;
					   end
					S8:begin
						next_state=(i_bit_seq)?S3:S1;
					   end
					default:begin
						next_state=S0;
							end
					endcase
				end
			
			//now load next state into state
			always@(posedge i_clk)
				begin
					if(i_rst)
						state<=S0;
					else
						state<=next_state;
				end
				
			//assigning of output 
			
			assign o_seq_detected=(state==S8)&&(i_bit_seq==0);
			
			
			//to find hit count
			 always @(posedge i_clk)
			   begin
                    if (i_rst|i_count_for_rx==10'd1001)
                          o_seq_det_count <= 6'd0;            // initialize to 0
                    else if (o_seq_detected)
                           o_seq_det_count <= o_seq_det_count + 6'd1;
                end	
                assign o_hit_valid=(i_count_for_rx==10'd1000)?1:0;
                
                
endmodule
	