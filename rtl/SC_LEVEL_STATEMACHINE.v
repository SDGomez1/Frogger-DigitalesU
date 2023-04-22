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
	SC_LEVEL_STATEMACHINE_FinishedGame_Out,
	SC_LEVEL_STATEMACHINE_upCount_out,
	SC_LEVEL_STATEMACHINE_ProgressUpCount_out,
	
//////////// INPUTS //////////
	SC_LEVEL_STATEMACHINE_CurrentLevel_In,
	SC_LEVEL_STATEMACHINE_LvlProgressCount_In,
	SC_LEVEL_STATEMACHINE_CLOCK_50,
	SC_LEVEL_STATEMACHINE_RESET_InHigh,
	SC_LEVEL_STATEMACHINE_T0_InLow
	
);

//=======================================================
//  PARAMETER declarations
//=======================================================

parameter CURRENT_LEVEDATAWIDTH								= 3;
parameter STATE_DATAWIDTH										= 4;

// states declaration
localparam STATE_NO_LEVEL										= 0;
localparam STATE_LEVEL_1										= 1;
localparam STATE_LEVEL_2										= 2;
localparam STATE_LEVEL_3										= 3;
localparam STATE_ENDGAME										= 4;
localparam STATE_COUNT_1										= 5;
localparam STATE_COUNT_2										= 6;
localparam STATE_COUNT_3										= 7;
localparam STATE_SHIFT_1										= 8;
localparam STATE_SHIFT_2										= 9;
localparam STATE_SHIFT_3										= 10;


//=======================================================
//  PORT declarations
//=======================================================

output reg		SC_LEVEL_STATEMACHINE_FinishedGame_Out;
output reg		SC_LEVEL_STATEMACHINE_LevelFinished_Out;
output reg		SC_LEVEL_STATEMACHINE_upCount_out;
output reg		SC_LEVEL_STATEMACHINE_ProgressUpCount_out;

input 			[CURRENT_LEVEDATAWIDTH-1:0]SC_LEVEL_STATEMACHINE_CurrentLevel_In;
input 			[4:0]SC_LEVEL_STATEMACHINE_LvlProgressCount_In;
input				SC_LEVEL_STATEMACHINE_CLOCK_50;
input				SC_LEVEL_STATEMACHINE_RESET_InHigh;
input				SC_LEVEL_STATEMACHINE_T0_InLow;


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
	
		STATE_NO_LEVEL:	if (SC_LEVEL_STATEMACHINE_CurrentLevel_In == 1) 
								   STATE_Signal = STATE_LEVEL_1;		
									
								else 
									STATE_Signal = STATE_NO_LEVEL;
									
						
		STATE_LEVEL_1:  	if (SC_LEVEL_STATEMACHINE_CurrentLevel_In == 2)
										STATE_Signal = STATE_LEVEL_2;		
										
								else if (SC_LEVEL_STATEMACHINE_T0_InLow == 0)
									STATE_Signal = STATE_SHIFT_1;
									
								else
									STATE_Signal = STATE_COUNT_1;
								
										
		STATE_LEVEL_2:		if (SC_LEVEL_STATEMACHINE_CurrentLevel_In == 3)		
									STATE_Signal = STATE_LEVEL_3;		
									
								else if (SC_LEVEL_STATEMACHINE_T0_InLow == 0)
									STATE_Signal = STATE_SHIFT_2;
									
								else
									STATE_Signal = STATE_COUNT_2;
									
		STATE_LEVEL_3: 	if (SC_LEVEL_STATEMACHINE_CurrentLevel_In == 4)		
									STATE_Signal = STATE_ENDGAME;	
								
								else if (SC_LEVEL_STATEMACHINE_T0_InLow == 0)
									STATE_Signal = STATE_SHIFT_3;
									
								else
									STATE_Signal = STATE_COUNT_3;
		
		
		STATE_ENDGAME:		if (SC_LEVEL_STATEMACHINE_RESET_InHigh == 1'b1)		
									STATE_Signal = STATE_NO_LEVEL;		
								else
									STATE_Signal = STATE_ENDGAME;	
		
		STATE_COUNT_1:		STATE_Signal = STATE_LEVEL_1;
		
		STATE_COUNT_2:		STATE_Signal = STATE_LEVEL_2;
				
		STATE_COUNT_3:		STATE_Signal = STATE_LEVEL_3;
		
		STATE_SHIFT_1: 	STATE_Signal = STATE_COUNT_1;
		
		STATE_SHIFT_2: 	STATE_Signal = STATE_COUNT_2;
		
		STATE_SHIFT_3: 	STATE_Signal = STATE_COUNT_3;


		default: 			STATE_Signal = STATE_NO_LEVEL;

	endcase

end 


// STATE REGISTER : SEQUENTIAL
always @ ( posedge SC_LEVEL_STATEMACHINE_CLOCK_50 , posedge SC_LEVEL_STATEMACHINE_RESET_InHigh)
begin
	if (SC_LEVEL_STATEMACHINE_RESET_InHigh == 1'b1)
		STATE_Register <= STATE_NO_LEVEL;
	else
		STATE_Register <= STATE_Signal;
end

//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL
always @ (*)
begin
	case (STATE_Register)
//=========================================================
// STATE_NO_LEVEL
//=========================================================
	STATE_NO_LEVEL :	
		begin
			SC_LEVEL_STATEMACHINE_LevelFinished_Out 	= 1;
			SC_LEVEL_STATEMACHINE_FinishedGame_Out		= 1;
			SC_LEVEL_STATEMACHINE_upCount_out 			= 1;
			SC_LEVEL_STATEMACHINE_ProgressUpCount_out = 1;
		end
//=========================================================
// STATE_LEVEL_1
//=========================================================
	STATE_LEVEL_1 :	
		begin
			if(SC_LEVEL_STATEMACHINE_LvlProgressCount_In == 5'b01100 + 8)begin
				SC_LEVEL_STATEMACHINE_LevelFinished_Out	= 0;
				SC_LEVEL_STATEMACHINE_FinishedGame_Out 	= 1;
				SC_LEVEL_STATEMACHINE_upCount_out 			= 1;
				SC_LEVEL_STATEMACHINE_ProgressUpCount_out = 1;
				
			end
			else begin
				SC_LEVEL_STATEMACHINE_LevelFinished_Out 	= 1;
				SC_LEVEL_STATEMACHINE_FinishedGame_Out		= 1;
				SC_LEVEL_STATEMACHINE_upCount_out 			= 1;
				SC_LEVEL_STATEMACHINE_ProgressUpCount_out = 1;
				
			end
			
		end

//========================================================
// STATE_LEVEL_2
//=========================================================
	STATE_LEVEL_2 :
		begin
				if(SC_LEVEL_STATEMACHINE_LvlProgressCount_In == 5'b01100 + 8)begin
				SC_LEVEL_STATEMACHINE_LevelFinished_Out 	= 0;
				SC_LEVEL_STATEMACHINE_FinishedGame_Out 	= 1;
				SC_LEVEL_STATEMACHINE_upCount_out 			= 1;
				SC_LEVEL_STATEMACHINE_ProgressUpCount_out = 1;

			end
			else begin
				SC_LEVEL_STATEMACHINE_LevelFinished_Out 	= 1;
				SC_LEVEL_STATEMACHINE_FinishedGame_Out 	= 1;
				SC_LEVEL_STATEMACHINE_upCount_out 			= 1;
				SC_LEVEL_STATEMACHINE_ProgressUpCount_out = 1;
			
			end
			
		end

//=======================================================
// STATE_LEVEL_3
//=========================================================
	STATE_LEVEL_3 :
		begin
			if(SC_LEVEL_STATEMACHINE_LvlProgressCount_In == 5'b01100 + 8)begin
				SC_LEVEL_STATEMACHINE_LevelFinished_Out 	= 0;
				SC_LEVEL_STATEMACHINE_FinishedGame_Out 	= 1;
				SC_LEVEL_STATEMACHINE_upCount_out 			= 1;
				SC_LEVEL_STATEMACHINE_ProgressUpCount_out = 1;

			end
			else begin
				SC_LEVEL_STATEMACHINE_LevelFinished_Out 	= 1;
				SC_LEVEL_STATEMACHINE_FinishedGame_Out 	= 1;
				SC_LEVEL_STATEMACHINE_upCount_out 			= 1;
				SC_LEVEL_STATEMACHINE_ProgressUpCount_out = 1;
			
			end
			
		end
		
//=======================================================
// STATE_ENDGAME
//=========================================================
	STATE_ENDGAME :	
		begin
				SC_LEVEL_STATEMACHINE_LevelFinished_Out 	= 1;
				SC_LEVEL_STATEMACHINE_FinishedGame_Out 	= 0;
				SC_LEVEL_STATEMACHINE_upCount_out 			= 1;
				SC_LEVEL_STATEMACHINE_ProgressUpCount_out = 1;
		end

//=======================================================
// STATE_COUNT_1
//=========================================================
	STATE_COUNT_1 :	
		begin
				SC_LEVEL_STATEMACHINE_LevelFinished_Out 	= 1;
				SC_LEVEL_STATEMACHINE_FinishedGame_Out 	= 1;
				SC_LEVEL_STATEMACHINE_upCount_out 			= 0;
				SC_LEVEL_STATEMACHINE_ProgressUpCount_out = 1;
		end

//=======================================================
// STATE_COUNT_2
//=========================================================
	STATE_COUNT_2 :	
		begin
				
				SC_LEVEL_STATEMACHINE_LevelFinished_Out 	= 1;
				SC_LEVEL_STATEMACHINE_FinishedGame_Out 	= 1;
				SC_LEVEL_STATEMACHINE_upCount_out 			= 0;
				SC_LEVEL_STATEMACHINE_ProgressUpCount_out = 1;
		end

//=======================================================
// STATE_COUNT_3
//=========================================================
	STATE_COUNT_3 :	
		begin
				SC_LEVEL_STATEMACHINE_LevelFinished_Out 	= 1;
				SC_LEVEL_STATEMACHINE_FinishedGame_Out 	= 1;
				SC_LEVEL_STATEMACHINE_upCount_out 			= 0;
				SC_LEVEL_STATEMACHINE_ProgressUpCount_out = 1;
		end

//=======================================================
// STATE_SHIFT_1
//=========================================================
	STATE_SHIFT_1 :	
		begin
				SC_LEVEL_STATEMACHINE_LevelFinished_Out 	= 1;
				SC_LEVEL_STATEMACHINE_FinishedGame_Out 	= 1;
				SC_LEVEL_STATEMACHINE_upCount_out 			= 1;
				SC_LEVEL_STATEMACHINE_ProgressUpCount_out = 0;
		end
//=======================================================
// STATE_SHIFT_2
//=========================================================
	STATE_SHIFT_2 :	
		begin
				SC_LEVEL_STATEMACHINE_LevelFinished_Out 	= 1;
				SC_LEVEL_STATEMACHINE_FinishedGame_Out 	= 1;	
				SC_LEVEL_STATEMACHINE_upCount_out 			= 1;
				SC_LEVEL_STATEMACHINE_ProgressUpCount_out = 0;
		end

		

//=======================================================
// STATE_SHIFT_3
//=========================================================
	STATE_SHIFT_3 :	
		begin
				SC_LEVEL_STATEMACHINE_LevelFinished_Out 	= 1;
				SC_LEVEL_STATEMACHINE_FinishedGame_Out 	= 1;
				SC_LEVEL_STATEMACHINE_upCount_out 			= 1;
				SC_LEVEL_STATEMACHINE_ProgressUpCount_out = 0;
		end

			

//=========================================================
// DEFAULT
//=========================================================
	default :
		begin
				SC_LEVEL_STATEMACHINE_LevelFinished_Out 	= 0; 
				SC_LEVEL_STATEMACHINE_FinishedGame_Out 	= 1;
				SC_LEVEL_STATEMACHINE_upCount_out 			= 1;
				SC_LEVEL_STATEMACHINE_ProgressUpCount_out = 1;

		end
		
	endcase
end

endmodule 
