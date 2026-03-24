//+FHDR-------------------------------------------------------------------------------
// FILE NAME           : se_acsu.v                                        
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
// STATE_BIT         [13]          the bit length of the state metrics   13                    
// BRANCH_BIT        [10]          the bit length of the branch metrics  10                    
//-FHDR-------------------------------------------------------------------------------

module se_acsu (
  clk,
  rset_n,
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

input                   clk;
input                   rset_n;
input  [STATE_BIT-1:0]  state_in_0;
input  [STATE_BIT-1:0]  state_in_1;
input  [STATE_BIT-1:0]  state_in_2;
input  [STATE_BIT-1:0]  state_in_3;
input  [BRANCH_BIT-1:0] branch_in_0; 
input  [BRANCH_BIT-1:0] branch_in_1;
input  [BRANCH_BIT-1:0] branch_in_2;
input  [BRANCH_BIT-1:0] branch_in_3;
output [STATE_BIT-1:0]  state_out;

wire [BRANCH_BIT-1: 0]   branch_reg_0;
wire [BRANCH_BIT-1: 0]   branch_reg_1;
wire [BRANCH_BIT-1: 0]   branch_reg_2;
wire [BRANCH_BIT-1: 0]   branch_reg_3;
wire [STATE_BIT-1: 0]    state_reg_0;
wire [STATE_BIT-1: 0]    state_reg_1;
wire [STATE_BIT-1: 0]    state_reg_2;
wire [STATE_BIT-1: 0]    state_reg_3;
wire [STATE_BIT-1: 0]    state_reg_in;

reg_p #(STATE_BIT) u_reg_si0(.clk(clk), .rset_n(rset_n), .r_in(state_in_0), .r_out(state_reg_0));
reg_p #(STATE_BIT) u_reg_si1(.clk(clk), .rset_n(rset_n), .r_in(state_in_1), .r_out(state_reg_1));
reg_p #(STATE_BIT) u_reg_si2(.clk(clk), .rset_n(rset_n), .r_in(state_in_2), .r_out(state_reg_2));
reg_p #(STATE_BIT) u_reg_si3(.clk(clk), .rset_n(rset_n), .r_in(state_in_3), .r_out(state_reg_3));
reg_p #(BRANCH_BIT) u_reg_bi0(.clk(clk), .rset_n(rset_n), .r_in(branch_in_0), .r_out(branch_reg_0));
reg_p #(BRANCH_BIT) u_reg_bi1(.clk(clk), .rset_n(rset_n), .r_in(branch_in_1), .r_out(branch_reg_1));
reg_p #(BRANCH_BIT) u_reg_bi2(.clk(clk), .rset_n(rset_n), .r_in(branch_in_2), .r_out(branch_reg_2));
reg_p #(BRANCH_BIT) u_reg_bi3(.clk(clk), .rset_n(rset_n), .r_in(branch_in_3), .r_out(branch_reg_3));

acsu_radix4 #(STATE_BIT, BRANCH_BIT) u_acs_radix4_0(
  .state_in_0(state_reg_0),
  .state_in_1(state_reg_1),
  .state_in_2(state_reg_2),
  .state_in_3(state_reg_3),
  .branch_in_0(branch_reg_0),
  .branch_in_1(branch_reg_1),
  .branch_in_2(branch_reg_2),
  .branch_in_3(branch_reg_3),
  .state_out(state_reg_in));

reg_p #(STATE_BIT) u_reg_so(.clk(clk), .rset_n(rset_n), .r_in(state_reg_in), .r_out(state_out));  

endmodule