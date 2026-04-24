module tb;

    reg clk = 0;
    reg rst = 0;
    reg start = 0;

    parameter N = 8;
    parameter WIDTH = 16;

    reg [N*WIDTH-1:0] arr_flat;

    wire signed [WIDTH-1:0] max_sum;
    wire done;

    max_subarray #(N, WIDTH) uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .arr_flat(arr_flat),
        .max_sum(max_sum),
        .done(done)
    );

    always #5 clk = ~clk;

    task run_test;
        input [N*WIDTH-1:0] data;
        input integer test_id;
        input integer expected;
    begin

        arr_flat = data;

        rst = 1; #10;
        rst = 0;

        start = 1; #10;
        start = 0;

        wait(done);

        $display("Test%0d Output = %0d | Expected = %0d", test_id, max_sum, expected);
        $display("----------------------------------------");

        #20;
    end
    endtask

    initial begin

        // =========================
        // TEST 1: Mixed array
        // =========================
        run_test({
            16'hFFFE, // -2
            16'hFFFD, // -3
            16'h0004, // 4
            16'hFFFF, // -1
            16'hFFFE, // -2
            16'h0001, // 1
            16'h0005, // 5
            16'hFFFD  // -3
        }, 1, 7);

        // =========================
        // TEST 2: All positive
        // =========================
        run_test({
            16'd1,16'd2,16'd3,16'd4,
            16'd5,16'd6,16'd7,16'd8
        }, 2, 36);

        // =========================
        // TEST 3: All negative
        // =========================
        run_test({
            16'hFFFB, // -5
            16'hFFFF, // -1
            16'hFFF8, // -8
            16'hFFF7, // -9
            16'hFFFE, // -2
            16'hFFFD, // -3
            16'hFFFA, // -6
            16'hFFF9  // -7
        }, 3, -1);

        // =========================
        // TEST 4: Single peak
        // =========================
        run_test({
            16'hFFF6, // -10
            16'hFFFE, // -2
            16'hFFFD, // -3
            16'd50,
            16'hFFFF, // -1
            16'hFFFE, // -2
            16'hFFFD, // -3
            16'hFFFC  // -4
        }, 4, 50);

        // =========================
        // TEST 5: multiple peaks
        // =========================
        run_test({
            16'd2,
            16'hFFFF, // -1
            16'd2,
            16'd3,
            16'hFFF7, // -9
            16'd4,
            16'd5,
            16'hFFFF  // -1
        }, 5, 9);

        // =========================
        // TEST 6: zeros included
        // =========================
        run_test({
            16'hFFFF, // -1
            16'd0,
            16'hFFFE, // -2
            16'd3,
            16'd4,
            16'hFFFF, // -1
            16'd2,
            16'hFFFB  // -5
        }, 6, 8);

        $finish;
    end

endmodule