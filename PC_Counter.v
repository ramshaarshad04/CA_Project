`timescale 1ns / 1ps

module PC_Counter(
    input clk,
    input reset,
    input PCWrite,
    input  [63:0]PC_in,
    output reg [63:0]PC_out
    );    
    initial PC_out = 0; 
    always @(posedge clk or reset)
		begin
			if (reset)
				begin
					PC_out <= 0;
				end
			else if (!(PCWrite) && clk)
				begin
					PC_out <= PC_out;
				end
			else if(clk) begin
			        if(PC_in > 263)
                        PC_out <= 1'bx;
					else PC_out <= PC_in;
			     end				
		end
endmodule
