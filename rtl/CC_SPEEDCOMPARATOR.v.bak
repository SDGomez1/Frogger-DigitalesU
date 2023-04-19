/*######################################################################
//#	G0B1T: HDL EXAMPLES. 2018.
//######################################################################
//# Copyright (C) 2018. F.E.Segura-Quijano (FES) fsegura@uniandes.edu.co
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
module CC_SPEEDCOMPARATOR #(parameter SPEEDCOMPARATOR_DATAWIDTH=23)(
//////////// OUTPUTS //////////
	CC_SPEEDCOMPARATOR_T0_OutLow,
//////////// INPUTS //////////
	CC_SPEEDCOMPARATOR_data_InBUS,
	CC_SPEEDCOMPARATOR_StartCount_In
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output	reg CC_SPEEDCOMPARATOR_T0_OutLow;
input 	[SPEEDCOMPARATOR_DATAWIDTH-1:0] CC_SPEEDCOMPARATOR_data_InBUS;
input 	CC_SPEEDCOMPARATOR_StartCount_In;
//=======================================================
//  REG/WIRE declarations
//=======================================================
//=======================================================
//  Structural coding
//=======================================================
always @(*)
begin
	case (CC_SPEEDCOMPARATOR_StartCount_In)
	
	0:	begin
			if( CC_SPEEDCOMPARATOR_data_InBUS == 23'b00000000000111111111111)
			CC_SPEEDCOMPARATOR_T0_OutLow = 1'b1;
			else 
			CC_SPEEDCOMPARATOR_T0_OutLow = 1'b0;
		end
	1: CC_SPEEDCOMPARATOR_T0_OutLow = 1'b1;	
	
	default: CC_SPEEDCOMPARATOR_T0_OutLow = 1'b1;	
	endcase
end

endmodule
