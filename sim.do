# 1. Clean Start
if {[file exists work]} {
    vdel -lib work -all
}
vlib work

# 2. Compile Design & Testbench (vcom for VHDL, vlog for SystemVerilog)
vcom -2008 traffic_light.vhd
vlog -sv top.sv
vlog -sv traffic_light_tb.sv

# 3. Load Simulator in GUI Mode
vsim -voptargs="+acc" traffic_light_tb

# 4. Add Signals to the Waveform Window 
#    Clear any previous waves
catch {delete wave *}

#    Add Top-Level Testbench signals {Clock, Reset, Buttons}
add wave -noupdate -divider "Testbench Signals"
add wave -noupdate /traffic_light_tb/*

#    Add Internal UUT signals (Crucial for seeing State Machine transitions!)
add wave -noupdate -divider "Internal FPGA Logic"
add wave -noupdate /traffic_light_tb/uut/*

# 5. formatting
#    Set the time units to act nicely in the viewer
configure wave -timelineunits ns

# 6. Run the Simulation
#    Run for a specific time or -all
run -all

# 7. Zoom to fit  
wave zoom full
