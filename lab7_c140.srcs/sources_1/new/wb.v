`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2026 02:00:25 PM
// Design Name: 
// Module Name: wb
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


module wb(
        input [31:0] alu_out,
        input [31:0] d_mem,
        input [31:0] pc_plus4,
        input [1:0] src,
        output reg [31:0] wd
    );
    always @(*)begin
    case(src)
      0: wd = alu_out;
      1: wd = d_mem;
      2: wd = pc_plus4;
      3: wd = 'bXXXXXXXXXXXXXXXX;
    endcase
    end
endmodule
