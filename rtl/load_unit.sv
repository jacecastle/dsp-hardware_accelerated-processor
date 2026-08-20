//mux for differentiating load types (lw, lb, lh, etc)
module load_unit (
    input logic [2:0] ld_type,
    input logic [31:0] ld_in,
    output logic [31:0] ld_out
);

    always_comb begin
        unique case (ld_type)
            3'b000: ld_out = {{24{ld_in[7]}}, ld_in[7:0]}; //lb
            3'b001: ld_out = {{16{ld_in[15]}}, ld_in[15:0]}; //lh
            3'b010: ld_out = ld_in; //lw
            default : ld_out = 32'h0000;
         endcase
    end
endmodule