`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2026 11:16:00 PM
// Design Name: 
// Module Name: execute_cycle
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


module execute_cycle(
    input clk, rst, ResultSrcE, ALUSrcE, BranchE, RegWriteE, MemWriteE,
    input [2:0] ALUControlE,
    input [31:0] RD1_E, RD2_E, ImmExtE,
    input [4:0] RdE,
    input [31:0] PCE, PCPlus4E,

    output [31:0] PCTargetE, ALUResultM, WriteDataM, PCPlus4M,
    output [4:0] RdM,
    output PCSrcE, RegWriteM, MemWriteM, ResultSrcM
    );

    wire [31:0] ScrB_E, ResultE;
    wire ZeroE;

    reg RegWriteE_reg, MemWriteE_reg, ResultSrcE_reg;
    reg [31:0] ResultE_reg, PCPlus4E_reg, WriteDataE_reg;
    reg [4:0] RdE_reg;
    

    alu alu_inst(
        .A(RD1_E),
        .B(ScrB_E),
        .ALUControl(ALUControlE),
        .Result(ResultE),
        .Z(ZeroE),
        .V(),
        .N(),
        .C()
    );

    mux mux_inst_srcb(
        .a(RD2_E),
        .b(ImmExtE),
        .s(ALUSrcE),
        .c(ScrB_E)
    );

    pc_adder pc_adder_inst(
        .a(PCE),
        .b(ImmExtE),
        .c(PCTargetE)
    );

    always @(posedge clk  or negedge rst) begin
        if (!rst) begin
            RegWriteE_reg <= 1'b0;
            MemWriteE_reg <= 1'b0;
            ResultSrcE_reg <= 1'b0;
            ResultE_reg <= 32'b0;
            PCPlus4E_reg <= 32'b0;
            WriteDataE_reg <= 32'b0;
            RdE_reg <= 5'b0;
        end else begin
            RegWriteE_reg <= RegWriteE;
            MemWriteE_reg <= MemWriteE;
            ResultSrcE_reg <= ResultSrcE;
            ResultE_reg <= ResultE;
            PCPlus4E_reg <= PCPlus4E;
            WriteDataE_reg <= RD2_E;
            RdE_reg <= RdE;
        end
    end

    assign PCSrcE = BranchE & ZeroE;

    assign ALUResultM = ResultE_reg;
    assign WriteDataM = WriteDataE_reg;
    assign PCPlus4M = PCPlus4E_reg;
    assign RdM = RdE_reg;
    assign RegWriteM = RegWriteE_reg;
    assign MemWriteM = MemWriteE_reg;
    assign ResultSrcM = ResultSrcE_reg;
endmodule
