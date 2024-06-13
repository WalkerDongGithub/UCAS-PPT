/* based on Salemi Ch. 6, UVM Primer, 2013   "not_virtual.sv"
*/
class animal;                           // base class
  int age=-1;

  function new(int a);
    age = a;
  endfunction : new

  function void make_sound();
//   original version from Ray Salemi textbook:
//     $fatal(1, "Generic animals don't have a sound.");
// but, $fatal = $finish if condition met; ModelSim shuts down on $finish
//   I replaced with the two following lines: 
    $display("Generic animals don't have a sound.");
    $stop;
  endfunction : make_sound

endclass : animal


class lion extends animal;             // 

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
    $stop;
  end :init_loop

endmodule : top




