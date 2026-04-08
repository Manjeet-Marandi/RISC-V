`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2026 05:35:52 PM
// Design Name: 
// Module Name: alu_decoder
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


module alu_decoder(
    input [6:0] op, funct7, //here funct7 is actually the 5th index of funct7
    input [2:0] funct3, ALUOp,
    output [2:0] ALUControl
    );

    wire [1:0] concatenation;

    assign concatenation = {op[5], funct7[5]};

    assign ALUControl = (ALUOp == 2'b00) ? 3'b000 : // ALUControl = add ; Instrusction = lw, sw
                        (ALUOp == 2'b01) ? 3'b001 : // ALUControl = subtract ; Instrusction = beq
                        ((ALUOp == 2'b10) & (funct3 == 3'b010)) ? 3'b101 : // ALUControl = set less than ; Instrusction = slt
                        ((ALUOp == 2'b10) & (funct3 == 3'b110)) ? 3'b011 : // ALUControl = or ; Instrusction = or
                        ((ALUOp == 2'b10) & (funct3 == 3'b111)) ? 3'b010 : // ALUControl = and ; Instrusction = and
                        ((ALUOp == 2'b10) & (funct3 == 3'b000) & (concatenation == 2'b11)) ? 3'b001 : // ALUControl = subtract ; Instrusction = sub
                        ((ALUOp == 2'b10) & (funct3 == 3'b000) & (concatenation != 2'b11)) ? 3'b000 : 3'b000 ; // ALUControl = add ; Instrusction = add
                        

endmodule
