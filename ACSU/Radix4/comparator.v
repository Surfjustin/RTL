
module comparator(
	A,
	B,
	C,
	D,
	s1,
	s0,
	);

parameter STATE_BIT  = 13; 

input  [STATE_BIT-1:0]A;
input  [STATE_BIT-1:0]B;
input  [STATE_BIT-1:0]C;
input  [STATE_BIT-1:0]D;
output s1;
output s0;
wire   [STATE_BIT-1:0]w1;
wire   [STATE_BIT-1:0]w2;
wire   [STATE_BIT-1:0]w3;
wire   [STATE_BIT-1:0]w4;
wire   [STATE_BIT-1:0]w5;
wire   [STATE_BIT-1:0]w6;
wire   [STATE_BIT-1:0]w7;
wire   [STATE_BIT-1:0]w8;
wire   [STATE_BIT-1:0]w9;
wire   [STATE_BIT-1:0]w10;
wire   [STATE_BIT-1:0]w11;
wire   [STATE_BIT-1:0]w12;
wire    s1;
wire    s0;

assign w1  = B + ~C;
assign w2  = B + ~D;
assign w3  = C + ~D;
assign w4  = ~B + A;
assign w5  = ~C + A;
assign w6  = ~D + A;
assign w7  = w1 | w2;
assign w8  = ~w3;
assign w9  = w4 | w5 | w6;
assign w10 = ~(w7 & w8);
assign w11  = w10 & w9;
assign w12  = w7 & w9;
assign s1  = w11[STATE_BIT-1];
assign s0  = w12[STATE_BIT-1];

endmodule

module tb_comparator;

  reg [12:0] a, b, c, d;
  wire s1, s0;

  
  // 实例化要测试的模块
  comparator uut(
    .A(a),
    .B(b),
	.C(c),
    .D(d),
    .s1(s1),  // 设置进位输入为0或其他值
    .s0(s0)
	);
  
  initial begin
    // 初始化输入值
    a = 13'b1111111111111;
    b = 13'b1111111111111;
	c = 13'b1111111111111;
    d = 13'b1111111111111;
    
    // 等待一段时间
    #10;
    
    // 打印输入值和输出结果
    $display("Input a: %b", a);
    $display("Input b: %b", b);
    $display("Input c: %b", c);
    $display("Input d: %b", d);
    $display("select: %b", s1);
    $display("select: %b", s0);
    
    // 结束仿真
    $finish;
  end
  
endmodule