`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2023 10:34:51 AM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input logic [31:0] Scr_A,
    input logic [31:0] Scr_C,
    input logic [3:0] alu_fun,
    output logic [31:0] result
    );
    
    always_comb
    begin
    case(alu_fun)
        4'b0000: begin
            result = $signed(Scr_A) + $signed(Scr_C);
        end
        4'b1000: begin
            result = $signed(Scr_A) - $signed(Scr_C);
        end
        4'b0110: begin
            result = Scr_A | Scr_C;
        end
        4'b0111: begin
            result = Scr_A & Scr_C;
        end
        4'b0100: begin
            result = Scr_A ^ Scr_C;
        end
        4'b0101: begin
            result = Scr_A >> Scr_C[4:0]; //shift logical right
        end
        4'b0001: begin
            result = Scr_A << Scr_C[4:0];    //shift logical left
        end
        4'b1101: begin
            result = $signed(Scr_A) >>>(Scr_C[4:0]); //arithematic shift right
        end
        4'b0010: begin
            result = $signed(Scr_A) < $signed(Scr_C); //less than signed value
        end
        4'b0011: begin
            result = Scr_A < Scr_C;     //less than unsigned value
        end
        4'b1001: begin
            result = Scr_A;
        end
        default:begin
            result = 0;
        end
    endcase
    end
    
    
endmodule
