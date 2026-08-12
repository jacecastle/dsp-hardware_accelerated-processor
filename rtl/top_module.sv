module top_module(
    input logic clk,
    input logic reset
);
    //PC to instruction_memory wires
    logic [31:0] pc; 
    logic [31:0] instr;

    //wire goes to input of pc module
    logic [31:0] pc_next;
    assign pc_next = pc + 32'h0004; //incrementing the pc by 4 to get the next instruction (mini-adder)

    //wires from decoder to input of reg_file
    logic RegWr;
    logic [4:0] rs1, rs2, rd;
    logic [31:0] wr_data;

    //wires from output of reg_file to input of ALU
    logic [31:0] RS1_out, RS2_out;

    //wire from decoder to input of ALU
    logic [2:0] alu_op;

    //wire from output of ALU to input of reg_file
    logic [31:0] alu_out;

    instruction_memory instruction_memory (
        .pc(pc), //connecting the wire pc to the input of instruction_mem
        .instr(instr) //connecting the output of instruction_mem to the wire instr
    );

    decoder decoder (
        .instruction(instr), //connecting the wire instr to the input of decoder
        .alu_op(alu_op), //connecting the output of decoder to the wire alu_op
        .RegWr(RegWr), //connecting the output of decoder to the wire RegWr
        .rs1(rs1), //connecting the output of decoder to the wire rs1
        .rs2(rs2), //connecting the output of decoder to the wire rs2
        .rd(rd) //connecting the output of decoder to the wire rd
    );

    pc pc (
        .clk(clk), //connecting the input clk to the input of pc
        .reset(reset), //connecting the input reset to the input of pc
        .pc_next(pc_next), //connecting the wire pc_next to the input of pc
        .pc(pc) //connecting the output of pc to the wire pc
    )

    reg_file regfile (
        .clk(clk), //connecting the input clk to the input of reg_file
        .reset(reset), //connecting the input reset to the input of reg_file
        .wr_data(wr_data), //connecting the wire wr_data to the input of reg_file
        .RS1(rs1), //connecting the wire rs1 to the input of reg_file
        .RS2(rs2), //connecting the wire rs2 to the input of reg_file
        .RD(rd), //connecting the wire rd to the input of reg_file
        .ld_reg(RegWr), //connecting the wire RegWr to the input of reg_file
        .RS1_out(RS1_out), //connecting the output of reg_file to the wire RS1_out
        .RS2_out(RS2_out) //connecting the output of reg_file to the wire RS2_out
    );

    alu ALU (
        .rs1(RS1_out), //connecting the wire RS1_out to the input of ALU
        .rs2(RS2_out), //connecting the wire RS2_out to the input of ALU
        .alu_op(alu_op), //connecting the wire alu_op to the control input of ALU
        .alu_out(alu_out) //connecting the output of ALU to the wire alu_out
    );


endmodule