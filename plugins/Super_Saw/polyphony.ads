with Interfaces.C;
use Interfaces.C;

with Super_Saw;
use Super_Saw;

package Polyphony is
   type Note_Array is array (0..3) of Float;
   Number_Of_Notes : Integer := 0;
   Maximum_Num_Of_Notes : constant Integer := 4;
   procedure Add_Note(Pitch : Interfaces.C.C_Float) with
     Post => Number_Of_Notes >= 0 and Number_Of_Notes < Maximum_Num_Of_Notes;

   procedure Remove_Note(Pitch : Interfaces.C.C_Float) with
     Post => Number_Of_Notes >= 0 and Number_Of_Notes < Maximum_Num_Of_Notes;

   function Compute_Polyphony(Time : Interfaces.C.C_Float;
                              Pitch : Interfaces.C.C_Float;Detune : Interfaces.C.C_Float;
                              Mix : Interfaces.C.C_Float;
                              Sample_Rate : Interfaces.C.C_Float)
                                return Interfaces.C.C_Float;

   pragma Export(CPP,Add_Note,"Add_Note");
   pragma Export(CPP,Remove_Note,"Remove_Note");
   pragma Export(CPP,Compute_Polyphony,"Compute_Polyphony");
private
   function Note_Exist (Pitch : Interfaces.C.C_Float) return Boolean;
end Polyphony;

