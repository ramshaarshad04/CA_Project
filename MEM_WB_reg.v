`timescale 1ns / 1ps

module MEM_WB_reg(
    input clk, reset,
	input [4:0] EX_MEM_rd,
	input [63:0] EX_MEM_result,
	input [63:0] EX_MEM_Read_Data,
	input EX_MEM_regWrite,
	input EX_MEM_MemtoReg,
	
	output reg [4:0] MEM_WB_rd,
	output reg [63:0] MEM_WB_ALU_result,
	output reg [63:0] MEM_WB_Mem_data,
	output reg MEM_WB_regWrite,
	output reg MEM_WB_MemtoReg
	
);

	always @(posedge clk or reset)
		begin
			if (reset)
				begin
					MEM_WB_rd = 0;
					MEM_WB_ALU_result = 0;
					MEM_WB_Mem_data = 0;
					MEM_WB_regWrite = 0;
					MEM_WB_MemtoReg = 0;
				end
			else if (clk)
				begin
					MEM_WB_rd = EX_MEM_rd;
					MEM_WB_ALU_result = EX_MEM_result;
					MEM_WB_Mem_data = EX_MEM_Read_Data;
					MEM_WB_regWrite = EX_MEM_regWrite;
					MEM_WB_MemtoReg = EX_MEM_MemtoReg;
				end
		
		end
endmodule
