transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Documentos/personal/frogger-digitales/rtl {D:/Documentos/personal/frogger-digitales/rtl/shift_reg_start_done.v}
vlog -vlog01compat -work work +incdir+D:/Documentos/personal/frogger-digitales/rtl {D:/Documentos/personal/frogger-digitales/rtl/max7219_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/Documentos/personal/frogger-digitales/rtl {D:/Documentos/personal/frogger-digitales/rtl/SC_DEBOUNCE1.v}
vlog -vlog01compat -work work +incdir+D:/Documentos/personal/frogger-digitales {D:/Documentos/personal/frogger-digitales/BB_SYSTEM.v}
vlog -vlog01compat -work work +incdir+D:/Documentos/personal/frogger-digitales/rtl {D:/Documentos/personal/frogger-digitales/rtl/SC_MAIN_STATEMACHINE.v}
vlog -vlog01compat -work work +incdir+D:/Documentos/personal/frogger-digitales/rtl {D:/Documentos/personal/frogger-digitales/rtl/SC_LEVELCOUNTER.v}
vlog -vlog01compat -work work +incdir+D:/Documentos/personal/frogger-digitales/rtl {D:/Documentos/personal/frogger-digitales/rtl/SC_LEVEL_STATEMACHINE.v}
vlog -vlog01compat -work work +incdir+D:/Documentos/personal/frogger-digitales/rtl {D:/Documentos/personal/frogger-digitales/rtl/SC_LEVELPROGRESSCOUNTER.v}
vlog -vlog01compat -work work +incdir+D:/Documentos/personal/frogger-digitales/rtl {D:/Documentos/personal/frogger-digitales/rtl/SC_upSPEEDCOUNTER.v}
vlog -vlog01compat -work work +incdir+D:/Documentos/personal/frogger-digitales/rtl {D:/Documentos/personal/frogger-digitales/rtl/CC_SPEEDCOMPARATOR.v}
vlog -vlog01compat -work work +incdir+D:/Documentos/personal/frogger-digitales/rtl {D:/Documentos/personal/frogger-digitales/rtl/CC_LEVEL_DATAHANDLER.v}
vlog -vlog01compat -work work +incdir+D:/Documentos/personal/frogger-digitales/rtl {D:/Documentos/personal/frogger-digitales/rtl/SC_RegGENERAL_CAR.v}
vlog -vlog01compat -work work +incdir+D:/Documentos/personal/frogger-digitales/rtl {D:/Documentos/personal/frogger-digitales/rtl/CC_DATADELAY.v}
vlog -vlog01compat -work work +incdir+D:/Documentos/personal/frogger-digitales/rtl {D:/Documentos/personal/frogger-digitales/rtl/CC_MUX3_1.v}
vlog -vlog01compat -work work +incdir+D:/Documentos/personal/frogger-digitales/rtl {D:/Documentos/personal/frogger-digitales/rtl/SC_PLAYER_STATEMACHINE.v}
vlog -vlog01compat -work work +incdir+D:/Documentos/personal/frogger-digitales/rtl {D:/Documentos/personal/frogger-digitales/rtl/CC_PLAYER_CAR_COMPARATOR.v}
vlog -vlog01compat -work work +incdir+D:/Documentos/personal/frogger-digitales/rtl {D:/Documentos/personal/frogger-digitales/rtl/SC_RegSHIFTER_PLAYER_1.v}
vlog -vlog01compat -work work +incdir+D:/Documentos/personal/frogger-digitales/rtl {D:/Documentos/personal/frogger-digitales/rtl/SC_RegSHIFTER_PLAYER_2.v}
vlog -vlog01compat -work work +incdir+D:/Documentos/personal/frogger-digitales/rtl {D:/Documentos/personal/frogger-digitales/rtl/CC_LEVEL_DATAHANDLER_PLAYER_2.v}
vlog -vlog01compat -work work +incdir+D:/Documentos/personal/frogger-digitales/rtl {D:/Documentos/personal/frogger-digitales/rtl/SC_POINTSCOUNTER.v}
vlog -vlog01compat -work work +incdir+D:/Documentos/personal/frogger-digitales/rtl {D:/Documentos/personal/frogger-digitales/rtl/CC_WINNERCOMPARATOR.v}

vlog -vlog01compat -work work +incdir+D:/Documentos/personal/frogger-digitales/simulation/modelsim {D:/Documentos/personal/frogger-digitales/simulation/modelsim/TB_SYSTEM.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  TB_SYSTEM

add wave *
view structure
view signals
run -all
