//+FHDR-------------------------------------------------------------------------------
// COPYRIGHT COMPANY   : (c) Graduate Institue of Electronic Engineering, 
//                           National Taiwan University (GIEEE/NTU)
// All right reserved                            
//------------------------------------------------------------------------------------
// FILE NAME           : acsu_radix2.v
// TYPE                : Second                                          
// AUTHOR              : Cheng-Hung Lin
// PROJECT		     : Mobile WiMAX
// CONTACT INFORMATION : dixson@access.ee.ntu.edu.tw                                 
//------------------------------------------------------------------------------------
// PURPOSE             : The Radx-2 ACSU with comparison output                                                        
//------------------------------------------------------------------------------------
// RELEASE VERSION     : V1.0                                                         
// VERSION DESCRIPTION : first edition no errata
// RELEASE DATE        : 01-19-2007     
//------------------------------------------------------------------------------------
// DESIGN ISSUES
// SIMULATOR         : NC-Verilog
// SYNTHESIZER       : Design Compiler
// RESET STRATEGY    : 
// CLOCK DOMIAN      :
// 
// PARAMETERS        :                                                              
// PARAMETER NAME    RANGE         DESCRIPTION                           DEFAULT VALUE
// STATE_BIT         [13]          the bit length of the state metrics   13
// BRANCH_BIT        [10]          the bit length of the branch metrics  10
// EXT_BIT           []            the bit length of the extend bits     STATE_BIT - BRANCH_BIT
//-FHDR-------------------------------------------------------------------------------

module acsu_radix2 (
  state_in_0, 
  state_in_1, 
  branch_in_0, 
  branch_in_1, 
  state_out
  );
  
parameter STATE_BIT  = 13; 
parameter BRANCH_BIT = 10;
parameter EXT_BIT    = STATE_BIT - BRANCH_BIT;

input  [STATE_BIT-1:0]  state_in_0;
input  [STATE_BIT-1:0]  state_in_1;
input  [BRANCH_BIT-1:0] branch_in_0; 
input  [BRANCH_BIT-1:0] branch_in_1;
output [STATE_BIT-1:0]  state_out;

reg    [STATE_BIT-1:0]  acs_in_00;
reg    [STATE_BIT-1:0]  acs_in_01;
reg                     s0;
reg    [STATE_BIT-1:0]  difference_0;
reg    [STATE_BIT-1:0]  state_out;

always @ (*)
begin
   acs_in_00 = state_in_0+{{EXT_BIT{branch_in_0[BRANCH_BIT-1]}},branch_in_0};
   acs_in_01 = state_in_1+{{EXT_BIT{branch_in_1[BRANCH_BIT-1]}},branch_in_1};
   
   difference_0 = acs_in_00 - acs_in_01;
   
   s0 = difference_0[STATE_BIT-1];
    
   if (s0)
      state_out = acs_in_01;
   else
      state_out = acs_in_00;
end
endmodule
