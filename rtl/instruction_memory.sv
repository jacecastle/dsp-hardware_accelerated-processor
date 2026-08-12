module instruction_mem (
    input  logic [31:0] pc,
    output logic [31:0] instr
);

    parameter ADDR_WIDTH = 8,
    parameter MEM_FILE = "instruction_mem.hex"
    parameter DEPTH = (1 << ADDR_WIDTH); // same as 2^(ADDR_WIDTH)

    logic [31:0] mem [0:DEPTH-1]; //creates 256 registers of 32 bits each

    //reads the contents of the instruction memory from a hex file, stores it in the mem array
    //
    //If we used BRAM instead of simulating memory, instruction would be stored in cells that hold 8 bits each, 
    //so we would appendd 4 cells together, and puts the info in a single register of mem.  
    initial begin
        $readmemh(MEM_FILE, mem); 
    end

    assign instr = mem[pc_addr[ADDR_WIDTH+1:2]];

endmodule