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
parameter DATALVL1_COUNT0   	= 8'b00100000;
parameter DATALVL1_COUNT1   	= 8'b10000000;
parameter DATALVL1_COUNT2   	= 8'b00100000;
parameter DATALVL1_COUNT3   	= 8'b00010000;
parameter DATALVL1_COUNT4   	= 8'b01000000;
parameter DATALVL1_COUNT5   	= 8'b00100000;
parameter DATALVL1_COUNT6   	= 8'b00100000;
parameter DATALVL1_COUNT7   	= 8'b00100000;
parameter DATALVL1_COUNT8   	= 8'b00010000;
parameter DATALVL1_COUNT9 	   = 8'b01000000;

//LEVEL 2
parameter DATALVL2_COUNT0   	= 8'b00100000;
parameter DATALVL2_COUNT1   	= 8'b10000000;
parameter DATALVL2_COUNT2   	= 8'b00100000;
parameter DATALVL2_COUNT3   	= 8'b00010000;
parameter DATALVL2_COUNT4   	= 8'b01000000;
parameter DATALVL2_COUNT5   	= 8'b00100000;
parameter DATALVL2_COUNT6   	= 8'b00100000;
parameter DATALVL2_COUNT7   	= 8'b00100000;
parameter DATALVL2_COUNT8   	= 8'b00010000;
parameter DATALVL2_COUNT9   	= 8'b01000000;
parameter DATALVL2_COUNT10   	= 8'b10000000;
parameter DATALVL2_COUNT11   	= 8'b00010000;
parameter DATALVL2_COUNT12   	= 8'b00100000;
parameter DATALVL2_COUNT13   	= 8'b00010000;
parameter DATALVL2_COUNT14   	= 8'b10000000;


//LEVEL 3
parameter DATALVL3_COUNT0   	= 8'b00100000;
parameter DATALVL3_COUNT1   	= 8'b10000000;
parameter DATALVL3_COUNT2   	= 8'b00100000;
parameter DATALVL3_COUNT3   	= 8'b00010000;
parameter DATALVL3_COUNT4   	= 8'b01000000;
parameter DATALVL3_COUNT5   	= 8'b00100000;
parameter DATALVL3_COUNT6   	= 8'b00100000;
parameter DATALVL3_COUNT7   	= 8'b00100000;
parameter DATALVL3_COUNT8   	= 8'b00010000;
parameter DATALVL3_COUNT9   	= 8'b01000000;
parameter DATALVL3_COUNT10   	= 8'b10000000;
parameter DATALVL3_COUNT11   	= 8'b00010000;
parameter DATALVL3_COUNT12   	= 8'b00100000;
parameter DATALVL3_COUNT13   	= 8'b00010000;
parameter DATALVL3_COUNT14   	= 8'b10000000;
parameter DATALVL3_COUNT15   	= 8'b00100000;
parameter DATALVL3_COUNT16   	= 8'b00010000;
parameter DATALVL3_COUNT17   	= 8'b10000000;
parameter DATALVL3_COUNT18   	= 8'b01000000;
parameter DATALVL3_COUNT19   	= 8'b00100000;

//imagen nivel 0 a 1
parameter DATALVL0toLVL1_COUNT0   = 8'b00011000;
parameter DATALVL0toLVL1_COUNT1   = 8'b01111000;
parameter DATALVL0toLVL1_COUNT2   = 8'b11011000;
parameter DATALVL0toLVL1_COUNT3   = 8'b00011000;
parameter DATALVL0toLVL1_COUNT4   = 8'b00011000;
parameter DATALVL0toLVL1_COUNT5   = 8'b00011000;
parameter DATALVL0toLVL1_COUNT6   = 8'b00011000;
parameter DATALVL0toLVL1_COUNT7   = 8'b11111111;


//imagen nivel 1 a 2

parameter DATALVL1toLVL2_COUNT0   = 8'b00011100;
parameter DATALVL1toLVL2_COUNT1   = 8'b00110110;
parameter DATALVL1toLVL2_COUNT2   = 8'b11100011;
parameter DATALVL1toLVL2_COUNT3   = 8'b00000111;
parameter DATALVL1toLVL2_COUNT4 	 = 8'b00001110;
parameter DATALVL1toLVL2_COUNT5   = 8'b00111000;
parameter DATALVL1toLVL2_COUNT6   = 8'b11100000;
parameter DATALVL1toLVL2_COUNT7 	 = 8'b11111111;



//imagen nivel 2 a 3
parameter DATALVL2toLVL3_COUNT0   = 8'b00011100;
parameter DATALVL2toLVL3_COUNT1   = 8'b00110110;
parameter DATALVL2toLVL3_COUNT2   = 8'b01100011;
parameter DATALVL2toLVL3_COUNT3   = 8'b00001110;
parameter DATALVL2toLVL3_COUNT4   = 8'b00011100;
parameter DATALVL2toLVL3_COUNT5   = 8'b00001110;
parameter DATALVL2toLVL3_COUNT6   = 8'b00000011;
parameter DATALVL2toLVL3_COUNT7   = 8'b01111110;




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
			if(CC_LEVEL_DATAHANDLER_LvlProgress == 1) CC_LEVEL_DATAHANDLER_LevelData_OutBus 			= DATALVL0toLVL1_COUNT7;
			else if(CC_LEVEL_DATAHANDLER_LvlProgress == 2) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL0toLVL1_COUNT6;
			else if(CC_LEVEL_DATAHANDLER_LvlProgress == 3) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL0toLVL1_COUNT5;
			else if(CC_LEVEL_DATAHANDLER_LvlProgress == 4) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL0toLVL1_COUNT4;
			else if(CC_LEVEL_DATAHANDLER_LvlProgress == 5) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL0toLVL1_COUNT3;
			else if(CC_LEVEL_DATAHANDLER_LvlProgress == 6) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL0toLVL1_COUNT2;
			else if(CC_LEVEL_DATAHANDLER_LvlProgress == 7) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL0toLVL1_COUNT1;
			else if(CC_LEVEL_DATAHANDLER_LvlProgress == 8) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL0toLVL1_COUNT0;
			else CC_LEVEL_DATAHANDLER_LevelData_OutBus = 0;
		end
	2: begin
			if(CC_LEVEL_DATAHANDLER_LvlProgress == 1) CC_LEVEL_DATAHANDLER_LevelData_OutBus 			= DATALVL1_COUNT0;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 2) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL1_COUNT1;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 3) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL1_COUNT2;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 4) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL1_COUNT3;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 5) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL1_COUNT4;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 6) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL1_COUNT5;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 7) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL1_COUNT6;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 8) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL1_COUNT7;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 9) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL1_COUNT8;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 10) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL1_COUNT9;
			else CC_LEVEL_DATAHANDLER_LevelData_OutBus = 0;
		end
	3: begin
			if(CC_LEVEL_DATAHANDLER_LvlProgress == 1) CC_LEVEL_DATAHANDLER_LevelData_OutBus 			= DATALVL1toLVL2_COUNT7;
			else if(CC_LEVEL_DATAHANDLER_LvlProgress == 2) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL1toLVL2_COUNT6;
			else if(CC_LEVEL_DATAHANDLER_LvlProgress == 3) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL1toLVL2_COUNT5;
			else if(CC_LEVEL_DATAHANDLER_LvlProgress == 4) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL1toLVL2_COUNT4;
			else if(CC_LEVEL_DATAHANDLER_LvlProgress == 5) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL1toLVL2_COUNT3;
			else if(CC_LEVEL_DATAHANDLER_LvlProgress == 6) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL1toLVL2_COUNT2;
			else if(CC_LEVEL_DATAHANDLER_LvlProgress == 7) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL1toLVL2_COUNT1;
			else if(CC_LEVEL_DATAHANDLER_LvlProgress == 8) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL1toLVL2_COUNT0;
			else CC_LEVEL_DATAHANDLER_LevelData_OutBus = 0;
		end
		
	4: begin
			if(CC_LEVEL_DATAHANDLER_LvlProgress == 1) CC_LEVEL_DATAHANDLER_LevelData_OutBus 			= DATALVL2_COUNT0;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 2) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL2_COUNT1;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 3) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL2_COUNT2;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 4) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL2_COUNT3;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 5) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL2_COUNT4;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 6) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL2_COUNT5;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 7) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL2_COUNT6;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 8) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL2_COUNT7;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 9) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL2_COUNT8;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 10) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL2_COUNT9;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 11) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL2_COUNT10;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 12) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL2_COUNT11;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 13) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL2_COUNT12;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 14) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL2_COUNT13;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 15) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL2_COUNT14;
			else CC_LEVEL_DATAHANDLER_LevelData_OutBus = 0;
		end
		
	5: begin
			if(CC_LEVEL_DATAHANDLER_LvlProgress == 1) CC_LEVEL_DATAHANDLER_LevelData_OutBus 			= DATALVL2toLVL3_COUNT7;
			else if(CC_LEVEL_DATAHANDLER_LvlProgress == 2) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL2toLVL3_COUNT6;
			else if(CC_LEVEL_DATAHANDLER_LvlProgress == 3) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL2toLVL3_COUNT5;
			else if(CC_LEVEL_DATAHANDLER_LvlProgress == 4) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL2toLVL3_COUNT4;
			else if(CC_LEVEL_DATAHANDLER_LvlProgress == 5) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL2toLVL3_COUNT3;
			else if(CC_LEVEL_DATAHANDLER_LvlProgress == 6) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL2toLVL3_COUNT2;
			else if(CC_LEVEL_DATAHANDLER_LvlProgress == 7) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL2toLVL3_COUNT1;
			else if(CC_LEVEL_DATAHANDLER_LvlProgress == 8) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL2toLVL3_COUNT0;
			else CC_LEVEL_DATAHANDLER_LevelData_OutBus = 0;
		end
		
	6: begin
			if(CC_LEVEL_DATAHANDLER_LvlProgress == 1) CC_LEVEL_DATAHANDLER_LevelData_OutBus 			= DATALVL3_COUNT0;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 2) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL3_COUNT1;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 3) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL3_COUNT2;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 4) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL3_COUNT3;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 5) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL3_COUNT4;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 6) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL3_COUNT5;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 7) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL3_COUNT6;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 8) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL3_COUNT7;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 9) CC_LEVEL_DATAHANDLER_LevelData_OutBus 	= DATALVL3_COUNT8;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 10) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL3_COUNT9;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 11) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL3_COUNT10;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 12) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL3_COUNT11;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 13) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL3_COUNT12;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 14) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL3_COUNT13;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 15) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL3_COUNT14;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 16) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL3_COUNT15;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 17) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL3_COUNT16;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 18) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL3_COUNT17;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 19) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL3_COUNT18;
			else if (CC_LEVEL_DATAHANDLER_LvlProgress == 20) CC_LEVEL_DATAHANDLER_LevelData_OutBus = DATALVL3_COUNT19;
			else CC_LEVEL_DATAHANDLER_LevelData_OutBus = 0;
		end
	default: CC_LEVEL_DATAHANDLER_LevelData_OutBus = 0;
	endcase

end

endmodule 