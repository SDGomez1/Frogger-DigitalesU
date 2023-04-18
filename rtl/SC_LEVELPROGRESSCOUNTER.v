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

module SC_LEVELPROGRESSCOUNTER (
//////////// OUTPUTS //////////
	SC_LEVELPROGRESSCOUNTER_Data_OutBus,
	
//////////// INPUTS //////////
	SC_LEVELPROGRESSCOUNTER_CountSignal_in,
	SC_LEVELPROGRESSCOUNTER_StartCountSignal_in,
	SC_LEVELPROGRESSCOUNTER_FinishedGame_in,
	SC_LEVELPROGRESSCOUNTER_CLOCK_50,
	SC_LEVELPROGRESSCOUNTER_RESET_InHigh
);

//=======================================================
//  PARAMETER declarations
//=======================================================

parameter LEVELPROGRESSCOUNTER_DATAWIDTH					= 5;

//=======================================================
//  PORT declarations
//=======================================================

output		[LEVELPROGRESSCOUNTER_DATAWIDTH-1:0] SC_LEVELPROGRESSCOUNTER_Data_OutBus;

input 		SC_LEVELPROGRESSCOUNTER_CountSignal_in;
input 		SC_LEVELPROGRESSCOUNTER_StartCountSignal_in;
input			SC_LEVELPROGRESSCOUNTER_FinishedGame_in;
input			SC_LEVELPROGRESSCOUNTER_CLOCK_50;
input 		SC_LEVELPROGRESSCOUNTER_RESET_InHigh;

//=======================================================
//  REG/WIRE declarations
//=======================================================


reg [LEVELPROGRESSCOUNTER_DATAWIDTH-1:0] LEVELPROGRESSCOUNTER_Register;
reg [LEVELPROGRESSCOUNTER_DATAWIDTH-1:0] LEVELPROGRESSCOUNTER_Signal;


//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL

always @(*)
begin
	if (SC_LEVELPROGRESSCOUNTER_FinishedGame_in == 1'b1) begin
	
		if(SC_LEVELPROGRESSCOUNTER_StartCountSignal_in)
			LEVELPROGRESSCOUNTER_Signal = 0;
		
		else begin		
			if (SC_LEVELPROGRESSCOUNTER_CountSignal_in == 1'b0)
				LEVELPROGRESSCOUNTER_Signal = LEVELPROGRESSCOUNTER_Signal + 1'b1;			
		end
	end
	
	else LEVELPROGRESSCOUNTER_Signal = 0;		
	
end 



//STATE REGISTER: SEQUENTIAL
always @(posedge SC_LEVELPROGRESSCOUNTER_CLOCK_50, posedge SC_LEVELPROGRESSCOUNTER_RESET_InHigh)
begin
	if (SC_LEVELPROGRESSCOUNTER_RESET_InHigh  == 1'b1)
		LEVELPROGRESSCOUNTER_Register <= 0;
	else
		LEVELPROGRESSCOUNTER_Register <= LEVELPROGRESSCOUNTER_Signal;
end

//=======================================================
//  Outputs
//=======================================================
//OUTPUT LOGIC: COMBINATIONAL
assign SC_LEVELPROGRESSCOUNTER_Data_OutBus = LEVELPROGRESSCOUNTER_Register;

endmodule 



