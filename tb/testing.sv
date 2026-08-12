`timescale 1ns/1ps

module testing;

logic clk;
logic reset;

top_module dut(
    .clk(clk),
    .reset(reset)
);

// 10 ns period
always #5 clk = ~clk;

initial begin

    clk = 0;
    reset = 1;

    // Hold reset for one cycle
    #10;
    reset = 0;

    // Preload registers
    dut.regfile.reg_file[1] = 32'd7;
    dut.regfile.reg_file[2] = 32'd5;

    // Let CPU run
    #30;

    $finish;

end

endmodule