with Interfaces.C;
use Interfaces.C;

with Ada.Numerics;
use Ada.Numerics;

with Ada.Numerics.Elementary_Functions;
use Ada.Numerics.Elementary_Functions;

with Blep;
package body Super_Saw is
   function Super_Saw(Time : Interfaces.C.C_Float; Pitch : Interfaces.C.C_Float;
                           Detune : Interfaces.C.C_Float; Mix : Interfaces.C.C_Float;
                           Sample_Rate : Interfaces.C.C_Float)
     return Interfaces.C.C_Float is
      Offsets : Offset_Array_Type := (0.01952356,0.06288439,0.11002313);
      Sample : Float := 0.0;
      Mix_Level : Mix_Level_Type := Compute_Mix(Float(Mix));
   begin
      -- Main oscillator
      Sample := Sample + Saw(Float(Time),Float(Pitch), Float(Sample_Rate))*Mix_Level.Master;

      -- 3 oscillators of higher pitch than main
      Higher_Oscillators:for D in 1 .. 3 loop
         Sample := Sample + Saw(Float(Time),Float(Pitch)*(1.0+Offsets(D)*Compute_Detune(Float(Detune))),
                                Float(Sample_Rate))*Mix_Level.Slave;
      end loop Higher_Oscillators;

      -- 3 oscillators of lower pitch than main
      Lower_Oscillators:for D in 1 .. 3 loop
         Sample := Sample + Saw(Float(Time),Float(Pitch)*(1.0+Offsets(D)*Compute_Detune(Float(Detune))),
                                Float(Sample_Rate))*Mix_Level.Slave;
      end loop Lower_Oscillators;
      return Interfaces.C.C_FLoat(Sample)*Interfaces.C.C_Float(0.1);
   end Super_Saw;

   function Saw(Time : Float; Pitch : Float; Sample_Rate : Float) return Float is
   begin
      return Blep.BLEP_Saw(Time,Pitch/Sample_Rate);
   end Saw;
   function Compute_Detune(Amount : Float) return Float is
   begin
      return (10028.7312891634*Amount**11)-(50818.8652045924*Amount**10)
        +(111363.4808729368*Amount**9)-(138150.6761080548*Amount**8)+
        (106649.6679158292*Amount**7)-(53046.9642751875*Amount**6)+
        (17019.9518580080*Amount**5)-(3425.0836591318*Amount**4)+
        (404.2703938388*Amount**3)-(24.1878824391*Amount**2)+
        (0.6717417634*Amount)+0.0030115596;
   end Compute_Detune;
   function Compute_Mix(Level : Float) return Mix_Level_Type is
      Mix_Level : Mix_Level_Type;
   begin
      Mix_Level.Master := -0.55366*Level + 0.99785;
      Mix_Level.Slave :=  -0.73764*Level**2 + 1.2841*Level + 0.044372;
      return Mix_Level;
   end Compute_Mix;
end Super_Saw;

