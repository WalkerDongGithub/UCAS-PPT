module queues_array_bb;		  // (queue is not a SystemVerilog keyword)
//declaration
  int    queue[$:2];          // bounded queue, length 3
  int    index;
  int  temp_var;
    
  initial begin
//Queue Initialization:
    queue = {7,3,1};
      
    $display("Queue elements are,");
    $display("\tqueue = %p",queue);
     
    queue.push_back(10);
     
    $display("After push_back Queue elements are,");
    $display("\tqueue = %p",queue);
     
    queue.push_front(10);
     
    $display("After push_front Queue elements are,");
    $display("\tqueue = %p",queue);
  end
  
endmodule