`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2023 07:18:40 PM
// Design Name: 
// Module Name: BranchAddrGen
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


module BranchAddrGen( 
    input logic [31:0]RS1,
    input logic [31:0]B_type,
    input logic [31:0]PC,
    input logic [31:0]J_type,
    input logic [31:0]I_type,
    
    output logic [31:0]jal,
    output logic [31:0]branch,
    output logic [31:0]jalr
    );
    
    assign branch = PC + B_type;
    assign jal = PC + J_type;
    assign jalr = RS1 + I_type;
endmodule
