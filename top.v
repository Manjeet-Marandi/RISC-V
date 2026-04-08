`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2026 05:12:24 AM
// Design Name: 
// Module Name: top
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


module top(
    input clk, rst
    );

wire RegWrite;
wire [31:0] pc_top, RD_instr, RD1_top, imm_extend_out, ALUResult, ReadData, PCPlus4;
wire [2:0] ALUControl_top;
    pc pc_inst(
        .clk(clk),
        .rst(rst),
        .pc(pc_top),
        .pc_next(PCPlus4)
    );
    pc_adder pc_adder_inst(
        .a(pc_top),
        .b(32'h4),
        .c(PCPlus4)
    );
    instr_mem instr_mem_inst(
        .rst(rst),
        .A(pc_top),
        .RD(RD_instr)
    );
    register_file register_file_inst(
        .clk(clk),
        .rst(rst),
        .WE3(RegWrite),
        .A1(RD_instr[19:15]), //rs1
        .A2(),
        .A3(RD_instr[11:7]), //rd
        .WD3(ReadData),
        .RD1(RD1_top),
        .RD2()
    );
    sign_extend sign_extend_inst(
        .imm_in(RD_instr),
        .imm_out(imm_extend_out)
    );
    alu alu_inst(
        .A(RD1_top),
        .B(imm_extend_out),
        .ALUControl(ALUControl_top),
        .Result(ALUResult),
        .Z(), .V(), .N(), .C()
    );
    control_unit control_unit_inst(
        .op(RD_instr[6:0]),
        .funct7(RD_instr[31:25]),
        .funct3(RD_instr[14:12]),
        .ResultSrc(), .MemWrite(), .ALUSrc(), .RegWrite(RegWrite), .Branch(),
        .ImmSrc(),
        .ALUControl(ALUControl_top)
    );
    data_mem data_mem_inst(
        .A(ALUResult),
        .WD(),
        .clk(clk),
        .rst(rst),
        .WE(),
        .RD(ReadData)
    );



endmodule
