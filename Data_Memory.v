`timescale 1ns / 1ps

module Data_Memory(
    input [63:0]mem_address,
    input [63:0]Write_Data,
    input clk,
    input MemWrite,
    input MemRead,
    output reg [63:0]Read_Data
    );
    reg [7:0]mem[99:0];

    integer i;
    // initializing the memory address array
    initial begin
        for(i=0; i<100; i=i+1)
            begin
            mem[i] = i+1;
            end
    end
    always@(posedge clk)  // only writing @ positive edge
    begin
    if(MemWrite)   // writing when signal is high
        begin 
// assigning the value to 8 consecutive registers starting from the memory address
        mem[mem_address] <= Write_Data[7:0];
        mem[mem_address+1] <= Write_Data[15:8];
        mem[mem_address+2] <= Write_Data[23:16];
        mem[mem_address+3] <= Write_Data[31:24];
        mem[mem_address+4] <= Write_Data[39:32];
        mem[mem_address+5] <= Write_Data[47:40];
        mem[mem_address+6] <= Write_Data[55:48];
        mem[mem_address+7] <= Write_Data[63:56];
        end 
    end
    
    always@(*)
    begin
    if(MemRead)
 //giving the output of 8 consecutive reg on memory address when read signal is high  
        begin 
            Read_Data[7:0] <= mem[mem_address];
            Read_Data[15:8] <= mem[mem_address+1];
            Read_Data[23:16] <= mem[mem_address+2];
            Read_Data[31:24] <= mem[mem_address+3];
            Read_Data[39:32] <= mem[mem_address+4];
            Read_Data[47:40] <= mem[mem_address+5];
            Read_Data[55:48] <= mem[mem_address+6];
            Read_Data[63:56] <= mem[mem_address+7];
        end
    end
    
endmodule
