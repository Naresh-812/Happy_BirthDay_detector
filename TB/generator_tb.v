/*
      file name: generator_tb.v
	  module name:generator
      specifications: testbench for the generator block 
					
	  Date of creation:01-11-2025
	  
*/

module generator_tb();
	reg 		clk;
	reg 		rst;
	wire 		count_valid;
	reg 		enable;
	wire[9:0] 	count;
	
	
	
	
	//DUT initilization
	
	generator DUT
				( 
			    .i_clk           (clk),
				.i_rst			 (rst),
				.i_enable        (enable),
			    .o_count_valid	 (count_valid),
				.o_count		 (count)
				);
				
	//clock generation block	
	initial begin
		clk=0;
		forever #5 clk=~clk;
	end
	
	
	initial begin
		rst=1;
		#10;  rst=0;
		      enable=1;
		#5    enable=0;
		#100; enable=1;
		#5    enable=0;
		#100; enable=1;
		#5    enable=0;
		#100; enable=1;
		#5    enable=0;
		#100; enable=1;
		#5    enable=0;
		#100; enable=1;
		#5    enable=0;
		#100; enable=1;
		#5    enable=0;
		#100; enable=1;
		
		$finish;
		
	end
	
	
	
	
				
				
				
endmodule