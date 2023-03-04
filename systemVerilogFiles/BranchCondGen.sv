`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2023 12:24:12 PM
// Design Name: 
// Module Name: BranchCondGen
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


module BranchCondGen(
    input logic [31:0] RegisterValue1,
    input logic [31:0] RegisterValue2,
    output logic branchEqual,
    output logic branchLessThan,
    output logic branchLessThanUnsigned
    );
    
    always_comb
    begin
            //set everything always to 0
            branchEqual = 0;
            branchLessThan = 0;
            branchLessThanUnsigned =0;
            
        if(RegisterValue1 == RegisterValue2)
        begin
            branchEqual = 1;
            branchLessThan = 0;
            branchLessThanUnsigned =0;
        end
        if($signed(RegisterValue1)<$signed(RegisterValue2))
        begin
            branchEqual = 0;
            branchLessThan = 1;
            //branchLessThanUnsigned =0;
        end
        if(RegisterValue1<RegisterValue2)
        begin
            branchEqual = 0;
            //branchLessThan = 0;
            branchLessThanUnsigned =1;
        end
    end
    
endmodule
