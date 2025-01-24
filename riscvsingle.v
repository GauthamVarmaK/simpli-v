module riscvsingle (
    input wire clk,
    input wire reset,
    output wire [31:0] PC,
    input wire [31:0] Instr,
    output wire MemWrite,
    output wire [31:0] ALUResult,
    output wire [31:0] WriteData,
    input wire [31:0] ReadData
);
  wire ALUSrc, RegWrite, Jump, Zero;
  wire [1:0] ResultSrc, ImmSrc;
  wire [3:0] ALUControl;
  controller c (
      Instr[6:0],
      Instr[14:12],
      Instr[30],
      Zero,
      ResultSrc,
      MemWrite,
      PCSrc,
      ALUSrc,
      RegWrite,
      Jump,
      ImmSrc,
      ALUControl
  );
  datapath dp (
      clk,
      reset,
      ResultSrc,
      PCSrc,
      ALUSrc,
      RegWrite,
      ImmSrc,
      ALUControl,
      Zero,
      PC,
      Instr,
      ALUResult,
      WriteData,
      ReadData
  );
endmodule
