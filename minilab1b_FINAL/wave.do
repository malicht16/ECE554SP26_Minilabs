onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /minilab1b_toplevel_tb/iDUT/minilab1b/read_mem/clk
add wave -noupdate /minilab1b_toplevel_tb/iDUT/minilab1b/read_mem/reset_n
add wave -noupdate -divider top_level_result_and_done
add wave -noupdate -radix hexadecimal /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/result
add wave -noupdate /minilab1b_toplevel_tb/iDUT/minilab1b/done
add wave -noupdate -divider read_mem
add wave -noupdate /minilab1b_toplevel_tb/iDUT/minilab1b/read_mem/read_done
add wave -noupdate -radix hexadecimal /minilab1b_toplevel_tb/iDUT/minilab1b/read_mem/matrix_a
add wave -noupdate -radix hexadecimal /minilab1b_toplevel_tb/iDUT/minilab1b/read_mem/vector_b
add wave -noupdate /minilab1b_toplevel_tb/iDUT/minilab1b/read_mem/rden
add wave -noupdate -radix hexadecimal /minilab1b_toplevel_tb/iDUT/minilab1b/read_mem/address
add wave -noupdate /minilab1b_toplevel_tb/iDUT/minilab1b/read_mem/readdatavalid
add wave -noupdate -radix hexadecimal /minilab1b_toplevel_tb/iDUT/minilab1b/read_mem/readdata
add wave -noupdate /minilab1b_toplevel_tb/iDUT/minilab1b/read_mem/waitrequest
add wave -noupdate -divider mvm
add wave -noupdate -radix hexadecimal /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/matrix_a
add wave -noupdate -radix hexadecimal /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/vector_b
add wave -noupdate -divider fifo0_mac0
add wave -noupdate {/minilab1b_toplevel_tb/iDUT/minilab1b/mvm/fifo_gen[0]/input_fifo/empty}
add wave -noupdate {/minilab1b_toplevel_tb/iDUT/minilab1b/mvm/fifo_gen[0]/input_fifo/full}
add wave -noupdate -radix hexadecimal {/minilab1b_toplevel_tb/iDUT/minilab1b/mvm/fifo_gen[0]/input_fifo/i_data}
add wave -noupdate {/minilab1b_toplevel_tb/iDUT/minilab1b/mvm/fifo_gen[0]/input_fifo/o_data}
add wave -noupdate {/minilab1b_toplevel_tb/iDUT/minilab1b/mvm/fifo_gen[0]/input_fifo/rden}
add wave -noupdate {/minilab1b_toplevel_tb/iDUT/minilab1b/mvm/fifo_gen[0]/input_fifo/wren}
add wave -noupdate -radix hexadecimal /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/mac0/accumulate
add wave -noupdate -radix hexadecimal /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/mac0/Ain
add wave -noupdate -radix hexadecimal /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/mac0/Bin
add wave -noupdate -radix hexadecimal /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/mac0/Cout
add wave -noupdate -radix hexadecimal /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/mac0/En
add wave -noupdate -radix hexadecimal /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/mac0/new_accumulate
add wave -noupdate -radix hexadecimal /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/mac0/new_ain
add wave -noupdate -radix hexadecimal /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/mac0/new_bin
add wave -noupdate -radix hexadecimal /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/mac0/new_product
add wave -noupdate -radix hexadecimal /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/mac0/product
add wave -noupdate -divider fifo1_mac1
add wave -noupdate {/minilab1b_toplevel_tb/iDUT/minilab1b/mvm/fifo_gen[1]/input_fifo/empty}
add wave -noupdate {/minilab1b_toplevel_tb/iDUT/minilab1b/mvm/fifo_gen[1]/input_fifo/full}
add wave -noupdate -radix hexadecimal {/minilab1b_toplevel_tb/iDUT/minilab1b/mvm/fifo_gen[1]/input_fifo/i_data}
add wave -noupdate -radix hexadecimal {/minilab1b_toplevel_tb/iDUT/minilab1b/mvm/fifo_gen[1]/input_fifo/o_data}
add wave -noupdate -radix hexadecimal {/minilab1b_toplevel_tb/iDUT/minilab1b/mvm/fifo_gen[1]/input_fifo/rden}
add wave -noupdate -radix hexadecimal {/minilab1b_toplevel_tb/iDUT/minilab1b/mvm/fifo_gen[1]/input_fifo/wren}
add wave -noupdate -radix hexadecimal /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/mac1/Clr
add wave -noupdate /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/mac1/En
add wave -noupdate /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/mac1/finish_calc
add wave -noupdate /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/mac1/new_ain
add wave -noupdate /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/mac1/new_bin
add wave -noupdate /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/mac1/Ain
add wave -noupdate /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/mac1/Bin
add wave -noupdate /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/mac1/Cout
add wave -noupdate /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/mac1/new_accumulate
add wave -noupdate /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/mac1/accumulate
add wave -noupdate /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/mac1/new_product
add wave -noupdate /minilab1b_toplevel_tb/iDUT/minilab1b/mvm/mac1/product
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2545 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 441
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
WaveRestoreZoom {5184 ps} {5386 ps}
