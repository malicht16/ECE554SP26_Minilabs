onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /simulation_tb/clk
add wave -noupdate /simulation_tb/rst
add wave -noupdate /simulation_tb/br_cfg
add wave -noupdate -divider brg0
add wave -noupdate /simulation_tb/spart0/brg_inst/clk
add wave -noupdate /simulation_tb/spart0/brg_inst/rst
add wave -noupdate /simulation_tb/spart0/brg_inst/ioaddr
add wave -noupdate /simulation_tb/spart0/brg_inst/databus
add wave -noupdate /simulation_tb/spart0/brg_inst/br_en
add wave -noupdate /simulation_tb/spart0/brg_inst/state
add wave -noupdate /simulation_tb/spart0/brg_inst/divisor_buffer
add wave -noupdate /simulation_tb/spart0/brg_inst/divisor_buffer_old
add wave -noupdate /simulation_tb/spart0/brg_inst/counter
add wave -noupdate /simulation_tb/spart0/brg_inst/reload
add wave -noupdate -divider brg1
add wave -noupdate /simulation_tb/spart1/brg_inst/clk
add wave -noupdate /simulation_tb/spart1/brg_inst/rst
add wave -noupdate /simulation_tb/spart1/brg_inst/ioaddr
add wave -noupdate /simulation_tb/spart1/brg_inst/databus
add wave -noupdate /simulation_tb/spart1/brg_inst/br_en
add wave -noupdate /simulation_tb/spart1/brg_inst/state
add wave -noupdate /simulation_tb/spart1/brg_inst/divisor_buffer
add wave -noupdate /simulation_tb/spart1/brg_inst/divisor_buffer_old
add wave -noupdate /simulation_tb/spart1/brg_inst/counter
add wave -noupdate /simulation_tb/spart1/brg_inst/reload
add wave -noupdate -divider transmit_and_receive_signals
add wave -noupdate /simulation_tb/txd0_rxd1
add wave -noupdate /simulation_tb/txd1_rxd0
add wave -noupdate -divider tb_generated_signals
add wave -noupdate /simulation_tb/iocs0
add wave -noupdate /simulation_tb/iorw0
add wave -noupdate /simulation_tb/ioaddr0
add wave -noupdate /simulation_tb/databus0
add wave -noupdate /simulation_tb/databus0_driver
add wave -noupdate -divider spart0_output_signals
add wave -noupdate /simulation_tb/rda0
add wave -noupdate /simulation_tb/tbr0
add wave -noupdate -divider driver1_output_signals
add wave -noupdate /simulation_tb/iocs1
add wave -noupdate /simulation_tb/iorw1
add wave -noupdate /simulation_tb/ioaddr1
add wave -noupdate /simulation_tb/databus1
add wave -noupdate -divider spart1_output_signals
add wave -noupdate /simulation_tb/rda1
add wave -noupdate /simulation_tb/tbr1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ps} {807 ps}
