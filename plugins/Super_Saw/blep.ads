with Ada.Numerics;
use Ada.Numerics;
with Ada.Numerics.Elementary_Functions;
use Ada.Numerics.Elementary_Functions;

package Blep is
   function BLEP_Saw(Phase : Float; Pitch : Float) return Float;
private
   function Naive_Saw(Phase : Float; Frequency : Float) return Float;
   function modulo (Dividend : Float; Divisor : Float) return Float;
   function Sinc (Phase : Float) return Float;
   function Hamming (N : Float; Size : Float) return Float;
end Blep;

