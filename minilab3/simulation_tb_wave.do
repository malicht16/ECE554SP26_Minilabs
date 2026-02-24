onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /simulation_tb/clk
add wave -noupdate /simulation_tb/rst
add wave -noupdate /simulation_tb/br_cfg
add wave -noupdate /simulation_tb/spart0/brg_inst/br_en
add wave -noupdate -divider spart0_transmitter
add wave -noupdate /simulation_tb/spart0/transmitter_inst/ioaddr
add wave -noupdate /simulation_tb/spart0/transmitter_inst/transmit_enable
add wave -noupdate /simulation_tb/spart0/transmitter_inst/transmit_buffer
add wave -noupdate /simulation_tb/spart0/transmitter_inst/theBuffer
add wave -noupdate /simulation_tb/spart0/transmitter_inst/TBR
add wave -noupdate /simulation_tb/spart0/transmitter_inst/TxD
add wave -noupdate -divider transferred_from_spart0_to_spart1
add wave -noupdate /simulation_tb/txd0_rxd1
add wave -noupdate /simulation_tb/rda1
add wave -noupdate -divider driver1
add wave -noupdate /simulation_tb/driver1/ioaddr
add wave -noupdate /simulation_tb/driver1/iorw
add wave -noupdate /simulation_tb/spart1/bus_inst/rec_buffer
add wave -noupdate /simulation_tb/spart1/bus_inst/databus
add wave -noupdate /simulation_tb/spart1/bus_int_input_data
add wave -noupdate /simulation_tb/spart1/databus_bus_int
add wave -noupdate /simulation_tb/driver1/databus
add wave -noupdate /simulation_tb/databus1
add wave -noupdate /simulation_tb/driver1/state
add wave -noupdate /simulation_tb/spart1/receiver_inst/receiver_buffer
add wave -noupdate /simulation_tb/driver1/stored_data
add wave -noupdate -divider spart1_transmitter
add wave -noupdate /simulation_tb/spart1/transmitter_inst/ioaddr
add wave -noupdate /simulation_tb/spart1/transmitter_inst/transmit_enable
add wave -noupdate /simulation_tb/spart1/transmitter_inst/transmit_buffer
add wave -noupdate /simulation_tb/spart1/transmitter_inst/theBuffer
add wave -noupdate /simulation_tb/spart1/transmitter_inst/TBR
add wave -noupdate /simulation_tb/spart1/transmitter_inst/TxD
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10645 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 305
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
WaveRestoreZoom {4219 ps} {17531 ps}
