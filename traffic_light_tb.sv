`timescale 1ns / 1ps

module traffic_light_tb;

    // 1. Signal Declaration
    logic clk;
    logic reset;      // Active high reset
    logic ped_button; 
    logic red, yellow, green;

    // 2. Instantiate the Unit Under Test (UUT)
    // Ensure the port names match your traffic_light.sv definition
    traffic_light uut (
        .clk(clk),
        .reset(reset),
        .ped_button(ped_button),
        .red(red),
        .yellow(yellow),
        .green(green)
    );

    // 3. Clock Generation
    // Generate a 10ns clock period (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // 4. Test Stimulus
    initial begin
        // Initialize Inputs
        reset = 1; // Assert reset (active high)
        ped_button = 0;
        $display("Time: %0t | Starting Simulation. Reset Active.", $time);

      // 2. Hold Reset for 50ns
      #50;
      reset = 0;       // Release Reset
      $display("Time: %0t | Reset Released. Traffic Light should start.", $time);

      // 3. Let it run normally for a while (e.g., Green state)
      #500;

      // 4. Test Pedestrian Button
      $display("Time: %0t | Pressing Pedestrian Button...", $time);
      ped_button = 1;  // Press button
      #20;             // Hold for 2 clock cycles
      ped_button = 0;  // Release button

      // 5. Observe transition sequence
      // The light should go from Green -> Yellow -> Red -> Green
      #2000; 

      $display("Time: %0t | Simulation Complete.", $time);
      $stop; // Use $stop to pause simulation in GUI, $finish exits
    end

    // 5. Output Monitor
    // This block prints a message whenever the light changes
    always @(red, yellow, green) begin
        // Adding a small delay (#1) to allow signals to settle before printing
        #1; 
        if (~reset) begin
            $display("Time: %0t | Light Status: R=%b Y=%b G=%b", 
                     $time, red, yellow, green);
        end
    end

endmodule
