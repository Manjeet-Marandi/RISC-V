`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2026 08:06:49 PM
// Design Name: 
// Module Name: alu
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


//ALU
module alu #(
    //parameters
) (
    input [31:0] A,B,
    input [2:0] ALUControl,
    
    output [31:0] Result,
    output Z, V, N, C // Zero, Overflow, Negative, Carry
);

    wire [31:0] a_and_b;
    wire [31:0] a_or_b;
    wire [31:0] not_b;

    wire [31:0] mux_1; //Mux before the sum block

    wire [31:0] sum; //Output from the sum block
    
    wire [31:0] mux_2; //4by1 Mux to get result of the ALU

    wire cout; // cout from the sum block

    wire [31:0] slt; // zero extension after sum block with the most significant bit of sum

    // AND Operation
    assign a_and_b = A & B;

    // OR Operation
    assign a_or_b = A | B;

    // NOT Operaration
    assign not_b = ~B;

    // Ternary Operator
    assign mux_1 = (ALUControl[0] == 1'b0) ? B : not_b;

    // Addition/Subtration Operation
    assign {cout, sum} = A + mux_1 + ALUControl[0]; 
    // A + sum block + 0(addition)/1(subtraction)
    // when ALUControl = 0 we normally add A + sum
    // when ALUControl = 1 we do A + (~B + 1) -> A + 2's compliment B 

    // Zero Extension
    assign slt = { {31{1'b0}}, sum[31] };

    // Desigining 4by1mux
    assign mux_2 =  (ALUControl[2:0] == 3'b000) ? sum :
                    (ALUControl[2:0] == 3'b001) ? sum :
                    (ALUControl[2:0] == 3'b010) ? a_and_b :
                    (ALUControl[2:0] == 3'b011) ? a_or_b :
                    (ALUControl[2:0] == 3'b101) ? slt : 32'h0;

    assign Result = mux_2;

    // Flags Assignment
    assign Z = &(~Result);
    assign N = Result[31];
    assign C = cout & (~ALUControl[1]); 
    assign V = (~ALUControl[1]) & (A[31] ^ sum[31]) & (~(A[31] ^ B[31] ^ ALUControl[0]));
    

    
endmodule
