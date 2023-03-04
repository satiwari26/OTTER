`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly
// Engineer: Junior Perez and Saumitra Tiwari
// 
// Create Date: 02/25/2023 01:43:16 PM: 
// Module Name: CU_DCDR
// Project Name: HW6_CONTROL_UNIT
// Target Devices: Basys3 
// Description: A not-so-simple decoder for the control unit of the OTTER
//////////////////////////////////////////////////////////////////////////////////


module CU_DCDR(
    // inputs for the decoder
    // 7bit opcode from instruction address
    input logic [6:0] ir_opcode,
    // 3bit function code from instruction address
    input logic [2:0]ir_func,
    // 30th bit of instruction address
    input logic ir_30,
//    // no clue what this is, not used
//    input logic int_taken,
    // branch if equal result input
    input logic br_eq,
    // branch if less than result input
    input logic br_lt,
    // branch if less than unsigned result input
    input logic br_ltu,
    // outputs for the decoder
    output logic [3:0]alu_fun,
    output logic alu_srcA,
    output logic [1:0]alu_srcB,
    output logic [1:0]pcSource,
    output logic [1:0]rf_wr_sel
    );
    
    always_comb
        begin
            //Set all the outputs of CU DCDR to zero 
            alu_fun = 0;
            alu_srcA = 0;
            alu_srcB = 0;
            pcSource = 3'b0;
            rf_wr_sel = 0;
            
            // Checking through all opcodes
            case(ir_opcode)
                7'b0110111:
                    begin
                        // LUI 
                        alu_fun = 4'b1001;
                        alu_srcA = 1;
                        rf_wr_sel = 3;
                    end
                7'b0010111: 
                    begin
                        // AUIPC
                        alu_fun = 4'b0000;
                        alu_srcA = 1;
                        alu_srcB = 3;
                        rf_wr_sel = 3;
                    end
                7'b1101111: 
                    begin
                        //JAL
                        pcSource = 3'b011;
                    end
                7'b1100111: 
                    begin 
                        //JALR
                        pcSource = 1;
                    end
                7'b0000011: 
                    begin
                        //LB 
                            alu_fun = 4'b0000;
                            alu_srcB = 1;
                            rf_wr_sel = 2;
                        //LH 
                            //same thing
                        //LW 
                            // same thing
                        //LBU 
                            // same thing
                        //LHU
                            // same thing                         
                    end
                7'b0010011: 
                    begin
                        case(ir_func)
                            3'b000:
                                begin
                                    //ADDI 
                                    alu_fun = 4'b0000;
                                    alu_srcB = 1;
                                    rf_wr_sel = 3;
                                end
                            3'b010:
                                begin
                                    //SLTI 
                                    alu_fun = 4'b0010;
                                    alu_srcB = 1;
                                    rf_wr_sel = 3;
                                end
                            3'b011:
                                //SLTIU 
                                begin
                                   alu_fun = 4'b0011;
                                   alu_srcB = 1;
                                   rf_wr_sel = 3;
                                end
                            3'b110:
                                //ORI
                                begin
                                   alu_fun = 4'b0110;
                                   alu_srcB = 1;
                                   rf_wr_sel = 3; 
                                end
                            3'b100:
                                //XORI 
                                begin
                                    alu_fun = 4'b0100;
                                    alu_srcB = 1;
                                    rf_wr_sel = 3;
                                end
                            3'b111:
                                //ANDI
                                begin
                                    alu_fun = 4'b0111;
                                    alu_srcB = 1;
                                    rf_wr_sel = 3;
                                end
                            3'b001:
                                //SLLI
                                begin
                                    alu_fun = 4'b0001;
                                    alu_srcB = 1;
                                    rf_wr_sel = 3;
                                end 
                            3'b101:
                                //SRLI
                                if (ir_30 == 0)
                                    begin        
                                        alu_fun = 4'b0101;
                                        alu_srcB = 1;
                                        rf_wr_sel = 3;                                      
                                    end
                                //SRAI
                                else 
                                    begin
                                        alu_fun = 4'b1101;
                                        alu_srcB = 1;
                                        rf_wr_sel = 3;
                                    end
                        endcase
                    end 
                7'b1100011:               
                    case(ir_func)
                        3'b000:
                            //BEQ,
                            begin if (br_eq == 1)
                                    pcSource = 3'b010;
                                  else
                                    pcSource = 0;
                            end
                        3'b001:
                            //BNE,
                            begin if (br_eq == 0) 
                                    pcSource = 3'b010;
                                  else
                                    pcSource = 0;
                            end
                        3'b100:
                            //BLT, 
                            begin if (br_lt == 1)
                                    pcSource = 3'b010;
                                  else
                                    pcSource = 0;
                            end
                        3'b101:
                            //BGE, 
                            begin if (br_lt == 0 || br_eq == 1)
                                    pcSource = 3'b010;
                                  else
                                    pcSource = 0;
                            end
                        3'b110:
                            //BLTU, 
                            begin if (br_ltu == 1)
                                    pcSource = 3'b010;
                                  else
                                    pcSource = 0;
                            end
                        3'b111:
                            //BGEU
                            begin if (br_ltu == 0 || br_eq == 1)
                                    pcSource = 3'b010;
                                  else
                                    pcSource = 0;
                            end
                    endcase
                7'b0100011: 
                    //SB,
                    alu_srcB = 3'b010;
                7'b0110011: 
                    begin
                        case(ir_func)
                            3'b000:
                                begin if (ir_30 == 0)
                                        begin
                                            //ADD,
                                            alu_fun = 4'b0000;                                 
                                            rf_wr_sel = 3;
                                        end
                                    else
                                        begin
                                            //SUB,
                                            alu_fun = 4'b1000;
                                            rf_wr_sel = 3; 
                                        end
                                end                            
                            3'b001:
                                begin
                                    //SLL,
                                    alu_fun = 4'b0001;
                                    rf_wr_sel = 3;
                                end 
                            3'b010:
                                begin
                                    //SLT,
                                    alu_fun = 4'b0010;
                                    rf_wr_sel = 3;
                                end
                            3'b011:
                                begin
                                    //SLTU,
                                    alu_fun = 4'b0011;
                                    rf_wr_sel = 3;
                                end                           
                            3'b100:
                                begin
                                    //XOR, 
                                    alu_fun = 4'b0100;
                                    rf_wr_sel = 3;
                                end
                            3'b101:
                                begin if (ir_30 == 0)
                                        begin
                                            //SRL,
                                            alu_fun = 4'b0101;
                                            rf_wr_sel = 3;
                                        end
                                    else
                                        begin
                                            //SRA,
                                            alu_fun = 4'b1101;
                                            rf_wr_sel = 3;
                                        end
                                end
                            3'b110:
                                begin
                                    //OR,
                                    alu_fun = 4'b0110;
                                    rf_wr_sel = 3;
                                end 
                            3'b111:
                                begin
                                    //AND
                                    alu_fun = 4'b0111;
                                    rf_wr_sel = 3;
                                end
                        endcase
                    end
            endcase
        end
endmodule


