module decoder(input logic [31:0] instruction,
               output logic [2:0] ALUK,
               output logic RegWr, 
               output logic [4:0] rs1, rs2, rd
);

logic [6:0] opcode = instruction[6:0];
logic [2:0] funct3 = instruction[14:12];
logic [6:0] funct7 = instruction[31:25];


always_comb begin
    RegWr = 1'b0;
    ALUK = 3'b0;
    
    case(opcode)

    //rtype
    7'b0110011: begin
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign rd  = instruction[11:7];
        RegWr = 1'b1;
        case(funct3)
            3'b000: begin
                if(funct7==7'b0) 
                    ALUK = 3'b000; //add
                else if (funct7 == 7'b0100000)
                    ALUK =   3'b001; //sub
            end

            3'b111:
                ALUK = 3'b010; //and


        endcase
    end

    endcase  
    
    


end


endmodule