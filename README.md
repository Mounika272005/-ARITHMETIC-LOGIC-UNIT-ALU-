Verilog code:

module ALU (
    input  [3:0] A,
    input  [3:0] B,
    input  [1:0] ALU_Sel,  // 2-bit selector
    output reg [3:0] ALU_Out,
    output reg CarryOut
);

always @(*) begin
    case (ALU_Sel)
        2'b00: {CarryOut, ALU_Out} = A + B;    // Addition
        2'b01: {CarryOut, ALU_Out} = A - B;    // Subtraction
        2'b10:  ALU_Out = A & B;               // AND 
        2'b11:  ALU_Out = A | B;               // OR
        default: ALU_Out = 4'b0000;
    endcase
end 

endmodule



Testbench:

`timescale 1ns / 1ps

module ALU_tb;

     reg [3:0] A, B;
     reg [1:0] ALU_Sel;
     wire [3:0] ALU_Out;
     wire CarryOut;

     // Instantiate ALU
     ALU uut (
        .A(A),
        .B(B),
        .ALU_Sel(ALU_Sel),
        .ALU_Out(ALU_Out),
        .CarryOut(CarryOut)
     );

     initial begin
         // Setup waveform dump
         $dumpfile("alu.vcd");
         $dumpvars(0,ALU_tb);

         // Header for display output
         $display("Time\tA\tB\tSel\tOut\tCarry");

         // Test Add
         A = 4'b0101; B = 4'b0011; ALU_Sel = 2'b00; #10;
         $display("%0t\t%b\t%b\t%b\t%b\t%b", $time, A, B, ALU_Sel, ALU_Out, CarryOut); 

         // Test SUB
         A = 4'b1000; B = 4'b0011; ALU_Sel = 2'b01; #10;
         $display("%0t\t%b\t%b\t%b\t%b\t%b", $time, A, B, ALU_Sel, ALU_Out, CarryOut);

         // Test AND
         A = 4'b1100; B = 4'b1010; ALU_Sel = 2'b10; #10;
         $display("%0t\t%b\t%b\t%b\t%b\t%b", $time, A, B, ALU_Sel, ALU_Out, CarryOut);    

         // Test OR
         A = 4'b1100; B = 4'b1010; ALU_Sel = 2'b11; #10;
         $display("%0t\t%b\t%b\t%b\t%b\t%b", $time, A, B, ALU_Sel, ALU_Out, CarryOut);   

         $finish;
    end 

endmodule        

