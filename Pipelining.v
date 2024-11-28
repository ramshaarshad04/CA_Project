`timescale 1ns / 1ps

module Pipelining(
    input clk,
    input reset
    );
    //fetch
    wire [63:0] Pc_out;
    wire [63:0] out1;
    wire [31:0] Instruction;
    wire [63:0] IF_ID_PC; 
    wire [31:0] IF_ID_Instruction; 
    PC_Counter pc(clk, reset,PCWrite, Pc_in, Pc_out);
    adder add1(Pc_out, 64'd4, out1);
    Instruction_Memory im(Pc_out, reset, clk,IF_ID_Write, Instruction);
   
    IF_ID_reg reg1(clk, reset, IF_ID_Write, Instruction, Pc_out, 
                   IF_ID_Instruction, IF_ID_PC);
    
    //decode
    wire [6:0] Opcode;
    wire [4:0] rd, rs1, rs2;
    wire [63:0] imm, readData1, readData2;
    wire Branch, MemRead, MemtoReg, MemWrite, AluSrc, regWrite;
    wire [1:0] AluOp;
    wire [3:0]concat;
    assign concat[2:0] = IF_ID_Instruction[14:12];
    assign concat[3] = IF_ID_Instruction[30];
    wire [63:0] ID_EX_PC, ID_EX_readData1, ID_EX_readData2, ID_EX_imm;
    wire [4:0] ID_EX_rs1, ID_EX_rs2, ID_EX_rd;
    wire [1:0] ID_EX_ALU_Op;
    wire [3:0] ID_EX_ALU_FUNC;
    wire ID_EX_Branch, ID_EX_MemRead, ID_EX_MemWrite, ID_EX_MemtoReg, ID_EX_AluSrc, ID_EX_regWrite;
    
    Instruction_parser ip(IF_ID_Instruction, Opcode, rd, func3, rs1, rs2, func7);
    data_extractor de(IF_ID_Instruction, imm);
    registerFile rf(Write_data, rs1, rs2, MEM_WB_rd, MEM_WB_regWrite, clk, reset, readData1, readData2);
    Control_unit cu(Opcode, Branch, MemRead, MemtoReg, AluOp, MemWrite, AluSrc, regWrite);
    
    ID_EX_reg reg2(clk, reset,sel,  concat, rd, rs1, rs2, imm, readData1, readData2, IF_ID_PC, AluSrc, AluOp, Branch, MemRead, MemWrite, regWrite, MemtoReg,
                   ID_EX_ALU_FUNC,ID_EX_rd, ID_EX_rs1, ID_EX_rs2, ID_EX_imm, ID_EX_readData1,ID_EX_readData2, ID_EX_PC,ID_EX_ALUSrc,ID_EX_ALU_Op,ID_EX_Branch,ID_EX_MemRead,
                   ID_EX_MemWrite,ID_EX_RegWrite,ID_EX_MemtoReg );
    
    wire PCWrite, IF_ID_Write, sel;
    
    // hazard detection unit
    hazard_detection_unit hdu(rs1, rs2, ID_EX_rd, ID_EX_MemRead, PCWrite, IF_ID_Write, sel);
    
    //execute
    wire [3:0] Operation;
    wire zero;
    wire [63:0] result, out2, b;    
    
    wire [63:0] EX_MEM_ALU_result, EX_MEM_readData2, EX_MEM_pcOut;
    wire [4:0] EX_MEM_rd;
    wire EX_MEM_Branch, EX_MEM_MemRead, EX_MEM_MemWrite, EX_MEM_MemtoReg, EX_MEM_regWrite;
    wire EX_MEM_zero;

    multiplexer mux1(forward_mux_output_b, ID_EX_imm, ID_EX_ALUSrc, b);
    ALU_Control ac(ID_EX_ALU_Op, ID_EX_ALU_FUNC, Operation);
    ALU_64bit alu(forward_mux_output_a, b, Operation, zero, result);
    adder add2(ID_EX_PC, ID_EX_imm, out2);
    
    EX_MEM_reg reg3( clk, reset, ID_EX_rd, ID_EX_readData2, result, zero, out2,ID_EX_Branch,ID_EX_MemRead,ID_EX_MemWrite,ID_EX_RegWrite, ID_EX_MemtoReg,
                    EX_MEM_rd, EX_MEM_readData2, EX_MEM_ALU_result, EX_MEM_zero,EX_MEM_pcOut, EX_MEM_Branch, EX_MEM_MemRead, EX_MEM_MemWrite,
	                EX_MEM_regWrite, EX_MEM_MemtoReg);
       
    //memory
    wire [63:0] Pc_in,Write_data, readData;   
    wire [63:0] MEM_WB_ALU_result, MEM_WB_Mem_data;
    wire [4:0] MEM_WB_rd;
    wire MEM_WB_MemtoReg, MEM_WB_regWrite;
    Data_Memory dm(EX_MEM_ALU_result, EX_MEM_readData2, clk, EX_MEM_MemWrite, EX_MEM_MemRead, readData);
    multiplexer mux2(out1, EX_MEM_pcOut, EX_MEM_Branch & EX_MEM_zero, Pc_in);
    
    MEM_WB_reg reg4(clk, reset, EX_MEM_rd,EX_MEM_ALU_result,readData,EX_MEM_regWrite,EX_MEM_MemtoReg,MEM_WB_rd,MEM_WB_ALU_result,MEM_WB_Mem_data,MEM_WB_regWrite,MEM_WB_MemtoReg);
    //writeback
    multiplexer mux3(MEM_WB_ALU_result, MEM_WB_Mem_data, MEM_WB_MemtoReg, Write_data);
    wire [1:0] forward_A, forward_B;
    wire[63:0] forward_mux_output_a, forward_mux_output_b;
    // forwarding unit
    forwarding_unit forward(ID_EX_rs1, ID_EX_rs2, EX_MEM_rd,EX_MEM_regWrite,MEM_WB_rd,MEM_WB_regWrite,forward_A, forward_B);
    mux3by1 mux_a(ID_EX_readData1,Write_data,EX_MEM_ALU_result, forward_A, forward_mux_output_a);
    mux3by1 mux_b(ID_EX_readData2,Write_data,EX_MEM_ALU_result, forward_B, forward_mux_output_b);
    
endmodule
