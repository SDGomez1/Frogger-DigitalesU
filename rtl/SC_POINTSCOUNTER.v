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

module SC_POINTSCOUNTER(
//////////// OUTPUTS //////////
	SC_POINTSCOUNTER_Data_OutBus,
//////////// INPUTS //////////
	SC_POINTSCOUNTER_LevelProgress_inLow,
	SC_POINTSCOUNTER_CLOCK_50,
	SC_POINTSCOUNTER_RESET_InHigh,
	SC_POINTSCOUNTER_CurrentLvl_In,
	SC_POINTSCOUNTER_PlayerLose_inLow,
	SC_POINTSCOUNTER_upCount_inLow
);


//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================

output  				[5:0]SC_POINTSCOUNTER_Data_OutBus;

input 				[4:0]SC_POINTSCOUNTER_LevelProgress_inLow;
input 				SC_POINTSCOUNTER_CLOCK_50;
input 				SC_POINTSCOUNTER_RESET_InHigh;
input 				[2:0]SC_POINTSCOUNTER_CurrentLvl_In;
input 				SC_POINTSCOUNTER_PlayerLose_inLow;		
input 				SC_POINTSCOUNTER_upCount_inLow;

//=======================================================
//  REG/WIRE declarations
//=======================================================


reg [5:0] SC_POINTSCOUNTER_Register;
reg [5:0] SC_POINTSCOUNTER_Signal;


//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL


always @(*)
begin
	
	if(SC_POINTSCOUNTER_LevelProgress_inLow >= 8)begin
		
		case (SC_POINTSCOUNTER_CurrentLvl_In)
		
			1: SC_POINTSCOUNTER_Signal = 0;
			
			2: if(SC_POINTSCOUNTER_Register <= 10 && SC_POINTSCOUNTER_PlayerLose_inLow == 1'b1 && SC_POINTSCOUNTER_upCount_inLow == 1'b0)
					SC_POINTSCOUNTER_Signal =	SC_POINTSCOUNTER_Register + 1;		
					
				else 
					SC_POINTSCOUNTER_Signal = SC_POINTSCOUNTER_Register;
					
					
					
			4: if(SC_POINTSCOUNTER_Register <= 25 && SC_POINTSCOUNTER_PlayerLose_inLow == 1'b1 && SC_POINTSCOUNTER_upCount_inLow == 1'b0)
					SC_POINTSCOUNTER_Signal =	SC_POINTSCOUNTER_Register + 1;		
					
				else 
					SC_POINTSCOUNTER_Signal = SC_POINTSCOUNTER_Register;
			
			6:	if(SC_POINTSCOUNTER_Register <= 45 && SC_POINTSCOUNTER_PlayerLose_inLow == 1'b1 && SC_POINTSCOUNTER_upCount_inLow == 1'b0)
					SC_POINTSCOUNTER_Signal =	SC_POINTSCOUNTER_Register + 1;		
					
				else 
					SC_POINTSCOUNTER_Signal = SC_POINTSCOUNTER_Register;
		
			default: SC_POINTSCOUNTER_Signal = SC_POINTSCOUNTER_Register;
		endcase
	end
	
	else 
		 SC_POINTSCOUNTER_Signal = SC_POINTSCOUNTER_Register;

end

//STATE REGISTER: SEQUENTIAL
always @(posedge SC_POINTSCOUNTER_CLOCK_50, posedge SC_POINTSCOUNTER_RESET_InHigh)
begin
	if (SC_POINTSCOUNTER_RESET_InHigh  == 1'b1)
		SC_POINTSCOUNTER_Register <= 0;
	else
		SC_POINTSCOUNTER_Register <= SC_POINTSCOUNTER_Signal;
end

//=======================================================
//  Outputs
//=======================================================
//OUTPUT LOGIC: COMBINATIONAL
assign SC_POINTSCOUNTER_Data_OutBus = SC_POINTSCOUNTER_Register;

endmodule 



