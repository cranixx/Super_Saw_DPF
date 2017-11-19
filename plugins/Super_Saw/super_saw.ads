with Interfaces.C;
use Interfaces.C;
package Super_Saw is
   type Mix_Level_Type is record
      Master : Float;
      Slave : Float;
   end record;
   type Offset_Array_Type is array (1..3) of Float;
   function Saw(Time : Float; Pitch : Float; Sample_Rate : Float) return Float;
   function Compute_Detune(Amount : Float) return Float;
   function Compute_Mix(Level : Float) return Mix_Level_Type;
   function Super_Saw(Time : Interfaces.C.C_Float;
                      Pitch : Interfaces.C.C_Float;Detune : Interfaces.C.C_Float;
                                                  Mix : Interfaces.C.C_Float
                                                    ;Sample_Rate : Interfaces.C.C_Float)
                     return Interfaces.C.C_Float;
   pragma Export(CPP,Super_Saw,"Super_Saw");
end Super_Saw;

