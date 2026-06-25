`default_nettype none
module school_bell(
input wire sys_clk,
input wire clear,
input wire enable,
input wire manual_ring_btn,
output reg bell_led,
output reg [7:0] display1, display2,
output reg [3:0]sel1,sel2);

reg [3:0] hour;
reg [5:0] min;
reg [5:0] sec;
reg am_pm;

wire [3:0] sec_one, sec_ten;
wire [3:0] min_one, min_ten;
wire [3:0] hour_one, hour_ten;

reg [$clog2(50_000)-1:0] clk_count;
reg clk_1ms;
 always @(posedge sys_clk or posedge clear)begin
    if(clear)begin
     clk_1ms<=0;
     clk_count<=0;
   end else begin
     if(clk_count == 49999)begin
     clk_1ms <= ~clk_1ms;
     clk_count<=0;
     end else begin
       clk_count<=clk_count+1;
     end
     end
   end      
  
assign sec_one  = sec  % 10;
assign sec_ten  = sec  / 10;
assign min_one  = min  % 10;
assign min_ten  = min  / 10;
assign hour_one = hour % 10;
assign hour_ten = hour / 10;

always @(posedge clk_1ms or posedge clear) begin
    if (clear) begin
        hour  <= 4'd12;
        min   <= 6'd0;
        sec   <= 6'd0;
        am_pm <= 1'b0;
    end else if (enable) begin
        if (sec == 59) begin
            sec <= 0;
            if (min == 59) begin
                min <= 0;
                if (hour == 4'd12) begin                   
                    hour  <= 4'd1;
                 end else if(hour == 4'd11)begin
                      hour <=hour +1;
                      am_pm <=~am_pm;                                      
                end else begin
                    hour <= hour + 1;
                end
            end else begin
                min <= min + 1;
            end
        end else begin
            sec <= sec + 1;
        end
    end  
end 
 reg [$clog2(600)-1:0]count;
 always @(posedge clk_1ms or posedge clear)begin
 if(clear)begin
   count <=0;
 end else begin
    if(count ==599)begin
       count<=0;
     end else begin
       count <=count+1;
     end
  end
end             
   
  
always @(*)begin
if(enable &~clear)begin
if(manual_ring_btn)begin
  bell_led =1'b1;
end
else begin
case({hour,min,sec,am_pm})
{4'd09,6'd00,6'd00,1'b0} : begin if(count == 599)bell_led =1'b0; else bell_led = 1'b1; end
{4'd09,6'd45,6'd00,1'b0} : begin if(count == 599)bell_led =1'b0; else bell_led = 1'b1; end
{4'd10,6'd30,6'd00,1'b0} : begin if(count == 599)bell_led =1'b0; else bell_led = 1'b1; end
{4'd11,6'd15,6'd00,1'b0} : begin if(count == 599)bell_led =1'b0; else bell_led = 1'b1; end
{4'd11,6'd30,6'd00,1'b0} : begin if(count == 599)bell_led =1'b0; else bell_led = 1'b1; end
{4'd12,6'd15,6'd00,1'b1} : begin if(count == 599)bell_led =1'b0; else bell_led = 1'b1; end
{4'd01,6'd00,6'd00,1'b1} : begin if(count == 599)bell_led =1'b0; else bell_led = 1'b1; end
{4'd01,6'd45,6'd00,1'b1} : begin if(count == 599)bell_led =1'b0; else bell_led = 1'b1; end
{4'd02,6'd15,6'd00,1'b1} : begin if(count == 599)bell_led =1'b0; else bell_led = 1'b1; end
{4'd03,6'd00,6'd00,1'b1} : begin if(count == 599)bell_led =1'b0; else bell_led = 1'b1; end
default: bell_led = 1'b0;
endcase
end
end else bell_led = 1'b0;
end

  

reg [1:0]flag1=0;
reg [1:0]flag2=0;
reg [7:0] segment [0:9];
always @(posedge clk_1ms) begin
 segment[0] <= 8'hC0;
 segment[1] <= 8'hF9;
 segment[2] <= 8'hA4;
 segment[3] <= 8'hB0;
 segment[4] <= 8'h99;
 segment[5] <= 8'h92;
 segment[6] <= 8'h82;
 segment[7] <= 8'hF8;
 segment[8] <= 8'h80;
 segment[9] <= 8'h90;
end
always @(posedge clk_1ms or posedge clear)begin
 if(clear)begin
  display1<=8'hC0;
    sel1 <=4'hE;
    end else begin
   case (flag1) 
   0: begin
     sel1 <= 4'hE;        
     display1 <= segment[am_pm];
     flag1 <= 1;
   end
   1: begin
     sel1 <= 4'hf;           
     display1 <= segment[0];
     flag1 <= 2;
   end
   2: begin
     sel1 <= 4'hB;          
     display1 <= segment[sec_one];
     flag1 <= 3;
   end 
   3: begin
     sel1 <= 4'h7;          
     display1 <= segment[sec_ten] & 8'h7F;
     flag1 <= 0;
   end 
  endcase
  end
end
always @(posedge clk_1ms or posedge clear)begin
 if(clear)begin
    display2<=8'hC0;
    sel2 <=4'hE;
    end else begin
   case (flag2) 
   0: begin
     sel2 <= 4'hE;        
     display2 <= segment[min_one];
     flag2 <= 1;
   end
   1: begin
     sel2 <= 4'hD;           
     display2 <= segment[min_ten];
     flag2 <= 2;
   end
   2: begin
     sel2 <= 4'hB;          
     display2 <= segment[hour_one];
     flag2 <= 3;
   end 
   3: begin
     sel2 <= 4'h7;          
     display2 <= segment[hour_ten] & 8'h7F;
     flag2 <= 0;
   end 
  endcase
  end
end  


endmodule
