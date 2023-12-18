`timescale 1ns/1ns
module TopLevel();
  
	reg clk = 0, rst = 1, ForwardingMode = 0;
	wire [31:0] PC, Instruction;
	ARM arm(clk, rst, ForwardingMode);



	always #10 clk = ~clk;
	initial begin
 	#20 rst = 0;
	ForwardingMode = 1;
  	end

endmodule

