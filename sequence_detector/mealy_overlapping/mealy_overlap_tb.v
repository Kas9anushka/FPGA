module mealy_overlap_tb();
reg seq, clk, rst;
wire dout;

mealy_overlapping uut (rst, clk, seq, dout);
initial begin clk=0;
forever #5 clk=~clk;
end
initial begin 
  seq=0;
  rst=1;
  #10 rst=0;
  #10 seq=1;
  #10 seq=0;
  #10 seq=0;
  #10 seq=1;
  #10 seq=0;
  #10 seq=0;
  #10 seq=1;
  #50 $finish;
end endmodule