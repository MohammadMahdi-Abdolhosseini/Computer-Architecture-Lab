module CondCheck(
	input [3:0] Cond,
	input [3:0] Status,
	
	output reg condition
);
	reg N, Z, C, V;
	always@(Cond, Status)begin
	case(Cond)
		4'd0 : condition = Z;
		4'd1 : condition = ~Z;
		4'd2 : condition = C;
		4'd3 : condition = ~C;
		4'd4 : condition = N;
		4'd5 : condition = ~N;
		4'd6 : condition = V;
		4'd7 : condition = ~V;
		4'd8 : condition = C & (~Z);
		4'd9 : condition = (~C) | Z;
		4'd10: condition = (N == V);
		4'd11: condition = (N != V);
		4'd12: condition = (Z == 1'b0) & (N == V);
		4'd13: condition = (Z == 1'b1) | (N != V);
		4'd14: condition = 1'b1;
		4'd15: condition = 1'b1;
	endcase
	end
	assign {N, Z, C, V} = Status;
endmodule
