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

module CC_LEVEL_DATAHANDLER (
//////////// OUTPUTS //////////
	CC_LEVEL_DATAHANDLER_LevelData_OutBus,
		
//////////// INPUTS //////////
	CC_LEVEL_DATAHANDLER_LvlProgress,
	CC_LEVEL_DATAHANDLER_CurrentLvl

);

//=======================================================
//  PARAMETER declarations
//=======================================================

parameter LEVEL_DATAHANDLER_DATAWIDTH 			= 8;
parameter CURRENTLEVEL_DATAWIDTH					= 3;
parameter LEVELPROGRESS_DATAWIDTH				= 5;


//LEVEL 1
parameter DATALVL1_COUNT0 		= 8'b00000000;
parameter DATALVL1_COUNT1 		= 8'b10010000;
parameter DATALVL1_COUNT2		= 8'b01000000;
parameter DATALVL1_COUNT3 		= 8'b11000000;
parameter DATALVL1_COUNT4 		= 8'b11010000;
parameter DATALVL1_COUNT5 		= 8'b01010000;
parameter DATALVL1_COUNT6 		= 8'b00110000;
parameter DATALVL1_COUNT7 		= 8'b10100000;
parameter DATALVL1_COUNT8 		= 8'b01110000;
parameter DATALVL1_COUNT9 		= 8'b10010000;
parameter DATALVL1_COUNT10		= 8'b10110000;
parameter DATALVL1_COUNT11 	= 8'b01010000;
parameter DATALVL1_COUNT12 	= 8'b11010000;

//LEVEL 2
parameter DATALVL2_COUNT0 		= 8'b11010000;
parameter DATALVL2_COUNT1 		= 8'b11010000;
parameter DATALVL2_COUNT2		= 8'b01100000;
parameter DATALVL2_COUNT3 		= 8'b11010000;
parameter DATALVL2_COUNT4 		= 8'b01010000;
parameter DATALVL2_COUNT5 		= 8'b01010000;
parameter DATALVL2_COUNT6 		= 8'b00110000;
parameter DATALVL2_COUNT7 		= 8'b10100000;
parameter DATALVL2_COUNT8 		= 8'b01110000;
parameter DATALVL2_COUNT9 		= 8'b10010000;
parameter DATALVL2_COUNT10		= 8'b10110000;
parameter DATALVL2_COUNT11 	= 8'b01010000;
parameter DATALVL2_COUNT12 	= 8'b11010000;


//LEVEL 3
parameter DATALVL3_COUNT0 		= 8'b01010000;
parameter DATALVL3_COUNT1 		= 8'b10010000;
parameter DATALVL3_COUNT2		= 8'b01000000;
parameter DATALVL3_COUNT3 		= 8'b11000000;
parameter DATALVL3_COUNT4 		= 8'b11010000;
parameter DATALVL3_COUNT5 		= 8'b01010000;
parameter DATALVL3_COUNT6 		= 8'b00110000;
parameter DATALVL3_COUNT7 		= 8'b10100000;
parameter DATALVL3_COUNT8 		= 8'b01110000;
parameter DATALVL3_COUNT9 		= 8'b10010000;
parameter DATALVL3_COUNT10		= 8'b10110000;
parameter DATALVL3_COUNT11 	= 8'b01010000;
parameter DATALVL3_COUNT12 	= 8'b11010000;


//=======================================================
//  PORT declarations
//=======================================================
output reg [LEVEL_DATAHANDLER_DATAWIDTH-1:0]	CC_LEVEL_DATAHANDLER_LevelData_OutBus;

	
input		  [LEVELPROGRESS_DATAWIDTH-1:0]	 	CC_LEVEL_DATAHANDLER_LvlProgress;
input 	  [CURRENTLEVEL_DATAWIDTH-1:0]		CC_LEVEL_DATAHANDLER_CurrentLvl;

//=======================================================
//  REG/WIRE declarations
//=======================================================


//=======================================================
//  Structural coding
//=======================================================
always @(*)
begin
	case (CC_LEVEL_DATAHANDLER_CurrentLvl)
	
	1: begin
			if(CC_LEVEL_DATAHANDLER_LvlProgress == 1) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT0;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 2) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT1;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 3) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT2;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 4) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT3;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 5) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT4;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 6) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT5;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 7) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT6;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 8) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT7;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 9) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT8;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 10) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT9;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 11) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT10;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 12) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT11;
			else CC_LEVEL_DATAHANDLER_LevelData_OutBus = 0;
		end
		
	2: begin
			if(CC_LEVEL_DATAHANDLER_LvlProgress == 1) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT0;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 2) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT1;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 3) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT2;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 4) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT3;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 5) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT4;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 6) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT5;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 7) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT6;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 8) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT7;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 9) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT8;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 10) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT9;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 11) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT10;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 12) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT11;
			else CC_LEVEL_DATAHANDLER_LevelData_OutBus = 0;
		end
	default: CC_LEVEL_DATAHANDLER_LevelData_OutBus = 0;
	endcase

end

endmodule 