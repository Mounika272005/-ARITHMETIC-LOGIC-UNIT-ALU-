`timescale 1ns/1ps
module ram_tb;

reg clk;
reg [3:0] addr;
reg [7:0] data_in;
wire [7:0] data_out;
reg we, re;

// Instantiate the RAM
ram uut (
    .clk(clk),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out),
    .we(we),
    .re(re)
);

// Clock generation: 10ns period (100MHz)
initial clk = 0;
always #5 clk = ~clk;

initial begin
    $dumpfile("ram.vcd");
    $dumpvars(0, ram_tb);

    // Initialize inputs
    addr = 0;
    data_in = 0;
    we = 0;
    re = 0;

    // Write to address 2
    #10;
    addr = 4'd2;
    data_in = 8'hAB;
    we = 1;
    #10 we = 0;

    // Wait one cycle before read
    #10;

    // Read from address 2
    addr = 4'd2;
    re = 1;
    #10 re = 0;

    // Write to address 4
    #10;
    addr = 4'd4;
    data_in = 8'hCD;
    we = 1;
    #10 we = 0;

    // Wait one cycle before read
    #10;

    // Read from address 4
    addr = 4'd4;
    re = 1;
    #10 re = 0;

    #20 $finish;
end

endmodule
