`timescale 1ns / 1ps

module single_cycle(
    input clk,
    input reset
    );
    wire [63:0] Pc_out;
    wire [31:0] Instruction;
    wire [6:0] Opcode;
    wire [4:0] rd;
    wire [2:0] func3;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [6:0] func7;
    wire [63:0] imm;
    wire [63:0] readData1;
    wire [63:0] readData2;
    wire Branch;
    wire MemRead;
    wire MemtoReg;
    wire [1:0] AluOp;
    wire MemWrite;
    wire AluSrc;
    wire regWrite;
    wire [63:0] b;
    wire [3:0] Operation;
    wire zero;
    wire [63:0] result;
    wire [63:0] out1;
    wire [63:0] out2;
    wire [63:0] Pc_in;
    wire [63:0] Write_data;
    wire [63:0] readData;
    wire [3:0]concat;
    assign concat[2:0] = Instruction[14:12];
    assign concat[3] = Instruction[30];
    PC_Counter pc(clk, reset, Pc_in, Pc_out);
    Instruction_Memory im(Pc_out, Instruction);
    Instruction_parser ip(Instruction, Opcode, rd, func3, rs1, rs2, func7);
    data_extractor de(Instruction, imm);
    registerFile rf(Write_data, rs1, rs2, rd, regWrite, clk, reset, readData1, readData2);
    Control_unit cu(Opcode, Branch, MemRead, MemtoReg, AluOp, MemWrite, AluSrc, regWrite);
    multiplexer mux1(readData2, imm, AluSrc, b);
    ALU_Control ac(AluOp, concat, Operation);
    ALU_64bit alu(readData1, b, Operation, zero, result);
    adder add1(Pc_out, 64'd4, out1);
    adder add2(Pc_out, imm, out2);
    multiplexer mux2(out1, out2, Branch & zero, Pc_in);
    Data_Memory dm(result, readData2, clk, MemWrite, MemRead, readData);
    multiplexer mux3(result, readData, MemtoReg, Write_data);
endmodule