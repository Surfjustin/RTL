//+FHDR-------------------------------------------------------------------------------
// FILE NAME           : acsu_radix22.v
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


module acsu_radix22 (
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
reg    [STATE_BIT-1 :0] difference_0;
reg    [STATE_BIT-1 :0] state_out;
reg                     s0;

acsu_radix2 acs_radix2_1(
	.state_in_0(state_in_0),
	.state_in_1(state_in_1),
	.branch_in_0(branch_in_0),
	.branch_in_1(branch_in_1),
	.state_out(mux0_out)
	);
acsu_radix2 acs_radix2_2(
	.state_in_0(state_in_2),
	.state_in_1(state_in_3),
	.branch_in_0(branch_in_2),
	.branch_in_1(branch_in_3),
	.state_out(mux1_out)
	);

always@(*)
begin
	difference_0 = mux0_out - mux1_out;
	
	s0 = difference_0[STATE_BIT-1];
	
	if (s0)
		state_out = mux1_out;
	else
		state_out = mux0_out;
end



endmodule