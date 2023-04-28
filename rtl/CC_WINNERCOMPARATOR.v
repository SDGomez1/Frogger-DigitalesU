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
module CC_WINNERCOMPARATOR(
//////////// OUTPUTS //////////
	CC_WINNERCOMPARATOR_Data0_outBus,
	CC_WINNERCOMPARATOR_Data1_outBus,
	CC_WINNERCOMPARATOR_Data2_outBus,
	CC_WINNERCOMPARATOR_Data3_outBus,
	CC_WINNERCOMPARATOR_Data4_outBus,
	CC_WINNERCOMPARATOR_Data5_outBus,
	CC_WINNERCOMPARATOR_Data6_outBus,
	CC_WINNERCOMPARATOR_Data7_outBus,
//////////// INPUTS //////////
	CC_WINNERCOMPARATOR_DataPLAYER1_In,
	CC_WINNERCOMPARATOR_DataPLAYER2_In
	
);


//=======================================================
//  PARAMETER declarations
//=======================================================
//Ganador 1
parameter WINNER_PLAYER_1_DATA0   = 8'b11110010;
parameter WINNER_PLAYER_1_DATA1   = 8'b00100110;
parameter WINNER_PLAYER_1_DATA2 	 = 8'b00101010;
parameter WINNER_PLAYER_1_DATA3   = 8'b00100010;
parameter WINNER_PLAYER_1_DATA4   = 8'b00100010;
parameter WINNER_PLAYER_1_DATA5   = 8'b10100010;
parameter WINNER_PLAYER_1_DATA6   = 8'b10100010;
parameter WINNER_PLAYER_1_DATA7   = 8'b11101111;

//Ganador 2
parameter WINNER_PLAYER_2_DATA0   = 8'b11111111;
parameter WINNER_PLAYER_2_DATA1   = 8'b00100001;
parameter WINNER_PLAYER_2_DATA2   = 8'b00100001;
parameter WINNER_PLAYER_2_DATA3   = 8'b00101111;
parameter WINNER_PLAYER_2_DATA4   = 8'b00101111;
parameter WINNER_PLAYER_2_DATA5   = 8'b10101000;
parameter WINNER_PLAYER_2_DATA6   = 8'b10101000;
parameter WINNER_PLAYER_2_DATA7   = 8'b11101111;



//=======================================================
//  PORT declarations
//=======================================================

output reg 	[7:0]	CC_WINNERCOMPARATOR_Data0_outBus;
output reg 	[7:0]	CC_WINNERCOMPARATOR_Data1_outBus;
output reg 	[7:0]	CC_WINNERCOMPARATOR_Data2_outBus;
output reg 	[7:0]	CC_WINNERCOMPARATOR_Data3_outBus;
output reg 	[7:0]	CC_WINNERCOMPARATOR_Data4_outBus;
output reg 	[7:0]	CC_WINNERCOMPARATOR_Data5_outBus;
output reg	[7:0]	CC_WINNERCOMPARATOR_Data6_outBus;
output reg 	[7:0]	CC_WINNERCOMPARATOR_Data7_outBus;

input 	[5:0]CC_WINNERCOMPARATOR_DataPLAYER1_In;
input		[5:0]CC_WINNERCOMPARATOR_DataPLAYER2_In;

//=======================================================
//  REG/WIRE declarations
//=======================================================


//=======================================================
//  Structural coding
//=======================================================

always @(*)
begin
	if(CC_WINNERCOMPARATOR_DataPLAYER1_In > CC_WINNERCOMPARATOR_DataPLAYER2_In)begin
		CC_WINNERCOMPARATOR_Data0_outBus = WINNER_PLAYER_1_DATA0;
		CC_WINNERCOMPARATOR_Data1_outBus = WINNER_PLAYER_1_DATA1;
		CC_WINNERCOMPARATOR_Data2_outBus = WINNER_PLAYER_1_DATA2;
		CC_WINNERCOMPARATOR_Data3_outBus = WINNER_PLAYER_1_DATA3;
		CC_WINNERCOMPARATOR_Data4_outBus = WINNER_PLAYER_1_DATA4;
		CC_WINNERCOMPARATOR_Data5_outBus = WINNER_PLAYER_1_DATA5;
		CC_WINNERCOMPARATOR_Data6_outBus = WINNER_PLAYER_1_DATA6;
		CC_WINNERCOMPARATOR_Data7_outBus = WINNER_PLAYER_1_DATA7;
	
	end
	else begin
	
		CC_WINNERCOMPARATOR_Data0_outBus = WINNER_PLAYER_2_DATA0;
		CC_WINNERCOMPARATOR_Data1_outBus = WINNER_PLAYER_2_DATA1;
		CC_WINNERCOMPARATOR_Data2_outBus = WINNER_PLAYER_2_DATA2;
		CC_WINNERCOMPARATOR_Data3_outBus = WINNER_PLAYER_2_DATA3;
		CC_WINNERCOMPARATOR_Data4_outBus = WINNER_PLAYER_2_DATA4;
		CC_WINNERCOMPARATOR_Data5_outBus = WINNER_PLAYER_2_DATA5;
		CC_WINNERCOMPARATOR_Data6_outBus = WINNER_PLAYER_2_DATA6;
		CC_WINNERCOMPARATOR_Data7_outBus = WINNER_PLAYER_2_DATA7;
	
	
	end


end


endmodule  