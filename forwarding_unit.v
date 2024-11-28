`timescale 1ns / 1ps
module forwarding_unit(
	input [4:0] ID_EX_rs1, ID_EX_rs2,
	input [4:0] EX_MEM_rd,
	input EX_MEM_regWrite,
	input [4:0] MEM_WB_rd,
	input MEM_WB_regWrite,
	output reg [1:0] forward_A, forward_B
);

	always @(*)
		begin

		// hazard: 1a (EX)
		if (EX_MEM_rd == ID_EX_rs1 && EX_MEM_regWrite == 1 && EX_MEM_rd != 0)
			begin
				forward_A = 2'b10;
			end
		
		// hazard: 2a (MEM)
		
		else if (MEM_WB_rd == ID_EX_rs1 && MEM_WB_regWrite == 1 && MEM_WB_rd != 0 && 
		// catering double data hazards(forwarding when EX hazard is not true)
		!(EX_MEM_rd == ID_EX_rs1 && EX_MEM_regWrite == 1 && EX_MEM_rd != 0))
			begin
				forward_A = 2'b01;
			end
		
		// No hazard
		else
			begin
				forward_A = 2'b00;
			end
		

		// hazard: 1b (EX)
		if (EX_MEM_rd == ID_EX_rs2 && EX_MEM_regWrite == 1 && EX_MEM_rd != 0)
			begin
				forward_B = 2'b10;
			end
		
		// hazard: 2b (MEM)
		else if (MEM_WB_rd == ID_EX_rs2 && MEM_WB_regWrite == 1 && MEM_WB_rd != 0 &&
				!(EX_MEM_rd == ID_EX_rs2 && EX_MEM_regWrite == 1 && EX_MEM_rd != 0))
			begin
				forward_B = 2'b01;
			end
		
		// No hazard
		else 
			begin
				forward_B = 2'b00;
			end
		
		end
endmodule
