module registers(input clk, input we,
                 input [2:0] ra1, ra2, wa,
                 input [7:0] wd,
                 output [7:0] rd1, rd2);

    reg [7:0] regfile[7:0];

    assign rd1 = regfile[ra1];
    assign rd2 = regfile[ra2];

    always @(posedge clk) begin
        if (we) regfile[wa] <= wd;
    end
endmodule
