`timescale 1ns/1ps

module tb;

    // Clock and reset
    logic clk;
    logic rst;


    // Instantiate the core
    core uut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation: 10ns period → 100MHz
    always #5 clk = ~clk;

    // Initial block for reset and simulation control
    initial begin


        clk = 0;
        rst = 1;

        // Hold reset active for some cycles
        #20;
        rst = 0;
       

        // Run simulation for 5000ns (500 cycles)
        repeat (500) begin
            @(posedge clk);
        end

    
        $finish;
    end

endmodule
