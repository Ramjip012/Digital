`timescale 1ns / 1ps
module FIR_Filter(clk, reset, data_in, data_out);
parameter N = 16;
input clk, reset;
input [N-1:0] data_in;
output reg [N-1:0] data_out; 
wire [4:0] n0 = 5'b01101; 
wire [4:0] n1 = 5'b10000; 
wire [4:0] n2 = 5'b10011; 
wire [4:0] n3 = 5'b10101;
wire [4:0] d0 = 5'b00001; 
wire [4:0] d1 = 5'b00001; 
wire [4:0] d2 = 5'b00001; 
wire [4:0] d3 = 5'b00001;
wire [N-1:0] x1, x2, x3;
  // Create delays i.e x[n-1], x[n-2], .. x[n-N]
// Instantiate D Flip Flops
DFF DFF0(clk, 0, data_in, x1); // x[n-1]
DFF DFF1(clk, 0, x1, x2); // x[n-2]
DFF DFF2(clk, 0, x2, x3); // x[n-3] 
// Multiplication
wire [N-1:0] Mul0, Mul1, Mul2, Mul3; 
assign Mul0 = data_in * n0; 
assign Mul1 = x1 * n1; 
assign Mul2 = x2 * n2; 
assign Mul3 = x3 * n3;
assign Mul4 = data_in * d0; 
assign Mul5 = x1 * d1; 
assign Mul6 = x2 * d2; 
assign Mul7 = x3 * d3;
// Addition operation
wire [N-1:0] Add_final; 
assign Add_num = Mul0 - Mul1 + Mul2 - Mul3;
assign Add_den = Mul4 + Mul5 + Mul6 + Mul7; 
assign Add_final = Add_num;
// Final calculation to output 
always@(posedge clk)
data_out <= Add_final; 
endmodule
module DFF(clk, reset, data_in, data_delayed);
parameter N = 16;
input clk, reset;
input [N-1:0] data_in;
output reg [N-1:0] data_delayed; 
always@(posedge clk, posedge reset)
begin
 if (reset)
 data_delayed <= 0;
 else
 data_delayed <= data_in; 
 end
endmodule

Filter Testbench:

`timescale 1ns / 1ps
module FIR_TB; 
parameter N = 16;
reg clk, reset;
reg [N-1:0] data_in;
reg [4:0] Address; 
reg [N-1:0] RAMM [31:0]; 
wire [N-1:0] data_out;
FIR_Filter inst0(clk, reset, data_in, data_out);
initial
begin
$readmemb("music.data", RAMM);
end
// Create the RAM
// create a clock
initial 
clk = 0;
always 
#10 clk = ~ clk; 
// Read RAMM data and give to design
always@(posedge clk)
 data_in <= RAMM[Address]; 
// Address counter
initial
Address = 1; 
always@(posedge clk)
begin
 if (Address == 31)
 Address = 0; 
 else
 Address = Address + 1; 
end 
endmodule

Input File:
$readmemb("music.data", RAMM):
RAMM [0] <= 16'b0000000001011010 ; 
RAMM [1] <= 16'b0000000100100011 ;
RAMM [2] <= 16'b0000000111100100 ;
RAMM [3] <= 16'b0000001001000111 ;
RAMM [4] <= 16'b0000001100110001 ;
RAMM [5] <= 16'b0000001110110100 ;
RAMM [6] <= 16'b0000001111110111 ; 
RAMM [7] <= 16'b0000001111111110 ;
RAMM [8] <= 16'b0000010000000000 ;
RAMM [9] <= 16'b0000001111110010 ;
RAMM [10] <= 16'b0000001111111101 ;
RAMM [11] <= 16'b0000001101100000 ;
RAMM [12] <= 16'b0000001100000010 ; 
RAMM [13] <= 16'b0000001000111000 ;
RAMM [14] <= 16'b0000000101011101 ;
RAMM [15] <= 16'b0000000011001101 ;
RAMM [16] <= 16'b1111111111001011 ;
RAMM [17] <= 16'b1111111100010110 ;
RAMM [18] <= 16'b1111111010011100 ; 
RAMM [19] <= 16'b1111110111100111 ;
RAMM [20] <= 16'b1111110100001010 ;
RAMM [21] <= 16'b1111110011001100 ;
RAMM [22] <= 16'b1111110001001110 ;
RAMM [23] <= 16'b1111110000010111 ;
RAMM [24] <= 16'b1111110000111011 ; 
RAMM [25] <= 16'b1111110001100100 ;
RAMM [26] <= 16'b1111110010011011 ;
RAMM [27] <= 16'b1111110100110100 ;
RAMM [28] <= 16'b1111110110011111 ;
RAMM [29] <= 16'b1111111000110000 ;
RAMM [30] <= 16'b1111111011110111 ;
RAMM [31] <= 16'b1111111111001000 ;
