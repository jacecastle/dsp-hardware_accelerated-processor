module PC(
    input logic clk,
    input logic reset,
    input logic [31:0] pc_next,
    output logic [31:0] pc_addr
);
    always_ff(@posedge clk) begin
        if(reset)
            pc_addr <= 32'h0000;
        else
            pc_addr <= pc_next;
        
    end
endmodule
