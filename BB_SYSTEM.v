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
	BB_SYSTEM_upButton_Out,
	BB_SYSTEM_downButton_Out,
	
//////////// INPUTS //////////
	BB_SYSTEM_CLOCK_50,
	BB_SYSTEM_RESET_InHigh,
	BB_SYSTEM_startButton_InLow, 
	BB_SYSTEM_leftButton_InLow,
	BB_SYSTEM_rightButton_InLow,
	BB_SYSTEM_upButton_InLow,
	BB_SYSTEM_downButton_InLow
);
//=======================================================
//  PARAMETER declarations
//=======================================================
 parameter DATAWIDTH_BUS 									= 8;
 parameter PRESCALER_DATAWIDTH 							= 23;
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
 
 parameter DATA_FIXED_ENDSCREEN_7 = 8'b00000000;
 parameter DATA_FIXED_ENDSCREEN_6 = 8'b00000000;
 parameter DATA_FIXED_ENDSCREEN_5 = 8'b01111100;
 parameter DATA_FIXED_ENDSCREEN_4 = 8'b01000000;
 parameter DATA_FIXED_ENDSCREEN_3 = 8'b01111100;
 parameter DATA_FIXED_ENDSCREEN_2 = 8'b01000000;
 parameter DATA_FIXED_ENDSCREEN_1 = 8'b01111100;
 parameter DATA_FIXED_ENDSCREEN_0 = 8'b00000000;
 
 //=======================================================
//  PORT declarations
//=======================================================
output		BB_SYSTEM_max7219DIN_Out;
output		BB_SYSTEM_max7219NCS_Out;
output		BB_SYSTEM_max7219CLK_Out;

output 		BB_SYSTEM_startButton_Out;
output 		BB_SYSTEM_leftButton_Out;
output 		BB_SYSTEM_rightButton_Out;
output 		BB_SYSTEM_upButton_Out;
output 		BB_SYSTEM_downButton_Out;

input			BB_SYSTEM_CLOCK_50;
input			BB_SYSTEM_RESET_InHigh;
input			BB_SYSTEM_startButton_InLow;
input			BB_SYSTEM_leftButton_InLow;
input			BB_SYSTEM_rightButton_InLow;
input 		BB_SYSTEM_upButton_InLow;
input 		BB_SYSTEM_downButton_InLow;
//=======================================================
//  REG/WIRE declarations
//=======================================================
// BUTTONS (DEBOUNCERS)s
wire 	BB_SYSTEM_startButton_InLow_cwire;
wire 	BB_SYSTEM_leftButton_InLow_cwire;
wire 	BB_SYSTEM_rightButton_InLow_cwire;
wire	BB_SYSTEM_upButton_InLow_cwire;
wire 	BB_SYSTEM_downButton_InLow_cwire;

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


//----------------------------------------------------------------------
// MAIN_STATEMACHINE WIRES
//----------------------------------------------------------------------

wire [MAIN_STATEMACHINE_STATE_DATAWIDTH-1:0] MAIN_STATEMACHINE_CurrentState_cwire;
wire MAIN_STATEMACHINE_LoadSignal_out_cwire;

//----------------------------------------------------------------------
// LEVEL_STATEMACHINE WIRES
//----------------------------------------------------------------------

wire LEVEL_STATEMACHINE_LevelFinished_Out_cwire;
wire LEVEL_STATEMACHINE_FinishedGame_Out_cwire;
wire LEVEL_STATEMACHINE_upCount_out_cwire;
wire LEVEL_STATEMACHINE_ProgressUpCount_out_cwire;

//----------------------------------------------------------------------
// SC_PLAYER_STATEMACHINE WIRES
//----------------------------------------------------------------------

wire [1:0]PLAYER_STATEMACHINE_ShiftSelection_Out_cwire;
wire PLAYER_STATEMACHINE_LoadData_Out_cwire;
wire [DATAWIDTH_BUS-1:0] PLAYER_STATEMACHINE_PlayerData_Out_cwire;
wire PLAYER_STATEMACHINE_PlayerLose_Out_cwire;


wire [1:0]PLAYER_STATEMACHINE_PLAYER_2_ShiftSelection_Out_cwire;
wire PLAYER_STATEMACHINE_PLAYER_2_LoadData_Out_cwire;
wire [DATAWIDTH_BUS-1:0] PLAYER_STATEMACHINE_PLAYER_2_PlayerData_Out_cwire;
wire PLAYER_STATEMACHINE_PLAYER_2_PlayerLose_Out_cwire;

//----------------------------------------------------------------------
// LEVEL_COUNTER WIRES
//----------------------------------------------------------------------

wire [LEVELCOUNTER_DATAWIDTH-1:0]	LEVELCOUNTER_DataOut_cwire;

//----------------------------------------------------------------------
// LEVEL_PROGRESS_COUNTER WIRES
//----------------------------------------------------------------------

wire [LEVELPROGRESSCOUNTER_DATAWIDTH-1:0] LEVELPROGRESSCOUNTER_DataOut_cwire;


//----------------------------------------------------------------------
// PRESCALER WIRES
//----------------------------------------------------------------------

wire [PRESCALER_DATAWIDTH-1:0]upSPEEDCOUNTER_data_OutBUS_cwire;
wire SPEEDCOMPARATOR_T0_Out_cwire;

//----------------------------------------------------------------------
// LEVEL_DATAHANDLER WIRES
//----------------------------------------------------------------------

wire [DATAWIDTH_BUS-1:0] LEVEL_DATAHANDLER_LevelData_OutBus_cwire;

//----------------------------------------------------------------------
// LEVEL_DATAHANDLER_PLAYER_2 WIRES
//----------------------------------------------------------------------

wire [DATAWIDTH_BUS-1:0] LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus_cwire;

//----------------------------------------------------------------------
// CAR_REGISTERS WIRES
//----------------------------------------------------------------------

wire [DATAWIDTH_BUS-1:0]REG0toReg1_DataBus_out;
wire [DATAWIDTH_BUS-1:0]REG1toReg2_DataBus_out;
wire [DATAWIDTH_BUS-1:0]REG2toReg3_DataBus_out;
wire [DATAWIDTH_BUS-1:0]REG3toReg4_DataBus_out;
wire [DATAWIDTH_BUS-1:0]REG4toReg5_DataBus_out;
wire [DATAWIDTH_BUS-1:0]REG5toReg6_DataBus_out;
wire [DATAWIDTH_BUS-1:0]REG6toReg7_DataBus_out;
wire [DATAWIDTH_BUS-1:0]REG8_DataBus_out;

//----------------------------------------------------------------------
// DATA_DELAY WIRES
//----------------------------------------------------------------------
wire [DATAWIDTH_BUS-1:0]REG0toReg1_DelayBus_out;
wire [DATAWIDTH_BUS-1:0]REG1toReg2_DelayBus_out;
wire [DATAWIDTH_BUS-1:0]REG2toReg3_DelayBus_out;
wire [DATAWIDTH_BUS-1:0]REG3toReg4_DelayBus_out;
wire [DATAWIDTH_BUS-1:0]REG4toReg5_DelayBus_out;
wire [DATAWIDTH_BUS-1:0]REG5toReg6_DelayBus_out;
wire [DATAWIDTH_BUS-1:0]REG6toReg7_DelayBus_out;




//----------------------------------------------------------------------
// SC_RegSHIFTER_PLAYER_1 wires
//----------------------------------------------------------------------
wire [DATAWIDTH_BUS-1:0]RegSHIFTER_data_OutBUS_cwire;


//----------------------------------------------------------------------
//CC_PLAYER_CAR_COMPARATOR wire
//----------------------------------------------------------------------
wire [DATAWIDTH_BUS-1:0]PLAYER_CAR_COMPARATOR_Data_OutBus_cwire;
wire PLAYER_CAR_COMPARATOR_PlayerLose_Out_cwire;

//----------------------------------------------------------------------
// CAR_PLAYER2_REGISTERS WIRES
//----------------------------------------------------------------------

wire [DATAWIDTH_BUS-1:0]PLAYER2_REG0toReg1_DataBus_out;
wire [DATAWIDTH_BUS-1:0]PLAYER2_REG1toReg2_DataBus_out;
wire [DATAWIDTH_BUS-1:0]PLAYER2_REG2toReg3_DataBus_out;
wire [DATAWIDTH_BUS-1:0]PLAYER2_REG3toReg4_DataBus_out;
wire [DATAWIDTH_BUS-1:0]PLAYER2_REG4toReg5_DataBus_out;
wire [DATAWIDTH_BUS-1:0]PLAYER2_REG5toReg6_DataBus_out;
wire [DATAWIDTH_BUS-1:0]PLAYER2_REG6toReg7_DataBus_out;
wire [DATAWIDTH_BUS-1:0]PLAYER2_REG8_DataBus_out;

//----------------------------------------------------------------------
// DATA_DELAY WIRES
//----------------------------------------------------------------------
wire [DATAWIDTH_BUS-1:0]PLAYER2_REG0toReg1_DelayBus_out;
wire [DATAWIDTH_BUS-1:0]PLAYER2_REG1toReg2_DelayBus_out;
wire [DATAWIDTH_BUS-1:0]PLAYER2_REG2toReg3_DelayBus_out;
wire [DATAWIDTH_BUS-1:0]PLAYER2_REG3toReg4_DelayBus_out;
wire [DATAWIDTH_BUS-1:0]PLAYER2_REG4toReg5_DelayBus_out;
wire [DATAWIDTH_BUS-1:0]PLAYER2_REG5toReg6_DelayBus_out;
wire [DATAWIDTH_BUS-1:0]PLAYER2_REG6toReg7_DelayBus_out;

//----------------------------------------------------------------------
// SC_RegSHIFTER_PLAYER_2 wires
//----------------------------------------------------------------------
wire [DATAWIDTH_BUS-1:0]RegSHIFTER_PLAYER_2_data_OutBUS_cwire;


//----------------------------------------------------------------------
//CC_PLAYER_CAR_PLAYER_2_COMPARATOR wire
//----------------------------------------------------------------------
wire [DATAWIDTH_BUS-1:0]CAR_COMPARATOR_PLAYER_2_Data_OutBus_cwire;
wire PLAYER_CAR_COMPARATOR_PLAYER_2_PlayerLose_Out_cwire;

//----------------------------------------------------------------------
// SC_POINTSCOUNTER WIRES
//----------------------------------------------------------------------

wire [5:0] POINTSCOUNTER_Data_OutBus_cwire;
wire [5:0] POINTSCOUNTER_PLAYER_2_Data_OutBus_cwire;

//----------------------------------------------------------------------
// REGTOMUX
//----------------------------------------------------------------------

wire [DATAWIDTH_BUS-1:0]REGTOMUX_REG0_DataBus_Out_cwire;
wire [DATAWIDTH_BUS-1:0]REGTOMUX_REG1_DataBus_Out_cwire;
wire [DATAWIDTH_BUS-1:0]REGTOMUX_REG2_DataBus_Out_cwire;
wire [DATAWIDTH_BUS-1:0]REGTOMUX_REG3_DataBus_Out_cwire;
wire [DATAWIDTH_BUS-1:0]REGTOMUX_REG4_DataBus_Out_cwire;
wire [DATAWIDTH_BUS-1:0]REGTOMUX_REG5_DataBus_Out_cwire;
wire [DATAWIDTH_BUS-1:0]REGTOMUX_REG6_DataBus_Out_cwire;
wire [DATAWIDTH_BUS-1:0]REGTOMUX_REG7_DataBus_Out_cwire;

//----------------------------------------------------------------------
// mux3_1 WIRES
//----------------------------------------------------------------------

wire [DATAWIDTH_BUS-1:0]MUX3_1_REG0_DataBus_Out_cwire;
wire [DATAWIDTH_BUS-1:0]MUX3_1_REG1_DataBus_Out_cwire;
wire [DATAWIDTH_BUS-1:0]MUX3_1_REG2_DataBus_Out_cwire;
wire [DATAWIDTH_BUS-1:0]MUX3_1_REG3_DataBus_Out_cwire;
wire [DATAWIDTH_BUS-1:0]MUX3_1_REG4_DataBus_Out_cwire;
wire [DATAWIDTH_BUS-1:0]MUX3_1_REG5_DataBus_Out_cwire;
wire [DATAWIDTH_BUS-1:0]MUX3_1_REG6_DataBus_Out_cwire;
wire [DATAWIDTH_BUS-1:0]MUX3_1_REG7_DataBus_Out_cwire;


//----------------------------------------------------------------------
// WINNERCOMPARATOR WIRES
//----------------------------------------------------------------------

wire [DATAWIDTH_BUS-1:0]WINNERCOMPARATOR_Data0_outBus_cwire;
wire [DATAWIDTH_BUS-1:0]WINNERCOMPARATOR_Data1_outBus_cwire;
wire [DATAWIDTH_BUS-1:0]WINNERCOMPARATOR_Data2_outBus_cwire;
wire [DATAWIDTH_BUS-1:0]WINNERCOMPARATOR_Data3_outBus_cwire;
wire [DATAWIDTH_BUS-1:0]WINNERCOMPARATOR_Data4_outBus_cwire;
wire [DATAWIDTH_BUS-1:0]WINNERCOMPARATOR_Data5_outBus_cwire;
wire [DATAWIDTH_BUS-1:0]WINNERCOMPARATOR_Data6_outBus_cwire;
wire [DATAWIDTH_BUS-1:0]WINNERCOMPARATOR_Data7_outBus_cwire;


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

SC_DEBOUNCE1 SC_DEBOUNCE1_u3 (
// port map - connection between master ports and signals/registers   
	.SC_DEBOUNCE1_button_Out(BB_SYSTEM_upButton_InLow_cwire),
	.SC_DEBOUNCE1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_DEBOUNCE1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_DEBOUNCE1_button_In(~BB_SYSTEM_upButton_InLow)
);

SC_DEBOUNCE1 SC_DEBOUNCE1_u4 (
// port map - connection between master ports and signals/registers   
	.SC_DEBOUNCE1_button_Out(BB_SYSTEM_downButton_InLow_cwire),
	.SC_DEBOUNCE1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_DEBOUNCE1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_DEBOUNCE1_button_In(~BB_SYSTEM_downButton_InLow)
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
	.SC_LEVEL_STATEMACHINE_FinishedGame_Out(LEVEL_STATEMACHINE_FinishedGame_Out_cwire),
	.SC_LEVEL_STATEMACHINE_upCount_out(LEVEL_STATEMACHINE_upCount_out_cwire),
	.SC_LEVEL_STATEMACHINE_ProgressUpCount_out(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire),
	.SC_LEVEL_STATEMACHINE_CurrentLevel_In(LEVELCOUNTER_DataOut_cwire),
	.SC_LEVEL_STATEMACHINE_LvlProgressCount_In(LEVELPROGRESSCOUNTER_DataOut_cwire),
	.SC_LEVEL_STATEMACHINE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_LEVEL_STATEMACHINE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_LEVEL_STATEMACHINE_T0_InLow(SPEEDCOMPARATOR_T0_Out_cwire)
);


//----------------------------------------------------------------------
// SC_PLAYER_STATEMACHINE
//----------------------------------------------------------------------

SC_PLAYER_STATEMACHINE SC_PLAYER_STATEMACHINE_u0(
	.SC_PLAYER_STATEMACHINE_ShiftSelection_Out(PLAYER_STATEMACHINE_ShiftSelection_Out_cwire),
	.SC_PLAYER_STATEMACHINE_LoadData_Out(PLAYER_STATEMACHINE_LoadData_Out_cwire),
	.SC_PLAYER_STATEMACHINE_PlayerData_Out(PLAYER_STATEMACHINE_PlayerData_Out_cwire),
	.SC_PLAYER_STATEMACHINE_PlayerLose_Out(PLAYER_STATEMACHINE_PlayerLose_Out_cwire),
	.SC_PLAYER_STATEMACHINE_PlayerLose_InLow(PLAYER_CAR_COMPARATOR_PlayerLose_Out_cwire),
	.SC_PLAYER_STATEMACHINE_FinishedLevel_InLow(LEVEL_STATEMACHINE_LevelFinished_Out_cwire),
	.SC_PLAYER_STATEMACHINE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_PLAYER_STATEMACHINE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_PLAYER_STATEMACHINE_LeftButton_InLow(BB_SYSTEM_leftButton_InLow_cwire),
	.SC_PLAYER_STATEMACHINE_RigthButton_InLow(BB_SYSTEM_rightButton_InLow_cwire)
);

SC_PLAYER_STATEMACHINE SC_PLAYER_STATEMACHINE_u1(
	.SC_PLAYER_STATEMACHINE_ShiftSelection_Out(PLAYER_STATEMACHINE_PLAYER_2_ShiftSelection_Out_cwire),
	.SC_PLAYER_STATEMACHINE_LoadData_Out(PLAYER_STATEMACHINE_PLAYER_2_LoadData_Out_cwire),
	.SC_PLAYER_STATEMACHINE_PlayerData_Out(PLAYER_STATEMACHINE_PLAYER_2_PlayerData_Out_cwire),
	.SC_PLAYER_STATEMACHINE_PlayerLose_Out(PLAYER_STATEMACHINE_PLAYER_2_PlayerLose_Out_cwire),
	.SC_PLAYER_STATEMACHINE_PlayerLose_InLow(PLAYER_CAR_COMPARATOR_PLAYER_2_PlayerLose_Out_cwire),
	.SC_PLAYER_STATEMACHINE_FinishedLevel_InLow(LEVEL_STATEMACHINE_LevelFinished_Out_cwire),
	.SC_PLAYER_STATEMACHINE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_PLAYER_STATEMACHINE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_PLAYER_STATEMACHINE_LeftButton_InLow(BB_SYSTEM_upButton_InLow_cwire),
	.SC_PLAYER_STATEMACHINE_RigthButton_InLow(BB_SYSTEM_downButton_InLow_cwire)
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
	.SC_LEVELPROGRESSCOUNTER_CountSignal_in(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire),
	.SC_LEVELPROGRESSCOUNTER_LevelFinished_in(LEVEL_STATEMACHINE_LevelFinished_Out_cwire),
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
		.SC_upSPEEDCOUNTER_upcount_InLow(LEVEL_STATEMACHINE_upCount_out_cwire),
		.SC_upSPEEDCOUNTER_T0_InLow(SPEEDCOMPARATOR_T0_Out_cwire)
);

CC_SPEEDCOMPARATOR #(.SPEEDCOMPARATOR_DATAWIDTH(PRESCALER_DATAWIDTH))
	CC_SPEEDCOMPARATOR_u0(
		.CC_SPEEDCOMPARATOR_T0_OutLow(SPEEDCOMPARATOR_T0_Out_cwire),
		.CC_SPEEDCOMPARATOR_data_InBUS(upSPEEDCOUNTER_data_OutBUS_cwire),
		.CC_SPEEDCOMPARATOR_CurrentLevel_In(LEVELCOUNTER_DataOut_cwire)
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

SC_RegGENERAL  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_car_u0(
		.SC_RegGENERAL_data_OutBUS(REG0toReg1_DataBus_out),
		.SC_RegGENERAL_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_load_InLow(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire),
		.SC_RegGENERAL_data_InBUS(LEVEL_DATAHANDLER_LevelData_OutBus_cwire)
);

SC_RegGENERAL  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_car_u1(
		.SC_RegGENERAL_data_OutBUS(REG1toReg2_DataBus_out),
		.SC_RegGENERAL_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_load_InLow(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire),
		.SC_RegGENERAL_data_InBUS(REG0toReg1_DelayBus_out)
);


SC_RegGENERAL  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_car_u2(
		.SC_RegGENERAL_data_OutBUS(REG2toReg3_DataBus_out),
		.SC_RegGENERAL_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_load_InLow(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire),
		.SC_RegGENERAL_data_InBUS(REG1toReg2_DelayBus_out)
);

SC_RegGENERAL  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_car_u3(
		.SC_RegGENERAL_data_OutBUS(REG3toReg4_DataBus_out),
		.SC_RegGENERAL_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_load_InLow(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire),
		.SC_RegGENERAL_data_InBUS(REG2toReg3_DelayBus_out)
);
SC_RegGENERAL  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_car_u4(
		.SC_RegGENERAL_data_OutBUS(REG4toReg5_DataBus_out),
		.SC_RegGENERAL_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_load_InLow(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire),
		.SC_RegGENERAL_data_InBUS(REG3toReg4_DelayBus_out)
);
SC_RegGENERAL  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_car_u5(
		.SC_RegGENERAL_data_OutBUS(REG5toReg6_DataBus_out),
		.SC_RegGENERAL_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_load_InLow(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire),
		.SC_RegGENERAL_data_InBUS(REG4toReg5_DelayBus_out)
);

SC_RegGENERAL  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_car_u6(
		.SC_RegGENERAL_data_OutBUS(REG6toReg7_DataBus_out),
		.SC_RegGENERAL_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_load_InLow(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire),
		.SC_RegGENERAL_data_InBUS(REG5toReg6_DelayBus_out)
);
SC_RegGENERAL  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_car_u7(
		.SC_RegGENERAL_data_OutBUS(REG8_DataBus_out),
		.SC_RegGENERAL_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_load_InLow(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire),
		.SC_RegGENERAL_data_InBUS(REG6toReg7_DelayBus_out)
);

//----------------------------------------------------------------------
//DATA_DELAY
//----------------------------------------------------------------------

CC_DATADELAY CC_DATADELAY_u0 (
	.CC_DATADELAY_DelayedData_outBus(REG0toReg1_DelayBus_out),
	.CC_DATADELAY_Data_inBus(REG0toReg1_DataBus_out),
	.CC_DATADELAY_SendDataSignal_In(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire)
);
CC_DATADELAY CC_DATADELAY_u1 (
	.CC_DATADELAY_DelayedData_outBus(REG1toReg2_DelayBus_out),
	.CC_DATADELAY_Data_inBus(REG1toReg2_DataBus_out),
	.CC_DATADELAY_SendDataSignal_In(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire)
);
CC_DATADELAY CC_DATADELAY_u2 (
	.CC_DATADELAY_DelayedData_outBus(REG2toReg3_DelayBus_out),
	.CC_DATADELAY_Data_inBus(REG2toReg3_DataBus_out),
	.CC_DATADELAY_SendDataSignal_In(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire)
);
CC_DATADELAY CC_DATADELAY_u3 (
	.CC_DATADELAY_DelayedData_outBus(REG3toReg4_DelayBus_out),
	.CC_DATADELAY_Data_inBus(REG3toReg4_DataBus_out),
	.CC_DATADELAY_SendDataSignal_In(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire)
);
CC_DATADELAY CC_DATADELAY_u4 (
	.CC_DATADELAY_DelayedData_outBus(REG4toReg5_DelayBus_out),
	.CC_DATADELAY_Data_inBus(REG4toReg5_DataBus_out),
	.CC_DATADELAY_SendDataSignal_In(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire)
);
CC_DATADELAY CC_DATADELAY_u5 (
	.CC_DATADELAY_DelayedData_outBus(REG5toReg6_DelayBus_out),
	.CC_DATADELAY_Data_inBus(REG5toReg6_DataBus_out),
	.CC_DATADELAY_SendDataSignal_In(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire)
);
CC_DATADELAY CC_DATADELAY_u6 (
	.CC_DATADELAY_DelayedData_outBus(REG6toReg7_DelayBus_out),
	.CC_DATADELAY_Data_inBus(REG6toReg7_DataBus_out),
	.CC_DATADELAY_SendDataSignal_In(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire)
);



//----------------------------------------------------------------------
//MUX3_1
//----------------------------------------------------------------------

CC_MUX3_1 CC_MUX3_1_u0(
	.CC_MUX3_1_DataBus_Out(MUX3_1_REG0_DataBus_Out_cwire),
	.CC_MUX3_1_Selector_In(MAIN_STATEMACHINE_CurrentState_cwire),
	.CC_MUX3_1_DataBus1_In(DATA_FIXED_INITREGPOINT_0),
	.CC_MUX3_1_DataBus2_In(REGTOMUX_REG0_DataBus_Out_cwire),
	.CC_MUX3_1_DataBus3_In(WINNERCOMPARATOR_Data0_outBus_cwire)
);
CC_MUX3_1 CC_MUX3_1_u1(
	.CC_MUX3_1_DataBus_Out(MUX3_1_REG1_DataBus_Out_cwire),
	.CC_MUX3_1_Selector_In(MAIN_STATEMACHINE_CurrentState_cwire),
	.CC_MUX3_1_DataBus1_In(DATA_FIXED_INITREGPOINT_1),
	.CC_MUX3_1_DataBus2_In(REGTOMUX_REG1_DataBus_Out_cwire),
	.CC_MUX3_1_DataBus3_In(WINNERCOMPARATOR_Data1_outBus_cwire)
);
CC_MUX3_1 CC_MUX3_1_u2(
	.CC_MUX3_1_DataBus_Out(MUX3_1_REG2_DataBus_Out_cwire),
	.CC_MUX3_1_Selector_In(MAIN_STATEMACHINE_CurrentState_cwire),
	.CC_MUX3_1_DataBus1_In(DATA_FIXED_INITREGPOINT_2),
	.CC_MUX3_1_DataBus2_In(REGTOMUX_REG2_DataBus_Out_cwire),
	.CC_MUX3_1_DataBus3_In(WINNERCOMPARATOR_Data2_outBus_cwire)
);
CC_MUX3_1 CC_MUX3_1_u3(
	.CC_MUX3_1_DataBus_Out(MUX3_1_REG3_DataBus_Out_cwire),
	.CC_MUX3_1_Selector_In(MAIN_STATEMACHINE_CurrentState_cwire),
	.CC_MUX3_1_DataBus1_In(DATA_FIXED_INITREGPOINT_3),
	.CC_MUX3_1_DataBus2_In(REGTOMUX_REG3_DataBus_Out_cwire),
	.CC_MUX3_1_DataBus3_In(WINNERCOMPARATOR_Data3_outBus_cwire)
);
CC_MUX3_1 CC_MUX3_1_u4(
	.CC_MUX3_1_DataBus_Out(MUX3_1_REG4_DataBus_Out_cwire),
	.CC_MUX3_1_Selector_In(MAIN_STATEMACHINE_CurrentState_cwire),
	.CC_MUX3_1_DataBus1_In(DATA_FIXED_INITREGPOINT_4),
	.CC_MUX3_1_DataBus2_In(REGTOMUX_REG4_DataBus_Out_cwire),
	.CC_MUX3_1_DataBus3_In(WINNERCOMPARATOR_Data4_outBus_cwire)
);
CC_MUX3_1 CC_MUX3_1_u5(
	.CC_MUX3_1_DataBus_Out(MUX3_1_REG5_DataBus_Out_cwire),
	.CC_MUX3_1_Selector_In(MAIN_STATEMACHINE_CurrentState_cwire),
	.CC_MUX3_1_DataBus1_In(DATA_FIXED_INITREGPOINT_5),
	.CC_MUX3_1_DataBus2_In(REGTOMUX_REG5_DataBus_Out_cwire),
	.CC_MUX3_1_DataBus3_In(WINNERCOMPARATOR_Data5_outBus_cwire)
);
CC_MUX3_1 CC_MUX3_1_u6(
	.CC_MUX3_1_DataBus_Out(MUX3_1_REG6_DataBus_Out_cwire),
	.CC_MUX3_1_Selector_In(MAIN_STATEMACHINE_CurrentState_cwire),
	.CC_MUX3_1_DataBus1_In(DATA_FIXED_INITREGPOINT_6),
	.CC_MUX3_1_DataBus2_In(REGTOMUX_REG6_DataBus_Out_cwire),
	.CC_MUX3_1_DataBus3_In(WINNERCOMPARATOR_Data6_outBus_cwire)
);
CC_MUX3_1 CC_MUX3_1_u7(
	.CC_MUX3_1_DataBus_Out(MUX3_1_REG7_DataBus_Out_cwire),
	.CC_MUX3_1_Selector_In(MAIN_STATEMACHINE_CurrentState_cwire),
	.CC_MUX3_1_DataBus1_In(DATA_FIXED_INITREGPOINT_7),
	.CC_MUX3_1_DataBus2_In(REGTOMUX_REG7_DataBus_Out_cwire),
	.CC_MUX3_1_DataBus3_In(WINNERCOMPARATOR_Data7_outBus_cwire)
);


//----------------------------------------------------------------------
// SC_RegSHIFTER_PLAYER_1
//----------------------------------------------------------------------
SC_RegSHIFTER_PLAYER_1 SC_RegSHIFTER_PLAYER_1_U0(
	.SC_RegSHIFTER_PLAYER_1_data_OutBUS(RegSHIFTER_data_OutBUS_cwire),
	.SC_RegSHIFTER_PLAYER_1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegSHIFTER_PLAYER_1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegSHIFTER_PLAYER_1_load_InLow(PLAYER_STATEMACHINE_LoadData_Out_cwire),
	.SC_RegSHIFTER_PLAYER_1_shiftselection_In(PLAYER_STATEMACHINE_ShiftSelection_Out_cwire),
	.SC_RegSHIFTER_PLAYER_1_data_InBUS(PLAYER_STATEMACHINE_PlayerData_Out_cwire)
);


//----------------------------------------------------------------------
// CC_PLAYER_CAR_COMPARATOR
//----------------------------------------------------------------------
CC_PLAYER_CAR_COMPARATOR CC_PLAYER_CAR_COMPARATOR_u0(

	.CC_PLAYER_CAR_COMPARATOR_Data_OutBus(PLAYER_CAR_COMPARATOR_Data_OutBus_cwire),
	.CC_PLAYER_CAR_COMPARATOR_PlayerLose_Out(PLAYER_CAR_COMPARATOR_PlayerLose_Out_cwire),
	.CC_PLAYER_CAR_COMPARATOR_PlayerData_InBus(REG8_DataBus_out),
	.CC_PLAYER_CAR_COMPARATOR_CarData_InBus(RegSHIFTER_data_OutBUS_cwire)

);

//----------------------------------------------------------------------
// SC_POINTSCOUNTER
//----------------------------------------------------------------------

SC_POINTSCOUNTER SC_POINTSCOUNTER_u0(
	.SC_POINTSCOUNTER_Data_OutBus(POINTSCOUNTER_Data_OutBus_cwire),
	.SC_POINTSCOUNTER_LevelProgress_inLow(LEVELPROGRESSCOUNTER_DataOut_cwire),
	.SC_POINTSCOUNTER_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_POINTSCOUNTER_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_POINTSCOUNTER_CurrentLvl_In(LEVELCOUNTER_DataOut_cwire),
	.SC_POINTSCOUNTER_PlayerLose_inLow(PLAYER_STATEMACHINE_PlayerLose_Out_cwire),
	.SC_POINTSCOUNTER_upCount_inLow(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire)
);
//########################################################################
// PLAYER2
//########################################################################

//----------------------------------------------------------------------
//LEVEL_DATAHANDLER
//----------------------------------------------------------------------

CC_LEVEL_DATAHANDLER_PLAYER_2 CC_LEVEL_DATAHANDLER_PLAYER_2_u0(
	.CC_LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus(LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus_cwire),
	.CC_LEVEL_DATAHANDLER_PLAYER_2_LvlProgress(LEVELPROGRESSCOUNTER_DataOut_cwire),
	.CC_LEVEL_DATAHANDLER_PLAYER_2_CurrentLvl(LEVELCOUNTER_DataOut_cwire)

);


//----------------------------------------------------------------------
//CAR_PLAYER2_REGISTERS
//----------------------------------------------------------------------

SC_RegGENERAL  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_car_PLAYER2_u0(
		.SC_RegGENERAL_data_OutBUS(PLAYER2_REG0toReg1_DataBus_out),
		.SC_RegGENERAL_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_load_InLow(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire),
		.SC_RegGENERAL_data_InBUS(LEVEL_DATAHANDLER_PLAYER_2_LevelData_OutBus_cwire)
);

SC_RegGENERAL  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_car_PLAYER2_u1(
		.SC_RegGENERAL_data_OutBUS(PLAYER2_REG1toReg2_DataBus_out),
		.SC_RegGENERAL_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_load_InLow(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire),
		.SC_RegGENERAL_data_InBUS(PLAYER2_REG0toReg1_DelayBus_out)
);


SC_RegGENERAL  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_car_PLAYER2_u2(
		.SC_RegGENERAL_data_OutBUS(PLAYER2_REG2toReg3_DataBus_out),
		.SC_RegGENERAL_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_load_InLow(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire),
		.SC_RegGENERAL_data_InBUS(PLAYER2_REG1toReg2_DelayBus_out)
);

SC_RegGENERAL  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_car_PLAYER2_u3(
		.SC_RegGENERAL_data_OutBUS(PLAYER2_REG3toReg4_DataBus_out),
		.SC_RegGENERAL_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_load_InLow(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire),
		.SC_RegGENERAL_data_InBUS(PLAYER2_REG2toReg3_DelayBus_out)
);
SC_RegGENERAL  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_car_PLAYER2_u4(
		.SC_RegGENERAL_data_OutBUS(PLAYER2_REG4toReg5_DataBus_out),
		.SC_RegGENERAL_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_load_InLow(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire),
		.SC_RegGENERAL_data_InBUS(PLAYER2_REG3toReg4_DelayBus_out)
);
SC_RegGENERAL  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_car_PLAYER2_u5(
		.SC_RegGENERAL_data_OutBUS(PLAYER2_REG5toReg6_DataBus_out),
		.SC_RegGENERAL_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_load_InLow(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire),
		.SC_RegGENERAL_data_InBUS(PLAYER2_REG4toReg5_DelayBus_out)
);

SC_RegGENERAL  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_car_PLAYER2_u6(
		.SC_RegGENERAL_data_OutBUS(PLAYER2_REG6toReg7_DataBus_out),
		.SC_RegGENERAL_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_load_InLow(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire),
		.SC_RegGENERAL_data_InBUS(PLAYER2_REG5toReg6_DelayBus_out)
);
SC_RegGENERAL  #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) 
	SC_RegGENERAL_car_PLAYER2_u7(
		.SC_RegGENERAL_data_OutBUS(PLAYER2_REG8_DataBus_out),
		.SC_RegGENERAL_CLOCK_50(BB_SYSTEM_CLOCK_50),
		.SC_RegGENERAL_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
		.SC_RegGENERAL_load_InLow(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire),
		.SC_RegGENERAL_data_InBUS(PLAYER2_REG6toReg7_DelayBus_out)
);

//----------------------------------------------------------------------
//DATA_DELAY_PLAYER2
//----------------------------------------------------------------------

CC_DATADELAY CC_DATADELAY_PLAYER2_u0 (
	.CC_DATADELAY_DelayedData_outBus(PLAYER2_REG0toReg1_DelayBus_out),
	.CC_DATADELAY_Data_inBus(PLAYER2_REG0toReg1_DataBus_out),
	.CC_DATADELAY_SendDataSignal_In(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire)
);
CC_DATADELAY CC_DATADELAY_PLAYER2_u1 (
	.CC_DATADELAY_DelayedData_outBus(PLAYER2_REG1toReg2_DelayBus_out),
	.CC_DATADELAY_Data_inBus(PLAYER2_REG1toReg2_DataBus_out),
	.CC_DATADELAY_SendDataSignal_In(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire)
);
CC_DATADELAY CC_DATADELAY_PLAYER2_u2 (
	.CC_DATADELAY_DelayedData_outBus(PLAYER2_REG2toReg3_DelayBus_out),
	.CC_DATADELAY_Data_inBus(PLAYER2_REG2toReg3_DataBus_out),
	.CC_DATADELAY_SendDataSignal_In(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire)
);
CC_DATADELAY CC_DATADELAY_PLAYER2_u3 (
	.CC_DATADELAY_DelayedData_outBus(PLAYER2_REG3toReg4_DelayBus_out),
	.CC_DATADELAY_Data_inBus(PLAYER2_REG3toReg4_DataBus_out),
	.CC_DATADELAY_SendDataSignal_In(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire)
);
CC_DATADELAY CC_DATADELAY_PLAYER2_u4 (
	.CC_DATADELAY_DelayedData_outBus(PLAYER2_REG4toReg5_DelayBus_out),
	.CC_DATADELAY_Data_inBus(PLAYER2_REG4toReg5_DataBus_out),
	.CC_DATADELAY_SendDataSignal_In(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire)
);
CC_DATADELAY CC_DATADELAY_PLAYER2_u5 (
	.CC_DATADELAY_DelayedData_outBus(PLAYER2_REG5toReg6_DelayBus_out),
	.CC_DATADELAY_Data_inBus(PLAYER2_REG5toReg6_DataBus_out),
	.CC_DATADELAY_SendDataSignal_In(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire)
);
CC_DATADELAY CC_DATADELAY_PLAYER2_u6 (
	.CC_DATADELAY_DelayedData_outBus(PLAYER2_REG6toReg7_DelayBus_out),
	.CC_DATADELAY_Data_inBus(PLAYER2_REG6toReg7_DataBus_out),
	.CC_DATADELAY_SendDataSignal_In(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire)
);

//----------------------------------------------------------------------
// SC_RegSHIFTER_PLAYER_2
//----------------------------------------------------------------------
SC_RegSHIFTER_PLAYER_2 SC_RegSHIFTER_PLAYER_2_U0(
	.SC_RegSHIFTER_PLAYER_2_data_OutBUS(RegSHIFTER_PLAYER_2_data_OutBUS_cwire),
	.SC_RegSHIFTER_PLAYER_2_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegSHIFTER_PLAYER_2_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegSHIFTER_PLAYER_2_load_InLow(PLAYER_STATEMACHINE_PLAYER_2_LoadData_Out_cwire),
	.SC_RegSHIFTER_PLAYER_2_shiftselection_In(PLAYER_STATEMACHINE_PLAYER_2_ShiftSelection_Out_cwire),
	.SC_RegSHIFTER_PLAYER_2_data_InBUS(PLAYER_STATEMACHINE_PLAYER_2_PlayerData_Out_cwire)
);


//----------------------------------------------------------------------
// CC_PLAYER_CAR_COMPARATOR
//----------------------------------------------------------------------
CC_PLAYER_CAR_COMPARATOR CC_PLAYER_CAR_COMPARATOR_u1(
	.CC_PLAYER_CAR_COMPARATOR_Data_OutBus(CAR_COMPARATOR_PLAYER_2_Data_OutBus_cwire),
	.CC_PLAYER_CAR_COMPARATOR_PlayerLose_Out(PLAYER_CAR_COMPARATOR_PLAYER_2_PlayerLose_Out_cwire),
	.CC_PLAYER_CAR_COMPARATOR_PlayerData_InBus(PLAYER2_REG8_DataBus_out),
	.CC_PLAYER_CAR_COMPARATOR_CarData_InBus(RegSHIFTER_PLAYER_2_data_OutBUS_cwire)

);


//----------------------------------------------------------------------
// SC_POINTSCOUNTER_PLAYER_2
//----------------------------------------------------------------------

SC_POINTSCOUNTER SC_POINTSCOUNTER_u1(
	.SC_POINTSCOUNTER_Data_OutBus(POINTSCOUNTER_PLAYER_2_Data_OutBus_cwire),
	.SC_POINTSCOUNTER_LevelProgress_inLow(LEVELPROGRESSCOUNTER_DataOut_cwire),
	.SC_POINTSCOUNTER_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_POINTSCOUNTER_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_POINTSCOUNTER_CurrentLvl_In(LEVELCOUNTER_DataOut_cwire),
	.SC_POINTSCOUNTER_PlayerLose_inLow(PLAYER_STATEMACHINE_PLAYER_2_PlayerLose_Out_cwire),
	.SC_POINTSCOUNTER_upCount_inLow(LEVEL_STATEMACHINE_ProgressUpCount_out_cwire)	
);


//----------------------------------------------------------------------
// CC_WINNERCOMPARATOR
//----------------------------------------------------------------------


CC_WINNERCOMPARATOR CC_WINNERCOMPARATOR_u0(
	.CC_WINNERCOMPARATOR_Data0_outBus(WINNERCOMPARATOR_Data0_outBus_cwire),
	.CC_WINNERCOMPARATOR_Data1_outBus(WINNERCOMPARATOR_Data1_outBus_cwire),
	.CC_WINNERCOMPARATOR_Data2_outBus(WINNERCOMPARATOR_Data2_outBus_cwire),
	.CC_WINNERCOMPARATOR_Data3_outBus(WINNERCOMPARATOR_Data3_outBus_cwire),
	.CC_WINNERCOMPARATOR_Data4_outBus(WINNERCOMPARATOR_Data4_outBus_cwire),
	.CC_WINNERCOMPARATOR_Data5_outBus(WINNERCOMPARATOR_Data5_outBus_cwire),
	.CC_WINNERCOMPARATOR_Data6_outBus(WINNERCOMPARATOR_Data6_outBus_cwire),
	.CC_WINNERCOMPARATOR_Data7_outBus(WINNERCOMPARATOR_Data7_outBus_cwire),
	.CC_WINNERCOMPARATOR_DataPLAYER1_In(POINTSCOUNTER_Data_OutBus_cwire),
	.CC_WINNERCOMPARATOR_DataPLAYER2_In(POINTSCOUNTER_PLAYER_2_Data_OutBus_cwire)
);
//######################################################################
//#	TO FINAL MUX: VISUALIZATION
//######################################################################

assign REGTOMUX_REG0_DataBus_Out_cwire = REG0toReg1_DataBus_out 						| 	PLAYER2_REG0toReg1_DataBus_out; 
assign REGTOMUX_REG1_DataBus_Out_cwire = REG1toReg2_DataBus_out						| 	PLAYER2_REG1toReg2_DataBus_out; 
assign REGTOMUX_REG2_DataBus_Out_cwire = REG2toReg3_DataBus_out						| 	PLAYER2_REG2toReg3_DataBus_out; 
assign REGTOMUX_REG3_DataBus_Out_cwire = REG3toReg4_DataBus_out 						| 	PLAYER2_REG3toReg4_DataBus_out; 
assign REGTOMUX_REG4_DataBus_Out_cwire = REG4toReg5_DataBus_out						| 	PLAYER2_REG4toReg5_DataBus_out; 
assign REGTOMUX_REG5_DataBus_Out_cwire = REG5toReg6_DataBus_out 						| 	PLAYER2_REG5toReg6_DataBus_out; 
assign REGTOMUX_REG6_DataBus_Out_cwire = REG6toReg7_DataBus_out						| 	PLAYER2_REG6toReg7_DataBus_out; 
assign REGTOMUX_REG7_DataBus_Out_cwire = PLAYER_CAR_COMPARATOR_Data_OutBus_cwire | 	CAR_COMPARATOR_PLAYER_2_Data_OutBus_cwire 	; 

//######################################################################
//#	TO LED MATRIZ: VISUALIZATION
//######################################################################
assign regGAME_data0_wire = MUX3_1_REG7_DataBus_Out_cwire;
assign regGAME_data1_wire = MUX3_1_REG6_DataBus_Out_cwire;
assign regGAME_data2_wire = MUX3_1_REG5_DataBus_Out_cwire;
assign regGAME_data3_wire = MUX3_1_REG4_DataBus_Out_cwire;
assign regGAME_data4_wire = MUX3_1_REG3_DataBus_Out_cwire;
assign regGAME_data5_wire = MUX3_1_REG2_DataBus_Out_cwire;
assign regGAME_data6_wire = MUX3_1_REG1_DataBus_Out_cwire;
assign regGAME_data7_wire = MUX3_1_REG0_DataBus_Out_cwire;

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
assign BB_SYSTEM_upButton_Out		=	BB_SYSTEM_upButton_InLow_cwire;
assign BB_SYSTEM_downButton_Out	= BB_SYSTEM_downButton_InLow_cwire;



endmodule
