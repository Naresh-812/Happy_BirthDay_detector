/*
      file name: system_top_tb.v
	  module name:system_top_tb
      specifications: testbench for the transmiter top module  block 
					
	  Date of creation:05-11-2025
	  
*/

module seven_sig
	(
		input 	      i_clk,
		input	      i_rst,
		input 	    [3:0] ones,
		input 	     [3:0] tens,
		output reg [1:0] digit_sel,
		output reg [6:0] seven_sig
	);
	
	
	reg sel;
	reg [3:0] count;
	
	//need to switch the digits
	always@(posedge i_clk)
		begin
			if(i_rst)
				begin
					sel<=0;
					count<=0;
				end
			else
				begin
					count=count+1;
					if(count==3'd5)   //refresh at 1khz
						begin
							count=0;
							sel<=~sel;
						end
					
				end
		end
		
		
		//block to sel the digits to active 
		
	always@(sel)
		begin
			if(sel)
				begin
					digit_sel[0]=1;
					digit_sel[1]=0;
				end
			else
				begin
					digit_sel[0]=0;
					digit_sel[1]=1;
				end
		end
	
	
	
	
	
	//need to active last two digits
 
	always@(*)
	begin
		if(sel)
		 begin
			case(tens)
				4'd0: 	seven_sig = 7'b0000001;
				4'd1: 	seven_sig = 7'b1001111;
				4'd2: 	seven_sig = 7'b0010010;
				4'd3: 	seven_sig = 7'b0000110;
				4'd4: 	seven_sig = 7'b1001100;
				4'd5: 	seven_sig = 7'b0100100;
				4'd6: 	seven_sig = 7'b0100000;
				4'd7: 	seven_sig = 7'b0001111;
				4'd8: 	seven_sig = 7'b0000000;
				4'd9: 	seven_sig = 7'b0000100;
				default:seven_sig  = 7'b1111111; // blank
			endcase
		 end
		 
		 else 
			begin
				case(ones)
				4'd0: 	seven_sig = 7'b0000001;
				4'd1: 	seven_sig = 7'b1001111;
				4'd2: 	seven_sig = 7'b0010010;
				4'd3: 	seven_sig = 7'b0000110;
				4'd4: 	seven_sig = 7'b1001100;
				4'd5: 	seven_sig = 7'b0100100;
				4'd6: 	seven_sig = 7'b0100000;
				4'd7: 	seven_sig = 7'b0001111;
				4'd8: 	seven_sig = 7'b0000000;
				4'd9: 	seven_sig = 7'b0000100;
				default:seven_sig  = 7'b1111111; // blank
			endcase
			
			end
		
	end
	
	
	
	
endmodule