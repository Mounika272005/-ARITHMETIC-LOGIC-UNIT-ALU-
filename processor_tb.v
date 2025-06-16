`timescale 1ns/1ps

module processor_tb;
    reg clk = 0;
    always #5 clk = ~clk;

    processor uut(clk);

    initial begin
        $dumpfile("processor.vcd");
        $dumpvars(0, processor_tb);
        #200 $finish;
    end
endmodule
