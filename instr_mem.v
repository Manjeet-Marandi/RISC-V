`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2026 10:36:31 PM
// Design Name: 
// Module Name: instr_mem
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


module instr_mem(
    input [31:0] A, 
    input rst,
    output [31:0] RD
    );

    reg [31:0] mem [1023:0] ;

    initial begin
        // mem[0] = 32'h0064A423 ; //sw x6, 8(x9)
        // mem[1] = 32'hFFC4A303 ; //lw x6, -4(x9)
        // mem[0] = 32'h0062E233 ; //or x4, x5, x6
        mem [0] = 32'h00500293 ; //addi x5, x0, 5
        mem [1] = 32'h00300313 ; //addi x6, x0, 3
        mem [2] = 32'h006283B3 ; //add x7, x5, x6
        mem [3] = 32'h00002403 ; //lw x8, 0(x0)
        mem [4] = 32'h00100493 ; //addii x9, x0, 1
        mem [5] = 32'h00940533 ; //add x10, x8, x9
    end
    assign RD = (!rst) ? 32'h0 : mem[A[31:2]] ;
endmodule
