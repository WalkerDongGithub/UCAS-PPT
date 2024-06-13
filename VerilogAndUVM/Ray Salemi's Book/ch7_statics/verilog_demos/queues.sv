// Queue declarations
bit    queue_1[$];     // queue of bits  (unbound queue)
int    queue_2[$];     // queue of int 
byte   queue_3[$:255]; // queue of byte (bounded queue with 256 entries)
string queue_4[$];     // queue of strings

// Queue initialization
queue_1  = {0,1,2,3}; 
queue_4  = {“Red”,"Blue”,"Green”};

