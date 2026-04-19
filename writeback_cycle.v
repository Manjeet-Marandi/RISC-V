`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2026 07:44:13 PM
// Design Name: 
// Module Name: writeback_cycle
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


module writeback_cycle(
    input clk, rst, ResultSrcW,
    input [31:0] ReadDataW, ALUResultW, PCPlus4W,

    output RegWriteW,
    output [31:0] ResultW
    );

    mux mux_result_src(
        .a(ALUResultW),
        .b(ReadDataW),
        .s(ResultSrcW),
        .c(ResultW)
    );
endmodule
