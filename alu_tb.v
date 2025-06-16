`timescale 1ns/1ps

module alu_tb;
    reg [3:0] A, B;
    reg [2:0] sel;
    wire [3:0] result;

    alu uut (.A(A), .B(B), .sel(sel), .result(result));

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);

        $monitor("Time=%0t A=%b B=%b sel=%b result=%b", $time, A, B, sel, result);

        A = 4'b0011; B = 4'b0001;

        sel = 3'b000; #10;
        sel = 3'b001; #10;
        sel = 3'b010; #10;
        sel = 3'b011; #10;
        sel = 3'b100; #10;

        $finish;
    end
