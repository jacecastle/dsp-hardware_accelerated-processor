module PC(input   logic        clk,
        input   logic        reset,
        input logic [31:0] pc_next,
        output logic [31:0] pc
);
    always_ff(@posedge clk) begin
        if(reset)
            pc_next <= 32'h0000;
        else begin
            pc_next <= pc + 32'h0004; 

                 
        end

        pc <= pc_next;
    end
endmodule
