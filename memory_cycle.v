`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2026 06:46:33 PM
// Design Name: 
// Module Name: memory_cycle
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


module memory_cycle(
    input clk, rst,
    input [31:0] ALUResultM, WriteDataM, PCPlus4M,
    input [4:0] RdM,
    input RegWriteM, MemWriteM, ResultSrcM,

    output RegWriteW, ResultSrcW,
    output [31:0] ReadDataW, ALUResultW, PCPlus4W,
    output [4:0] RdW
    );

    wire [31:0] ReadDataM;

    reg [31:0] ReadDataM_reg, PCPlus4M_reg, ALUResultM_reg;
    reg [4:0] RdM_reg;
    reg RegWriteM_reg, ResultSrcM_reg;

    data_mem data_mem_inst(
        .clk(clk),
        .rst(rst),
        .WE(MemWriteM),
        .A(ALUResultM),
        .WD(WriteDataM),
        .RD(ReadDataM)
    );

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            ReadDataM_reg <= 32'h0;
            ALUResultM_reg <= 32'h0;
            PCPlus4M_reg <= 32'h0;
            RdM_reg <= 5'h0;
            RegWriteM_reg <= 1'b0;
            ResultSrcM_reg <= 1'b0;
        end else begin
            ReadDataM_reg <= ReadDataM;
            ALUResultM_reg <= ALUResultM;
            PCPlus4M_reg <= PCPlus4M;
            RdM_reg <= RdM;
            RegWriteM_reg <= RegWriteM;
            ResultSrcM_reg <= ResultSrcM;
        end
    end

    assign ReadDataW = ReadDataM_reg;
    assign ALUResultW = ALUResultM_reg;
    assign PCPlus4W = PCPlus4M_reg;
    assign RdW = RdM_reg;
    assign RegWriteW = RegWriteM_reg;
    assign ResultSrcW = ResultSrcM_reg;
endmodule
