`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2026 07:47:30 AM
// Design Name: 
// Module Name: sign_extend
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


module sign_extend(
    input [31:0] imm_in,
    output [31:0] imm_out
    );
    assign imm_out = (imm_in[31]) ? {20'hFFFFF, imm_in[31:20]} : {20'h00000, imm_in[31:20]};
                             
endmodule
