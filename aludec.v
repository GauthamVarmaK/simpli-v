module aludec (
    input wire opb5,
    input wire [2:0] funct3,
    input wire funct7b5,
    input wire [1:0] ALUOp,
    output reg [3:0] ALUControl
);
  wire RtypeSub;
  assign RtypeSub = funct7b5 & opb5;
  always @(*)
  case(ALUOp)
   2'b00: ALUControl = 4'b0000; // Perform a+b for lw,sw,jal
   2'b01:
      case(funct3[2:1])
          2'b00: ALUControl = 4'b1000; // Perform a-b for beq and bnq
          2'b10: ALUControl = 4'b0010; // Perform a-b for blt and bge
          2'b11: ALUControl = 4'b0011; // Perform a-b for bltu and bgeu   
          default: ALUControl = 4'b1000; // Perform a-b for beq and bnq
      endcase
   default:
      case(funct3)
          3'b000: ALUControl = {funct7b5 & opb5,3'b000}; // Perform addition/sub for R/I type
          3'b001: ALUControl = 4'b0001; // Shift left
          3'b010: ALUControl = 4'b0010; // Set Less Than
          3'b011: ALUControl = 4'b0011; // Set Less Than Unsigned
          3'b100: ALUControl = 4'b0100; // Bitwise XOR
          3'b101: ALUControl = {funct7b5,3'b101}; // srl or sra
          3'b110: ALUControl = 4'b0110; // Bitwise OR
          3'b111: ALUControl = 4'b0111; // Bitwise AND
          default: ALUControl = 3'bxxx;  //other
      endcase
  endcase
endmodule
