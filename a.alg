procedure ecalculation (n, d);
    value n;
    integer n;
    integer array d;

    begin 
        integer m;
        real test;
        m := 4;
        test := (n + 1) * 2.30258509;
        
        loop: m = m + 1;
        if m * (ln(m) - 1.0) + 0.5 * ln(6.2831852 * m)
            < test then go to loop;
                
        begin integer i, j, carry, temp;
            
            integer array coef [2 : m];
        
            for j := 2 step 1 until m do coef[j] := 1;
            
            d[0]:= 2;

            sweep: for i := 1 step 1 until n do begin
                carry := 0;
        
                for j := m step -1 until 2 do begin
                    temp := coef[j] * 10 + carry;
                    carry := temp ÷ j;
                    coef[j]:= temp - carry * j
                end of digit generation;

                d[i]:= carry

            end having calculated n digits

        end deleting declarations

    end of calculation;

    