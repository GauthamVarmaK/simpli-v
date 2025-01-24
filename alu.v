module alu (
    input wire [31:0] SrcA,
    input wire [31:0] SrcB,
    input wire [3:0] ALUControl,
    output reg [31:0] ALUResult,
    output reg Zero
);
  reg [31:0] temp_result;

  always @(*) begin
    case (ALUControl)
      4'b0000: temp_result = SrcA + SrcB;  // Addition
      4'b1000: temp_result = SrcA - SrcB;  // Subtraction
      4'b0001: temp_result = SrcA << SrcB[4:0];  //Shift left
      4'b0010: temp_result = (SrcA < SrcB) ? 1 : 0;  // Set Less Than
      4'b0011: temp_result = (SrcA < SrcB) ? 1 : 0;  // Set Less Than Unsigned
      4'b0100: temp_result = SrcA ^ SrcB;  // Bitwise XOR
      4'b0101: temp_result = SrcA >> SrcB[4:0];  // Logical shift right
      4'b1101: temp_result = SrcA >>> SrcB[4:0];  // Arithmetic shift right
      4'b0110: temp_result = SrcA | SrcB;  // Bitwise OR
      4'b0111: temp_result = SrcA & SrcB;  // Bitwise AND
      default: temp_result = 32'h0;
    endcase

    ALUResult = temp_result;  // was temp_result
    Zero = (ALUResult == 32'h0);  // Set Zero flag
  end
endmodule
