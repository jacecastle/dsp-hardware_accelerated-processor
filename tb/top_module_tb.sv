module top_module_tb;

    logic clk;
    logic reset;

    // Instantiate the processor
    top_module dut (
        .clk(clk),
        .reset(reset)
    );

    // 10 ns clock period
    always #5 clk = ~clk;

    initial begin

        //gives permission to dump the waveform to a file for viewing in GTKWave
        $dumpfile("waveform.vcd"); // Specifies the output file name
        $dumpvars(0, top_module_tb);       // Dumps all signals in testbench module 'tb_top'

        // Initialize clock and reset
        clk   = 1'b0;
        reset = 1'b1;

        // Hold reset for one clock cycle
        @(posedge clk);
        reset = 1'b0;

        // Initialize registers
        dut.regfile.reg_file[1] = 32'd10;  // x1 = 10
        dut.regfile.reg_file[2] = 32'd20;  // x2 = 20

        // Load instructions into instruction memory
        dut.instruction_memory.mem[0] = 32'h002081B3; // add x3, x1, x2
        dut.instruction_memory.mem[1] = 32'h40118233; // sub x4, x3, x1

        // Wait for ADD instruction to execute
        @(posedge clk);

        // Check x3
        if (dut.regfile.reg_file[3] == 32'd30)
            $display("PASS: ADD x3 = %0d", dut.regfile.reg_file[3]);
        else
            $display("FAIL: ADD x3 = %0d, expected 30",
                     dut.regfile.reg_file[3]);

        // Wait for SUB instruction to execute
        @(posedge clk);

        // Check x4
        if (dut.regfile.reg_file[4] == 32'd20)
            $display("PASS: SUB x4 = %0d", dut.regfile.reg_file[4]);
        else
            $display("FAIL: SUB x4 = %0d, expected 20",
                     dut.regfile.reg_file[4]);

        $finish;
    end

endmodule
