module IF_Reg(
	input clk, rst, freeze, flush,
	input [31:0] PC_in, Intsruction_in,
	output reg [31:0] PC, Instruction
);
	always@(posedge clk, posedge rst)begin
		if(rst == 1'b1)begin
			PC <= 0;
			Instruction <= 0;
		end
		else begin
			if(freeze == 1'b0)begin
				PC <= PC_in;
				Instruction <= Intsruction_in;
			end
		end
	end
endmodule
