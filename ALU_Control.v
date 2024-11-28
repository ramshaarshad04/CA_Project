`timescale 1ns / 1ps

module ALU_Control(
    input [1:0]ALUOp,
    input [3:0]Funct,
    output reg [3:0]Operation
    );
    
    always @(*)
    begin
        if (ALUOp == 2'b00) begin    // I/S-Type (ld, sd)
            if(Funct[2:0]==3'b001)    // slli
                Operation <= 4'b1000; 
            else
                Operation <= 4'b0010;  
        end
        else if (ALUOp == 2'b01) begin // SB-Type (Beq)
            if(Funct[2:0]==3'b100)    // blt
                Operation <= 4'b0111; 
            else
                Operation <= 4'b0110;   // beq
        end
        else if (ALUOp == 2'b10) begin   // R-Type 
            // checking different values for function in R-Type
            if (Funct == 4'b0000)   
                Operation <= 4'b0010;
            if (Funct == 4'b1000)
                Operation <= 4'b0110;
            if (Funct == 4'b0111)
                Operation <= 4'b0000;
            if (Funct == 4'b0110)
                Operation <= 4'b0001;
        end
    end
endmodule
