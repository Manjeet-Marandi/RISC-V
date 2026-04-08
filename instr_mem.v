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
    input [31:0] A, //should be 10 bits long I think because we have 1024 locations
    input rst,
    output [31:0] RD
    );

    reg [31:0] mem [1023:0] ;

    initial begin
        mem[0] = 32'hFFC4A303 ; //lw x6, -4(x9)
    end
    assign RD = (!rst) ? 32'h0 : mem[A[31:2]] ;
endmodule
