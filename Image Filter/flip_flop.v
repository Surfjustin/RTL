module flip_flop (
	input clk,
	input rst,
	input wire [7:0] d,
	input en,
	output reg [7:0] q
);

always @ (posedge clk) begin
	if(rst)
		q <= 0;
	else if (en)
		q <= d;
end
endmodule