module mips (
        input  wire        clk,
        input  wire        rst,
        input  wire [4:0]  ra3,
        input  wire [31:0] instr_if,
        input  wire [31:0] rd_dm,
        output wire        we_dm,
        output wire [31:0] pc_current_if,
        output wire [31:0] a_dm,
        output wire [31:0] wd_dm,
        output wire [31:0] rd3
    );
    
    wire [31:0] pc_plus4_if;
    wire [31:0] pc_next_if;
    wire        pc_we_if;
    fetch f(
      .clk(clk),
      .rst(rst),
      .pc(pc_current_if),
      .pc_d(pc_next_if),
      .pc_plus4(pc_plus4_if),
      .pc_we(pc_we_if)
    );
    
    wire [31:0] instr_id;
    wire [31:0] pc_plus4_id;
    pipeline_reg #64 if_id(
      .clk(clk),
      .rst(rst),
      .d({instr_if, pc_plus4_if}),
      .q({instr_id, pc_plus4_id})
    );
    
    wire [31:0] rd1_id;
    wire [31:0] rd2_id;
    wire [31:0] imm_id;
    wire [4:0] alu_op_id;
    wire [4:0] shamt_id;
    wire mem_we_id;
    wire reg_we_id;
    wire alu_dst_id;
    wire alu_src_id;
    wire branch_id;
    wire jr_id;
    
    id d(
      .clk(clk),
      .rst(rst),
      .instr(instr_id),
      .pc_plus4(pc_plus4_id),
      .ra3(ra3),
      .rd3(rd3),
      .rd1(rd1_id),
      .rd2(rd2_id),
      .imm(imm_id),
      .alu_op(alu_op_id),
      .branch(branch_id),
      .jr(jr_id)
    );
    
    wire [31:0] rd1_ex;
    wire [31:0] rd2_ex;
    wire [31:0] imm_ex;
    wire [31:0] pc_plus4_ex;
    wire [4:0] alu_op_ex;
    wire [4:0] shamt_ex;
    wire mem_we_ex;
    wire reg_we_ex;
    wire alu_dst_ex;
    wire alu_src_ex;
    wire branch_ex;
    wire jr_ex;
    pipeline_reg #144 id_ex(
      .clk(clk),
      .rst(rst),
      .d({rd1_id, rd2_id, imm_id, pc_plus4_id, shamt_id, alu_op_id, mem_we_id, reg_we_id, alu_dst_id, alu_src_id, branch_id, jr_id}),
      .q({rd1_ex, rd2_ex, imm_ex, pc_plus4_ex, shamt_ex, alu_op_ex, mem_we_ex, reg_we_ex, alu_dst_ex, alu_src_ex, branch_ex, jr_ex})
    );

    wire [31:0] alu_out_ex;
    wire zero_ex;
    ex e(
      .clk(clk),
      .rst(rst),
      .rd1(rd1_ex),
      .rd2(rd2_ex),
      .imm(imm_ex),
      .alu_src(alu_src_ex),
      .shamt(shamt_ex),
      .alu_op(alu_op_ex),
      .pc_plus4(pc_plus4_ex),
      .branch(branch_ex),
      .jr(jr_ex),
      .zero(zero_ex),
      .alu_out(alu_out_ex),
      .pc_next(pc_next_if),
      .pc_we(pc_we_if)
    );
    
    wire we_mem;
    wire [31:0] rd2_mem;
    wire [31:0] alu_out_mem;
    wire [31:0] pc_plus4_mem;
    pipeline_reg #300 ex_mem(
        .clk(clk),
        .rst(rst),
        .d({rd2_ex, we_ex, alu_out_ex, pc_plus4_mem}),
        .q({rd2_mem, we_mem, alu_out_mem, pc_plus4_mem})
    );
    wire d_mem;
    assign a_dm = alu_out_mem;
    assign wd_dm = rd2_mem;
    assign d_mem = rd_dm;
    
    
    wire [31:0] alu_out_wb;
    wire [31:0] d_wb;
    wire [31:0] pc_plus4_wb;
    pipeline_reg mem_wb(
        .clk(clk),
        .rst(rst),
        .d({alu_out_mem, d_mem, pc_plus4_mem}),
        .q({alu_out_wb,  d_wb,  pc_plus4_wb})
    );
    wb writeback();

endmodule