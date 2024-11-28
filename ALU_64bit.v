`timescale 1ns / 1ps


module ALU_64bit(
    input [63:0]a,
    input [63:0]b,
    input [3:0]op,
    output reg zero,
    output reg [63:0]result
    );
    always @* 
    begin
        if (op == 4'b0000) //checking opcode for and
            result = a & b;
        else if (op == 4'b0001) //checking opcode for or
            result = a | b;
        else if (op == 4'b0010) //checking opcode for addition
            result = a + b;
        else if (op == 4'b0110) //checking opcode for subtraction
              result = $signed(a) - $signed(b);
        else if (op == 4'b1100) //checking opcode for nor
            result = ~(a | b);
        else if (op == 4'b1101) //checking opcode for nand
            result = ~(a & b);
        else if (op == 4'b1000) //checking opcode for shift left
            result = a*(2**b);
        else if (op == 4'b0111) //checking opcode for blt
            result = ($signed(a) < $signed(b)) ? 64'b0 : 64'b1;
        if (result == 64'b0) // checking if result is 0
            zero = 1;
        else
            zero = 0;
    end
    
endmodule
