module top(
	input clk,
	input rst,
	input en,
	input [7:0] data,
	output reg output_en,
	output reg [7:0] out_z
);

wire [1:0] w1;
wire [7:0] w2;
wire w3;

FSM f1 (.clk(clk), .rst(rst), .en(en), .output_en(w3), .z(w1));

caculate c1 (.data(data), .en(en), .clk(clk), .rst(rst), .sel(w1), .out(w2));

always @ (*) begin
	output_en = w3;
end

always @ (*) begin
	if (!output_en)
		out_z = 0;
	else
		out_z = w2;
end

endmodule