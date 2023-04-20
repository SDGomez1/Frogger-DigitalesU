/*######################################################################
//#	G0B1T: HDL EXAMPLES. 2018.
//######################################################################
//# 
//# This program is free software: you can redistribute it and/or modify
//# it under the terms of the GNU General Public License as published by
//# the Free Software Foundation, version 3 of the License.
//#
//# This program is distributed in the hope that it will be useful,
//# but WITHOUT ANY WARRANTY; without even the implied warranty of
//# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//# GNU General Public License for more details.
//#
//# You should have received a copy of the GNU General Public License
//# along with this program.  If not, see <http://www.gnu.org/licenses/>
//####################################################################*/
//=======================================================
//  MODULE Definition
//=======================================================
module CC_MUX3_1(
//////////// OUTPUTS //////////
	CC_MUX3_1_DataBus_Out,
//////////// INPUTS //////////
	CC_MUX3_1_Selector_In,
	CC_MUX3_1_DataBus1_In,
	CC_MUX3_1_DataBus2_In,
	CC_MUX3_1_DataBus3_In
);

//=======================================================
//  PARAMETER declarations
//=======================================================
parameter DATAWIDTH_BUS 	= 8;
//=======================================================
//  PORT declarations
//=======================================================

output reg 	[DATAWIDTH_BUS-1:0]CC_MUX3_1_DataBus_Out;

input 		[1:0]CC_MUX3_1_Selector_In;
input 		[DATAWIDTH_BUS-1:0]CC_MUX3_1_DataBus1_In;
input 		[DATAWIDTH_BUS-1:0]CC_MUX3_1_DataBus2_In;
input 		[DATAWIDTH_BUS-1:0]CC_MUX3_1_DataBus3_In;

//=======================================================
//  REG/WIRE declarations
//=======================================================


//=======================================================
//  Structural coding
//=======================================================

always @(*)begin

	if(CC_MUX3_1_Selector_In == 2'b00)
		CC_MUX3_1_DataBus_Out = CC_MUX3_1_DataBus1_In;
		
	else if (CC_MUX3_1_Selector_In == 2'b01)
		CC_MUX3_1_DataBus_Out = CC_MUX3_1_DataBus2_In;

	else if (CC_MUX3_1_Selector_In == 2'b10)
		CC_MUX3_1_DataBus_Out = CC_MUX3_1_DataBus3_In;

	else
		CC_MUX3_1_DataBus_Out = CC_MUX3_1_DataBus3_In;
		
end


endmodule 

