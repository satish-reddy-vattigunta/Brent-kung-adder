`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:49:46 07/26/2021 
// Design Name: 
// Module Name:    ripple_carry_adder 
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
module ripple_carry_adder(input [15:0] a,b,output cout,input cin,output [15:0] sum
    );
wire [16:0] carry;
assign carry[0]=cin;
assign cout=carry[16];
genvar i;
generate
for(i=0;i<16;i=i+1) begin:ripple_gen
full_adder f1 (.sum(sum[i]),.cout(carry[i+1]),.a(a[i]),.b(b[i]),.cin(carry[i]));
end
endgenerate
endmodule

module full_adder(input a,b,input cin,output cout,sum);
assign cout=(a & b) | cin &(a | b);
assign sum=a^b^cin;
endmodule