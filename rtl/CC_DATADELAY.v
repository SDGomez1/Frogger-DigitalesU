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

module CC_DATADELAY(
//////////// OUTPUTS //////////
	CC_DATADELAY_DelayedData_outBus,

//////////// INPUTS //////////
	CC_DATADELAY_Data_inBus,
	CC_DATADELAY_SendDataSignal_In

);

//=======================================================
//  PARAMETER declarations
//=======================================================

parameter DATAWIDTH_BUS 									= 8;

//=======================================================
//  PORT declarations
//=======================================================

	
output reg	[DATAWIDTH_BUS-1:0] CC_DATADELAY_DelayedData_outBus;

input			[DATAWIDTH_BUS-1:0] CC_DATADELAY_Data_inBus;
input			CC_DATADELAY_SendDataSignal_In;


//=======================================================
//  REG/WIRE declarations
//=======================================================

reg [DATAWIDTH_BUS-1:0] DELAYED_DATA;

//=======================================================
//  Structural coding
//=======================================================


always @(CC_DATADELAY_SendDataSignal_In) begin

  DELAYED_DATA <= CC_DATADELAY_Data_inBus;
end


//=======================================================
//  Outputs
//=======================================================

always @(CC_DATADELAY_SendDataSignal_In) begin

  CC_DATADELAY_DelayedData_outBus <= DELAYED_DATA;
end

endmodule

