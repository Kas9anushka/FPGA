module wallac(input [7:0]a,b, output [15:0]x);

wire [63:0]p; // partial product
wire [53:1]s; //  sum output
wire [53:1]c;  // carry output
wire [15:0]z;  // carry output for last reduction (ripple carry adder)

//generating partial product

genvar i, j;
    generate
        for (i = 0; i < 8; i = i + 1) begin
            for (j = 0; j < 8; j = j + 1) begin
                assign p[i * 8 + j] = a[i] & b[j];
            end
        end
    endgenerate

//reduction level 1

half h1(p[1],p[8],s[1],c[1]);
full f1(p[2],p[9],p[16],s[2],c[2]);
full f2(p[3],p[10],p[17],s[3],c[3]);
full f3(p[4],p[11],p[18],s[4],c[4]);
half h2(p[25],p[32],s[5],c[5]);
full f4(p[5],p[12],p[19],s[6],c[6]);
full f5(p[26],p[33],p[40],s[7],c[7]);
full f6(p[6],p[13],p[20],s[8],c[8]);
full f7(p[27],p[34],p[41],s[9],c[9]);
full f8(p[7],p[14],p[21],s[10],c[10]);
full f9(p[28],p[35],p[42],s[11],c[11]);
half h3(p[15],p[22],s[12],c[12]);
full f10(p[29],p[36],p[43],s[13],c[13]);
full f11(p[30],p[37],p[44],s[14],c[14]);
full f12(p[31],p[38],p[45],s[15],c[15]);
half h4(p[39],p[46],s[16],c[16]);

// reduction level 2

half h5(c[1],s[2],s[17],c[17]);
full f13(c[2],s[3],p[24],s[18],c[18]);
full f14(c[3],s[4],s[5],s[19],c[19]);
full f15(c[4],c[5],s[6],s[20],c[20]);
full f16(c[6],c[7],s[8],s[21],c[21]);
half h6(s[9],p[48],s[22],c[22]);
full f17(c[8],c[9],s[10],s[23],c[23]);
full f18(s[11],p[49],p[56],s[24],c[24]);
full f19(s[12],s[13],c[10],s[25],c[25]);
full f20(c[11],p[50],p[57],s[26],c[26]);
full f21(c[12],c[13],s[14],s[27],c[27]);
full f22(p[23],p[51],p[58],s[28],c[28]);
full f23(s[15],p[52],p[59],s[29],c[29]);
full f24(c[15],p[53],p[60],s[30],c[30]);
full f25(p[47],p[54],p[61],s[31],c[31]);
half h7(p[55],p[62],s[32],c[32]);

// reduction level 3

half h8(c[17],s[18],s[33],c[33]);
half h9(c[18],s[19],s[34],c[34]);
full f26(c[19],s[20],s[7],s[35],c[35]);
full f27(c[20],s[21],s[22],s[36],c[36]);
full f28(c[21],c[22],s[23],s[37],c[37]);
full f29(c[23],c[24],s[25],s[38],c[38]);
full f30(c[25],c[26],s[27],s[39],c[39]);
full f31(c[27],c[28],s[29],s[40],c[40]);
half h10(c[29],s[30],s[41],c[41]);
half h11(c[16],c[30],s[42],c[42]);

// reduction level 4

half h12(c[33],s[34],s[43],c[43]);
half h13(c[34],s[35],s[44],c[44]);
half h14(c[35],s[36],s[45],c[45]);
full f32(c[36],s[37],s[24],s[46],c[46]);
full f33(c[37],s[38],s[26],s[47],c[47]);
full f34(c[38],s[39],s[28],s[48],c[48]);
full f35(c[39],s[40],c[14],s[49],c[49]);
full f36(c[40],s[41],s[16],s[50],c[50]);
full f37(c[41],s[42],s[32],s[51],c[51]);
full f38(c[42],c[32],s[33],s[52],c[52]);
half h15(c[33],p[63],s[53],c[53]);

// reduction level 5

half x0(p[0],1'b0,x[0],z[0]);
half x1(s[1],1'b0,x[1],z[1]);
half x2(s[17],1'b0,x[2],z[2]);
half x3(s[34],1'b0,x[3],z[3]);
half x4(s[43],1'b0,x[4],z[4]);
full x5(c[43],s[44],z[4],x[5],z[5]);
full x6(c[44],s[45],z[5],x[6],z[6]);
full x7(c[45],s[46],z[6],x[7],z[7]);
full x8(c[46],s[47],z[7],x[8],z[8]);
full x9(c[47],s[48],z[8],x[9],z[9]);
full x10(c[48],s[49],z[9],x[10],z[10]);
full x11(c[49],s[50],z[10],x[11],z[11]);
full x12(c[50],s[51],z[11],x[12],z[12]);
full x13(c[51],s[52],z[12],x[13],z[13]);
full x14(c[52],s[53],z[13],x[14],z[14]);
half x15(c[53],z[14],x[15],z[15]);



endmodule

// half adder
module half(input x,y, output sum,carry);
assign sum = x^y;
assign carry = x& y;
endmodule

// full adder
module full(input x,y,z, output sum,carry);
assign sum = x^y^z;
assign carry = (x&y)|(y&z)|(z&x);
endmodule
