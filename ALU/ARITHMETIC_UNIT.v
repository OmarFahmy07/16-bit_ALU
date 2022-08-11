module ARITHMETIC_UNIT #(
  parameter DATA_WIDTH = 8
  ) (
  input wire [DATA_WIDTH - 1 : 0]        in1,
  input wire [DATA_WIDTH - 1 : 0]        in2,
  input wire                            clk,
  input wire [1:0]                      arith_fun,
  input wire                            arith_en,
  output reg [DATA_WIDTH - 1 : 0]  arith_out,
  output reg                            arith_cout,
  output reg                            arith_flag
  );
  
  reg [DATA_WIDTH - 1 : 0] arith_out_comb;
  reg arith_cout_comb;
  reg arith_flag_comb;

  always @(posedge clk)
  begin
    arith_out <= arith_out_comb;
    arith_cout <= arith_cout_comb;
    arith_flag <= arith_flag_comb;
  end

  always @(*)
    begin
      arith_out_comb = 'b0;
      arith_cout_comb = 1'b0;
      arith_flag_comb = 1'b0;
      if (arith_en)
        begin
          case (arith_fun)
            2'b00: 
            begin
              {arith_cout_comb, arith_out_comb} = in1 + in2;
              arith_flag_comb = 1'b1;
            end
            
            2'b01:
            begin
              {arith_cout_comb, arith_out_comb} = in1 - in2;
              arith_flag_comb = 1'b1;
            end
          
            2'b10:
            begin
              {arith_cout_comb, arith_out_comb} = in1 * in2;
              arith_flag_comb = 1'b1;
            end
          
            2'b11:
            begin
              {arith_cout_comb, arith_out_comb} = in1 / in2;
              arith_flag_comb = 1'b1;
            end
          
            default:
            begin
              arith_out_comb = 'b0;
              arith_cout_comb = 1'b0;
              arith_flag_comb = 1'b0;
            end
          
          endcase
        end
      else
        begin
          arith_out_comb = 'b0;
          arith_cout_comb = 1'b0;
          arith_flag_comb = 1'b0;
        end  
    end
  
endmodule
