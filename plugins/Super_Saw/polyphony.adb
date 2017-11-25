with Interfaces.C;
use Interfaces.C;

with Super_Saw;

package body Polyphony is
   procedure Add_Note (Pitch : C_Float) is
   begin
      if Note_Count <= Voices then
         for I in Notes'Range loop
            if Notes(I) = 0.0 then
               Notes(I) := Float(Pitch);
               Note_Count := Note_Count + 1;
               exit;
            end if;
         end loop;
      end if;
   end Add_Note;

   procedure Remove_Note (Pitch : C_Float) is
   begin
      if Note_Count > 0 then
         for I in Notes'Range loop
            if Notes(I) = Float(Pitch) then
               Notes(I) := 0.0;
               Note_Count := Note_Count - 1;
               exit;
            end if;
         end loop;
      end if;
   end Remove_Note;

   function Compute_Polyphony (Time : C_Float;
                               Detune : C_Float; Mix : C_Float;
                               Sample_Rate : C_Float) return C_Float is
      Sample : C_Float := 0.0;
   begin
      for I in Notes'Range loop
         if Notes(I) /= 0.0 then
            Sample := Sample + Super_Saw.Super_Saw(Time => Time, Pitch => C_Float(Notes(I)),
                                                  Detune => Detune, Mix => Mix,
                                                   Sample_Rate => Sample_Rate);
         end if;
      end loop;
      return Sample;
   end Compute_Polyphony;
end Polyphony;

