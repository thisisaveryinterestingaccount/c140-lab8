`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2026 02:04:25 PM
// Design Name: 
// Module Name: ex
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


module ex(
    input clk,
    input rst,
    input [31:0] rd1,
    input [31:0] rd2,
    input [31:0] imm,
    input alu_src,
    input [4:0] shamt,
    input [4:0] alu_op,
    input  [31:0] pc_plus4,
    input  branch,
    input  jr,
    output zero,
    output [31:0] alu_out,
    output reg [31:0] pc_next,
    output reg pc_we
    );
    
    alu a(
      .clk(clk),
      .rst(rst),
      .a(alu_src ? imm : rd2),
      .b(rd2),
      .op(alu_op),
      .shift_amount(shamt),
      .zero(zero),
      .y(alu_out)
    );
    
    always @(*) begin
      if(branch) begin
        pc_next = pc_plus4 + {imm, 2'b00};
        pc_we = 1;
      end else if(jr) begin
        pc_next = rd1;
        pc_we = 1;
      end else begin
        pc_next = 32'bX;
        pc_we = 0;
      end
    end
endmodule
