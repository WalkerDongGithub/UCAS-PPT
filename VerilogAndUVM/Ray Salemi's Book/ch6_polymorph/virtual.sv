/*  Adapted from Ray Salemi, UVM Primer Ch. 6, 2013  "virtual.sv"
*/
class animal;                                      // base class
  int age=-1;

  function new(int a);
    age = a;
  endfunction : new
                                                   // virtual function --
  virtual function void make_sound();              //   will adapt to whatever extended class is used
    $display("Generic animals don't have a sound.");
    $stop;                                         // don't use $finish or $fatal w/ ModelSim
  endfunction : make_sound

endclass : animal


class lion extends animal;

  function new(int age);
    super.new(age);
  endfunction : new

  function void make_sound();                      // no "virtual" keyword -- inherit from base class
    $display ("The Lion says Roar");               
  endfunction : make_sound

endclass : lion


class chicken extends animal;

  function new(int age);
    super.new(age);
  endfunction : new

  function void make_sound();                      // inherit "virtual" from base class
    $display ("The Chicken says BECAWW");
  endfunction : make_sound

endclass : chicken


module top;                                        // test bench
  initial begin   :init_loop
 
    lion     lion_h1, lion_h2;                     // class lion; instances lion_h
    chicken  chicken_h;
    animal   animal_h;
      
    lion_h1  = new(15);                            // instantiate a lion
    lion_h1.make_sound();
    $display("Lion 1 is %0d years old", lion_h1.age);
    
    chicken_h = new(1);
    chicken_h.make_sound();
    $display("The Chicken is %0d years old", chicken_h.age);

    lion_h2  = new(12);
    lion_h1.make_sound();
    $display("Lion 2 is %0d years old", lion_h2.age);

    animal_h = lion_h1;                            // note polymorphism of animal_h
    animal_h.make_sound();                         // return lion results
    $display("The animal is %0d years old", animal_h.age);
    
    animal_h = chicken_h;                          // note polymorphism of animal_h
    animal_h.make_sound();                         // chicken results
    $display("The animal is %0d years old", animal_h.age);

    animal_h = lion_h2;                            // note polymorphism of animal_h
    animal_h.make_sound();                         // lion results
    $display("The animal is %0d years old", animal_h.age);
      
   end :init_loop

endmodule : top




