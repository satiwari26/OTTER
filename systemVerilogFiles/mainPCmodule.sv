`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2023 04:20:41 PM
// Design Name: 
// Module Name: mainPCmodule
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


module mainPCmodule(
    //mux inputs
    input logic [31:0] JALR,
    input logic [31:0] BRANCH,
    input logic [31:0] JAL,
    //input logic [31:0] MTVEC,
    //input logic [31:0] MEPC,
    input logic [1:0] PC_SOURCE,
    //input logic [31:0] PC_four,
    //output logic [31:0] PC_DOUT,
    //PC_module inputs
    input logic PC_WRITE,
    input logic PC_RST,
    //input logic [31:0] PC_DIN,
    input logic clk,
    output logic [31:0] PC_COUNT,
    output logic [31:0] PCAddressWithFourAdd
    );
    
    logic [31:0] PC_DOUT; //connection for PC_out value
    logic [31:0] PC_DIN; //connection for the PC_DIN value
    logic [31:0] PC_four;// feedback loop for the PC_Four from PC_module to PC_source
    
    PC_source PC_SOURCE_Main(.JALR(JALR),.BRANCH(BRANCH),.JAL(JAL),
    .PC_SOURCE(PC_SOURCE),.PC_four(PC_four),
    .PC_DOUT(PC_DOUT));
    
    PC_module PC_module_Main(.PC_WRITE(PC_WRITE),.PC_RST(PC_RST),
    .PC_DIN(PC_DIN),.clk(clk),.PC_COUNT(PC_COUNT),
    .PCAddressWithFourAdd(PCAddressWithFourAdd));
    
    assign PC_four = PCAddressWithFourAdd;//assigning PC-plus-four value to received 
    //value from PC_module to internal logic
    
    assign PC_DIN = PC_DOUT;
endmodule
