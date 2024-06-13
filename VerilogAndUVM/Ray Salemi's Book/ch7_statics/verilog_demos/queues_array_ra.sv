module queues_array_ra;    // random access
  //declaration
  int    queue[$];
  int    index;
  int  temp_var;
    
  initial begin
    //Queue Initialization:
    queue = {7,3,1,0,8};
      
    $display("----- Queue elements with index -----");
    foreach(queue[i])
      $display("\tqueue[%0d] = %0d",i,queue[i]);
    $display("-------------------------------------\n");
     
    $display("Before Queue size is %0d",queue.size());
    repeat(2) begin //{
      index    = $urandom_range(0,4); //index of queue is from 0 to 4
      temp_var = queue[index];
      $display("Value of Index %0d in Queue is %0d",index,temp_var);
    end //}
    $display("After Queue size is %0d",queue.size());
  end
endmodule