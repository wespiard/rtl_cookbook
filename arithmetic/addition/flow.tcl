set top adder
set outputDir ./build_output
file mkdir $outputDir

set_part xcau15p-ffvb676-2-i

read_sverilog -sv ./adder.sv
read_sverilog -sv ./adder_ternary.sv

read_xdc ./clk.sdc

synth_design -top $top
write_checkpoint -force $outputDir/post_synth
report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
report_utilization -file $outputDir/post_synth_utilization.rpt
