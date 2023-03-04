`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2023 09:42:19 AM
// Design Name: 
// Module Name: PC_source
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


module PC_source(
    input logic [31:0] JALR,
    input logic [31:0] BRANCH,
    input logic [31:0] JAL,
    //input logic [31:0] MTVEC,
    //input logic [31:0] MEPC,
    input logic [1:0] PC_SOURCE,
    input logic [31:0] PC_four,
    output logic [31:0] PC_DOUT
    );
    
    
    //logic [31:0] PC_four;
    //logic [31:0] PC_DOUT;
    //PC_module PCAddressWithPlusFour(.PCAddressWithFourAdd(PC_four), .PC_DIN(PC_DOUT));
     

    always_comb
    begin
        case(PC_SOURCE)
        2'b00: begin
           PC_DOUT = PC_four;
        end
        2'b01: begin
           PC_DOUT = JALR;
        end
        2'b10: begin
           PC_DOUT = BRANCH;
        end
        2'b11: begin
           PC_DOUT = JAL;
        end
        default: begin
            PC_DOUT = 32'b0;
        end
    endcase
    
    end
    
    
    
endmodule
