module ALU (
    input [31:0] Val1, Val2,
    input [3:0] EXE_CMD, SR,
    output reg [31:0] Result,
    output reg[3:0] Status
);

// quartus
reg N = 0, Z = 0, C = 0, V = 0;

// modelsim
//reg C = 0;
//wire  N = 0, Z = 0, V = 0;

always @(*) begin
    case (EXE_CMD)
        4'b0001: Result <= Val2;   // MOV
        4'b1001: Result <= ~Val2;  // MVN
        // ADD
        4'b0010: begin {C, Result} <= Val1 + Val2;
                 V <= (Result[31] && ~Val1[31] && ~Val2[31]) || (~Result[31] && Val1[31] && Val2[31]); end
        // ADC
        4'b0011: begin {C, Result} <= Val1 + Val2 + SR[1];
                 V <= (Result[31] && ~Val1[31] && ~Val2[31]) || (~Result[31] && Val1[31] && Val2[31]); end
        // SUB
        4'b0100: begin Result <= Val1 - Val2; 
                 V <= (Result[31] && ~Val1[31] && Val2[31]) || (~Result[31] && Val1[31] && ~Val2[31]); end
        // SBC
        4'b0101: begin Result <= Val1 - Val2 - !SR[1]; 
                 V <= (Result[31] && ~Val1[31] && Val2[31]) || (~Result[31] && Val1[31] && ~Val2[31]); end
        4'b0110: Result <= Val1 & Val2; // AND
        4'b0111: Result <= Val1 | Val2; // ORR
        4'b1000: Result <= Val1 ^ Val2; // XOR
        // CMP
        4'b0100: begin Result <= Val1 - Val2;
                 V <= (Result[31] && ~Val1[31] && Val2[31]) || (~Result[31] && Val1[31] && ~Val2[31]); end
        4'b0110: Result <= Val1 & Val2; // TST
        4'b0010: Result <= Val1 + Val2; // LDR
        4'b0010: Result <= Val1 + Val2; // STR
        default: Result <= 0;
    endcase

    Z <= (Result == 32'b0)? 1'b1 : 1'b0;
    //V <= (Result[31] && ~Val1[31] && Val2[31]) || (~Result[31] && Val1[31] && ~Val2[31]);
    N <= Result[31]? 1'b1 : 1'b0;
    Status <= {N, Z, C, V}; 

end

/*
assign Status = {N, Z, C, V};

assign Z = (Result == 32'b0)? 1'b1 : 1'b0;

assign V = (Result[31] & ~Val1[31] & ~Val2[31]) | (~Result[31] & Val1[31] & Val2[31]);

assign N = Result[31] ?  1'b1 : 1'b0;
*/

endmodule