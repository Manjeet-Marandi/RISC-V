`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2026 07:38:59 PM
// Design Name: 
// Module Name: fetch_cycle
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


module fetch_cycle(
    input clk,rst,
    input PCSrcE,
    input [31:0] PCTargetE,
    output [31:0] InstrD,
    output [31:0] PCD, PCPlus4D
    );

    wire [31:0] PC_F, PCF, PCPlus4F, InstrF ; //PC_F is before the cycle, PCF is after the cycle, PCPlus4F is the output of the adder before the cycle
    reg [31:0] InstrF_reg, PCF_reg, PCPlus4F_reg;


    mux mux_inst_pcmux(
        .a(PCPlus4F),
        .b(PCTargetE),
        .s(PCSrcE),
        .c(PC_F)
    );

    pc pc_inst(
        .clk(clk),
        .rst(rst),
        .pc(PCF),
        .pc_next(PC_F)
    );

    instr_mem instr_mem_inst(
        .A(PCF),
        .rst(rst),
        .RD(InstrF)
    );

    pc_adder pc_adder_inst(
        .a(PCF),
        .b(32'h4),
        .c(PCPlus4F)
    );

    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            InstrF_reg <= 32'b0;
            PCF_reg <= 32'b0;
            PCPlus4F_reg <= 32'b0;
        end else begin
            InstrF_reg <= InstrF;
            PCF_reg <= PCF;
            PCPlus4F_reg <= PCPlus4F;
        end
    end

assign InstrD = InstrF_reg;
assign PCD = PCF_reg;
assign PCPlus4D = PCPlus4F_reg;

endmodule
