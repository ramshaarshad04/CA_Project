`timescale 1ns / 1ps

module adder(
    input [63:0]a,
    input [63:0]b,
    output [63:0]c
    );
    assign c = a+b; // adding the two inputs and assigning them to output
endmodule
