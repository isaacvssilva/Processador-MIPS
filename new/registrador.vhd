library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pkg_mips.all;

entity registrador is
    generic(valorInicial : bus32 := (others=>'0'));
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           D : in bus32;
           Q : out bus32);
end registrador;

architecture Behavioral of registrador is

begin
    process(rst,clk)
    begin
        
    end process;

end Behavioral;
