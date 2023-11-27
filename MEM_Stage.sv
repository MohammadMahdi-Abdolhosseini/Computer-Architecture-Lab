module MEM_Stage(
	input clk, rst, WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN,
	input [31:0] ALU_Res_IN, VAL_RM_IN, Dest_IN,
	
	output WB_EN, MEM_R_EN, 
	output [31:0] ALU_Res, DATA, Dest
);

	Memory memory(clk, rst, MEM_R_EN_IN, MEM_W_EN_IN, ALU_Res_IN, VAL_RM_IN, DATA);
	
	assign WB_EN = WB_EN_IN;
	assign MEM_R_EN = MEM_R_EN_IN;
	assign ALU_Res = ALU_Res_IN;
	assign Dest = Dest_IN;

endmodule
