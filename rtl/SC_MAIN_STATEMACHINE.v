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

module SC_MAIN_STATEMACHINE(
//////////// OUTPUTS //////////
	SC_MAIN_STATEMACHINE_CurrentState_Out,

//////////// INPUTS //////////

	SC_MAIN_STATEMACHINE_CLOCK_50,
	SC_MAIN_STATEMACHINE_RESET_InHigh,
	SC_MAIN_STATEMACHINE_StartSignal_InLow,
	SC_MAIN_STATEMACHINE_EndGameSignal_InLow

);

//=======================================================
//  PARAMETER declarations
//=======================================================

parameter STATE_DATAWIDTH										= 2;

// states declaration
localparam STATE_AWAITSTART_0									= 0;
localparam STATE_STARTGAME_0									= 1;
localparam STATE_ENDGAME_0										= 2;
localparam STATE_AWAITSTART_1									= 3;


//=======================================================
//  PORT declarations
//=======================================================

output reg		[STATE_DATAWIDTH-1:0] SC_MAIN_STATEMACHINE_CurrentState_Out;

input				SC_MAIN_STATEMACHINE_CLOCK_50;
input 			SC_MAIN_STATEMACHINE_RESET_InHigh;
input				SC_MAIN_STATEMACHINE_StartSignal_InLow;
input				SC_MAIN_STATEMACHINE_EndGameSignal_InLow;


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
	
		STATE_AWAITSTART_0: 	if (SC_MAIN_STATEMACHINE_StartSignal_InLow == 1'b0) 
									   STATE_Signal = STATE_AWAITSTART_1;
										
									else 
										STATE_Signal = STATE_AWAITSTART_0;
										
										
		STATE_AWAITSTART_1:	STATE_Signal = STATE_STARTGAME_0;
						
		STATE_STARTGAME_0:  	if (SC_MAIN_STATEMACHINE_EndGameSignal_InLow == 1'b0)
										STATE_Signal = STATE_ENDGAME_0;
										
									else if (SC_MAIN_STATEMACHINE_RESET_InHigh == 1'b1)
										STATE_Signal = STATE_AWAITSTART_0;
									
									else 
										STATE_Signal = STATE_STARTGAME_0;
										
		STATE_ENDGAME_0:		if (SC_MAIN_STATEMACHINE_RESET_InHigh == 1'b1)		
										STATE_Signal = STATE_AWAITSTART_0;
										
									else
										STATE_Signal = STATE_ENDGAME_0;

		default: 				STATE_Signal = STATE_STARTGAME_0;
	
	endcase

end 

// STATE REGISTER : SEQUENTIAL
always @ ( posedge SC_MAIN_STATEMACHINE_CLOCK_50 , posedge SC_MAIN_STATEMACHINE_RESET_InHigh)
begin
	if (SC_MAIN_STATEMACHINE_RESET_InHigh == 1'b1)
		STATE_Register <= STATE_AWAITSTART_0;
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
// STATE_AWAITSTART_0
//=========================================================
	STATE_AWAITSTART_0 :	
		begin
			SC_MAIN_STATEMACHINE_CurrentState_Out = 2'b00;
		end
//=========================================================
// STATE_STARTGAME_0
//=========================================================
	STATE_STARTGAME_0 :	
		begin
			SC_MAIN_STATEMACHINE_CurrentState_Out = 2'b01;
		end

//========================================================
// STATE_ENDGAME_0
//=========================================================
	STATE_ENDGAME_0 :
		begin
			SC_MAIN_STATEMACHINE_CurrentState_Out = 2'b10;
			
		end
//=========================================================
// STATE_AWAITSTART_1
//=========================================================
	STATE_AWAITSTART_1 :	
		begin
			SC_MAIN_STATEMACHINE_CurrentState_Out = 2'b11;
		end
//=========================================================
// DEFAULT
//=========================================================
	default :
		begin
			SC_MAIN_STATEMACHINE_CurrentState_Out = 2'b00;
		end
	endcase
end

endmodule 