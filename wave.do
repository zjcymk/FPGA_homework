onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/clk
add wave -noupdate /tb/rstn
add wave -noupdate /tb/coin
add wave -noupdate /tb/keys
add wave -noupdate /tb/uut/goods
add wave -noupdate -radix unsigned -childformat {{{/tb/uut/coins[3]} -radix unsigned} {{/tb/uut/coins[2]} -radix unsigned} {{/tb/uut/coins[1]} -radix unsigned} {{/tb/uut/coins[0]} -radix unsigned}} -subitemconfig {{/tb/uut/coins[3]} {-height 15 -radix unsigned} {/tb/uut/coins[2]} {-height 15 -radix unsigned} {/tb/uut/coins[1]} {-height 15 -radix unsigned} {/tb/uut/coins[0]} {-height 15 -radix unsigned}} /tb/uut/coins
add wave -noupdate -radix unsigned /tb/uut/change_r
add wave -noupdate -radix unsigned /tb/change
add wave -noupdate /tb/sell
add wave -noupdate /tb/uut/refund_p
add wave -noupdate -radix unsigned /tb/uut/count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {58904 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {61090 ps}
