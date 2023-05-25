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
    --/*ToDo*/
    begin -- verificacao da borda -> sensivel a borda de subida do clock e reset 
        if rst = '1' then
              Q <= valorInicial(31 downto 0);
       elsif clk'event and clk = '1' then
           if en = '1' then
              Q <= D; -- Dados de entrada vai para saida caso (en) esteja em nivel logico alto
           end if;
       end if;
        
    end process;

end Behavioral;
