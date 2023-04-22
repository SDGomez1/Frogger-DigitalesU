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

module CC_LEVEL_DATAHANDLER_PLAYER_2 (
//////////// OUTPUTS //////////
	CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus,
		
//////////// INPUTS //////////
	CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress,
	CC_LEVEL_DATAHANDLER_PLAYER_2_CurrentLvl

);

//=======================================================
//  PARAMETER declarations
//=======================================================

parameter LEVEL_DATAHANDLER_DATAWIDTH 			= 8;
parameter CURRENTLEVEL_DATAWIDTH					= 3;
parameter LEVELPROGRESS_DATAWIDTH				= 5;


//LEVEL 1
parameter DATALVL1_COUNT0 		= 8'b00000001;
parameter DATALVL1_COUNT1 		= 8'b00001001;
parameter DATALVL1_COUNT2		= 8'b00000100;
parameter DATALVL1_COUNT3 		= 8'b00001100;
parameter DATALVL1_COUNT4 		= 8'b00001101;
parameter DATALVL1_COUNT5 		= 8'b00000101;
parameter DATALVL1_COUNT6 		= 8'b00000011;
parameter DATALVL1_COUNT7 		= 8'b00001010;
parameter DATALVL1_COUNT8 		= 8'b00000111;
parameter DATALVL1_COUNT9 		= 8'b00001001;
parameter DATALVL1_COUNT10		= 8'b00001011;
parameter DATALVL1_COUNT11 	= 8'b00000101;
parameter DATALVL1_COUNT12 	= 8'b00001101;

//LEVEL 2
parameter DATALVL2_COUNT0 		= 8'b00001101;
parameter DATALVL2_COUNT1 		= 8'b00001101;
parameter DATALVL2_COUNT2		= 8'b00000110;
parameter DATALVL2_COUNT3 		= 8'b00001101;
parameter DATALVL2_COUNT4 		= 8'b00000101;
parameter DATALVL2_COUNT5 		= 8'b00000101;
parameter DATALVL2_COUNT6 		= 8'b00000011;
parameter DATALVL2_COUNT7 		= 8'b00001010;
parameter DATALVL2_COUNT8 		= 8'b00000111;
parameter DATALVL2_COUNT9 		= 8'b00001001;
parameter DATALVL2_COUNT10		= 8'b00001011;
parameter DATALVL2_COUNT11 	= 8'b00000101;
parameter DATALVL2_COUNT12 	= 8'b00001101;


//LEVEL 3
parameter DATALVL3_COUNT0 		= 8'b00000101;
parameter DATALVL3_COUNT1 		= 8'b00001001;
parameter DATALVL3_COUNT2		= 8'b00000100;
parameter DATALVL3_COUNT3 		= 8'b00001100;
parameter DATALVL3_COUNT4 		= 8'b00001101;
parameter DATALVL3_COUNT5 		= 8'b00000101;
parameter DATALVL3_COUNT6 		= 8'b00000011;
parameter DATALVL3_COUNT7 		= 8'b00001010;
parameter DATALVL3_COUNT8 		= 8'b00000111;
parameter DATALVL3_COUNT9 		= 8'b00001001;
parameter DATALVL3_COUNT10		= 8'b00001011;
parameter DATALVL3_COUNT11 	= 8'b00000101;
parameter DATALVL3_COUNT12 	= 8'b00001101;


//=======================================================
//  PORT declarations
//=======================================================
output reg [LEVEL_DATAHANDLER_DATAWIDTH-1:0]	CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus;

	
input		  [LEVELPROGRESS_DATAWIDTH-1:0]	 	CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress;
input 	  [CURRENTLEVEL_DATAWIDTH-1:0]		CC_LEVEL_DATAHANDLER_PLAYER_2_CurrentLvl;

//=======================================================
//  REG/WIRE declarations
//=======================================================


//=======================================================
//  Structural coding
//=======================================================
always @(*)
begin
	case (CC_LEVEL_DATAHANDLER_PLAYER_2_CurrentLvl)
	
	1: begin
			if(CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 1) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT0;
			else if (CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 2) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT1;
			else if (CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 3) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT2;
			else if (CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 4) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT3;
			else if (CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 5) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT4;
			else if (CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 6) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT5;
			else if (CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 7) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT6;
			else if (CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 8) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT7;
			else if (CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 9) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT8;
			else if (CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 10) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT9;
			else if (CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 11) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT10;
			else if (CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 12) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT11;
			else CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = 0;
		end
		
	2: begin
			if(CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 1) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT0;
			else if (CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 2) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT1;
			else if (CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 3) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT2;
			else if (CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 4) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT3;
			else if (CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 5) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT4;
			else if (CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 6) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT5;
			else if (CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 7) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT6;
			else if (CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 8) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT7;
			else if (CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 9) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT8;
			else if (CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 10) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT9;
			else if (CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 11) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT10;
			else if (CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress == 12) CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = DATALVL1_COUNT11;
			else CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = 0;
		end
	default: CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus = 0;
	endcase

end

endmodule 