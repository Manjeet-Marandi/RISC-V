`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2026 04:38:22 PM
// Design Name: 
// Module Name: main_decoder
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


module main_decoder(
    input [6:0] op,
    output ResultSrc, MemWrite, ALUSrc, RegWrite,
    output Branch,
    output [1:0] ImmSrc, ALUOp
    );


    assign RegWrite =   ((op == 7'b0000011) | (op == 7'b0110011)) ? 1'b1 : 1'b0;
    assign MemWrite =   (op == 7'b0100011) ? 1'b1 : 1'b0 ;
    assign ResultSrc =  (op == 7'b0000011) ? 1'b1 : 1'b0 ;
    assign ALUSrc =     ((op == 7'b0000011) | (op == 7'b0100011)) ? 1'b1 : 1'b0 ;
    assign Branch =     (op == 7'b1100011) ? 1'b1 : 1'b0 ;

    assign ImmSrc = (op == 7'b0100011) ? 2'b01 : 
                    (op == 7'b1100011) ? 2'b10 : 2'b00 ;

    assign ALUOp =  (op == 7'b0110011) ? 2'b10 :
                    (op == 7'b1100011) ? 2'b01 : 2'b00 ;

endmodule
