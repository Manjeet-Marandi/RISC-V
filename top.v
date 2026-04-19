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

wire RegWrite, MemWrite, ALUSrc, ResultSrc;
wire [31:0] pc_top, RD_instr, RD1_top, RD2_top, imm_extend_out, ALUResult, ReadData, PCPlus4, SrcB, Result;
wire [1:0] ImmSrc;
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
        .A2(RD_instr[24:20]), //rs2
        .A3(RD_instr[11:7]), //rd
        .WD3(Result),
        .RD1(RD1_top),
        .RD2(RD2_top)
    );
    sign_extend sign_extend_inst(
        .imm_in(RD_instr),
        .ImmSrc(ImmSrc[0]),
        .imm_out(imm_extend_out)
    );
    alu alu_inst(
        .A(RD1_top),
        .B(SrcB),
        .ALUControl(ALUControl_top),
        .Result(ALUResult),
        .Z(), .V(), .N(), .C()
    );
    control_unit control_unit_inst(
        .op(RD_instr[6:0]),
        .funct7(RD_instr[31:25]),
        .funct3(RD_instr[14:12]),
        .ResultSrc(ResultSrc), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .Branch(),
        .ImmSrc(ImmSrc),
        .ALUControl(ALUControl_top)
    );
    data_mem data_mem_inst(
        .A(ALUResult),
        .WD(RD2_top),
        .clk(clk),
        .rst(rst),
        .WE(MemWrite), // When 0 we read from data memory and when 1 we write to data memory
        .RD(ReadData)
    );
    mux mux_inst_register_to_ALU(
        .a(RD2_top),
        .b(imm_extend_out),
        .s(ALUSrc), // when ALUSrc is 0 we take the value from register file and when ALUSrc is 1 we take the value from imm_extend
        .c(SrcB) 
    );
    mux mux_inst_data_to_register(
        .a(ALUResult),
        .b(ReadData),
        .s(ResultSrc),
        .c(Result) 
    );


endmodule
