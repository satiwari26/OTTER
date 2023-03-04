`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2023 02:51:59 PM
// Design Name: 
// Module Name: CU_FSM
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


module CU_FSM(
    input logic RST,
    input logic[6:0] instSeven,
    //input logic[3:0] instThree,
    input logic clk,
    output logic PCWrite,
    output logic regWrite,
    output logic memWE2,
    output logic memRDEN1,
    output logic memRDEN2,
    output logic reset
    );
    
    typedef enum {ST_INIT,ST_FETCH,ST_EXECUTE,ST_WRITEBACK} STATES;
    
    STATES PS,NS;
    always_ff @(posedge clk)
    begin
        if(RST==1'b1)
        begin
            PS<=ST_INIT;
        end
        else
        begin
            PS<=NS;
        end
    end
    
    //setting up all the outputs and NS
    always_comb
    begin
     PCWrite = 0;
    regWrite =0;
    memWE2=0;
    memRDEN1=0;
    memRDEN2=0;
    reset=0;
    case(PS)
        ST_INIT:begin
            NS=ST_FETCH;
            reset = 1'b1;
        end
        ST_FETCH:begin
            NS = ST_EXECUTE;
            memRDEN1 = 1'b1;
        end
        ST_EXECUTE:begin
            //conditionally change the NS if present state is different
            NS = ST_FETCH;
            
            /*if(instSeven ==7'b0000011)
            begin
                NS = ST_WRITEBACK;
            end
            else
            begin
                NS = ST_FETCH;
            end
            */
            //checking for the condition of the opcodes now to perform the execution
            case(instSeven)
                7'b0110011: begin   //R type
                PCWrite =1;
                regWrite =1;
                end
                7'b0010011: begin   //I type
                 PCWrite =1;
                regWrite =1;
                end
                7'b1100111:begin    //jalr type
                PCWrite =1;
                regWrite =1;
                end
                7'b0000011:begin    //load types; require write back state
                PCWrite =0;
                regWrite =0;
                memRDEN2 = 1;
                NS = ST_WRITEBACK;
                end
                7'b1100011:begin    //Branch type
                PCWrite =1;
                end
                7'b0100011:begin    //S type
                PCWrite =1;
                memWE2 =1;
                end
                7'b1101111:begin    //J type
                PCWrite =1;
                regWrite = 1;
                end
                7'b0110111:begin    //U-type lui
                PCWrite =1;
                regWrite = 1;
                end
                7'b0010111:begin    //U-type auipc
                PCWrite =1;
                regWrite = 1;
                end
                default:
                begin
                    PCWrite = 0;
                    regWrite =0;
                    memWE2=0;
                end
            endcase
        end
        ST_WRITEBACK: begin
            //setting pc write and reg write to high.
            PCWrite =1;
            regWrite =1;
            NS = ST_FETCH;
        end
        //default case
        default:
        begin
            NS = ST_INIT;
        end
        
     endcase
    end
    
    
endmodule
