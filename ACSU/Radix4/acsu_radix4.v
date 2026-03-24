//+FHDR-------------------------------------------------------------------------------
// FILE NAME           : acsu_radix4.v
// AUTHOR              : 
// STUDENT ID          : 
// E-MAIL              :   
//------------------------------------------------------------------------------------
// PURPOSE             :                                                         
//------------------------------------------------------------------------------------
// RELEASE VERSION     :                                                          
// VERSION DESCRIPTION : 
// RELEASE DATE        :      
//------------------------------------------------------------------------------------
// DESIGN ISSUES
// SIMULATOR         : 
// SYNTHESIZER       : 
// RESET STRATEGY    : 
// CLOCK DOMIAN      :
// 
// PARAMETERS        :                                                              
// PARAMETER NAME    RANGE         DESCRIPTION                           DEFAULT VALUE
//-FHDR-------------------------------------------------------------------------------

module acsu_radix4 (
  state_in_0, 
  state_in_1, 
  state_in_2, 
  state_in_3, 
  branch_in_0, 
  branch_in_1, 
  branch_in_2, 
  branch_in_3, 
  state_out
  );

parameter STATE_BIT  = 13; 
parameter BRANCH_BIT = 10;
parameter EXT_BIT    = STATE_BIT - BRANCH_BIT;

input  [STATE_BIT-1:0]  state_in_0;
input  [STATE_BIT-1:0]  state_in_1;
input  [STATE_BIT-1:0]  state_in_2;
input  [STATE_BIT-1:0]  state_in_3;
input  [BRANCH_BIT-1:0] branch_in_0; 
input  [BRANCH_BIT-1:0] branch_in_1;
input  [BRANCH_BIT-1:0] branch_in_2;
input  [BRANCH_BIT-1:0] branch_in_3;
output [STATE_BIT-1:0]  state_out;

wire    [STATE_BIT-1 :0] mux0_out;
wire    [STATE_BIT-1 :0] mux1_out;
wire     				com_s1;
wire     				com_s0;
reg    [STATE_BIT-1 :0] state_out;
reg                     s0;
reg    [STATE_BIT-1:0]  acs_in_00;
reg    [STATE_BIT-1:0]  acs_in_01;
reg    [STATE_BIT-1:0]  acs_in_02;
reg    [STATE_BIT-1:0]  acs_in_03;

acsu_radix2_notsub acs_radix21(
	.state_in_0(state_in_0),
	.state_in_1(state_in_1),
	.branch_in_0(branch_in_0),
	.branch_in_1(branch_in_1),
	.s0(com_s1),
	.state_out(mux0_out)
	);

acsu_radix2_notsub acs_radix22(
	.state_in_0(state_in_2),
	.state_in_1(state_in_3),
	.branch_in_0(branch_in_2),
	.branch_in_1(branch_in_3),
	.s0(com_s1),
	.state_out(mux1_out)
	);

comparator com1(
	.A(acs_in_00),
	.B(acs_in_01),
	.C(acs_in_02),
	.D(acs_in_03),
	.s1(com_s1),
	.s0(com_s0)
	);
	
always @(*)
begin
	acs_in_00 = state_in_0+{{EXT_BIT{branch_in_0[BRANCH_BIT-1]}},branch_in_0};
	acs_in_01 = state_in_1+{{EXT_BIT{branch_in_1[BRANCH_BIT-1]}},branch_in_1};
	acs_in_02 = state_in_2+{{EXT_BIT{branch_in_2[BRANCH_BIT-1]}},branch_in_2};
	acs_in_03 = state_in_3+{{EXT_BIT{branch_in_3[BRANCH_BIT-1]}},branch_in_3};
	
	if (com_s0)
		state_out = mux1_out;
	else
		state_out = mux0_out;
end
endmodule