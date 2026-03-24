
module acsu_radix2_notsub (
  state_in_0, 
  state_in_1, 
  branch_in_0, 
  branch_in_1,
  s0,
  state_out
  );
  
parameter STATE_BIT  = 13; 
parameter BRANCH_BIT = 10;
parameter EXT_BIT    = STATE_BIT - BRANCH_BIT;

input  [STATE_BIT-1:0]  state_in_0;
input  [STATE_BIT-1:0]  state_in_1;
input  [BRANCH_BIT-1:0] branch_in_0; 
input  [BRANCH_BIT-1:0] branch_in_1;
input                   s0;
output [STATE_BIT-1:0]  state_out;

reg    [STATE_BIT-1:0]  acs_in_00;
reg    [STATE_BIT-1:0]  acs_in_01;
reg    [STATE_BIT-1:0]  state_out;

always @ (*)
begin
   acs_in_00 = state_in_0+{{EXT_BIT{branch_in_0[BRANCH_BIT-1]}},branch_in_0};
   acs_in_01 = state_in_1+{{EXT_BIT{branch_in_1[BRANCH_BIT-1]}},branch_in_1};
    
   if (s0)
      state_out = acs_in_01;
   else
      state_out = acs_in_00;
end
endmodule

module tb_radix2not;

  reg [12:0] a, b;
  reg [9:0] c, d;
  wire [12:0]state_out;

  
  // 实例化要测试的模块
  acsu_radix2_notsub uut(
    .state_in_0(a),
    .state_in_1(b),
	.branch_in_0(c),
    .branch_in_1(d),
    .s0(1'b0),  // 设置进位输入为0或其他值
    .state_out(state_out)
	);
  
  initial begin
    // 初始化输入值
    a = 13'b0000000000001;
    b = 13'b0000000000011;
	c = 10'b0000000001;
    d = 10'b0000000011;
    
    // 等待一段时间
    #10;
    
    // 打印输入值和输出结果
    $display("Input a: %b", a);
    $display("Input b: %b", b);
    $display("Input c: %b", c);
    $display("Input d: %b", d);
	$display("state_out: %b", state_out);
    
    // 结束仿真
    $finish;
  end
  
endmodule