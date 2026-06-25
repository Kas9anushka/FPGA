`default_nettype none

module top (
    input  wire clk,
    input  wire rst,
    output wire pwm_out
);
 wire [$clog2(200000)-1:0] addr;
 wire [7:0]dout;
 wire sample_ena;

clk_div u1 (.clk(clk),.rst(rst),.sample_ena(sample_ena));
address_generator u2(.clk(clk),.rst(rst),.addr(addr),.sample_ena(sample_ena));
blk_mem_gen_0 bram0 (.clka(clk),.ena(1'b1), .addra(addr), .douta(dout));
pwm u4 (.clk(clk),.rst(rst),.duty(dout),.pwm_out(pwm_out));

endmodule
