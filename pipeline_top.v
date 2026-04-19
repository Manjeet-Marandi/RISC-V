`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2026 10:37:21 PM
// Design Name: 
// Module Name: pipeline_top
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

module pipeline_top(
    input clk, rst
    );

    wire PCSrcE, RegWriteW, ResultSrcE, ALUSrcE, BranchE, RegWriteE, MemWriteE, RegWriteM
            , MemWriteM, ResultSrcM, ResultSrcW ;
    wire [2:0] ALUControlE;
    wire [31:0] PCTargetE, InstrD, PCD, PCPlus4D, ResultW, RD1_E, RD2_E, ImmExtE, PCE,
                PCPlus4E, ALUResultM, WriteDataM, PCPlus4M, ReadDataW, ALUResultW,
                PCPlus4W;
    wire [4:0] RdW, RdE, RdM;

    fetch_cycle fetch_cycle_inst(
        .clk(clk),
        .rst(rst),
        .PCSrcE(PCSrcE),
        .PCTargetE(PCTargetE),

        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D)
    );

    decode_cycle decode_cycle_inst(
        .clk(clk),
        .rst(rst),
        .RegWriteW(RegWriteW),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D),
        .ResultW(ResultW),
        .RdW(RdW),

        .ResultSrcE(ResultSrcE),
        .ALUSrcE(ALUSrcE),
        .BranchE(BranchE),
        .RegWriteE(RegWriteE),
        .MemWriteE(MemWriteE),
        .ALUControlE(ALUControlE),
        .RD1_E(RD1_E),
        .RD2_E(RD2_E),
        .ImmExtE(ImmExtE),
        .RdE(RdE),
        .PCE(PCE),
        .PCPlus4E(PCPlus4E)
    );

    execute_cycle execute_cycle_inst(
        .clk(clk),
        .rst(rst),
        .ResultSrcE(ResultSrcE),
        .ALUSrcE(ALUSrcE),
        .BranchE(BranchE),
        .RegWriteE(RegWriteE),
        .MemWriteE(MemWriteE),
        .ALUControlE(ALUControlE),
        .RD1_E(RD1_E),
        .RD2_E(RD2_E),
        .ImmExtE(ImmExtE),
        .RdE(RdE),
        .PCE(PCE),
        .PCPlus4E(PCPlus4E),

        .PCTargetE(PCTargetE),
        .ALUResultM(ALUResultM),
        .WriteDataM(WriteDataM),
        .PCPlus4M(PCPlus4M),
        .RdM(RdM),
        .PCSrcE(PCSrcE),
        .RegWriteM(RegWriteM),
        .MemWriteM(MemWriteM),
        .ResultSrcM(ResultSrcM)
    );

    memory_cycle memory_cycle_inst(
        .clk(clk),
        .rst(rst),
        .ALUResultM(ALUResultM),
        .WriteDataM(WriteDataM),
        .PCPlus4M(PCPlus4M),
        .RdM(RdM),
        .RegWriteM(RegWriteM),
        .MemWriteM(MemWriteM),
        .ResultSrcM(ResultSrcM),

        .RegWriteW(RegWriteW),
        .ResultSrcW(ResultSrcW),
        .ReadDataW(ReadDataW),
        .ALUResultW(ALUResultW),
        .PCPlus4W(PCPlus4W),
        .RdW(RdW)
    );

    writeback_cycle writeback_cycle_inst(
        .clk(clk),
        .rst(rst),
        .ResultSrcW(ResultSrcW),
        .ReadDataW(ReadDataW),
        .ALUResultW(ALUResultW),
        .PCPlus4W(PCPlus4W),

        .RegWriteW(RegWriteW),
        .ResultW(ResultW)
    );
endmodule
