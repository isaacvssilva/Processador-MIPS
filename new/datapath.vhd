library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--AQUI
--AQUI
use work.pkg_mips.all;
entity datapath is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           uins : in microinstrucoes;
           d_address : out bus32;
           data : inout bus32;
           instruction : in bus32);
end datapath;

architecture Behavioral of datapath is
    signal result, r1, r2, ext32, reg_dest, op2 : bus32;
    signal adD : std_logic_vector(4 downto 0);
    signal instR, zero : std_logic;
begin
    -- instrução  com formato R
    --AQUI
    
    -- escolha da instrucao de execucao
    --AQUI
    
    -- extensao de 32 bits 
    --AQUI
    -- sinal da ula 
    --AQUI
    
    --AQUI
    -- operacoes de memoria de dados
    --AQUI
    
    --AQUI
    
    --AQUI
end Behavioral;
