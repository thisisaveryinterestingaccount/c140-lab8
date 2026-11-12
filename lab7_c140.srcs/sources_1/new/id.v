`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2026 02:04:25 PM
// Design Name: 
// Module Name: id
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


module id(
    input clk,
    input rst,
    input [31:0] instr,
    input [31:0] pc_plus4,
    input        reg_we_now,
    input [31:0] reg_wd,
    input [31:0] ra3,
    output [31:0] rd1,
    output [31:0] rd2,
    output [31:0] rd3,
    output [31:0] imm,
    output [4:0]  shamt,
    output [4:0] alu_op,
    output mem_we,
    output reg_we_later,
    output alu_dst,
    output alu_src,
    output jr,
    output branch,
    output pc_we,
    output jump
    );
    wire reg_dst;
    wire rf_we;
    
    assign imm = {{16{instr[15]}}, instr};
    assign shamt = instr[10:6];
    
    wire is_jal = instr[31:26] == 6'b000011;
    wire [4:0] wa_r_i;
    assign wa_r_i =  reg_dst ? instr[15:11] : instr[20:16];
    wire [4:0] wa;
    assign wa = is_jal ? 31 : wa_r_i;
    
    regfile rf(
      .clk(clk),
      .rst(rst),
      .we(rf_we),
      .ra1(instr[25:21]),
      .ra2(instr[20:16]),
      .ra3(ra3),
      .rd1(rd1),
      .rd2(rd2),
      .rd3(rd3),
      .wa(wa),
      .wd(reg_wd)
    );
    
    control_unit cu(
        .opcode(instr[31:26]),
        .funct(instr[5:0]),
        .branch(branch),
        .jump(jump)
    );
endmodule
