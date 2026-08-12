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


module ALU(input logic [31:0] rs1, rs2,
           input logic [2:0] alu_op,
           output logic [31:0] alu_out

    );
    always_comb begin
      
        unique case (alu_op)
            3'b000: alu_out = rs1 + rs2;
            3'b001: alu_out = rs1 & rs2;
            3'b010: alu_out = rs1 + (~rs2+32'h0001);
            3'b011: alu_out = rs1 ^ rs2;
            3'b100: alu_out = rs1 || rs2;
            default : alu_out = 32'h0000;
         endcase
    end
endmodule
