/* bfm
*/
interface tinyalu_bfm;
   import tinyalu_pkg::*;

   byte         unsigned        A;
   byte         unsigned        B;
   bit          clk;
   bit          reset_n;
   wire [2:0]   op;
   bit          start;
   wire         done;
   wire [15:0]  result;
   operation_t  op_set;

   assign op = op_set;

   always begin
     #10ns clk = 'b1;
     #10ns clk = 'b0;
   end

   task reset_alu();
      reset_n = 1'b0;
      @(negedge clk);
      @(negedge clk);
      reset_n = 1'b1;
      start = 1'b0;
   endtask : reset_alu

// sends an operation to the ALU (duh!) and returns the results   
  task send_op(input byte iA, input byte iB, input operation_t iop, 
               output shortint alu_result);
    op_set = iop;
     
    if (iop == rst_op) begin            // pulse reset for one clock cycle
      @(posedge clk);
      reset_n = 1'b0;
      start = 1'b0;
      @(posedge clk);
      #1ns;
      reset_n = 1'b1;
    end 
    else begin
      @(negedge clk);                   // change inputs between active clock edges 
      A = iA;
      B = iB;
      start = 1'b1;
      if (iop == no_op) begin           // no op
         @(posedge clk);
         #1;
         start = 1'b0;           
      end 
      else begin
        do
        @(negedge clk);                 // wait through clock cycles until done==1
        while (done == 0);
        start = 1'b0;                   // then release start
      end
    end // else: !if(iop == rst_op)
      
   endtask : send_op

endinterface : tinyalu_bfm