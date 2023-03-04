`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2023 01:05:02 PM
// Design Name: 
// Module Name: ImmGenerator
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


module ImmGenerator(
    input logic[24:0] instruct,
    output logic[31:0] U_type,
    output logic[31:0] I_type,
    output logic[31:0] S_type,
    output logic[31:0] B_type,
    output logic[31:0] J_type
);

    assign U_type = {instruct[24:5],{12{1'b0}}};
    assign I_type = {{21{instruct[24]}}, instruct[23:13]};
    assign S_type = {{21{instruct[24]}}, instruct[23:18], instruct[4:0]};
    assign B_type = {{20{instruct[24]}},instruct[0],instruct[23:18],instruct[4:1],1'b0};
    assign J_type = {{12{instruct[24]}}, instruct[12:5], instruct[13],instruct[23:14], 1'b0};
    
endmodule
