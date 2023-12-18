module MUX3to1(
	input [31:0] src1, src2, src3,
	input [1:0] sel,

	output [31:0] out
);

assign out = (sel == 2'b00)? src1 : ((sel == 2'b01)? src2 : (src3));

		
endmodule