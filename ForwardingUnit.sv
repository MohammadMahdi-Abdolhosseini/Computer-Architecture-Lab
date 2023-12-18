module ForwardingUnit(
	input ForwardingMode,
	input [3:0] src1, src2,
	input [3:0] Dest_MEM, Dest_WB,
	input WB_EN_MEM, WB_EN_WB,

	output [1:0]  sel_src1, sel_src2
);

	assign sel_src1 = 2'b00;
	assign sel_src2 = 2'b00;

	assign sel_src1 = (src1 == Dest_MEM && WB_EN_MEM == 1'b1) ? 2'b01 :
																((src1 == Dest_WB && WB_EN_WB == 1'b1)? 2'b10 : 2'b00);

	assign sel_src2 = (src2 == Dest_MEM && WB_EN_MEM == 1'b1) ? 2'b01 :
																((src2 == Dest_WB && WB_EN_WB == 1'b1)? 2'b10 : 2'b00);


	assign sel_src1 = (ForwardingMode == 0)? 2'b00 : sel_src1;
	assign sel_src2 = (ForwardingMode == 0)? 2'b00 : sel_src2;
		
endmodule