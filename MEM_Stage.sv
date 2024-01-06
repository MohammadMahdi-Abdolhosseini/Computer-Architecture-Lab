module MEM_Stage(
	input clk, rst, WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN,
	input [31:0] ALU_Res_IN, VAL_RM_IN,
	input [3:0] Dest_IN,
	
	output WB_EN, MEM_R_EN, 
	output [31:0] ALU_Res, DATA,
	output [3:0] Dest,

	output ready,

	inout [15:0] SRAM_DQ,
	output [17:0] SRAM_ADDR,
	output SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N
);

	MemoryController memoryController(clk, rst, MEM_R_EN_IN, MEM_W_EN_IN, ALU_Res_IN, VAL_RM_IN, DATA,
									  ready, SRAM_DQ, SRAM_ADDR, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N);
	
	assign WB_EN = WB_EN_IN;
	assign MEM_R_EN = MEM_R_EN_IN;
	assign ALU_Res = ALU_Res_IN;
	assign Dest = Dest_IN;

endmodule
