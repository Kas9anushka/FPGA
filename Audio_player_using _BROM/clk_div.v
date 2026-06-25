`default_nettype none

module clk_div (
    input  wire clk,
    input  wire rst,
    output reg  sample_ena
);

    reg [15:0] count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count        <= 0;
            sample_ena <= 1'b0;
        end else begin
            if (count == 2267) begin
                count        <= 0;
                sample_ena <= 1'b1;
            end else begin
                count        <= count + 1;
                sample_ena <= 1'b0;
            end
        end
    end

endmodule
