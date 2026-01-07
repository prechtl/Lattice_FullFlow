module top
(
	input	logic clk,
	input	logic reset,
	input	logic ped_button,
	output	logic red,
	output	logic yellow,
	output	logic green
);

// Instantiate the VHDL module
// Synplify handles the cross-language binding automatically
traffic_light u_traffic_light
(
	.clk(clk),
	.reset(reset),
	.ped_button(ped_button),
	.red(red),
	.yellow(yellow),
	.green(green)
);

endmodule
