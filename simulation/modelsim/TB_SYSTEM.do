do BB_SYSTEM_run_msim_rtl_verilog.do
onerror {resume}
quietly WaveActivateNextPane {} 0
delete wave *
#add wave -noupdate /TB_SYSTEM/eachvec
#
#add wave  -divider LedMATRIX
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_CLOCK_50
#add wave -noupdate /TB_SYSTEM/TB_SYSTEM_RESET_InHigh
#add wave -noupdate /TB_SYSTEM/TB_SYSTEM_startButton_InLow
#add wave -noupdate /TB_SYSTEM/TB_SYSTEM_leftButton_InLow
#add wave -noupdate /TB_SYSTEM/TB_SYSTEM_rightButton_InLow
#
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_max7219DIN_Out
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_max7219NCS_Out
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_max7219CLK_Out

add wave  -divider SC_DEBOUNCE1_u0
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_DEBOUNCE1_u0/SC_DEBOUNCE1_button_In
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_DEBOUNCE1_u0/SC_DEBOUNCE1_button_Out

#add wave  -divider SC_DEBOUNCE1_u1
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_DEBOUNCE1_u1/SC_DEBOUNCE1_button_In
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_DEBOUNCE1_u1/SC_DEBOUNCE1_button_Out
#
#add wave  -divider SC_DEBOUNCE1_u2
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_DEBOUNCE1_u2/SC_DEBOUNCE1_button_In
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_DEBOUNCE1_u2/SC_DEBOUNCE1_button_Out
#
#add wave  -divider TEST
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/matrix_ctrl_unit_0/clk_driver
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/matrix_ctrl_unit_0/Trig_SignalNEG
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/matrix_ctrl_unit_0/Trig_SignalPOS

add wave  -divider SC_MAIN_STATEMACHINE_u0
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_MAIN_STATEMACHINE_u0/SC_MAIN_STATEMACHINE_CurrentState_Out

add wave  -divider SC_LEVEL_STATEMACHINE_u0
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_LEVEL_STATEMACHINE_u0/SC_LEVEL_STATEMACHINE_LevelFinished_Out
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_LEVEL_STATEMACHINE_u0/SC_LEVEL_STATEMACHINE_StartCount_Out
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_LEVEL_STATEMACHINE_u0/SC_LEVEL_STATEMACHINE_FinishedGame_Out

add wave  -divider SC_LEVELCOUNTER_u0
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_LEVELCOUNTER_u0/SC_LEVELCOUNTER_Data_OutBus

add wave  -divider SC_LEVELPROGRESSCOUNTER_u0
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_LEVELPROGRESSCOUNTER_u0/SC_LEVELPROGRESSCOUNTER_Data_OutBus

add wave  -divider SC_upSPEEDCOUNTER_u0
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_upSPEEDCOUNTER_u0/SC_upSPEEDCOUNTER_data_OutBUS

add wave  -divider CC_SPEEDCOMPARATOR_u0
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_SPEEDCOMPARATOR_u0/CC_SPEEDCOMPARATOR_T0_OutLow

#add wave  -divider REGISTER
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegGENERAL_CAR_u0/SC_RegGENERAL_CAR_data_OutBUS
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegGENERAL_CAR_u1/SC_RegGENERAL_CAR_data_OutBUS
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegGENERAL_CAR_u2/SC_RegGENERAL_CAR_data_OutBUS
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegGENERAL_CAR_u3/SC_RegGENERAL_CAR_data_OutBUS
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegGENERAL_CAR_u4/SC_RegGENERAL_CAR_data_OutBUS
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegGENERAL_CAR_u5/SC_RegGENERAL_CAR_data_OutBUS
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegGENERAL_CAR_u6/SC_RegGENERAL_CAR_data_OutBUS
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/SC_RegGENERAL_CAR_u7/SC_RegGENERAL_CAR_data_OutBUS


#add wave  -divider DATA_DELAY
#add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_DATADELAY_u0/CC_DATADELAY_DelayedData_outBus
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_DATADELAY_u1/CC_DATADELAY_DelayedData_outBus
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_DATADELAY_u2/CC_DATADELAY_DelayedData_outBus
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_DATADELAY_u3/CC_DATADELAY_DelayedData_outBus
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_DATADELAY_u4/CC_DATADELAY_DelayedData_outBus
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_DATADELAY_u5/CC_DATADELAY_DelayedData_outBus
##add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_DATADELAY_u6/CC_DATADELAY_DelayedData_outBus


add wave  -divider CC_MUX3_1
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_MUX3_1_u0/CC_MUX3_1_DataBus_Out
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_MUX3_1_u1/CC_MUX3_1_DataBus_Out
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_MUX3_1_u2/CC_MUX3_1_DataBus_Out
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_MUX3_1_u3/CC_MUX3_1_DataBus_Out
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_MUX3_1_u4/CC_MUX3_1_DataBus_Out
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_MUX3_1_u5/CC_MUX3_1_DataBus_Out
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/CC_MUX3_1_u6/CC_MUX3_1_DataBus_Out


restart
run 1000000ns

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {319999492 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 445
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {59829352 ps} {60892417 ps}
