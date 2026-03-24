module tb_caculate;

	reg clk, rst, en;
	reg [7:0] data;
	reg [1:0] sel;
	wire [7:0] out;

	caculate uut (
		.data(data),
		.en(en),
		.clk(clk),
		.rst(rst),
		.sel(sel),
		.out(out)
	);

	// Clock generator
	initial clk = 0;
	always #10 clk = ~clk;

	initial begin
		$dumpfile("wave.vcd");  // 如果你用 GTKWave 可以加
		$dumpvars(0, tb_caculate);

		rst = 1;
		en = 0;
		sel = 2'b00;
		data = 8'h00;
		#30;
		rst = 0;
		en = 1;

		// 連續輸入資料
		data = 8'd10; #20;
		data = 8'd20; #20;
		data = 8'd30; #20;
		data = 8'd40; #20;
		data = 8'd50; #20;
		data = 8'd60; #20;
		data = 8'd70; #20;
		data = 8'd80; #20;
		data = 8'd90; #20;
		data = 8'd100; #20;
		data = 8'd110; #20;

		// 選擇不同輸出看看效果
		sel = 2'b00; #40;
		sel = 2'b01; #40;
		sel = 2'b10; #40;
		sel = 2'b11; #40;

		#100 $finish;
	end
endmodule
