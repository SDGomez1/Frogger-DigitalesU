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
module SC_upSPEEDCOUNTER #(parameter upSPEEDCOUNTER_DATAWIDTH=23)(
	//////////// OUTPUTS //////////
	SC_upSPEEDCOUNTER_data_OutBUS,
	//////////// INPUTS //////////
	SC_upSPEEDCOUNTER_CLOCK_50,
	SC_upSPEEDCOUNTER_RESET_InHigh,
	SC_upSPEEDCOUNTER_upcount_InLow
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output		[upSPEEDCOUNTER_DATAWIDTH-1:0]	SC_upSPEEDCOUNTER_data_OutBUS;
input		SC_upSPEEDCOUNTER_CLOCK_50;
input		SC_upSPEEDCOUNTER_RESET_InHigh;
input		SC_upSPEEDCOUNTER_upcount_InLow;

//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [upSPEEDCOUNTER_DATAWIDTH-1:0] upSPEEDCOUNTER_Register;
reg [upSPEEDCOUNTER_DATAWIDTH-1:0] upSPEEDCOUNTER_Signal;
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always @(*)
begin
	if (SC_upSPEEDCOUNTER_upcount_InLow == 1'b0)
		upSPEEDCOUNTER_Signal = upSPEEDCOUNTER_Register + 1'b1;
	else
		upSPEEDCOUNTER_Signal = 1'b0;
	end	
//STATE REGISTER: SEQUENTIAL
always @(posedge SC_upSPEEDCOUNTER_CLOCK_50, posedge SC_upSPEEDCOUNTER_RESET_InHigh)
begin
	if (SC_upSPEEDCOUNTER_RESET_InHigh  == 1'b1)
		upSPEEDCOUNTER_Register <= 0;
	else
		upSPEEDCOUNTER_Register <= upSPEEDCOUNTER_Signal;
end
//=======================================================
//  Outputs
//=======================================================
//OUTPUT LOGIC: COMBINATIONAL
assign SC_upSPEEDCOUNTER_data_OutBUS = upSPEEDCOUNTER_Register;

endmodule 