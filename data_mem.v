`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2026 11:11:26 PM
// Design Name: 
// Module Name: data_mem
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


module data_mem(
    input [31:0] A, WD,
    input clk, rst,WE, 
    output [31:0] RD
    );
    
    reg [31:0] data_memory [1023:0];

    //Read
    assign RD = (!WE) ? data_memory[A] : 32'h0 ;

    //Write
    always @(posedge clk ) begin
        if (WE) begin
            data_memory[A] <= WD ;
        end
    end

initial begin
    data_memory [14] = 32'h00000021 ; //x6 = 33
    data_memory [3] = 32'h00000011 ; //x6 = 17
end

endmodule
