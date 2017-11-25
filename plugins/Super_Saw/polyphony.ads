with Interfaces.C;
use Interfaces.C;

package Polyphony is
   type Note_Array_Type is array (1..4) of Float;
   Notes : Note_Array_Type := (others => 0.0);
   Note_Count : Natural := 0;
   Voices : constant := 4;
   procedure Add_Note (Pitch : C_Float)
     with Post => Note_Count <= Voices and Note_Count >= 0;
   procedure Remove_Note (Pitch : C_Float)
     with Post => Note_Count <= Voices and Note_Count >= 0;
   function Compute_Polyphony (Time : C_Float; Detune : C_Float; Mix : C_Float;
                              Sample_Rate : C_Float) return C_Float;

   pragma Export(CPP,Add_Note,"Add_Note");
   pragma Export(CPP,Remove_Note,"Remove_Note");
   pragma Export(CPP,Compute_Polyphony,"Compute_Polyphony");
end Polyphony;

