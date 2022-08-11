module LOGIC_UNIT #(
  parameter DATA_WIDTH = 8
  ) (
  input wire [DATA_WIDTH - 1 : 0]        in1,
  input wire [DATA_WIDTH - 1 : 0]        in2,
  input wire                            clk,
  input wire [1:0]                      logic_fun,
  input wire                            logic_en,
  output reg [DATA_WIDTH - 1 : 0]  logic_out,
  output reg                            logic_flag
  );
  
  reg [DATA_WIDTH - 1 : 0] logic_out_comb;
  reg logic_flag_comb;
  
  always @(posedge clk)
    begin
      logic_out <= logic_out_comb;
      logic_flag <= logic_flag_comb;      
    end
  
  always @(*)
    begin
      logic_out_comb = 'b0;
      logic_flag_comb = 1'b0;
      if (logic_en)
        begin
          case (logic_fun)
            2'b00: 
            begin
              logic_out_comb = in1 & in2;
              logic_flag_comb = 1'b1;
            end
            
            2'b01:
            begin
              logic_out_comb = in1 | in2;
              logic_flag_comb = 1'b1;
            end
          
            2'b10:
            begin
              logic_out_comb = ~(in1 & in2);
              logic_flag_comb = 1'b1;
            end
          
            2'b11:
            begin
              logic_out_comb = ~(in1 | in2);
              logic_flag_comb = 1'b1;
            end
          
            default:
            begin
              logic_out_comb = 'b0;
              logic_flag_comb = 1'b0;
            end
          
          endcase
        end
      else
        begin
          logic_out_comb = 'b0;
          logic_flag_comb = 1'b0;
        end  
    end
  
  
endmodule


