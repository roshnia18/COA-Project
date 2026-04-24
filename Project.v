module max_subarray #(
    parameter N = 8,
    parameter WIDTH = 16
)(
    input clk,
    input rst,
    input start,

    input [N*WIDTH-1:0] arr_flat,

    output reg signed [WIDTH-1:0] max_sum,
    output reg done
);

    // signed array storage
    reg signed [WIDTH-1:0] arr [0:N-1];

    integer i;

    reg [7:0] idx;

    reg signed [WIDTH-1:0] curr_sum;

    // unpack input safely
    always @(*) begin
        for (i = 0; i < N; i = i + 1)
            arr[i] = arr_flat[i*WIDTH +: WIDTH];
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            idx <= 0;
            curr_sum <= 0;
            max_sum <= 0;
            done <= 0;
        end

        else begin

            if (start) begin
                idx <= 1;
                curr_sum <= arr[0];
                max_sum <= arr[0];
                done <= 0;
            end

            else if (idx < N) begin

                // Kadane correct step (no pipeline lag bug)
                if (curr_sum + arr[idx] > arr[idx])
                    curr_sum <= curr_sum + arr[idx];
                else
                    curr_sum <= arr[idx];

                // IMPORTANT: use SAME expression (fixes 35 vs 36 bug)
                if ((curr_sum + arr[idx] > arr[idx] ? 
                    curr_sum + arr[idx] : arr[idx]) > max_sum)
                begin
                    max_sum <= (curr_sum + arr[idx] > arr[idx]) ?
                               (curr_sum + arr[idx]) : arr[idx];
                end

                idx <= idx + 1;

            end

            else begin
                done <= 1;
            end

        end
    end

endmodule
