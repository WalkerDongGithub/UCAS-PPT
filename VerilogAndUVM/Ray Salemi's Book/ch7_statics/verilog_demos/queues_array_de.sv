module queues_array_de;               // random delete
  //declaration
  int    queue[$];
  int    index;
  int  temp_var;
    
  initial begin
    //Queue Initialization:
    queue = {7,3,1,0,8};
      
    $display("Queue entries are %p",queue);
    $display("Before Queue size is %0d",queue.size());
    index    = $urandom_range(0,4); //index of queue is from 0 to 4
    $display("Index %0d is deleted",index);
    queue.delete(index);
    $display("After Queue size is %0d",queue.size());
    $display("Queue entries are %p",queue);
    
    $display("\nQueue entries are %p",queue);
    $display("Before Queue size is %0d",queue.size());
    index    = $urandom_range(0,3); //index of queue is from 0 to 4
    $display("Index %0d is deleted",index);
    queue.delete(index);
    $display("After Queue size is %0d",queue.size());
    $display("Queue entries are %p",queue);   
  end
endmodule