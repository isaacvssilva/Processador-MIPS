library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--AQUI
--AQUI
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
begin
    resultado<=sel_ula;
    --ADDU, SUBU, AAND, OOR, XXOR, NNOR
    
    --AQUI
    
    --AQUI

end Behavioral;
