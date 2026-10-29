module alu (
        input wire clk,
        input  wire [3:0]  op,
        input  wire [31:0] a,
        input  wire [31:0] b,
        input  wire [4:0] shift_amount,
        output wire        zero,
        output reg  [63:0] y
    );

    assign zero = (y == 0);
    reg[63:0] hilo;

    always @ (*) begin
        case (op)
            4'b0000: y = a & b;
            4'b0001: y = a | b;
            4'b0010: y = a + b;
            4'b0011: y = a * b;
            4'b0100: y = hilo[31:0];
            4'b0101: y = hilo[63:32];
            4'b0110: y = a - b;
            4'b0111: y = (a < b) ? 1 : 0;
            4'b1000: y = a >> shift_amount;
            4'b1001: y = a << shift_amount;
        endcase
    end
    
    always @(posedge clk) begin
        if (op == 4'b0011)
            hilo = y;
       
    end

endmodule