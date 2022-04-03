with ada.text_io; use ada.text_io;
with Ada.Numerics.Elementary_Functions;
use  Ada.Numerics.Elementary_Functions;
with Ada.Integer_Text_IO;
procedure calce is
    type intList is array (Positive range<>) of integer;
    
    procedure keepe(sig_digits : in integer) is 
        m      : integer := 4;
        carry  : integer := 0;
        temp   : integer := 0;
        test   : float   := 0.0;
        evalue : intList(1..sig_digits);
        coeff  : intList(2..806);
    begin
        test := (float(sig_digits + 1)) * 2.30258509;
        
        while float(m) * (log(float(m)) - 1.0) + 0.5 * log(6.2831852 * float(m)) < test loop
            m := m + 1;
        end loop;

        for i in 2..m loop
            coeff(i) := 1;
        end loop;

        for i in 1..sig_digits loop
            if i = 1 then
                evalue(i) := 2;
            else
                evalue(i) := 0;
            end if; 
        end loop;

        for i in 2..sig_digits loop
            carry := 0;
           
            for j in reverse 2..m loop
                temp := coeff(j) * 10 + carry;
                carry := temp/j;
                coeff(j) := temp - carry * j;
            end loop;
    
            evalue(i) := carry;
        end loop;
    end keepe;
   
    num_digits : integer;
begin
    num_digits := 801;
    keepe(num_digits);
end calce;