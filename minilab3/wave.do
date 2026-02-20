onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /driver_tb/driver_inst/clk
add wave -noupdate /driver_tb/driver_inst/rst
add wave -noupdate /driver_tb/driver_inst/br_cfg
add wave -noupdate /driver_tb/driver_inst/divisor
add wave -noupdate /driver_tb/driver_inst/iocs
add wave -noupdate /driver_tb/driver_inst/iorw
add wave -noupdate /driver_tb/driver_inst/rda
add wave -noupdate /driver_tb/driver_inst/tbr
add wave -noupdate /driver_tb/driver_inst/state
add wave -noupdate /driver_tb/driver_inst/ioaddr
add wave -noupdate /driver_tb/driver_inst/databus
add wave -noupdate /driver_tb/driver_inst/databus
add wave -noupdate /driver_tb/driver_inst/stored_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {135 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 222
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
configure wave -timelineunits ps
update
WaveRestoreZoom {114 ps} {172 ps}
