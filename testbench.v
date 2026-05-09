`timescale 1ns/1ps

module tb_cpu_4bit;

    reg clk;
    reg rst;

    reg load_A;
    reg load_B;
    reg add_enable;

    reg [3:0] data_in;

    wire [3:0] data_out;

    cpu_4bit uut (
        .clk(clk),
        .rst(rst),
        .load_A(load_A),
        .load_B(load_B),
        .add_enable(add_enable),
        .data_in(data_in),
        .data_out(data_out)
    );

    // clock generation
    always #5 clk = ~clk;

    initial begin
        $dumpfile("cpu.vcd");
        $dumpvars(0, tb_cpu_4bit);

        clk = 0;
        rst = 1;
        load_A = 0;
        load_B = 0;
        add_enable = 0;
        data_in = 0;

        #10 rst = 0;

        // Load A = 3
        #10 data_in = 4'd3;
            load_A = 1;
        #10 load_A = 0;

        // Load B = 5
        #10 data_in = 4'd5;
            load_B = 1;
        #10 load_B = 0;

        // Add A + B → A
        #10 add_enable = 1;
        #10 add_enable = 0;

        // observe result
        #20;

        $finish;
    end

endmodule