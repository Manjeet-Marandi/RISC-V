`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2026 10:59:26 PM
// Design Name: 
// Module Name: register_file
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


module register_file(
    input clk, rst, WE3, // WE3 for enable write
    input [4:0] A1, A2, A3, // A1 - RD1 // A2 - RD2 // A3 - WD3
    input [31:0] WD3,
    output[31:0] RD1, RD2
    );

    reg [31:0] registers [31:0];

    //Write
    always @(posedge clk ) begin
        if (WE3) begin
            registers[A3] <= WD3;
        end
    end
    //Read
    assign RD1 = (rst == 1'b0) ? 32'h0 : registers[A1] ;
    assign RD2 = (rst == 1'b0) ? 32'h0 : registers[A2] ;

    initial begin
        // registers[9] = 32'h00000007 ; //x9 = 7
        // registers[6] = 32'h00000003 ; //x6 = 3
        registers[5] = 32'h00000006 ; //x5 = 6
        registers[6] = 32'h0000000A ; //x6 = 10
    end
endmodule
