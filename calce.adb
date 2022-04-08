with Ada.Text_IO;                       use Ada.Text_IO;
with Ada.Directories;                   use Ada.Directories;
with Ada.Strings.Fixed;                 use Ada.Strings.Fixed;
with Ada.Integer_Text_IO;               use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;             use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO;     use Ada.Strings.Unbounded.Text_IO;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

procedure calce is
    type intList is array (Positive range <>) of Integer;

    function getInput (sig_digits : out Integer) return Unbounded_String is
        exist     : Boolean;
        overwrite : Character;
        file      : Unbounded_String;

    begin
        Put_Line ("Please enter the number of significant digits: ");
        Get (sig_digits);
        Skip_Line;

        Put_Line ("Please enter the file name for the output: ");
        Get_Line (file);
        exist := Exists (To_String (file));

        if exist then
            Put_Line
               ("The file already exists, would you like to overwrite it?(Y/N)");
            Get (overwrite);
            Skip_Line;
        else
            return file;
        end if;

        if overwrite = 'Y' or overwrite = 'y' then
            return file;
        elsif overwrite = 'N' or overwrite = 'n' then
            while exist loop
                Put_Line ("Please provide a different file name:");
                Get_Line (file);
                exist := Exists (To_String (file));
            end loop;
        end if;

        return file;
    end getInput;

    procedure getestLen
       (sig_digits : in Integer; estLen : out Integer; test : out Float)
    is
    begin
        estLen := 4;
        test   := (Float (sig_digits + 1)) * 2.302_585_09;

        while Float (estLen) * (Log (Float (estLen)) - 1.0) +
           0.5 * Log (6.283_185_2 * Float (estLen)) <
           test
        loop
            estLen := estLen + 1;
        end loop;

    end getestLen;

    function ecalcul
       (sig_digits : in Integer; estLen : in Integer) return intList
    is
        carry  : Integer := 0;
        temp   : Integer := 0;
        evalue : intList (1 .. sig_digits);
        coeff  : intList (2 .. estLen + 1);
    begin
        for i in 2 .. estLen loop
            coeff (i) := 1;
        end loop;

        for i in 1 .. sig_digits loop
            if i = 1 then
                evalue (i) := 2;
            else
                evalue (i) := 0;
            end if;
        end loop;

        for i in 2 .. sig_digits loop
            carry := 0;

            for j in reverse 2 .. estLen loop
                temp      := coeff (j) * 10 + carry;
                carry     := temp / j;
                coeff (j) := temp - carry * j;
            end loop;

            evalue (i) := carry;
        end loop;

        return evalue;
    end ecalcul;

    --procedure to write the resulting e value to an ASCII file specified by the user
    procedure keepe
       (evalue : in intList; filename : Unbounded_String)
    is
        outputFp : File_Type;
    begin

        Create (outputFp, Out_File, To_String (filename));
        Set_Output (outputFp);

        for i in 1 .. evalue'length loop
            Put (trim(Integer'Image (evalue (i)), ada.strings.both));
            if i = 1 then
                put(".");
            end if;
        end loop;

        Set_Output (Standard_Output);
        Put_Line("Output successfully recorded in " & filename);

        --close file!--
        if Is_Open (outputFp) then
            Close (outputFp);
        end if;
    end keepe;

    ---start of the main wrapper program---
    num_digits : Integer;
    estLen     : Integer := 4;
    test       : Float   := 0.0;
    filename   : Unbounded_String;
begin
    filename := getInput (num_digits);
    getestLen (num_digits, estLen, test);
    keepe (ecalcul (num_digits, estLen), filename);
end calce;
