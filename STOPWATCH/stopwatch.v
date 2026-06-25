module stopwatch(
    input  wire sys_clk,
    input  wire clear,
    input  wire start,
    input  wire pause,
    input  wire increment,

    output reg [7:0] display1,display2,
    output reg [3:0] sel1,sel2
);
reg [3:0]hour;
reg [5:0]min;
reg [5:0]sec;
reg [6:0]milli;


wire [3:0] milli_one, milli_ten;
wire [3:0] sec_one, sec_ten;
wire [3:0] min_one, min_ten;
wire [3:0] hour_one, hour_ten;

 reg clk_1ms;
 reg [$clog2(50000)-1:0]clk_count;
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
reg start_d, pause_d, increment_d;

wire start_pulse     = start& ~start_d;
wire pause_pulse     = pause& ~pause_d;
wire increment_pulse = increment& ~increment_d;

always @(posedge clk_1ms or posedge clear) begin
    if(clear) begin
        start_d     <= 0;
        pause_d     <= 0;
        increment_d <= 0;
    end
    else begin
        start_d     <= start;
        pause_d     <= pause;
        increment_d <= increment;
    end
end
assign milli_one = milli%10;
assign milli_ten = milli/10;
assign sec_one = sec%10;
assign sec_ten = sec/10;
assign min_one = min%10;
assign min_ten = min/10;
assign hour_one = hour%10;
assign hour_ten = hour/10;

reg running;
always @(posedge clk_1ms or posedge clear) begin
    if(clear)
        running <= 1'b0;
    else begin
        if(start_pulse)
            running <= 1'b1;
        else if(pause_pulse)
            running <= 1'b0;
    end
end           
always @(posedge clk_1ms or posedge clear)begin
if(clear)begin
    hour<=4'b0;
    min<=6'b0;
    sec<=6'b0;
    milli<=7'b0;
end
else begin
if(running == 1)begin
               if(milli==99)begin
                   milli<=0;
                   if(sec == 59)begin
                      sec<=0;
                      if(min ==59)begin
                         min<=0;
                         if(hour == 11)
                           hour<=0;
                         else
                           hour<=hour+1;
                      end else 
                         min<=min+1;
                   end else 
                      sec<=sec+1;       
               end else 
                   milli<=milli+1;
end else if(pause_pulse==1)begin
           milli<=milli;
           sec<=sec;
           min<=min;
           hour<=hour;
end else if(increment_pulse==1)begin
             if(milli==99)begin
                   milli<=0;
                   if(sec == 59)begin
                      sec<=0;
                      if(min ==59)begin
                         min<=0;
                         if(hour == 11)
                           hour<=0;
                         else
                           hour<=hour+1;
                      end else 
                         min<=min+1;
                   end else 
                      sec<=sec+1;       
               end else 
                   milli<=milli+1;       
end else begin
    milli <= milli;
    sec   <= sec;
    min   <= min;
    hour  <= hour;
end
  end      
  end
 
reg [7:0] segment [0:9];
reg [1:0]flag1=0;
reg [1:0]flag2=0;
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
     display1 <= segment[milli_one];
     flag1 <= 1;
   end
   1: begin
     sel1 <= 4'hD;           
     display1 <= segment[milli_ten];
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
                 
                 
             
             
   
