library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--AQUI
--AQUI
use IEEE.NUMERIC_STD.ALL;
use work.pkg_mips.all;

entity ula is
    Port ( op_ula : in inst_tipo;
           op1 : in bus32;
           op2 : in bus32;
           resultado : out bus32;
           zero : out STD_LOGIC);
end ula;

architecture Behavioral of ula is
    signal sel_ula : bus32;
     signal sel_ula_unsigned : unsigned(sel_ula'range);
    signal sel_ula_integer : integer;
begin 
    resultado<=sel_ula;
    --ADDU, SUBU, AAND, OOR, XXOR, NNOR
    
    --AQUI
    process (op_ula, op1, op2)
    begin
        case op_ula is
            when SUBU =>
                sel_ula <= std_logic_vector(unsigned(op1) - unsigned(op2));
            when AAND =>
                sel_ula <= op1 and op2;
            when OOR | ORI =>
                sel_ula <= op1 or op2;
            when XXOR =>
                sel_ula <= op1 xor op2;
            when NNOR =>
                sel_ula <= op1 nor op2;
            when others =>
               sel_ula <= std_logic_vector(unsigned(op1) + unsigned(op2));
        end case;

        sel_ula_unsigned <= unsigned(sel_ula);
        sel_ula_integer <= to_integer(sel_ula_unsigned);
    end process;
    --AQUI
     zero <= '1' when sel_ula_integer <= 0 else '0';
end Behavioral;
