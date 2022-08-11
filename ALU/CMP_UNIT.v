module CMP_UNIT #(
  parameter DATA_WIDTH = 8
  ) (
  input wire [DATA_WIDTH - 1 : 0]        in1,
  input wire [DATA_WIDTH - 1 : 0]        in2,
  input wire                            clk,
  input wire [1:0]                      cmp_fun,
  input wire                            cmp_en,
  output reg [DATA_WIDTH - 1 : 0]    cmp_out,
  output reg                            cmp_flag
  );
  
  reg [DATA_WIDTH - 1 : 0] cmp_out_comb;
  reg cmp_flag_comb;
  
  always @(posedge clk)
    begin
      cmp_out <= cmp_out_comb;
      cmp_flag <= cmp_flag_comb;      
    end
  
  always @(*)
    begin
      cmp_out_comb = 'b0;
      cmp_flag_comb = 1'b0;
      if (cmp_en)
        begin
          case (cmp_fun)
            2'b00: 
            begin
              cmp_out_comb = 'b0;
              cmp_flag_comb = 1'b1;
            end
            
            2'b01:
            begin
              if(in1 == in2)
                begin
                  cmp_out_comb = 'b1;
                end
              else
                begin
                  cmp_out_comb = 'b0;
                end
              cmp_flag_comb = 1'b1;
            end
          
            2'b10:
            begin
              if(in1 > in2)
                begin
                  cmp_out_comb = 'b10;
                end
              else
                begin
                  cmp_out_comb = 'b0;
                end
              cmp_flag_comb = 1'b1;
            end
          
            2'b11:
            begin
              if(in1 < in2)
                begin
                  cmp_out_comb = 'b11;
                end
              else
                begin
                  cmp_out_comb = 'b0;
                end
              cmp_flag_comb = 1'b1;
            end
          
            default:
            begin
              cmp_out_comb = 'b0;
              cmp_flag_comb = 1'b0;
            end
          
          endcase
        end
      else
        begin
          cmp_out_comb = 'b0;
          cmp_flag_comb = 1'b0;
        end  
    end
  
endmodule


