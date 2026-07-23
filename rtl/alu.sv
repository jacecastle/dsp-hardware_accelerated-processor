`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2026 03:59:01 PM
// Design Name: 
// Module Name: ALU
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


module ALU(input logic [31:0] a, b,
           input logic [1:0] ALUK,
           output logic [31:0] alu_out

    );
    always_comb begin
      
        unique case (ALUK)
            2'b00: alu_out = a + b;
            2'b01: alu_out = a & b;
            2'b10: alu_out = ~a;
            2'b11: alu_out = a;
            default : alu_out = 32'h0000;
         endcase
    end
endmodule
