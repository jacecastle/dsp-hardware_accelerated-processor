module decoder(input logic [31:0] instruction,
               output logic [2:0] alu_op,
               output logic RegWr, 
               output logic ALUSrc,
               output logic MemWr,
               output logic MemRd,
               output logic [2:0] ld_type, 
               output logic [2:0] st_type,
               output logic [4:0] rs1, rs2, rd,
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
assign immediate = MemWr ? {{20{instruction[31]}}, instruction[31:25], instruction[11:7]} 
                        : {{20{instruction[31]}}, instruction[31:20]};


always_comb begin
    RegWr = 1'b0;
    alu_op = 3'b0;
    ALUSrc = 1'b0;
    MemRd = 1'b0;
    MemWr = 1'b0;
    ld_type = 3'b0;
    
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
                alu_op = 3'b011; //xor
        endcase
    end

    //itype
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
            3'b100:
                alu_op = 3'b011; //xori
        endcase
    end

    //i-type load 
    7'b0000011: begin
        RegWr = 1'b1; 
        ALUSrc = 1'b0;
        MemRd = 1'b1;
        alu_op = 3'b000; //ALU needs to do addition for target memory address calculation
        case(funct3)
            3'b000: begin
                ld_type = 3'b000;
                //lb
            end
            3'b001: begin
                ld_type = 3'b001;
                //lh
            end
            3'b010: begin
                ld_type = 3'b010;
                //lw
            end

            
            //include uppers later
        endcase
    end

    //s-type store
    7'b0100011: begin
        ALUSrc = 1'b0;
        MemWr = 1'b1;
        alu_op = 3'b000; //ALU needs to do addition for target memory address calculation
        case(funct3)
            3'b000: begin
                st_type = 3'b000;
                //sb
            end
            3'b001: begin
                st_type = 3'b001;
                //sh
            end
            3'b010: begin
                st_type = 3'b010;
                //sw
            end
            
            //include uppers later
        endcase
    end

    endcase
end


endmodule