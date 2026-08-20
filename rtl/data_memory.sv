module data_mem (
    input logic clk,
    input  logic [31:0] data_addr,
    input logic [31:0] data_in,
    input logic MemWr,
    input logic MemRd,
    output logic [31:0] data_out,
);

    logic [7:0] mem [0:255]; //creates 256 registers of 8 bits each, since sdfsdfsdf
 
    //data_addr[7:2] is used to index the memory, since each register is 
    //4 bytes (32 bits) and we want to ignore the last 2 bits of the address
    assign data_out = MemRd ? {mem[data_addr+3], mem[data_addr+2], mem[data_addr+1], mem[data_addr]} : 32'b0;

    always_ff @(posedge clk) begin
        if (MemWr)
            mem[data_addr[7:2]] <= data_in;
    end

endmodule