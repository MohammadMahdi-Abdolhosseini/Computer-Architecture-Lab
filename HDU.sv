module HDU (
    input [3:0] SRC1, SRC2, Dest_EXE, Dest_MEM,
    input WB_EN_EXE, WB_EN_MEM,
    input Two_SRC,

    output hazard
);

assign hazard = ((SRC1 == Dest_EXE) && WB_EN_EXE) ||
		 ((SRC1 == Dest_MEM) && WB_EN_MEM) ||
		 ((SRC2 == Dest_EXE) && WB_EN_EXE && Two_SRC) ||
		 ((SRC2 == Dest_MEM) && WB_EN_MEM && Two_SRC) ? 1'b1 : 1'b0;  //Two_SRC

endmodule