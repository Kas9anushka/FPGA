`default_nettype none
module pwm(
    input  wire       clk,
    input  wire       rst,
    input  wire [7:0] duty,
    output reg       pwm_out
);
 reg [15:0] counter;
    always @(posedge clk or posedge rst) begin
        if (rst)begin
            counter <= 8'd0;
            pwm_out <= 'b0;
       end else begin 
            if (counter >= 1023)
                counter <= 'b0;
            else 
                counter <= counter + 1'b1;            
            if (counter < duty)
                pwm_out <= 1'b1;
            else 
                pwm_out <= 'b0;
        end   
    end
endmodule
