/*
 expanded from "UVM Primer," Ch. 7, 2013, Ray Salemi
 Lions and Tigers and ...
*/
virtual class animal;		    // parent/base class
  protected int age=-1;	        // protected = not visible outside the class
							    //   is visible in derived classes
  protected string        name;

  function new(int age);	    // generic function used in all child classes
    set_age(age);
  endfunction : new

  function void set_age(int a);
    age = a;
  endfunction : set_age

  function int get_age();	    // used in all child classes
    if (age == -1)			    // default nonsensical flag
      $fatal(1, "You didn't set the age.");
    else
      return age;
  endfunction : get_age

  function string get_name();
    return name;
  endfunction 

  pure virtual function void make_sound();

endclass : animal
						
class tiger extends animal;	    // first of two derived classes

  function new(int age, string n);
    super.new(age);
    name = n;
  endfunction : new

  function void make_sound();   // void: does not return a variable
    $display ("%s says Growl", get_name());
  endfunction 

endclass : tiger

class lion extends animal;		// second of two derived classes

  function new(int age, string n);
    super.new(age);
    name = n;
  endfunction 

  function void make_sound();	// tailored to lions vs. tigers
    $display ("%s says Roar", get_name());
  endfunction 

endclass : lion

class tiger_cage;
  static tiger cage2[$];		// create unbounded queue
endclass : tiger_cage

class lion_cage;				
  static lion cage[$];	        // creates separate queue
endclass : lion_cage

module top;
								// test bench
  initial begin

    tiger tiger_h;				// all class declarations come first
    lion   lion_h;
    string freed_lion;			// for queue.pop demo 

// instantiate three tigers, put in cage in succession
	tiger_h = new(7, "Kitty1 ");
	tiger_cage::cage2.push_back(tiger_h);
	tiger_h = new(14, "Kitty 2 ");
	tiger_cage::cage2.push_back(tiger_h);
// FIFO: normally push_front or push_back only, not mixed as here
	tiger_h = new(10, "Kitty 3 ");
	tiger_cage::cage2.push_front(tiger_h);
	$display("\n Tigers in cage");
	foreach(tiger_cage::cage2[i])
	  $write (tiger_cage::cage2[i].get_name());

    lion_h  = new(2,  "Kimba");
    lion_cage::cage.push_back(lion_h);	  // access variable by naming class ::
    $display("\n Lions in cage after push_back Kimba"); 
    foreach (lion_cage::cage[i]) begin		  
      $write(lion_cage::cage[i].get_name());
	  $write(" ");
	end
    lion_h  = new(3,  "Simba");
    lion_cage::cage.push_back(lion_h);	  // lion_h is now "Simba"
    $display("\n Lions in cage after push_back Simba"); 
    foreach (lion_cage::cage[i]) begin		  
      $write(lion_cage::cage[i].get_name());
	  $write(" ");
	end
    lion_h  = new(15, "Mustafa");
    lion_cage::cage.push_back(lion_h);
    $display("\n Lions in cage after push_back Mustafa"); 
    foreach (lion_cage::cage[i]) begin		  
      $write(lion_cage::cage[i].get_name());
	  $write(" ");
	end

	lion_h = new(6, "Scar");
    lion_cage::cage.push_front(lion_h);
	$display("\n Lions in cage after push_front Scar"); 
    foreach (lion_cage::cage[i]) begin		  
      $write(lion_cage::cage[i].get_name());
	  $write(" ");
    end
// string' casts popped out variable as a string
    freed_lion = string'(lion_cage::cage.pop_front());
	$display("\n Lions in cage after pop_front");
    foreach (lion_cage::cage[i]) begin		  
      $write(lion_cage::cage[i].get_name());
	  $write(" ");
	end
	$display();
	$display("%s is on the prowl",freed_lion);
// random position insertion supported for queues, not mailboxes/FIFOs
    lion_cage::cage.insert (2,lion_h);
	$display("\n Lions in cage after insert 2, Scar");
    foreach (lion_cage::cage[i]) begin		  
      $write(lion_cage::cage[i].get_name());
	  $write(" ");
	end

  end

endmodule : top


   
        
      