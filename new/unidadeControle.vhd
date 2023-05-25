library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--AQUI
--AQUI
use work.pkg_mips.all;

entity unidadeControle is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           uins : out microinstrucoes;
           instruction : in bus32;
           i_address : out bus32);
end unidadeControle;

architecture Behavioral of unidadeControle is
    signal incpc, pc : bus32;
    signal i: inst_tipo;
begin
    -- proxima instrucao PC  
    --AQUI
    
   -- incpc<=pc+4;
    incpc <= std_logic_vector(unsigned(pc) + 4);
    -- decodificacao de instrucoes
    uins.i <= i;
    
    --AQUI
         
    assert i/= inst_invalida
        report "Instrução invalida"
        severity error;
    
    -- gerador de sinais de controle para acesso a memoria externa
    --AQUI
end Behavioral;