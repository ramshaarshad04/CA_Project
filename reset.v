`timescale 1ns / 1ps

module reset(
    input clock,
    input reset,
    input flush,
    output reg reset_out
);
integer i;
    reg [1:0] flush_counter = 2'b00;  // Initialize flush_counter to 0

    always @(*) begin
        if (flush) begin
        
        for(i=0; i<3; i=i+1)
            reset_out <= 1'b1;
            
    end
          
         else reset_out <= reset;

    end

endmodule
