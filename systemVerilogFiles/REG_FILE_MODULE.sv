`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2023 09:40:56 AM
// Design Name: 
// Module Name: REG_FILE_MODULE
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


module REG_FILE_MODULE(
    input logic [4:0] REG_adr1,
    input logic [4:0] REG_adr2,
    input logic [4:0] REG_wa,
    input logic [31:0] REG_wd,
    output logic [31:0] REG_rs1,
    output logic [31:0] REG_rs2,
    input logic REG_enable,
    input logic clk
    );
    
    logic [31:0] ram[0:31]; //creating 32 32-bits registers
    
    initial begin
    
        int i;
    
        for(i=0;i<32;i++)
            begin
                ram[i] = 0; //initializing all the registers to 0
            end
            
                 //REG_rs1 = ram[REG_adr1]; //continously read the value into ram(reg)
                //REG_rs2 = ram[REG_adr2]; //continously read the value into ram(reg)
    end
    
    always_ff @(posedge clk)
    begin
      if(REG_enable== 1 && REG_wa !=0)
      begin
        ram[REG_wa]<= REG_wd;
      end
    end
    
     assign REG_rs1 = ram[REG_adr1]; //continously read the value into ram(reg)
     assign REG_rs2 = ram[REG_adr2]; //continously read the value into ram(reg)
    
endmodule
