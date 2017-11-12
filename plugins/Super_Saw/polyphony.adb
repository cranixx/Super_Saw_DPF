with Interfaces.C;
use Interfaces.C;

package body Polyphony is
   Notes : Note_Array;
   procedure Add_Note(Pitch : Interfaces.C.C_Float) is
   begin
      if Number_Of_Notes < Maximum_Num_Of_Notes then
         if Note_Exist(Pitch) = False then
            Notes(Number_Of_Notes) := Float(Pitch);
            Number_Of_Notes := Number_Of_Notes + 1;
         end if;
      end if;
   end Add_Note;

   procedure Remove_Note(Pitch : Interfaces.C.C_Float) is
   begin
      for I in Notes'Range loop
         if Notes(I) = Float(Pitch) then
            Notes(I) := 0.0;
            Number_Of_Notes := Number_Of_Notes - 1;
         end if;
      end loop;
   end Remove_Note;

   function Compute_Polyphony(Time : Interfaces.C.C_Float;
                              Pitch : Interfaces.C.C_Float;Detune : Interfaces.C.C_Float;
                              Mix : Interfaces.C.C_Float;
                              Sample_Rate : Interfaces.C.C_Float;
                              Harmonics : Interfaces.C.int) return Interfaces.C.C_Float is
      Sample : Interfaces.C.C_Float := 0.0;
   begin
      for I in 0..(Number_Of_Notes-1) loop
         Sample := Sample + Super_Saw.Super_Saw(Time,Interfaces.C.C_Float(Notes(I)),
                                                Detune,Mix,Sample_Rate,Harmonics);
      end loop;
      return Sample;
   end Compute_Polyphony;

   function Note_Exist (Pitch : Interfaces.C.C_Float) return Boolean is
   begin
      for I in Notes'Range loop
         if Notes(I) = Float(Pitch) then
            return True;
         end if;
      end loop;
      return False;
   end Note_Exist;
end Polyphony;

