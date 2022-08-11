module SHIFT_UNIT #(
  parameter DATA_WIDTH = 8
  ) (
  input wire [DATA_WIDTH - 1 : 0]        in1,
  input wire [DATA_WIDTH - 1 : 0]        in2,
  input wire                            clk,
  input wire [1:0]                      shift_fun,
  input wire                            shift_en,
  output reg [DATA_WIDTH - 1 : 0]  shift_out,
  output reg                            shift_flag
  );
  
  reg [DATA_WIDTH - 1 : 0] shift_out_comb;
  reg shift_flag_comb;
  
  always @(posedge clk)
    begin
      shift_out <= shift_out_comb;
      shift_flag <= shift_flag_comb;      
    end
  
  always @(*)
    begin
      shift_out_comb = 'b0;
      shift_flag_comb = 1'b0;
      if (shift_en)
        begin
          case (shift_fun)
            2'b00: 
            begin
              shift_out_comb = in1 >> 1'b1;
              shift_flag_comb = 1'b1;
            end
            
            2'b01:
            begin
              shift_out_comb = in1 << 1'b1;
              shift_flag_comb = 1'b1;
            end
          
            2'b10:
            begin
              shift_out_comb = in2 >> 1'b1;
              shift_flag_comb = 1'b1;
            end
          
            2'b11:
            begin
              shift_out_comb = in2 << 1'b1;
              shift_flag_comb = 1'b1;
            end
          
            default:
            begin
              shift_out_comb = 'b0;
              shift_flag_comb = 1'b0;
            end
          
          endcase
        end
      else
        begin
          shift_out_comb = 'b0;
          shift_flag_comb = 1'b0;
        end  
    end
  
endmodule


