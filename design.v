module cpu_4bit (
    input clk,
    input rst,

    input load_A,
    input load_B,
    input add_enable,

    input [3:0] data_in,
    output reg [3:0] data_out
);

    reg [3:0] A;
    reg [3:0] B;

    wire [3:0] sum;

    assign sum = A + B;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            A <= 4'b0000;
            B <= 4'b0000;
            data_out <= 4'b0000;
        end else begin

            // Load A
            if (load_A)
                A <= data_in;

            // Load B
            if (load_B)
                B <= data_in;

            // Add and store in A
            if (add_enable)
                A <= sum;

            // output always reflects A
            data_out <= A;

        end
    end

endmodule
