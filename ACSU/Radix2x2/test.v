`timescale 1 ns/10 ps

module test();

parameter STATE_BIT  = 13; 
parameter BRANCH_BIT = 10;

reg                       clk;
reg                       rset_n;

reg  [STATE_BIT-1: 0]     state_in_0; 
reg  [STATE_BIT-1: 0]     state_in_1; 
reg  [STATE_BIT-1: 0]     state_in_2; 
reg  [STATE_BIT-1: 0]     state_in_3; 
reg  [BRANCH_BIT-1: 0]    branch_in_0; 
reg  [BRANCH_BIT-1: 0]    branch_in_1; 
reg  [BRANCH_BIT-1: 0]    branch_in_2; 
reg  [BRANCH_BIT-1: 0]    branch_in_3; 

wire [STATE_BIT-1: 0] state_out;
	
se_acsu #(STATE_BIT, BRANCH_BIT) testtop(
  .clk(clk),
  .rset_n(rset_n),
  .state_in_0(state_in_0), 
  .state_in_1(state_in_1), 
  .state_in_2(state_in_2), 
  .state_in_3(state_in_3), 
  .branch_in_0(branch_in_0), 
  .branch_in_1(branch_in_1), 
  .branch_in_2(branch_in_2), 
  .branch_in_3(branch_in_3), 
  .state_out(state_out)
  );

always begin
#5 clk=~clk;
end

initial begin

rset_n = 0; clk = 0; state_in_0 = 0; state_in_1 =0; state_in_2 = 0; state_in_3 = 0; branch_in_0 = 0; branch_in_1 =0; branch_in_2 = 0; branch_in_3 = 0; //state_out = 0
#28 rset_n = 1; //state_out = 0
#10 state_in_0 = -4000; state_in_1 = 1; state_in_2 = -159; state_in_3 = 456; branch_in_0 = 511; branch_in_1 = 13; branch_in_2 = 486; branch_in_3 = -3; //state_out = 453
#10 state_in_0 = 153; state_in_1 = -984; state_in_2 = 688; state_in_3 = -247; branch_in_0 = 466; branch_in_1 = 355; branch_in_2 = 46; branch_in_3 = -78; //state_out = 734
#10 state_in_0 = -999; state_in_1 = -456; state_in_2 = -789; state_in_3 = -2099; branch_in_0 = -64; branch_in_1 = -123; branch_in_2 = 321; branch_in_3 = 78; //state_out = -468     
#10 state_in_0 = 1234; state_in_1 = 2345; state_in_2 = -2; state_in_3 = 0; branch_in_0 = -9; branch_in_1 = 84; branch_in_2 = 124; branch_in_3 = -321; //state_out = 2429
#10 state_in_0 = 777; state_in_1 = 888; state_in_2 = 1234; state_in_3 = -4000; branch_in_0 = -5; branch_in_1 = -64; branch_in_2 = -98; branch_in_3 = 35; //state_out = -3965
#10 state_in_0 = -2; state_in_1 = -3; state_in_2 = -4; state_in_3 = -5; branch_in_0 = -5; branch_in_1 = -6; branch_in_2 = -7; branch_in_3 = -8; //state_out = -7
#20

$finish;
end
initial
begin
//$fsdbDumpfile("TEST.fsdb");
//$fsdbDumpvars;
$dumpfile("TESTVG.vcd");
$dumpvars;
//$sdf_annotate("XXX.sdf", testtop);
end 
endmodule
