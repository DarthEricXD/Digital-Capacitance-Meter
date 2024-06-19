`timescale 1ns / 1ps

module tb_count;

	// Inputs
	reg clk;
	reg clear_n;
	reg en;

	// Outputs
	wire [3:0] dout;
	wire co;

	// Instantiate the Unit Under Test (UUT)
	count uut (
		.clk(clk), 
		.clear_n(clear_n), 
		.en(en), 
		.dout(dout), 
		.co(co)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clear_n = 0;
		en = 0;

		// Wait 100 ns for global reset to finish
		#100 clear_n = 1;
		     forever #1000 en = ~en;
        
		// Add stimulus here

	end
      
   always #20 clk = ~clk;
endmodule

