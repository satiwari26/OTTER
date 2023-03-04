`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2023 10:04:12 AM
// Design Name: 
// Module Name: PC_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PC_module(
    input logic PC_WRITE,
    input logic PC_RST,
    input logic [31:0] PC_DIN,
    input logic clk,
    output logic [31:0] PC_COUNT,
    output logic [31:0] PCAddressWithFourAdd
    );
    
    //logic [31:0] PC_COUNT1;
    
    
    always_ff @(posedge clk)
    begin
        if(PC_RST==1)
        begin
            PC_COUNT <=32'b0;
        end
        else if(PC_WRITE==1)
        begin
           PC_COUNT <= PC_DIN;
        end
    end
    
    assign PCAddressWithFourAdd = PC_COUNT+4;
    
endmodule
