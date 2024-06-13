module three_cycle(
  input       [ 7:0] A,
                     B,
  input              clk,
                     reset_n,
			         start,
  output logic       done_mult,
  output logic[15:0] result_mult);

  logic[ 7:0]        a_int, b_int;
  logic[15:0]        mult1, mult2;
  logic[ 3:1]        done;
  
  always @(posedge clk) 
  	if(!reset_n) begin
  	  done_mult     <= 'b0;
	  done          <= 'b0;
	  a_int         <= 'b0;
	  b_int         <= 'b0;
	  mult1         <= 'b0;
	  mult2         <= 'b0;
	  result_mult   <= 'b0;
    end 
	else begin
	  a_int         <= A;
	  b_int         <= B;
	  mult1         <= a_int * b_int;
	  mult2         <= mult1;
	  result_mult   <= mult2;
	  done[3]       <= start && (!done_mult);
	  done[2]       <= done[3] && (!done_mult);
	  done[1]       <= done[2] && (!done_mult);
	  done_mult     <= done[1] && (!done_mult);
    end

endmodule