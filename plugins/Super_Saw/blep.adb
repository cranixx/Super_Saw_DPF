package body Blep is
  function BLEP_Saw(Phase : Float; Pitch : Float) return Float is
     Blep : Float;
  begin
     Blep := Sinc(Modulo(2.0*Phase,1.0/Pitch))*Hamming(Modulo(Phase,1.0/Pitch),1.0/Pitch);
     Blep := Blep + Sinc(Modulo(2.0/Pitch+2.0*Phase,2.0/Pitch))*
       Hamming(Modulo(2.0/Pitch+Phase,2.0/Pitch),2.0/Pitch);
     return Naive_Saw(Phase, Pitch)+Blep;
  end BLEP_Saw;

   function Naive_Saw(Phase : Float; Frequency: Float) return Float is
   begin
      return Modulo((Phase*Frequency),1.0);
   end Naive_Saw;

   function modulo (Dividend : Float; Divisor : Float) return Float is
      Fraction : Float;
      Int_Part : Integer;
   begin
     Int_Part := Integer(Dividend);
     Fraction := Dividend - Float(Int_Part);
     return Float((Int_Part mod Integer(Divisor))) + Fraction;
   end modulo;

   function Sinc (Phase : Float) return Float is
   begin
      if Phase = 0.0 then
         return 1.0;
      else
         return Sin(Phase)/Phase;
      end if;
   end Sinc;

   function Hamming (N : Float; Size : Float) return Float is
   begin
      return 0.54 - 0.46*Cos(2.0*Pi*N/(Size - 1.0));
   end Hamming;
end Blep;

