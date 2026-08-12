module PC(input   logic        clk,
        input   logic        reset,
        input logic [31:0] pc_next,
        output logic [31:0] pc
);
    always_ff(@posedge clk) begin
        if(reset)
            pc <= 32'h0000;
        else begin
            pc <= pc_next;
                 
        end

        
    end
endmodule
