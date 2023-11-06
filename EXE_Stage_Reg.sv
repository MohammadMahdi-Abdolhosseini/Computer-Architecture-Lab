module EXE_Reg(
	input clk, rst,
	input [31:0] PC_in,
	output reg [31:0] PC
);
	always@(posedge clk, posedge rst)begin
		if(rst == 1'b1)
			PC <= 0;
		else
			PC <= PC_in;
	end
endmodule
