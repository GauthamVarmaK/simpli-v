module datapath (
    input wire clk,
    input wire reset,
    input wire [1:0] ResultSrc,
    input wire PCSrc,
    input wire ALUSrc,
    input wire RegWrite,
    input wire [1:0] ImmSrc,
    input wire [3:0] ALUControl,
    output wire Zero,
    output wire [31:0] PC,
    input wire [31:0] Instr,
    output wire [31:0] ALUResult,
    output wire [31:0] WriteData,
    input wire [31:0] ReadData
);
  wire [31:0] PCNext, PCPlus4, PCTarget;
  wire [31:0] ImmExt;
  wire [31:0] SrcA, SrcB;
  wire [31:0] Result;
  wire [31:0] upimm = {Instr[31:12],{12{1'b0}}};
  // next PC logic
  flopr #(32) pcreg (
      clk,
      reset,
      PCNext,
      PC
  );
  adder pcadd4 (
      PC,
      32'd4,
      PCPlus4
  );
  adder pcaddbranch (
      PC,
      ImmExt,
      PCTarget
  );
  mux2 #(32) pcmux (
      PCPlus4,
      PCTarget,
      PCSrc,
      PCNext
  );
  // register file logic
  regfile rf (
      clk,
      RegWrite,
      Instr[19:15],
      Instr[24:20],
      Instr[11:7],
      Result,
      SrcA,
      WriteData
  );
  extend ext (
      Instr[31:7],
      ImmSrc,
      ImmExt
  );
  // ALU logic
  mux2 #(32) srcbmux (
      WriteData,
      ImmExt,
      ALUSrc,
      SrcB
  );
  alu alu (
      SrcA,
      SrcB,
      ALUControl,
      ALUResult,
      Zero
  );
  mux4 #(32) resultmux (
      ALUResult,
      ReadData,
      PCPlus4,
      upimm,
      ResultSrc,
      Result
  );
endmodule
