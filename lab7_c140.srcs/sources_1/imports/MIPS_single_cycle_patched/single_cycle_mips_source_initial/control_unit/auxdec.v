module auxdec (
        input  wire [1:0] alu_op,
        input  wire [5:0] funct,
        output wire [3:0] alu_ctrl,
        output wire reg_we,
        output  wire        jra
    );

    reg [5:0] ctrl;

    assign {alu_ctrl, jra, reg_we} = ctrl;

    always @ (alu_op, funct) begin
        case (alu_op)
            2'b00: ctrl = 'b0010_0_1;          // ADD
            2'b01: ctrl = 'b0110_0_1;          // SUB
            default: case (funct)
                6'b10_0100: ctrl = 'b0000_0_1; // AND
                6'b10_0101: ctrl = 'b0001_0_1; // OR
                6'b10_0000: ctrl = 'b0010_0_1; // ADD
                6'b10_0010: ctrl = 'b0110_0_1; // SUB
                6'b10_1010: ctrl = 'b0111_0_1; // SLT
                6'b01_1001: ctrl = 'b0011_0_0; // MULTU
                6'b01_0000: ctrl = 'b0101_0_1; // MFHI
                6'b01_0010: ctrl = 'b0100_0_1; // MFLO
                6'b00_0000: ctrl = 'b1001_0_1; // SLL
                6'b00_0010: ctrl = 'b1000_0_1; // SRL
                6'b00_1000: ctrl = 'b0000_1_0; // JR
                default:    ctrl = 'bxxxx_x_x;
            endcase
        endcase
    end

endmodule