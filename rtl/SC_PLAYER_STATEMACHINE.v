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
module SC_PLAYER_STATEMACHINE(
//////////// OUTPUTS //////////
	SC_PLAYER_STATEMACHINE_ShiftSelection_Out,

	//////////// INPUTS //////////
	SC_PLAYER_STATEMACHINE_CLOCK_50,
	SC_PLAYER_STATEMACHINE_RESET_InHigh,
	SC_PLAYER_STATEMACHINE_LeftButton_InLow,
	SC_PLAYER_STATEMACHINE_RigthButton_InLow,
	SC_PLAYER_STATEMACHINE_PlayerLose_InLow,
	SC_PLAYER_STATEMACHINE_FinishedLevel_InLow
);

//=======================================================
//  PARAMETER declarations
//=======================================================

// states declaration
localparam STATE_STANDINGSTILL								= 0;
localparam STATE_MOVINGLEFT_0									= 1;
localparam STATE_MOVINGLEFT_1									= 2;
localparam STATE_MOVINGRIGHT_0								= 3;
localparam STATE_MOVINGRIGHT_1								= 4;
localparam STATE_PLAYERLOSE									= 5;



//=======================================================
//  PORT declarations
//=======================================================

output reg 	[1:0]SC_PLAYER_STATEMACHINE_ShiftSelection_Out;

input 		SC_PLAYER_STATEMACHINE_CLOCK_50;
input			SC_PLAYER_STATEMACHINE_RESET_InHigh;
input			SC_PLAYER_STATEMACHINE_LeftButton_InLow;
input 		SC_PLAYER_STATEMACHINE_RigthButton_InLow;
input 		SC_PLAYER_STATEMACHINE_PlayerLose_InLow;
input 		SC_PLAYER_STATEMACHINE_FinishedLevel_InLow;

//=======================================================
//  REG/WIRE declarations
//=======================================================

reg [3:0] STATE_Register;
reg [3:0] STATE_Signal;

//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
// NEXT STATE LOGIC : COMBINATIONAL

always @(*) 
begin

	case (STATE_Register)
	
		STATE_STANDINGSTILL: 	if (SC_PLAYER_STATEMACHINE_LeftButton_InLow == 1'b0) 
											STATE_Signal = STATE_MOVINGLEFT_0;
										
										else if (SC_PLAYER_STATEMACHINE_RigthButton_InLow == 1'b0)
											STATE_Signal = STATE_MOVINGRIGHT_0;
											
										else if (SC_PLAYER_STATEMACHINE_PlayerLose_InLow == 1'b0)
											STATE_Signal = STATE_PLAYERLOSE;
										else 
											STATE_Signal = STATE_STANDINGSTILL;
											
		STATE_MOVINGLEFT_0:		STATE_Signal = STATE_MOVINGLEFT_1;									
						
		STATE_MOVINGLEFT_1:  	if (SC_PLAYER_STATEMACHINE_LeftButton_InLow == 1'b1)
										STATE_Signal = STATE_STANDINGSTILL;
										
										else if (SC_PLAYER_STATEMACHINE_RigthButton_InLow == 1'b0)
											STATE_Signal = STATE_MOVINGRIGHT_0;
											
										else if (SC_PLAYER_STATEMACHINE_PlayerLose_InLow == 1'b0)
										STATE_Signal = STATE_PLAYERLOSE;
									
										else 
											STATE_Signal = STATE_MOVINGLEFT_1;
										
		STATE_MOVINGRIGHT_0:		STATE_Signal = STATE_MOVINGRIGHT_1;	
		
		STATE_MOVINGRIGHT_1:		if (SC_PLAYER_STATEMACHINE_RigthButton_InLow == 1'b1)
											STATE_Signal = STATE_STANDINGSTILL;
										
										else if (SC_PLAYER_STATEMACHINE_LeftButton_InLow == 1'b0)
											STATE_Signal = STATE_MOVINGLEFT_0;
											
										else if (SC_PLAYER_STATEMACHINE_PlayerLose_InLow == 1'b0)
											STATE_Signal = STATE_PLAYERLOSE;
											
										else 
											STATE_Signal = STATE_MOVINGRIGHT_1;
											
		STATE_PLAYERLOSE: 		if(SC_PLAYER_STATEMACHINE_FinishedLevel_InLow == 1'b0)
											STATE_Signal = STATE_STANDINGSTILL;
										else
											STATE_Signal = STATE_PLAYERLOSE;
		default: 					STATE_Signal = STATE_STANDINGSTILL;
	
	endcase

end 

// STATE REGISTER : SEQUENTIAL
always @ ( posedge SC_PLAYER_STATEMACHINE_CLOCK_50 , posedge SC_PLAYER_STATEMACHINE_RESET_InHigh)
begin
	if (SC_PLAYER_STATEMACHINE_RESET_InHigh == 1'b1)
		STATE_Register <= STATE_STANDINGSTILL;
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
// STATE_STANDINGSTILL
//=========================================================
	STATE_STANDINGSTILL :	
		begin
			SC_PLAYER_STATEMACHINE_ShiftSelection_Out = 2'b00;
		end
//=========================================================
// STATE_MOVINGLEFT_0
//=========================================================
	STATE_MOVINGLEFT_0 :	
		begin
			SC_PLAYER_STATEMACHINE_ShiftSelection_Out = 2'b01;
			
		end
//=========================================================
// STATE_MOVINGLEFT_1
//=========================================================
	STATE_MOVINGLEFT_1 :	
		begin
			SC_PLAYER_STATEMACHINE_ShiftSelection_Out = 2'b00;
			
		end

//=========================================================
// STATE_MOVINGRIGHT_0
//=========================================================
	STATE_MOVINGRIGHT_0 :
		begin
			SC_PLAYER_STATEMACHINE_ShiftSelection_Out = 2'b10;
			
		end
		
//=========================================================
// STATE_MOVINGRIGHT_1
//=========================================================
	STATE_MOVINGRIGHT_1 :
		begin
			SC_PLAYER_STATEMACHINE_ShiftSelection_Out = 2'b00;
			
		end

//=========================================================
// STATE_PLAYERLOSE
//=========================================================
	STATE_PLAYERLOSE :
		begin
			SC_PLAYER_STATEMACHINE_ShiftSelection_Out = 2'b00;
			
		end
//=========================================================
// DEFAULT
//=========================================================
	default :
		begin
			SC_PLAYER_STATEMACHINE_ShiftSelection_Out = 2'b00;
		end
	endcase
end

endmodule 
