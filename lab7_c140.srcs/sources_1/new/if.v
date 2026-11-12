`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2026 02:04:25 PM
// Design Name: 
// Module Name: if
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


module if(
    input [31:0] instr,
    input [31:0] pc_plus4,
    output rd1,
    output rd2,
    output imm,
    output alu_op,
    output mem_we,
    output alu_dst,
    output alu_src
    );
endmodule
