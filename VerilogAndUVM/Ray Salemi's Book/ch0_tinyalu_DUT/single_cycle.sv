module single_cycle(
  input       [ 7:0] A, B,
  input              clk,
  input       [ 2:0] op,
  input              reset_n,
                     start,
  output logic       done_aax,
  output logic[15:0] result_aax);

  always @(posedge clk) 
    if(!reset_n) begin
	  result_aax <= 'b0;
	  done_aax   <= 'b0;
	end
	else if(start) begin
      done_aax <= op? 'b1 : 'b0; 
	  case(op)
	    3'b001:  result_aax <= A+B;
	    3'b010:  result_aax <= A&B;
	    3'b011:  result_aax <= A^B;
	    default: result_aax <= 'b0; 
	  endcase
	end
	else 
	  done_aax <= 'b0;
endmodule

 