module WB_Stage(
	input clk, rst,
	input WB_EN_IN, MEM_R_EN_IN,
	input [31:0] ALU_Res_IN, DATA_MEM_IN,
	input [3:0] Dest_IN,
	output reg WriteBackEn,
	output reg [31:0] Result_WB,
	output reg [3:0] Dest_WB
);
	assign WriteBackEn = WB_EN_IN;

	assign Result_WB = MEM_R_EN_IN ? DATA_MEM_IN : ALU_Res_IN;

	assign Dest_WB = Dest_IN;

endmodule
