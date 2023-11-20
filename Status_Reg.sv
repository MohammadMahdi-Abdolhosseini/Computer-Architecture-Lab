module Status_Reg(
    input clk, rst,
    input [3:0] SR_IN,
    input S_IN,

    output reg [3:0] SR
);

    always @(posedge clk, posedge rst) begin
		if(rst == 1'b1)
			SR <= 0;
		else if (S_IN == 1)
			SR <= SR_IN;
	end

endmodule