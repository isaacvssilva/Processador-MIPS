library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--AQUI
--AQUI
use work.pkg_mips.all;

entity bancoRegistradores is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           AdRP1 : in std_logic_vector(4 downto 0);
           AdRP2 : in std_logic_vector(4 downto 0);
           AdWP : in std_logic_vector(4 downto 0);
           DataWP : in bus32;
           DataRP1 : out bus32;
           DataRP2 : out bus32);
end bancoRegistradores;

architecture Behavioral of bancoRegistradores is
    type banco_reg is array(0 to 31) of bus32;
    signal reg : banco_reg;
    signal wen : bus32;
begin
    
    g1: for i in 0 to 31 generate
        
        --AQUI
        
        g2:if i=29 generate
        --AQUI
        end generate;
        
        g3:if i/=29 generate
        --AQUI
        end generate;    
    end generate;
    
    --AQUI
    
    --AQUI
end Behavioral;
