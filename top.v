module top (
    input wire clk,
    input wire reset,
    output wire [31:0] WriteData,
    output wire [31:0] DataAdr,
    output wire MemWrite
);
  wire [31:0] PC;
  wire [31:0] Instr, ReadData;
  // instantiate processor and memories
  riscvsingle rvsingle (
      clk,
      reset,
      PC,
      Instr,
      MemWrite,
      DataAdr,
      WriteData,
      ReadData
  );
  imem imem1 (
      PC,
      Instr
  );
  dmem dmem1 (
      clk,
      MemWrite,
      DataAdr,
      WriteData,
      ReadData
  );
endmodule
