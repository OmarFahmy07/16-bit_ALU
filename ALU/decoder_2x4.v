module decoder_2x4(
  input wire [1:0] in,
  output reg out0,
  output reg out1,
  output reg out2,
  output reg out3
  );
  
  always @(*)
  begin
    case (in)
      2'b00:
        begin
          out0 = 1'b1;
          out1 = 1'b0;
          out2 = 1'b0;
          out3 = 1'b0;
        end
        
      2'b01:
        begin
          out0 = 1'b0;
          out1 = 1'b1;
          out2 = 1'b0;
          out3 = 1'b0;
        end
        
      2'b10:
        begin
          out0 = 1'b0;
          out1 = 1'b0;
          out2 = 1'b1;
          out3 = 1'b0;
        end
        
      2'b11:
        begin
          out0 = 1'b0;
          out1 = 1'b0;
          out2 = 1'b0;
          out3 = 1'b1;
        end
        
    endcase
  end
  
endmodule
