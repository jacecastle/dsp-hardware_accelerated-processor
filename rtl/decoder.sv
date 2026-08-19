module decoder(input logic [31:0] instruction,
               output logic [2:0] alu_op,
               output logic RegWr, 
               output logic ALUSrc,
               output logic [4:0] rs1, rs2, rd
               output logic [31:0] immediate
);

logic [6:0] opcode;
logic [2:0] funct3;
logic [6:0] funct7;
 

assign opcode = instruction[6:0];
assign funct3 = instruction[14:12];
assign funct7 = instruction[31:25];

assign rs1 = instruction[19:15];
assign rs2 = instruction[24:20];
assign rd  = instruction[11:7];
//immediate 
assign immediate = {{20{instruction[31]}}, instruction[31:20]};


always_comb begin
    RegWr = 1'b0;
    alu_op = 3'b0;
    
    case(opcode)

    //rtype
    7'b0110011: begin
        RegWr = 1'b1;
        ALUSrc = 1'b1;
        case(funct3)
            3'b000: begin
                if(funct7==7'b0) 
                    alu_op = 3'b000; //add
                else if (funct7 == 7'b0100000)
                    alu_op =   3'b001; //sub
            end

            3'b111:
                alu_op = 3'b010; //and
            
            3'b110:
                alu_op = 3'b100; //or

            3'b100:
                alu_op = 3'011;
        endcase
    end

    7'b0010011: begin
        RegWr = 1'b1; 
        ALUSrc = 1'b0;
        case(funct3)
            3'b000:
                alu_op = 3'b000; //addi
            3'b111:
                alu_op = 3'b010; //andi
            3'b110:
                alu_op = 3'b100; //ori
        endcase
    end

    endcase
    
    


end


endmodule