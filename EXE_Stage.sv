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
	output [3:0] Dest, Status

);

	//wire [31:0] Val2Gen;

	ALU alu(VAL_RN_IN, Val2Gen, EXE_CMD_IN, SR_IN, ALU_Res, Status);
	VAL2GEN val2gen(VAL_RM_IN, IMM_IN, ShiftOperand_IN, MEM_R_EN_IN | MEM_W_EN_IN, Val2Gen);


	assign WB_EN = WB_EN_IN;
	assign MEM_R_EN = MEM_R_EN_IN;
	assign MEM_W_EN = MEM_W_EN_IN;
	assign VAL_RM = VAL_RM_IN;
	assign Dest = Dest_IN;


endmodule
