module dadda (input [7:0]a,b, output [15:0]x);

wire [63:0]p;
wire [42:1]s;
wire [42:1]c;
wire [15:0]z;

genvar i, j;
    generate
        for (i = 0; i < 8; i = i + 1) begin
            for (j = 0; j < 8; j = j + 1) begin
                assign p[i * 8 + j] = a[i] & b[j];
            end
        end
    endgenerate

// level 1 reduction

half h1(p[6],p[13],s[1],c[1]);
full f1(p[7],p[14],p[21],s[2],c[2]);
half h2(p[28],p[35],s[3],c[3]);
full f2(p[15],p[22],p[29],s[4],c[4]);
half h3(p[36],p[43],s[5],c[5]);
full f3(p[23],p[30],p[37],s[6],c[6]);

// level 2 reduction

half h4(p[4],p[11],s[7],c[7]);
full f4(p[5],p[12],p[19],s[8],c[8]);
half h5(p[26],p[33],s[9],c[9]);
full f5(s[1],p[20],p[27],s[10],c[10]);
full f6(p[34],p[41],p[48],s[11],c[11]);
full f7(c[1],s[2],s[3],s[12],c[12]);
full f8(p[42],p[49],p[56],s[13],c[13]);
full f9(c[2],c[3],s[4],s[14],c[14]);
full f10(s[5],p[50],p[57],s[15],c[15]);
full f11(c[4],c[5],s[6],s[16],c[16]);
full f12(p[44],p[51],p[58],s[17],c[17]);
full f13(p[31],p[38],c[6],s[18],c[18]);
full f14(p[45],p[52],p[59],s[19],c[19]);
full f15(p[39],p[46],p[53],s[20],c[20]);

// level 3 redution

half h6(p[3],p[10],s[21],c[21]);
full f16(s[7],p[18],p[25],s[22],c[22]);
full f17(c[7],s[8],s[9],s[23],c[23]);
full f18(c[8],c[9],s[10],s[24],c[24]);
full f19(c[10],c[11],s[12],s[25],c[25]);
full f20(c[12],c[13],s[14],s[26],c[26]);
full f21(c[14],c[15],s[16],s[27],c[27]);
full f22(c[16],c[17],s[18],s[28],c[28]);
full f23(c[18],c[19],s[20],s[29],c[29]);
full f24(c[20],p[47],p[54],s[30],c[30]);

// level 4 reduction

half h7(p[2],p[9],s[31],c[31]);
full f25(s[21],p[17],p[24],s[32],c[32]);
full f26(c[21],s[22],p[32],s[33],c[33]);
full f27(c[22],s[23],p[40],s[34],c[34]);
full f28(c[23],s[11],s[24],s[35],c[35]);
full f29(c[24],s[25],s[13],s[36],c[36]);
full f30(c[25],s[26],s[15],s[37],c[37]);
full f31(c[26],s[27],s[17],s[38],c[38]);
full f32(c[27],s[28],s[19],s[39],c[39]);
full f33(c[28],p[60],s[29],s[40],c[40]);
full f34(c[29],p[61],s[30],s[41],c[41]);
full f35(c[30],p[55],p[62],s[42],c[42]);


// level 5 reduction (ripple carry adder)

half x0(p[0],1'b0,x[0],z[0]);
full x1(p[1],p[8],z[0],x[1],z[1]);
full x2(s[31],p[16],z[1],x[2],z[2]);
full x3(c[31],s[32],z[2],x[3],z[3]);
full x4(c[32],s[33],z[3],x[4],z[4]);
full x5(c[33],s[34],z[4],x[5],z[5]);
full x6(c[34],s[35],z[5],x[6],z[6]);
full x7(c[35],s[36],z[6],x[7],z[7]);
full x8(c[36],s[37],z[7],x[8],z[8]);
full x9(c[37],s[38],z[8],x[9],z[9]);
full x10(c[38],s[39],z[9],x[10],z[10]);
full x11(c[39],s[40],z[10],x[11],z[11]);
full x12(c[40],s[41],z[11],x[12],z[12]);
full x13(c[41],s[42],z[12],x[13],z[13]);
full x14(c[42],p[63],z[13],x[14],z[14]);
assign x[15]=z[14];


endmodule

//hald adder

module half(input x, y, output sum, carry);
assign sum=x^y;
assign carry=x&y;
endmodule

// full adder

module full(input x,y,z, output sum, carry);
assign sum=x^y^z;
assign carry=(x&y)|(y&z)|(z&x);
endmodule
