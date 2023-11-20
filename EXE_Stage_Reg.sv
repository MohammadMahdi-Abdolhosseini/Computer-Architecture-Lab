module EXE_Reg(
	input clk, rst,
	input WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN, B_IN, S_IN,
	input [31:0] ALU_Res_IN,
	input [31:0] VAL_RM_IN,
	input [3:0] Dest_IN,

	output reg WB_EN, MEM_R_EN, MEM_W_EN, B, S,
	output reg [31:0] ALU_Res,
	output reg [31:0] VAL_RM,
	output reg [3:0] Dest
);

	always@(posedge clk, posedge rst)begin
		if(rst == 1'b1) begin
			{WB_EN, MEM_R_EN, MEM_W_EN, B, S} <= 0;
			ALU_Res <= 32'd0;
			VAL_RM <= 32'd0;
			Dest <= 0;
		end else begin
			{WB_EN, MEM_R_EN, MEM_W_EN, B, S} <= {WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN, B_IN, S_IN};
			ALU_Res <= ALU_Res_IN;
			VAL_RM <= VAL_RM_IN;
			Dest <= Dest_IN;
		end
	end

endmodule
