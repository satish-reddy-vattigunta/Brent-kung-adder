`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:25:14 07/25/2021 
// Design Name: 
// Module Name:    Brent_kung_adder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Brent_kung_adder(
    input [15:0] a,
    input [15:0] b,
    output Cout,
    input Cin,
    output [15:0] sum
    );

reg [15:0] gen_fo,prop_fo; //first order generation,propagation
reg [7:0] gen_so,prop_so;//second order
reg [3:0] gen_to,prop_to;//third order
reg [1:0] gen_foro,prop_foro;//fourth order
reg gen_fifo,prop_fifo;//fifth order
wire [16:0] Carry;
integer i,j,k,l;
always@*
begin
for (i=0;i<16;i=i+1) begin
gen_fo[i]=a[i]& b[i];
prop_fo[i]=a[i] ^ b[i];
end
end

always@*
begin
for (j=0;j<8;j=j+1)
begin
//j=i%2;
gen_so[j]=gen_fo[2*j+1] | (prop_fo[2*j+1] & gen_fo[2*j]);
prop_so[j]=prop_fo[2*j+1] & prop_fo[2*j];
end
end


always@*
begin
for (k=0;k<4;k=k+1)
begin
//j=i%4;
gen_to[k]=gen_so[2*k+1] | (prop_so[2*k+1] & gen_so[2*k]);
prop_to[k]=prop_so[2*k+1] & prop_so[2*k];
end
end


always@*
begin
for (l=0;l<2;l=l+1)
begin
//j=i%8;
gen_foro[l]=gen_to[2*l+1] | (prop_to[2*l+1] & gen_to[2*l]);
prop_foro[l]=prop_to[2*l+1] & prop_to[2*l];
end
end

always@*
begin
 gen_fifo=gen_foro[1] | (prop_foro[1] & gen_foro[0]);
 prop_fifo=prop_foro[1] & prop_foro[0];
end
assign Carry[0] = Cin;

//first computation
assign Carry[1] = gen_fo[0] | (prop_fo[0]&Carry[0]);

assign Carry[2] = gen_so[0] | (prop_so[0]&Carry[0]);

assign Carry[4] = gen_to[0] | (prop_to[0]&Carry[0]);

assign Carry[8] = gen_foro[0] | (prop_foro[0]&Carry[0]);

assign Carry[16] = gen_fifo | (prop_fifo&Carry[0]);


//second computation
assign Carry[3] = gen_fo[2] | (prop_fo[2]&Carry[2]);

assign Carry[5] = gen_fo[4] | (prop_fo[4]&Carry[4]);

assign Carry[9] = gen_fo[8] | (prop_fo[8]&Carry[8]);

assign Carry[6] = gen_so[2] | (prop_so[2]&Carry[4]);

assign Carry[10] = gen_so[4] | (prop_so[4]&Carry[8]);

assign Carry[12] = gen_to[2] | (prop_to[2]&Carry[8]);


//third computation
assign Carry[7] = gen_fo[6] | (prop_fo[6]&Carry[6]);

assign Carry[11] = gen_fo[10] | (prop_fo[10]&Carry[10]);

assign Carry[13] = gen_fo[12] | (prop_fo[12]&Carry[12]);

assign Carry[14] = gen_so[6] | (prop_so[6]&Carry[12]);

//fourth computation
assign Carry[15] = gen_fo[14] | (prop_fo[14]&Carry[14]);


assign sum[15:0] = prop_fo[15:0] ^ Carry[15:0];

assign Cout=Carry[16];


endmodule
