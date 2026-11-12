`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2026 02:05:12 PM
// Design Name: 
// Module Name: fetch
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


module fetch(
    input clk,
    input rst,
    input pc_we,
    input [31:0] pc_d,
    output [31:0] pc_plus4,
    output [31:0] pc
    );
    wire[31:0] next_pc;
    dreg pc_reg(
       .clk(clk),
       .rst(rst),
       .d(next_pc),
       .q(pc)
    );

    assign pc_plus4 = pc + 4;
    assign next_pc = pc_we ? pc_d : pc_plus4; 

endmodule
