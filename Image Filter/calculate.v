module caculate (
	input [7:0] data,
	input en,
	input clk,
	input rst,
	input [1:0] sel,
	output reg [7:0] out
);

wire [7:0] w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11;
reg [7:0] A, B, C, D;

	flip_flop f1  (.clk(clk), .rst(rst), .d(data), .en(en), .q(w1));
	flip_flop f2  (.clk(clk), .rst(rst), .d(w1), .en(en), .q(w2));
	flip_flop f3  (.clk(clk), .rst(rst), .d(w2), .en(en), .q(w3));
	flip_flop f4  (.clk(clk), .rst(rst), .d(w3), .en(en), .q(w4));
	flip_flop f5  (.clk(clk), .rst(rst), .d(w4), .en(en), .q(w5));
	flip_flop f6  (.clk(clk), .rst(rst), .d(w5), .en(en), .q(w6));
	flip_flop f7  (.clk(clk), .rst(rst), .d(w6), .en(en), .q(w7));
	flip_flop f8  (.clk(clk), .rst(rst), .d(w7), .en(en), .q(w8));
	flip_flop f9  (.clk(clk), .rst(rst), .d(w8), .en(en), .q(w9));
	flip_flop f10 (.clk(clk), .rst(rst), .d(w9), .en(en), .q(w10));
	flip_flop f11 (.clk(clk), .rst(rst), .d(w10), .en(en), .q(w11));

always @(posedge clk) begin
	A = w1;
	B = w2;
	C = w11;
	D = (B + C) >> 1;
end

always @ (*) begin
	case(sel)
		2'b00: out = A;
		2'b01: out = B;
		2'b10: out = C;
		2'b11: out = D;
	endcase
end
endmodule