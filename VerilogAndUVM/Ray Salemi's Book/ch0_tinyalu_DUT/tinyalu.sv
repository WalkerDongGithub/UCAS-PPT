module tinyalu(
  input       [ 7:0] A, B,
  input              clk,
  input       [ 2:0] op,
  input              reset_n,
                     start,
  output logic       done,
  output logic[15:0] result);

  logic       done_aax,
              done_mult;
  logic[15:0] result_aax,
              result_mult;
  logic       start_single,
			  start_mult;

  single_cycle sc1(
    .A, .B, .clk, .op, .reset_n, .start(start_single),
    .done_aax, .result_aax);
    
  three_cycle tc1(
    .A, .B, .clk, .reset_n, .start(start_mult),
    .done_mult, .result_mult);                
									 
  always_comb 
    if(op[2]) begin
	  start_single = 'b0;
	  start_mult   = start;
	end
	else begin
	  start_single = start;
      start_mult   = 'b0;
	end
    
  always_comb 
    if(op[2]) begin
	  result        = result_mult;
	  done          = done_mult;
    end
	else begin 
	  result        = result_aax;
	  done          = done_aax;
	end

 endmodule