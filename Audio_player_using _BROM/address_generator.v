`default_nettype none
module address_generator(
input wire clk,
input wire rst,
input wire sample_ena,
output reg [$clog2(200000)-1:0]addr
);
always @(posedge clk or posedge rst) begin
    if (rst)
        addr <= 0;
    else if (sample_ena) 
        begin
            if (addr == 199999)
                addr <= 0;
            else
                addr <= addr + 1;
        end
    else addr <=addr;    
end
endmodule
