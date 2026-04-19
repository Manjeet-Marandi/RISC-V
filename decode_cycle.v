`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2026 09:35:49 PM
// Design Name: 
// Module Name: decode_cycle
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


module decode_cycle(
    input clk, rst, RegWriteW,
    input [31:0] InstrD, PCD, PCPlus4D,ResultW,
    input [4:0] RdW,

    output ResultSrcE, ALUSrcE, BranchE, RegWriteE, MemWriteE,
    output [2:0] ALUControlE,
    output [31:0] RD1_E, RD2_E, ImmExtE,
    output [4:0] RdE,
    output [31:0] PCE, PCPlus4E
    );

    wire ResultSrcD, ALUSrcD, BranchD, RegWriteD, MemWriteD;
    wire [1:0] ImmSrcD;
    wire [2:0] ALUControlD;
    wire [31:0] RD1_D, RD2_D, ImmExtD;

    reg ResultSrcD_reg, ALUSrcD_reg, BranchD_reg, RegWriteD_reg, MemWriteD_reg;
    reg [2:0] ALUControlD_reg;
    reg [31:0] RD1_D_reg, RD2_D_reg, ImmExtD_reg;
    reg [4:0] RD_D_reg;
    reg [31:0] PCD_reg, PCPlus4D_reg;

    control_unit control_unit_inst(
        .op(InstrD[6:0]), 
        .funct7(InstrD[31:25]), 
        .funct3(InstrD[14:12]), 
        .ResultSrc(ResultSrcD), 
        .MemWrite(MemWriteD), 
        .ALUSrc(ALUSrcD), 
        .RegWrite(RegWriteD), 
        .Branch(BranchD),
        .ImmSrc(ImmSrcD), 
        .ALUControl(ALUControlD)
    );

    register_file register_file_inst(
        .clk(clk),
        .rst(rst),
        .WE3(RegWriteW),
        .A1(InstrD[19:15]),
        .A2(InstrD[24:20]),
        .A3(RdW),
        .WD3(ResultW),
        .RD1(RD1_D),
        .RD2(RD2_D)
    );

    sign_extend sign_extend_inst(
        .imm_in(InstrD),
        .ImmSrc(ImmSrcD),
        .imm_out(ImmExtD)
    );

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            ResultSrcD_reg <= 1'b0;
            ALUSrcD_reg <= 1'b0;
            BranchD_reg <= 1'b0;
            RegWriteD_reg <= 1'b0;
            MemWriteD_reg <= 1'b0;
            ALUControlD_reg <= 3'b0;
            RD1_D_reg <= 32'b0;
            RD2_D_reg <= 32'b0;
            ImmExtD_reg <= 32'b0;
            RD_D_reg <= 5'b0;
            PCD_reg <= 32'b0;
            PCPlus4D_reg <= 32'b0;
        end else begin
            ResultSrcD_reg <= ResultSrcD;
            ALUSrcD_reg <= ALUSrcD;
            BranchD_reg <= BranchD;
            RegWriteD_reg <= RegWriteD;
            MemWriteD_reg <= MemWriteD;
            ALUControlD_reg <= ALUControlD;
            RD1_D_reg <= RD1_D;
            RD2_D_reg <= RD2_D;
            ImmExtD_reg <= ImmExtD;
            RD_D_reg <= InstrD[11:7];
            PCD_reg <= PCD;
            PCPlus4D_reg <= PCPlus4D;
        end
    end
assign ResultSrcE = ResultSrcD_reg;
assign BranchE = BranchD_reg;
assign ALUSrcE = ALUSrcD_reg;
assign RegWriteE = RegWriteD_reg;
assign MemWriteE = MemWriteD_reg;
assign ALUControlE = ALUControlD_reg;
assign RD2_E = RD2_D_reg;
assign RD1_E = RD1_D_reg;
assign ImmExtE = ImmExtD_reg;
assign RdE = RD_D_reg;
assign PCE = PCD_reg;
assign PCPlus4E = PCPlus4D_reg;

endmodule
