//mux for differentiating store types (sw, sb, sh, etc)
module store_unit (
    input logic [2:0] st_type,
    input logic [31:0] st_in,
    output logic [31:0] st_out
);

    always_comb begin
        unique case (st_type)
            3'b000: st_out = {{24{st_in[7]}}, st_in[7:0]}; //sb
            3'b001: st_out = {{16{st_in[15]}}, st_in[15:0]}; //sh
            3'b010: st_out = st_in; //sw
            default : st_out = 32'h0000;
         endcase
    end
endmodule