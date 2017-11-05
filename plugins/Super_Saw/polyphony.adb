with Interfaces.C;
use Interfaces.C;

package body Polyphony is
   Notes : Note_Array;
   Number_Of_Notes : Integer;
   procedure Add_Note(Pitch : Interfaces.C.C_Float) is
   begin
      if Number_Of_Notes < 4 then
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
                              Sample_Rate : Interfaces.C.C_Float) return Interfaces.C.C_Float is
   begin
      return 0.0;
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
begin
   Number_Of_Notes := 0;
end Polyphony;

