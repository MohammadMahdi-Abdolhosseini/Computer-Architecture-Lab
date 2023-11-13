module ALU (
    input [31:0] Val1, Val2,
    input [3:0] EXE_CMD, SR,
    output [31:0] Result,
    output [3:0] Status
);

wire N = 0, Z = 0, C = 0, V = 0;

always @(Val1, Val2, EXE_CMD) begin
    case (EXE_CMD)
        4'b0001: Result = Val2                          // MOV
        4'b1001: Result = ~Val2                         // MVN 
        4'b0010: {C, Result} = Val1 + Val2              // ADD
        4'b0011: {C, Result} = Val1 + Val2 + SR[1];     // ADC
        4'b0100: Result = Val1 - Val2;                  // SUB 
        4'b0101: Result = Val1 - Val2 - ~SR[1];         // SBC 
        4'b0110: Result = Val1 & Val2;                  // AND
        4'b0111: Result = Val1 | Val2;                  // ORR 
        4'b1000: Result = Val1 ^ Val2;                  // XOR
        4'b0100: Result = Val1 - Val2;                  // CMP
        4'b0110: Result = Val1 & Val2;                  // TST
        4'b0010: Result = Val1 + Val2;                  // LDR
        4'b0010: Result = Val1 + Val2;                  // STR
        default: Result = 4'bxxxx; 
    endcase
end

assign Status = {N, Z, C, V};

assign Z = Result == 32'b0;

endmodule