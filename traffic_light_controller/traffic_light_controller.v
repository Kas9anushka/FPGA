module traffic_light_controller(rst,clk,east_light,west_light,north_light,south_light);
input rst;
input clk;
output reg [2:0]east_light, west_light, north_light, south_light;

reg [2:0]state;
parameter [2:0]east=3'b000, east_yellow=3'b001, south=3'b010, south_yellow=3'b011,
west=3'b100, west_yellow=3'b101, north=3'b110, north_yellow=3'b111;

reg [4:0]count;

always @(posedge clk, posedge rst)
     begin
         if(rst)begin
            count<=5'b00000;
            state<=east;
         end 
         else begin
           case(state)
   east: begin
          if(count==5'b11101)begin // count till 30s 
             count<=5'b00000;
             state<=east_yellow;
           end else begin
              count<=count+5'b00001;
              state<=east;
           end
end
   east_yellow: begin
           if(count==5'b00100)begin // count for 5 sec
             count<=5'b00000;
             state<=south;
           end else begin
              count<=count+5'b00001;
              state<=east_yellow;
           end
end
south: begin
           if(count==5'b11101)begin
             count<=5'b00000;
             state<=south_yellow;
           end else begin
              count<=count+5'b00001;
              state<=south;
           end
end
  south_yellow: begin
           if(count==5'b00100)begin
             count<=5'b00000;
             state<=west;
           end else begin
              count<=count+5'b00001;
              state<=south_yellow;
           end
end
west: begin
          if(count==5'b11101)begin
             count<=5'b00000;
             state<=west_yellow;
           end else begin
              count<=count+5'b00001;
              state<=west;
           end
end
 west_yellow: begin
           if(count==5'b00100)begin
             count<=5'b00000;
             state<=north;
           end else begin
              count<=count+5'b00001;
              state<=west_yellow;
           end
end
north: begin
           if(count==5'b11101)begin
             count<=5'b00000;
             state<=north_yellow;
           end else begin
              count<=count+5'b00001;
              state<=north;
           end
end
   north_yellow: begin
           if(count==5'b00100)begin
             count<=5'b00000;
             state<=east;
           end else begin
              count<=count+5'b00001;
              state<=north_yellow;
           end
end
endcase
end
end
always @(*)begin
case(state)
east: begin
      east_light=3'b100;
      west_light=3'b000;
      north_light=3'b000;
      south_light=3'b000;
end
east_yellow: begin
      east_light=3'b010;
      west_light=3'b000;
      north_light=3'b000;
      south_light=3'b000;
end
south: begin
      east_light=3'b000;
      west_light=3'b000;
      north_light=3'b000;
      south_light=3'b100;
end
south_yellow: begin
      east_light=3'b000;
      west_light=3'b000;
      north_light=3'b000;
      south_light=3'b010;
end
north:begin
      east_light=3'b000;
      west_light=3'b000;
      north_light=3'b100;
      south_light=3'b000;
end
north_yellow:begin
      east_light=3'b000;
      west_light=3'b000;
      north_light=3'b010;
      south_light=3'b000;
end
west:begin
      east_light=3'b000;
      west_light=3'b100;
      north_light=3'b000;
      south_light=3'b000;
end
west_yellow:begin
      east_light=3'b000;
      west_light=3'b010;
      north_light=3'b000;
      south_light=3'b000;
end
default: begin
      east_light=3'b000;
      west_light=3'b000;
      north_light=3'b000;
      south_light=3'b000;
end
endcase
end
endmodule







