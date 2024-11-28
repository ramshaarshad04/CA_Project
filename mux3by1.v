`timescale 1ns / 1ps

module mux3by1(
    input [63:0]a,
    input [63:0]b,
    input [63:0]c,
    input [1:0]sel,
    output [63:0]data_out
    );
    assign data_out = (sel==2'b00) ? a : (sel==2'b01) ? b : c;
endmodule
