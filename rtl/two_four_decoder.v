`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2025 04:11:13 PM
// Design Name: 
// Module Name: two_four_decoder
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
`default_nettype none

module two_four_decoder(W, En, Y);
input wire [1:0] W;
input wire En;
output reg [3:0] Y;

always@(En or W) //whenever enable or input changes, do this stuff:
begin
if(En==1'b1)
    case(W)
    2'b00: Y = 4'b0001;
    2'b01: Y = 4'b0010;
    2'b10: Y = 4'b0100;
    2'b11: Y = 4'b1000;
    endcase
else
    Y = 4'b0000; //disable all outputs if En is not high

end

endmodule
