`timescale 1ns / 1ps

module data_extractor(
    input [31:0]Instruction,
    output reg [63:0]imm
    );
    wire [1:0]opcode;
    assign opcode = Instruction[6:5];
    always @* begin
        if (opcode == 7'b00)       // I type 
            begin
               imm[11:0] = Instruction[31:20];
               imm[63:12] = {52{Instruction[31]}};   // sign extension
            end
        else if (opcode == 7'b01)  // S type
            begin
                imm [4:0] = Instruction [11:7];
                imm [11:5] = Instruction [31:25];
                imm[63:12] = {52{Instruction[31]}};
            end
        else if (opcode == 7'b11)    // S-B type
            begin
                imm [0] = 0;
                imm [4:1] = Instruction [11:8];
                imm [10:5] = Instruction [30:25];
                imm [11] = Instruction [7];
                imm [12] = Instruction [31];
                imm[63:12] = {52{Instruction[31]}};
            end
    end
endmodule
