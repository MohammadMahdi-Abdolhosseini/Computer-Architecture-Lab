module EXE_Stage(
	input clk, rst,
	input WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN, B_IN, S_IN,
	input [3:0] EXE_CMD_IN, SR_IN,
	input [31:0] PC_IN, VAL_RN_IN, VAL_RM_IN,
	input IMM_IN,
	input [11:0] ShiftOperand_IN,
	input [23:0] Signed_IMM_24_IN,
	input [3:0] Dest_IN,

	output WB_EN, MEM_R_EN, MEM_W_EN, B, S,
	output [31:0] ALU_Res,
	output [31:0] VAL_RM,
	output [3:0] Dest, Status,
	output [31:0] Branch_Address,

	input [1:0]  sel_src1, sel_src2,
	input [31:0] ALU_Res_EXE_reg, Result_WB

);

	wire [31:0] Val2Gen_out, val1ALU;

	ALU alu(val1ALU, Val2Gen_out, EXE_CMD_IN, SR_IN, ALU_Res, Status);
	Val2Gen val2gen(VAL_RM, IMM_IN, ShiftOperand_IN, MEM_R_EN_IN | MEM_W_EN_IN, Val2Gen_out);

	assign WB_EN = WB_EN_IN;
	assign MEM_R_EN = MEM_R_EN_IN;
	assign MEM_W_EN = MEM_W_EN_IN;
	assign B = B_IN;
	assign S = S_IN;
	//assign VAL_RM = VAL_RM_IN;
	assign Dest = Dest_IN;

	assign Branch_Address = PC_IN + {{6{Signed_IMM_24_IN[23]}}, Signed_IMM_24_IN, 2'b0};

	
	MUX3to1 M1(VAL_RN_IN, ALU_Res_EXE_reg, Result_WB, sel_src1, val1ALU);
	MUX3to1 M2(VAL_RM_IN, ALU_Res_EXE_reg, Result_WB, sel_src2, VAL_RM);


endmodule
