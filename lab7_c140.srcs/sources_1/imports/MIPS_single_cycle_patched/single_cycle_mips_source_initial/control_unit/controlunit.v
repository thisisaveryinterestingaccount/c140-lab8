module controlunit (
        input  wire [5:0]  opcode,
        input  wire [5:0]  funct,
        output wire        branch,
        output wire        jump,
        output wire        reg_dst,
        output wire        we_reg,
        output wire        alu_src,
        output wire        we_dm,
        output wire        dm2reg,
        output  wire        jra,
        output  wire        rd_pc4,
        output wire [3:0]  alu_ctrl
    );
    
    wire [1:0] alu_op;
    wire main_we;
    wire aux_we;
    assign we_reg = main_we & aux_we;

    maindec md (
        .opcode         (opcode),
        .branch         (branch),
        .jump           (jump),
        .reg_dst        (reg_dst),
        .we_reg         (main_we),
        .alu_src        (alu_src),
        .we_dm          (we_dm),
        .dm2reg         (dm2reg),
        .alu_op         (alu_op),
        .rd_pc4(rd_pc4)
    );

    auxdec ad (
        .alu_op         (alu_op),
        .funct          (funct),
        .alu_ctrl       (alu_ctrl),
        .reg_we         (aux_we),
        .jra            (jra)
    );

endmodule