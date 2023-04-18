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

module SC_LEVEL_STATEMACHINE(
//////////// OUTPUTS //////////
	SC_LEVEL_STATEMACHINE_LevelFinished_Out,
	SC_LEVEL_STATEMACHINE_StartCount_Out,
	SC_LEVEL_STATEMACHINE_FinishedGame_Out,
	
//////////// INPUTS //////////
	SC_LEVEL_STATEMACHINE_CurrentLevel_In,
	SC_LEVEL_STATEMACHINE_LvlProgressCount_In,
		,
	SC_LEVEL_STATEMACHINE_RESET_InHigh,
	
);

//=======================================================
//  PARAMETER declarations
//=======================================================

parameter CURRENT_LEVEDATAWIDTH								= 3;
parameter STATE_DATAWIDTH										= 3;

// states declaration
localparam STATE_NO_LEVEL										= 0;
localparam STATE_LEVEL_1										= 1;
localparam STATE_LEVEL_2										= 2;
localparam STATE_LEVEL_3										= 3;
localparam STATE_ENDGAME										= 4;


//=======================================================
//  PORT declarations
//=======================================================

output reg		CC_LEVELHANDLER_LevelFinished_Out;
output reg		CC_LEVELHANDLER_StartCount_Out;
output reg		CC_LEVELHANDLER_FinishedGame_Out;

input 			[CURRENT_LEVEDATAWIDTH-1:0]CC_LEVELHANDLER_CurrentLevel_In;
input 			[4:0]CC_LEVELHANDLER_LvlProgressCount_In;
input				SC_LEVEL_STATEMACHINE_CLOCK_50;
input				SC_LEVEL_STATEMACHINE_RESET_InHigh;


//=======================================================
//  REG/WIRE declarations
//=======================================================

reg [STATE_DATAWIDTH-1:0] STATE_Register;
reg [STATE_DATAWIDTH-1:0] STATE_Signal;

//=======================================================
//  Structural coding
//=======================================================

//INPUT LOGIC: COMBINATIONAL
// NEXT STATE LOGIC : COMBINATIONAL
always @(*) 
begin

	case (STATE_Register)
	
		STATE_NO_LEVEL:	if (SC_MAIN_STATEMACHINE_StartSignal_InLow == 1'b0) 
									   STATE_Signal = STATE_STARTGAME_0;
										
									else 
										STATE_Signal = STATE_AWAITSTART_0;
						
		STATE_LEVEL_1:  	if (SC_MAIN_STATEMACHINE_EndGameSignal_InLow == 1'b0)
										STATE_Signal = STATE_ENDGAME_0;
										
									else if (SC_MAIN_STATEMACHINE_RESET_InHigh == 1'b1)
										STATE_Signal = STATE_AWAITSTART_0;
									
									else 
										STATE_Signal = STATE_STARTGAME_0;
										
		STATE_LEVEL_2:		if (SC_MAIN_STATEMACHINE_RESET_InHigh == 1'b1)		
										STATE_Signal = STATE_AWAITSTART_0;
										
									else
										STATE_Signal = STATE_ENDGAME_0;
		STATE_LEVEL_3: 	
		
		
		STATE_ENDGAME:

		default: 				STATE_Signal = STATE_LEVEL_0;
	
	endcase

end 



