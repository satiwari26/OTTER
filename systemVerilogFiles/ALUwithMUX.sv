`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2023 11:34:19 AM
// Design Name: 
// Module Name: ALUwithMUX
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


module ALUwithMUX(
    input logic [31:0] RS1,
    input logic [31:0] U_type,
    input logic [31:0] RS2,
    input logic [31:0] I_type,
    input logic [31:0] S_type,
    input logic [31:0] PC_OUT,
    input logic [3:0] alu_fun,
    input logic alu_srcA,
    input logic [1:0]alu_srcB,
    
    output logic[31:0] ALU_RESULT
    );
    

    logic [31:0]SRC_A;
    logic [31:0]SRC_B;
    
    //mux for SRC_A
    always_comb
    begin
        case(alu_srcA)
            1'b0:
            begin
                SRC_A = RS1;
            end
            1'b1:
            begin
                SRC_A = U_type;
            end
            default:
            begin
                SRC_A = 32'b0;
            end
        endcase
    end
    
    //mux for SRC_B
    always_comb
    begin
        case(alu_srcB)
            2'b00:
            begin
                SRC_B = RS2;
            end
            2'b01:
            begin
                SRC_B = I_type;
            end
            2'b10:
            begin
                SRC_B = S_type;
            end
            2'b11:
            begin
                SRC_B = PC_OUT;
            end
            default:
            begin
                SRC_B = 32'b0;
            end
        endcase
    end
    
    
    ALU airthLogicUnit(.Scr_A(SRC_A),.Scr_C(SRC_B),.alu_fun(alu_fun),.result(ALU_RESULT));
    
    
endmodule
