`timescale 1ns / 1ps

module EX_MEM_reg(
input clk, reset,
	input [4:0] ID_EX_rd,
	input [63:0] ID_EX_readData2, result,
	input zero,
	input [63:0] out2,
	input ID_EX_Branch,
	input ID_EX_MemRead,
	input ID_EX_MemWrite,
	input ID_EX_regWrite,
	input ID_EX_MemtoReg,
	
	output reg [4:0] EX_MEM_rd,
	output reg [63:0] EX_MEM_readData2, EX_MEM_ALU_result,
	output reg EX_MEM_zero,
	output reg [63:0] EX_MEM_pcOut,
	output reg EX_MEM_Branch,
	output reg EX_MEM_MemRead,
	output reg EX_MEM_MemWrite,
	output reg EX_MEM_regWrite,
	output reg EX_MEM_MemtoReg
	
);

	always @(posedge clk or reset)
		begin
			if (reset)
				begin
					EX_MEM_rd = 0;
					EX_MEM_readData2 = 0;
					EX_MEM_ALU_result = 0;
					EX_MEM_zero = 0;
					EX_MEM_pcOut = 0;
					EX_MEM_Branch = 0;
					EX_MEM_MemRead = 0;
					EX_MEM_MemWrite = 0;
					EX_MEM_regWrite = 0;
					EX_MEM_MemtoReg = 0;
				end
			else if (clk)
				begin
					EX_MEM_rd = ID_EX_rd;
					EX_MEM_readData2 = ID_EX_readData2;
					EX_MEM_ALU_result = result;
					EX_MEM_zero = zero;
					EX_MEM_pcOut = out2;
					EX_MEM_Branch = ID_EX_Branch;
					EX_MEM_MemRead = ID_EX_MemRead;
					EX_MEM_MemWrite = ID_EX_MemWrite;
					EX_MEM_regWrite = ID_EX_regWrite;
					EX_MEM_MemtoReg = ID_EX_MemtoReg;
				end
		
		end
endmodule
