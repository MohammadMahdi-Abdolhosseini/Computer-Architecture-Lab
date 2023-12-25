module MEM_Reg(
	input clk, rst, freeze,
	input WB_EN_MEM_IN, MEM_R_EN_MEM_IN, 
	input [31:0] ALU_Res_MEM_IN, DATA_MEM_IN, Dest_MEM_IN,
	
	output reg WB_EN_MEM, MEM_R_EN_MEM,
	output reg [31:0] ALU_Res_MEM, DATA_MEM, Dest_MEM
);
	always@(posedge clk, posedge rst)begin
		if(rst == 1'b1) begin
			{WB_EN_MEM, MEM_R_EN_MEM} <= 0;
			{ALU_Res_MEM, DATA_MEM, Dest_MEM} <= 0;
		end else begin
			if(freeze == 1'b0) begin
				{WB_EN_MEM, MEM_R_EN_MEM} <= {WB_EN_MEM_IN, MEM_R_EN_MEM_IN};
				{ALU_Res_MEM, DATA_MEM, Dest_MEM} <= {ALU_Res_MEM_IN, DATA_MEM_IN, Dest_MEM_IN};
			end
		end
	end
endmodule
