/* adpated "From UVM Primer," Ch. 6, 2013, Ray Salemi
*/
virtual class animal;
  int age=-1;

  function new(int a);
    age = a;
  endfunction : new

  pure virtual function void make_sound();     // no body!

endclass : animal


class lion extends animal;

  function new(int age);
    super.new(age);
  endfunction : new

  function void make_sound();
    $display ("The Lion says Roar");
  endfunction : make_sound

endclass : lion


class chicken extends animal;

  function new(int age);
    super.new(age);
  endfunction : new

  function void make_sound();
    $display ("The Chicken says BECAWW");
  endfunction : make_sound

endclass : chicken


module top;

  initial begin :init_loop
  
    lion    lion_h;
    chicken chicken_h;
    animal  animal_h;
  
    animal_h = new(3); 
    
    lion_h  = new(15);
    lion_h.make_sound();
    $display("The Lion is %0d years old", lion_h.age);
    
    chicken_h = new(1);
    chicken_h.make_sound();
    $display("The Chicken is %0d years old", chicken_h.age);

    animal_h = lion_h;
    animal_h.make_sound();
    $display("The animal is %0d years old", animal_h.age);
    
    animal_h = chicken_h;
    animal_h.make_sound();
    $display("The animal is %0d years old", animal_h.age);
      
   end :init_loop

endmodule : top




