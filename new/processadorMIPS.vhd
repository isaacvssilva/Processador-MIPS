library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--AQUI
use work.pkg_mips.all;

entity processadorMIPS is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en, rw : out STD_LOGIC;
           i_address : out bus32;
           d_address : out bus32;
           data : inout bus32;
           instruction : in bus32);
end processadorMIPS;

architecture Behavioral of processadorMIPS is
    signal uins : microinstrucoes;
begin
    --AQUI
    
    --AQUI
        
    --AQUI
    --AQUI
     
end Behavioral;
