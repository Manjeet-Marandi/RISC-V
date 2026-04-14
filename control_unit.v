`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2026 08:18:04 AM
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input [6:0] op,funct7,
    input [2:0] funct3,
    output ResultSrc, MemWrite, ALUSrc, RegWrite,
    output Branch,
    output [1:0] ImmSrc,
    output [2:0] ALUControl
    );

    wire [1:0] ALUOp;

     alu_decoder alu_decoder_inst(
        .op(op), 
        .funct7(funct7), 
        .funct3(funct3), 
        .ALUOp(ALUOp), 
        .ALUControl(ALUControl)
    );
    
    main_decoder main_decoder_inst(
        .op(op),
        .ResultSrc(ResultSrc), 
        .MemWrite(MemWrite), 
        .ALUSrc(ALUSrc), 
        .RegWrite(RegWrite), 
        .Branch(Branch),
        .ImmSrc(ImmSrc), 
        .ALUOp(ALUOp)
    );
endmodule
