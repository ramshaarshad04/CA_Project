`timescale 1ns / 1ps

module Control_unit(
    input [6:0] opcode,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [1:0] AluOp,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite
);

    always @(*) begin
        // Default values 
        Branch <= 0;
        MemRead <= 0;
        MemtoReg <= 0;
        AluOp <= 2'b00;
        MemWrite <= 0;
        ALUSrc <= 0;
        RegWrite <= 0;

        if (opcode == 7'b0110011) begin  // R-type
            ALUSrc <= 0;
            MemtoReg <= 0;
            RegWrite <= 1;
            MemRead <= 0;
            MemWrite <= 0;
            Branch <= 0;
            AluOp <= 2'b10;
        end
        else if (opcode == 7'b0000011) begin // I-type (load)
            ALUSrc <= 1;
            MemtoReg <= 1;
            RegWrite <= 1;
            MemRead <= 1;
            MemWrite <= 0;
            Branch <= 0;
            AluOp <= 2'b00;
        end
        else if (opcode == 7'b0100011) begin  // S-type (store)
            ALUSrc <= 1;
            MemtoReg <= 1'bX;
            RegWrite <= 0;
            MemRead <= 0;
            MemWrite <= 1;
            Branch <= 0;
            AluOp <= 2'b00;
        end
        else if (opcode == 7'b1100011) begin  // SB-type (branch)
            ALUSrc <= 0;
            MemtoReg <= 1'bX;
            RegWrite <= 0;
            MemRead <= 0;
            MemWrite <= 0;
            Branch <= 1;
            AluOp <= 2'b01;
        end
        else if (opcode == 7'b0010011) begin // I-type 
            ALUSrc <= 1;
            MemtoReg <= 0;
            RegWrite <= 1;
            MemRead <= 0;
            MemWrite <= 0;
            Branch <= 0;
            AluOp <= 2'b00;
        end
    end
endmodule
