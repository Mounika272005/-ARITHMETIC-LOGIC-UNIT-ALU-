module processor(input clk);

    reg [7:0] instr_mem[15:0];
    reg [7:0] data_mem[15:0];
    reg [7:0] regfile[7:0];
    reg [3:0] PC = 0;

    reg [7:0] instr;
    reg [7:0] result;

    always @(posedge clk) begin
        instr = instr_mem[PC];
        PC = PC + 1;

        case(instr[7:6])
            2'b00: begin // ADD
                result = regfile[instr[5:3]] + regfile[instr[2:0]];
                regfile[instr[5:3]] = result;
            end
            2'b01: begin // SUB
                result = regfile[instr[5:3]] - regfile[instr[2:0]];
                regfile[instr[5:3]] = result;
            end
            2'b10: begin // LOAD
                regfile[instr[5:3]] = data_mem[regfile[instr[2:0]]];
            end
        endcase
    end

    initial begin
        // Instruction memory
        instr_mem[0] = 8'b000_001_010; // ADD R1 = R1 + R2
        instr_mem[1] = 8'b001_001_011; // SUB R1 = R1 - R3
        instr_mem[2] = 8'b010_100_101; // LOAD R4 = MEM[R5]

        // Register values
        regfile[1] = 10;
        regfile[2] = 5;
        regfile[3] = 2;
        regfile[5] = 3;

        // Data memory
        data_mem[3] = 20;
    end

endmodule
