`timescale 1ns / 1ps

module ID_EX_reg(
    input clk, reset, sel,
	input [3:0] IF_ID_func,
	input [4:0] rd, rs1, rs2,
	input [63:0] imm, ReadData1,
	input [63:0] ReadData2, IF_ID_PC,
	input ALUSrc,
	input ALUOp,
	input Branch,
	input MemRead,
	input MemWrite,
	input RegWrite,
	input MemtoReg,
	
	output reg [3:0] ID_EX_instruction,
	output reg [4:0] ID_EX_Rd, ID_EX_Rs1, ID_EX_Rs2, 
	output reg [63:0] ID_EX_imm_data, ID_EX_ReadData1,
	output reg [63:0] ID_EX_ReadData2, ID_EX_PC_Out,
	output reg ID_EX_ALUSrc,
	output reg [1:0] ID_EX_ALUOp,
	output reg ID_EX_Branch,
	output reg ID_EX_MemRead,
	output reg ID_EX_MemWrite,
	output reg ID_EX_RegWrite,
	output reg ID_EX_MemtoReg
);

	always @(posedge clk or reset)
		begin
			if (reset)
				begin
					ID_EX_instruction = 0;
					ID_EX_Rd = 0;
					ID_EX_Rs2 = 0;
					ID_EX_Rs1 = 0;
					ID_EX_imm_data = 0;
					ID_EX_ReadData2 = 0;
					ID_EX_ReadData1 = 0;
					ID_EX_PC_Out = 0;
					ID_EX_ALUSrc = 0;
					ID_EX_ALUOp = 0;
					ID_EX_Branch = 0;
					ID_EX_MemRead = 0;
					ID_EX_MemWrite = 0;
					ID_EX_RegWrite = 0;
					ID_EX_MemtoReg = 0;
				end
			else if (clk)
				begin
					ID_EX_instruction = IF_ID_func;
					ID_EX_Rd = rd;
					ID_EX_Rs2 = rs2;
					ID_EX_Rs1 = rs1;
					ID_EX_imm_data = imm;
					ID_EX_ReadData2 = ReadData2;
					ID_EX_ReadData1 = ReadData1;
					ID_EX_PC_Out = IF_ID_PC;
					if(sel) begin 
					ID_EX_ALUSrc = ALUSrc;
					ID_EX_ALUOp = ALUOp;
					ID_EX_Branch = Branch;
					ID_EX_MemRead = MemRead;
					ID_EX_MemWrite = MemWrite;
					ID_EX_RegWrite = RegWrite;
					ID_EX_MemtoReg = MemtoReg;
					end
					else begin
					ID_EX_ALUSrc = 0;
					ID_EX_ALUOp = 0;
					ID_EX_Branch = 0;
					ID_EX_MemRead = 0;
					ID_EX_MemWrite = 0;
					ID_EX_RegWrite = 0;
					ID_EX_MemtoReg = 0;
					
					end
				end
		end
endmodule
