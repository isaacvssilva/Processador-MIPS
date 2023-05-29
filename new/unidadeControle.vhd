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
    signal incpc, pc, novoPC : bus32;
    signal i: inst_tipo;
begin
    -- proxima instrucao PC  
    --AQUI
    --buscando a proxima instrucao com registrador PC
    buscaPC: entity work.registrador generic map (valorInicial => x"00400000")
        -- fazendo o mapeamento dos sinais de entrada e saida do registrador
        port map (
        clk => clk, 
        rst => rst, 
        en =>'1', 
        D => novoPC, 
        Q => pc);
    
    incpc <= std_logic_vector(unsigned(pc) + 4);
    -- decodificacao de instrucoes
    uins.i <= i;
    --AQUI
    process(instruction) -- processo sensivel a mudanca de sinal de instruction
        begin
            case instruction(31 downto 26) is -- usando os bits 31 a 26 para comparar e determinar a instrucao 
                when "000000" =>
                    case instruction(10 downto 0) is -- bits 10 a 0 responsavel por especificar a instrucao
                        when "00000100001" => -- ADDU
                            i <= ADDU;
                        when "00000100011" => -- SUBU
                            i <= SUBU;
                        when "00000100100" => -- AND
                            i <= AAND;
                        when "00000100101" => -- OR
                            i <= OOR;
                        when "00000100110" => -- XOR
                            i <= XXOR;
                        when "00000100111" => -- NOR
                            i <= NNOR;
                        when others =>
                            assert i /= inst_invalida
                                report "Instrução inválida"
                                severity error;
                    end case;
                when "001101" => -- ORI
                    i <= ORI;
                when "100011" => -- LW
                    i <= LW;
                when "101011" => -- SW
                    i <= SW;
                when others =>
                    assert i /= inst_invalida
                        report "Instrução inválida"
                        severity error;
            end case;
    end process;

    -- gerador de sinais de controle para acesso a memoria externa
    
    -- define a ativacao dos sinais de controle: '1' para (Store Word) ou (Load Store), '0' para outras instrucoes
    uins.en  <= '1' when i = SW or i = LW else '0';
     -- define da transferencia de dados: '0' escrita (SW), '1' leitura
    uins.rw  <= '0' when i = SW else '1';
    uins.wreg <= '0' when i=SW else '1';
    
    

end Behavioral;