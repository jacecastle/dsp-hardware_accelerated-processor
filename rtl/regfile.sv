module reg_file(input logic clk,
                input logic reset,
                input logic [31:0] wr_data,
                input logic [4:0] RS1,
                input logic [4:0] RS2,
                input logic [4:0] RD,
                input logic ld_reg, 
                output logic [31:0] RS1_out,
                output logic [31:0] RS2_out
    );

     logic [31:0] reg_file [32];
     integer i;
    
     assign RS1_out = reg_file[RS1];
     assign RS2_out = reg_file[RS2];

         
    always_ff@(posedge clk)begin
        if(reset) begin
            for(i=0; i<=31; i=i+1) begin
                reg_file[i] <= 32'h0000;
            end
        end
        else if(ld_reg && RD != 5'd0)begin
            reg_file[RD]<=wr_data;    
        end
    end
            
endmodule


