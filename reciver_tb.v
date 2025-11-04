/*

		file name: reciver_tb.v
		module name:reciver_tb
		
		Date of Creation:03-11-2025


*/

module reciver_tb();
		reg  clk,
		reg  rst,
		reg  bit_seq,
		wire bit_detected
		
		
		//initialize the dut 
		reciver  DUT
			(
				i_clk			(clk),
				i_rst			(rst),
				i_bit_seq       (bit_seq),  				
				o_seq_detected  (bit_detected)			
			);
		
		//clock generation
		initial begin
			clk=0;
			forever #5 clk=~clk;
		end
		
		//to send the serial  data 
		task send_data(input bit b);
		 begin
			bit_in=b;
			@(posedge clk);
		 end
		endtask
			
			
		//to send stimulus
		initial begin
			$dumpfile("reciver_tb.vcd");
			$dumpvars(tb_vars);
			
			
			//reset 
			rst=1;
			bit_in=0;
			repeat(3)@(posedge clk);
			rst=0;
			
			//send random data 
			send_bit(1);
			send_bit(1);
			send_bit(1);
			send_bit(0);
			send_bit(1);
			send_bit(1);
			send_bit(0);
			send_bit(1);
			send_bit(0);
			send_bit(1);
			send_bit(1);
			send_bit(1);
			send_bit(0);
			send_bit(1);
			send_bit(0);
			send_bit(1);
			send_bit(0);
			send_bit(0);
			send_bit(1);
			send_bit(1);
			send_bit(1);
			send_bit(0);
			send_bit(1);
			send_bit(1);
			send_bit(0);
			send_bit(1);
			send_bit(0);
			
			$finish;
		end
		
			
			
			
			
			
endmodule