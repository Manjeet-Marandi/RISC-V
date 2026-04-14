`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2026 10:52:15 PM
// Design Name: 
// Module Name: pc
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


module pc( 
    input [31:0] pc_next,
    input rst,clk,
    output reg [31:0] pc
    );

    always @(posedge clk ) begin
        if (!rst) begin
            pc <= 32'h0;
        end
        else begin
            pc <= pc_next;
        end
    end
endmodule
