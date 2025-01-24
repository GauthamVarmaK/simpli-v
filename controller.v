module controller (
    input wire [6:0] op,
    input wire [2:0] funct3,
    input wire funct7b5,
    input wire Zero,
    output wire [1:0] ResultSrc,
    output wire MemWrite,
    output wire PCSrc,
    output wire ALUSrc,
    output wire RegWrite,
    output wire Jump,
    output wire [1:0] ImmSrc,
    output wire [3:0] ALUControl
);
  wire [1:0] ALUOp;
  wire Branch;

  maindec md (
      op,
      ResultSrc,
      MemWrite,
      Branch,
      ALUSrc,
      RegWrite,
      Jump,
      ImmSrc,
      ALUOp
  );
  aludec ad (
      op[5],
      funct3,
      funct7b5,
      ALUOp,
      ALUControl
  );
  assign PCSrc = (Branch & (funct3[2]^funct3[0]^Zero)) | Jump;
endmodule

