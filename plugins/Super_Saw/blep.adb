package body Blep is
  function BLEP_Saw(Phase : Float; Pitch : Float) return Float is
     Sample : Float := Naive_Saw(Phase, Pitch);
     Step : Float := Naive_Saw(1.0,Pitch) - Naive_Saw(0.0,Pitch);
     Blep : Float := Poly_BLEP(Sample, Step);
  begin
     return (1.0 - (2.0 * Sample)) + Blep;
  end BLEP_Saw;

   function Naive_Saw(Phase : Float; Frequency: Float) return Float is
   begin
      return (Phase*Frequency) mod 1.0;
   end Naive_Saw;

   function Poly_BLEP(Phase : Float; Phase_Step : Float) return Float is
      T : Float;
   begin
      if Phase < Phase_Step then
         T := Phase / Phase_Step;
         return T*2.0 - T**2 - 1.0;
      elsif Phase > (1.0 - Phase_Step) then
         T := (Phase - 1.0) / Phase_Step;
         return T**2 + T*2.0  + 1.0;
      else
        return 0.0;
      end if;
   end Poly_BLEP;

   function "mod" (Dividend : Float; Divisor : Float) return Float is
      Tmp : Float := Dividend;
   begin
      if Tmp = Divisor then
         return 0.0;
      elsif Tmp < Divisor then
         return Tmp;
      else
         while Tmp >= Divisor loop
            Tmp := Tmp - Divisor;
         end loop;
         if Tmp < 0.01 then
            Tmp := 0.0;
         end if;
         return Tmp;
      end if;
   end "mod";
end Blep;

