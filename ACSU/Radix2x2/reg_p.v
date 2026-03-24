//+FHDR-------------------------------------------------------------------------------
// COPYRIGHT COMPANY   : (c) Graduate Institue of Electronic Engineering, 
//                           National Taiwan University (GIEEE/NTU)
// All right reserved                            
//------------------------------------------------------------------------------------
// FILE NAME           : reg_p.v
// TYPE                : First                                          
// AUTHOR              : Cheng-Hung Lin
// PROJECT	       : Mobile WiMAX
// CONTACT INFORMATION : dixson@access.ee.ntu.edu.tw                                 
//------------------------------------------------------------------------------------
// PURPOSE             : The register with positive ege trigle clock                                                      
//------------------------------------------------------------------------------------
// RELEASE VERSION     : V1.0                                                         
// VERSION DESCRIPTION : first edition no errata
// RELEASE DATE        : 02-28-2007     
//------------------------------------------------------------------------------------
// DESIGN ISSUES
// SIMULATOR         : NC-Verilog
// SYNTHESIZER       : Design Compiler
// RESET STRATEGY    : 
// CLOCK DOMIAN      :
// 
// PARAMETERS        :                                                              
// PARAMETER NAME    RANGE         DESCRIPTION                           DEFAULT VALUE
// BIT               [13]          the bit length of the state metrics   13
// RSV               [13]          the reset value                       0 
//-FHDR-------------------------------------------------------------------------------

module reg_p (
  clk,
  rset_n,
  r_in,
  r_out
  );

parameter REG_BIT  = 1;
parameter INI_VAL  = 0;

input	clk;
input	rset_n;
input 	[REG_BIT-1: 0] r_in;
output 	[REG_BIT-1: 0] r_out;

reg 	[REG_BIT-1: 0] r_out;

//register description
always@(posedge clk)
  if (!rset_n)
    r_out <= INI_VAL;
  else 
    r_out <= r_in;
endmodule