`timescale 1ns / 1ps

module hazard_detection_unit(
    input [4:0] IF_ID_rs1,
    input [4:0] IF_ID_rs2,
    input [4:0] ID_EX_rd,
    input ID_EX_MemRead,
    output reg PCWrite, reg IF_ID_Write, reg sel
);
    always @(*) begin
        if (ID_EX_MemRead && ((ID_EX_rd == IF_ID_rs1) || (ID_EX_rd == IF_ID_rs2))) begin
            IF_ID_Write <= 0;
            PCWrite <= 0;
            sel <= 0;
             
        end else begin
            IF_ID_Write <= 1; 
            PCWrite <= 1;
            sel <= 1;
        end
    end
endmodule
