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
module BB_SYSTEM (
//////////// OUTPUTS //////////
	BB_SYSTEM_max7219DIN_Out,
	BB_SYSTEM_max7219NCS_Out,
	BB_SYSTEM_max7219CLK_Out,

	BB_SYSTEM_startButton_Out, 
	BB_SYSTEM_leftButton_Out,
	BB_SYSTEM_rightButton_Out,

//////////// INPUTS //////////
	BB_SYSTEM_CLOCK_50,
	BB_SYSTEM_RESET_InHigh,
	BB_SYSTEM_startButton_InLow, 
	BB_SYSTEM_leftButton_InLow,
	BB_SYSTEM_rightButton_InLow
);
//=======================================================
//  PARAMETER declarations
//=======================================================
 parameter DATAWIDTH_BUS 									= 8;
 parameter PRESCALER_DATAWIDTH 							= 24;
 parameter DISPLAY_DATAWIDTH								= 12;
 parameter MAIN_STATEMACHINE_STATE_DATAWIDTH			= 2;
 parameter LEVELCOUNTER_DATAWIDTH						= 3; 
 parameter LEVELPROGRESSCOUNTER_DATAWIDTH				= 5;


 parameter DATA_FIXED_INITREGPOINT_7 = 8'b00010000;
 parameter DATA_FIXED_INITREGPOINT_6 = 8'b00111000;
 parameter DATA_FIXED_INITREGPOINT_5 = 8'b01111100;
 parameter DATA_FIXED_INITREGPOINT_4 = 8'b01111100;
 parameter DATA_FIXED_INITREGPOINT_3 = 8'b00111000;
 parameter DATA_FIXED_INITREGPOINT_2 = 8'b00010000;
 parameter DATA_FIXED_INITREGPOINT_1 = 8'b00000000;
 parameter DATA_FIXED_INITREGPOINT_0 = 8'b00010000;
 
 //=======================================================
//  PORT declarations
//=======================================================
output		BB_SYSTEM_max7219DIN_Out;
output		BB_SYSTEM_max7219NCS_Out;
output		BB_SYSTEM_max7219CLK_Out;

output 		BB_SYSTEM_startButton_Out;
output 		BB_SYSTEM_leftButton_Out;
output 		BB_SYSTEM_rightButton_Out;

input		BB_SYSTEM_CLOCK_50;
input		BB_SYSTEM_RESET_InHigh;
input		BB_SYSTEM_startButton_InLow;
input		BB_SYSTEM_leftButton_InLow;
input		BB_SYSTEM_rightButton_InLow;
//=======================================================
//  REG/WIRE declarations
//=======================================================
// BUTTONS (DEBOUNCERS)s
wire 	BB_SYSTEM_startButton_InLow_cwire;
wire 	BB_SYSTEM_leftButton_InLow_cwire;
wire 	BB_SYSTEM_rightButton_InLow_cwire;

// GAME
wire [DATAWIDTH_BUS-1:0] regGAME_data7_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data6_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data5_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data4_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data3_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data2_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data1_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data0_wire;

wire 	[7:0] data_max;
wire 	[2:0] add;


// MAIN_STATEMACHINE

wire [MAIN_STATEMACHINE_STATE_DATAWIDTH-1:0] MAIN_STATEMACHINE_CurrentState_cwire;


// LEVEL_STATEMACHINE

wire LEVEL_STATEMACHINE_LevelFinished_Out_cwire;
wire LEVEL_STATEMACHINE_StartCount_Out_cwire;
wire LEVEL_STATEMACHINE_FinishedGame_Out_cwire;

//LEVEL_COUNTER

wire [LEVELCOUNTER_DATAWIDTH-1:0]	LEVELCOUNTER_DataOut_cwire;

//LEVEL_PROGRESS_COUNTER

wire [LEVELPROGRESSCOUNTER_DATAWIDTH-1:0] LEVELPROGRESSCOUNTER_DataOut_cwire;

//PRESCALER

wire [PRESCALER_DATAWIDTH-1:0]upSPEEDCOUNTER_data_OutBUS_cwire;
wire SPEEDCOMPARATOR_T0_Out_cwire;


//LEVEL_DATAHANDLER
wire [DATAWIDTH_BUS-1:0] LEVEL_DATAHANDLER_LevelData_OutBus_cwire;

// REG WIRES

wire [DATAWIDTH_BUS-1:0]REG0toReg1_DataBus_out;
wire [DATAWIDTH_BUS-1:0]REG1toReg2_DataBus_out;
wire [DATAWIDTH_BUS-1:0]REG2toReg3_DataBus_out;
wire [DATAWIDTH_BUS-1:0]REG3toReg4_DataBus_out;
wire [DATAWIDTH_BUS-1:0]REG4toReg5_DataBus_out;
wire [DATAWIDTH_BUS-1:0]REG5toReg6_DataBus_out;
wire [DATAWIDTH_BUS-1:0]REG6toReg7_DataBus_out;

//DELAY
wire [DATAWIDTH_BUS-1:0]REG0toReg1_DelayBus_out;
wire [DATAWIDTH_BUS-1:0]REG1toReg2_DelayBus_out;
wire [DATAWIDTH_BUS-1:0]REG2toReg3_DelayBus_out;
wire [DATAWIDTH_BUS-1:0]REG3toReg4_DelayBus_out;
wire [DATAWIDTH_BUS-1:0]REG4toReg5_DelayBus_out;
wire [DATAWIDTH_BUS-1:0]REG5toReg6_DelayBus_out;
wire [DATAWIDTH_BUS-1:0]REG6toReg7_DelayBus_out;

//=======================================================
//  Structural coding
//=======================================================

//######################################################################
//#	INPUTS
//######################################################################
SC_DEBOUNCE1 SC_DEBOUNCE1_u0 (
// port map - connection between master ports and signals/registers   
	.SC_DEBOUNCE1_button_Out(BB_SYSTEM_startButton_InLow_cwire),
	.SC_DEBOUNCE1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_DEBOUNCE1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_DEBOUNCE1_button_In(~BB_SYSTEM_startButton_InLow)
);
SC_DEBOUNCE1 SC_DEBOUNCE1_u1 (
// port map - connection between master ports and signals/registers   
	.SC_DEBOUNCE1_button_Out(BB_SYSTEM_leftButton_InLow_cwire),
	.SC_DEBOUNCE1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_DEBOUNCE1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_DEBOUNCE1_button_In(~BB_SYSTEM_leftButton_InLow)
);
SC_DEBOUNCE1 SC_DEBOUNCE1_u2 (
// port map - connection between master ports and signals/registers   
	.SC_DEBOUNCE1_button_Out(BB_SYSTEM_rightButton_InLow_cwire),
	.SC_DEBOUNCE1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_DEBOUNCE1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_DEBOUNCE1_button_In(~BB_SYSTEM_rightButton_InLow)
);

//######################################################################
//#	!!! ACA VAN TUS COMPONENTES
//######################################################################


//----------------------------------------------------------------------
// MAIN_STATEMACHINE
//----------------------------------------------------------------------

SC_MAIN_STATEMACHINE SC_MAIN_STATEMACHINE_u0 (
// port map - connection between master ports and signals/registers   
	.SC_MAIN_STATEMACHINE_CurrentState_Out(MAIN_STATEMACHINE_CurrentState_cwire),
	.SC_MAIN_STATEMACHINE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_MAIN_STATEMACHINE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_MAIN_STATEMACHINE_StartSignal_InLow(BB_SYSTEM_startButton_InLow_cwire),
	.SC_MAIN_STATEMACHINE_EndGameSignal_InLow(LEVEL_STATEMACHINE_FinishedGame_Out_cwire)
);

//----------------------------------------------------------------------
// LEVEL_STATEMACHINE
//----------------------------------------------------------------------

SC_LEVEL_STATEMACHINE SC_LEVEL_STATEMACHINE_u0(
	.SC_LEVEL_STATEMACHINE_LevelFinished_Out(LEVEL_STATEMACHINE_LevelFinished_Out_cwire),
	.SC_LEVEL_STATEMACHINE_StartCount_Out(LEVEL_STATEMACHINE_StartCount_Out_cwire),
	.SC_LEVEL_STATEMACHINE_FinishedGame_Out(LEVEL_STATEMACHINE_FinishedGame_Out_cwire),
	.SC_LEVEL_STATEMACHINE_CurrentLevel_In(LEVELCOUNTER_DataOut_cwire),
	.SC_LEVEL_STATEMACHINE_LvlProgressCount_In(LEVELPROGRESSCOUNTER_DataOut_cwire),
	.SC_LEVEL_STATEMACHINE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_LEVEL_STATEMACHINE_RESET_InHigh(BB_SYSTEM_RESET_InHigh)
);
//----------------------------------------------------------------------
// LEVEL_COUNTER
//----------------------------------------------------------------------

SC_LEVELCOUNTER SC_LEVELCOUNTER_u0(
	.SC_LEVELCOUNTER_Data_OutBus(LEVELCOUNTER_DataOut_cwire),
	.SC_LEVELCOUNTER_CurrentState_Inbus(MAIN_STATEMACHINE_CurrentState_cwire),
	.SC_LEVELCOUNTER_CountSignal_InLow(LEVEL_STATEMACHINE_LevelFinished_Out_cwire),
	.SC_LEVELCOUNTER_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_LEVELCOUNTER_RESET_InHigh(BB_SYSTEM_RESET_InHigh)
);

//----------------------------------------------------------------------
//LEVEL_PROGRESS_COUNTER
//----------------------------------------------------------------------
SC_LEVELPROGRESSCOUNTER SC_LEVELPROGRESSCOUNTER_u0(
	.SC_LEVELPROGRESSCOUNTER_Data_OutBus(LEVELPROGRESSCOUNTER_DataOut_cwire),
	.SC_LEVELPROGRESSCOUNTER_CountSignal_in(SPEEDCOMPARATOR_T0_Out_cwire),
	.SC_LEVELPROGRESSCOUNTER_StartCountSignal_in(LEVEL_STATEMACHINE_StartCount_Out_cwire),
	.SC_LEVELPROGRESSCOUNTER_FinishedGame_in(LEVEL_STATEMACHINE_FinishedGame_Out_cwire),
	.SC_LEVELPROGRESSCOUNTER_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_LEVELPROGRESSCOUNTER_RESET_InHigh(BB_SYSTEM_RESET_InHigh)
);

//----------------------------------------------------------------------
//PRESCALER
//----------------------------------------------------------------------

SC_upSPEEDCOUNTER #(.upSPEEDCOUNTER_DATAWIDTH(PRESCALER_DATAWIDTH))
	SC_upSPEEDCOUNTER_u0(
		.SC_upSPEEDCOUNTER_data_OutBUS(upSPEEDCOUNTER_data_OutBUS_cwire),
		.SC_upSPEEDCOUNTER_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_upSPEEDCOUNTER_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_upSPEEDCOUNTER_upcount_InLow(SPEEDCOMPARATOR_T0_Out_cwire)
);

CC_SPEEDCOMPARATOR #(.SPEEDCOMPARATOR_DATAWIDTH(PRESCALER_DATAWIDTH))
	CC_SPEEDCOMPARATOR_u0(
		.CC_SPEEDCOMPARATOR_T0_OutLow(SPEEDCOMPARATOR_T0_Out_cwire),
		.CC_SPEEDCOMPARATOR_data_InBUS(upSPEEDCOUNTER_data_OutBUS_cwire),
		.CC_SPEEDCOMPARATOR_StartCount_In(LEVEL_STATEMACHINE_StartCount_Out_cwire)
);

//----------------------------------------------------------------------
//LEVEL_DATAHANDLER
//----------------------------------------------------------------------

CC_LEVEL_DATAHANDLER CC_LEVEL_DATAHANDLER_u0(
	.CC_LEVEL_DATAHANDLER_LevelData_OutBus(LEVEL_DATAHANDLER_LevelData_OutBus_cwire),
	.CC_LEVEL_DATAHANDLER_LvlProgress(LEVELPROGRESSCOUNTER_DataOut_cwire),
	.CC_LEVEL_DATAHANDLER_CurrentLvl(LEVELCOUNTER_DataOut_cwire)

);

//----------------------------------------------------------------------
//CAR_REGISTERS
//----------------------------------------------------------------------

SC_RegGENERAL_CAR  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_CAR_u0(
		.SC_RegGENERAL_CAR_data_OutBUS(REG0toReg1_DataBus_out),
		.SC_RegGENERAL_CAR_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_CAR_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_CAR_load_InLow(LEVEL_STATEMACHINE_StartCount_Out_cwire),
		.SC_RegGENERAL_CAR_data_InBUS(LEVEL_DATAHANDLER_LevelData_OutBus_cwire)
);

SC_RegGENERAL_CAR  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_CAR_u1(
		.SC_RegGENERAL_CAR_data_OutBUS(REG1toReg2_DataBus_out),
		.SC_RegGENERAL_CAR_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_CAR_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_CAR_load_InLow(LEVEL_STATEMACHINE_StartCount_Out_cwire),
		.SC_RegGENERAL_CAR_data_InBUS(REG0toReg1_DelayBus_out)
);


SC_RegGENERAL_CAR  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_CAR_u2(
		.SC_RegGENERAL_CAR_data_OutBUS(REG2toReg3_DataBus_out),
		.SC_RegGENERAL_CAR_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_CAR_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_CAR_load_InLow(LEVEL_STATEMACHINE_StartCount_Out_cwire),
		.SC_RegGENERAL_CAR_data_InBUS(REG1toReg2_DelayBus_out)
);

SC_RegGENERAL_CAR  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_CAR_u3(
		.SC_RegGENERAL_CAR_data_OutBUS(REG3toReg4_DataBus_out),
		.SC_RegGENERAL_CAR_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_CAR_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_CAR_load_InLow(LEVEL_STATEMACHINE_StartCount_Out_cwire),
		.SC_RegGENERAL_CAR_data_InBUS(REG2toReg3_DelayBus_out)
);
SC_RegGENERAL_CAR  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_CAR_u4(
		.SC_RegGENERAL_CAR_data_OutBUS(REG4toReg5_DataBus_out),
		.SC_RegGENERAL_CAR_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_CAR_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_CAR_load_InLow(LEVEL_STATEMACHINE_StartCount_Out_cwire),
		.SC_RegGENERAL_CAR_data_InBUS(REG3toReg4_DelayBus_out)
);
SC_RegGENERAL_CAR  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_CAR_u5(
		.SC_RegGENERAL_CAR_data_OutBUS(REG5toReg6_DataBus_out),
		.SC_RegGENERAL_CAR_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_CAR_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_CAR_load_InLow(LEVEL_STATEMACHINE_StartCount_Out_cwire),
		.SC_RegGENERAL_CAR_data_InBUS(REG4toReg5_DelayBus_out)
);

SC_RegGENERAL_CAR  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_CAR_u6(
		.SC_RegGENERAL_CAR_data_OutBUS(REG6toReg7_DataBus_out),
		.SC_RegGENERAL_CAR_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_CAR_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_CAR_load_InLow(LEVEL_STATEMACHINE_StartCount_Out_cwire),
		.SC_RegGENERAL_CAR_data_InBUS(REG5toReg6_DelayBus_out)
);
SC_RegGENERAL_CAR  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_CAR_u7(
		.SC_RegGENERAL_CAR_data_OutBUS(),
		.SC_RegGENERAL_CAR_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_CAR_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_CAR_load_InLow(LEVEL_STATEMACHINE_StartCount_Out_cwire),
		.SC_RegGENERAL_CAR_data_InBUS(REG6toReg7_DelayBus_out)
);

//----------------------------------------------------------------------
//DATA_DELAY
//----------------------------------------------------------------------

CC_DATADELAY CC_DATADELAY_u0 (
	.CC_DATADELAY_DelayedData_outBus(REG0toReg1_DelayBus_out),
	.CC_DATADELAY_Data_inBus(REG0toReg1_DataBus_out),
	.CC_DATADELAY_SendDataSignal_In(SPEEDCOMPARATOR_T0_Out_cwire)
);
CC_DATADELAY CC_DATADELAY_u1 (
	.CC_DATADELAY_DelayedData_outBus(REG1toReg2_DelayBus_out),
	.CC_DATADELAY_Data_inBus(REG1toReg2_DataBus_out),
	.CC_DATADELAY_SendDataSignal_In(SPEEDCOMPARATOR_T0_Out_cwire)
);
CC_DATADELAY CC_DATADELAY_u2 (
	.CC_DATADELAY_DelayedData_outBus(REG2toReg3_DelayBus_out),
	.CC_DATADELAY_Data_inBus(REG2toReg3_DataBus_out),
	.CC_DATADELAY_SendDataSignal_In(SPEEDCOMPARATOR_T0_Out_cwire)
);
CC_DATADELAY CC_DATADELAY_u3 (
	.CC_DATADELAY_DelayedData_outBus(REG3toReg4_DelayBus_out),
	.CC_DATADELAY_Data_inBus(REG3toReg4_DataBus_out),
	.CC_DATADELAY_SendDataSignal_In(SPEEDCOMPARATOR_T0_Out_cwire)
);
CC_DATADELAY CC_DATADELAY_u4 (
	.CC_DATADELAY_DelayedData_outBus(REG4toReg5_DelayBus_out),
	.CC_DATADELAY_Data_inBus(REG4toReg5_DataBus_out),
	.CC_DATADELAY_SendDataSignal_In(SPEEDCOMPARATOR_T0_Out_cwire)
);
CC_DATADELAY CC_DATADELAY_u5 (
	.CC_DATADELAY_DelayedData_outBus(REG5toReg6_DelayBus_out),
	.CC_DATADELAY_Data_inBus(REG5toReg6_DataBus_out),
	.CC_DATADELAY_SendDataSignal_In(SPEEDCOMPARATOR_T0_Out_cwire)
);
CC_DATADELAY CC_DATADELAY_u6 (
	.CC_DATADELAY_DelayedData_outBus(REG6toReg7_DelayBus_out),
	.CC_DATADELAY_Data_inBus(REG6toReg7_DataBus_out),
	.CC_DATADELAY_SendDataSignal_In(SPEEDCOMPARATOR_T0_Out_cwire)
);
//######################################################################
//#	TO LED MATRIZ: VISUALIZATION
//######################################################################
assign regGAME_data0_wire = DATA_FIXED_INITREGPOINT_0;
assign regGAME_data1_wire = DATA_FIXED_INITREGPOINT_1;
assign regGAME_data2_wire = DATA_FIXED_INITREGPOINT_2;
assign regGAME_data3_wire = DATA_FIXED_INITREGPOINT_3;
assign regGAME_data4_wire = DATA_FIXED_INITREGPOINT_4;
assign regGAME_data5_wire = DATA_FIXED_INITREGPOINT_5;
assign regGAME_data6_wire = DATA_FIXED_INITREGPOINT_6;
assign regGAME_data7_wire = DATA_FIXED_INITREGPOINT_7;

assign data_max =(add==3'b000)?{regGAME_data0_wire[7],regGAME_data1_wire[7],regGAME_data2_wire[7],regGAME_data3_wire[7],regGAME_data4_wire[7],regGAME_data5_wire[7],regGAME_data6_wire[7],regGAME_data7_wire[7]}:
	       (add==3'b001)?{regGAME_data0_wire[6],regGAME_data1_wire[6],regGAME_data2_wire[6],regGAME_data3_wire[6],regGAME_data4_wire[6],regGAME_data5_wire[6],regGAME_data6_wire[6],regGAME_data7_wire[6]}:
	       (add==3'b010)?{regGAME_data0_wire[5],regGAME_data1_wire[5],regGAME_data2_wire[5],regGAME_data3_wire[5],regGAME_data4_wire[5],regGAME_data5_wire[5],regGAME_data6_wire[5],regGAME_data7_wire[5]}:
	       (add==3'b011)?{regGAME_data0_wire[4],regGAME_data1_wire[4],regGAME_data2_wire[4],regGAME_data3_wire[4],regGAME_data4_wire[4],regGAME_data5_wire[4],regGAME_data6_wire[4],regGAME_data7_wire[4]}:
	       (add==3'b100)?{regGAME_data0_wire[3],regGAME_data1_wire[3],regGAME_data2_wire[3],regGAME_data3_wire[3],regGAME_data4_wire[3],regGAME_data5_wire[3],regGAME_data6_wire[3],regGAME_data7_wire[3]}:
	       (add==3'b101)?{regGAME_data0_wire[2],regGAME_data1_wire[2],regGAME_data2_wire[2],regGAME_data3_wire[2],regGAME_data4_wire[2],regGAME_data5_wire[2],regGAME_data6_wire[2],regGAME_data7_wire[2]}:
	       (add==3'b110)?{regGAME_data0_wire[1],regGAME_data1_wire[1],regGAME_data2_wire[1],regGAME_data3_wire[1],regGAME_data4_wire[1],regGAME_data5_wire[1],regGAME_data6_wire[1],regGAME_data7_wire[1]}:
						{regGAME_data0_wire[0],regGAME_data1_wire[0],regGAME_data2_wire[0],regGAME_data3_wire[0],regGAME_data4_wire[0],regGAME_data5_wire[0],regGAME_data6_wire[0],regGAME_data7_wire[0]};
									 
matrix_ctrl matrix_ctrl_unit_0( 
.max7219_din(BB_SYSTEM_max7219DIN_Out),//max7219_din 
.max7219_ncs(BB_SYSTEM_max7219NCS_Out),//max7219_ncs 
.max7219_clk(BB_SYSTEM_max7219CLK_Out),//max7219_clk
.disp_data(data_max), 
.disp_addr(add),
.intensity(4'hA),
.clk(BB_SYSTEM_CLOCK_50),
.reset(BB_SYSTEM_RESET_InHigh) //~lowRst_System
 ); 
 
//######################################################################
//#	TO TEST
//######################################################################

assign BB_SYSTEM_startButton_Out = BB_SYSTEM_startButton_InLow_cwire;
assign BB_SYSTEM_leftButton_Out = BB_SYSTEM_leftButton_InLow_cwire;
assign BB_SYSTEM_rightButton_Out = BB_SYSTEM_rightButton_InLow_cwire;




endmodule
