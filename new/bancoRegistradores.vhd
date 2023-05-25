library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--AQUI
--AQUI
use IEEE.NUMERIC_STD.ALL;
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
        --/*ToDo*/
        -- 1º Atribuindo valor para o sinal 'wen(i)' indicando se o reg i deve ser habilitado;
        -- 2º Verificando se o valor de i é diferente de zero, garantindo que o registrador de numero 0 (zero) 
            -- nao sera habilitado para escrita;
            
        -- 3º AdWP = std_logic_vector(to_unsigned(i, AdWP'length)): Compara o valor de AdWP (endereco de escrita) 
            -- com i convertido para um std_logic_vector com o mesmo tamanho de AdWP. Essa comparacao verifica se o 
            -- endereco de escrita corresponde ao registrador atual i;
            
        -- 4º en = '1': Verifica se o sinal de controle en esta ativo (valor logico '1'). 
            -- Isso indica que a escrita no banco de registradores esta habilitada.
            
        -- 5º Se todas as condicoes acima forem verdadeiras, o valor de wen(i) e atribuido como '1', 
            -- habilitando a escrita no registrador i. Caso contrario, ou seja, se alguma das condicoes for falsa, o valor de wen(i) 
            -- e atribuido como '0', desabilitando a escrita no registrador i.
        wen(i) <= '1' when i /= 0 and AdWP = std_logic_vector(to_unsigned(i, AdWP'length)) and en = '1' else '0';
        
        g2:if i=29 generate
        --AQUI
        --/*ToDo*/
            -- O registrador 29 (reg29) refere-se ao stack pointer (SP) na arquitetura MIPS,
                -- que acaba apontando para algum lugar proximo ao final da memoria de dados
            reg29: entity work.registrador generic map (valorInicial => x"10010800")
                -- fazendo o mapeamento dos sinais de entrada e saida do registrador
                port map (
                    clk => clk, 
                    rst => rst, 
                    en => wen(i), 
                    D => DataWP, 
                    Q => reg(i));
        end generate;
        
        g3:if i/=29 generate --verificando se o valor da variavel i é diferente de 29
        --AQUI
        --/*ToDo*/
            -- fazendo o mapeamento dos sinais de entrada e saida do registrador
            regX: entity work.registrador port map (
                                            clk => clk, 
                                            rst => rst, 
                                            en => wen(i), 
                                            D => DataWP, 
                                            Q => reg(i));
        end generate;    
    end generate;
    --AQUI
    --/*ToDo*/
    --Atribuindo valores aos sinais DataRP1 e DataRP2 com base no endereco de 
    -- AdRP1 e AdRP2 usando um indice inteiro para acessar o elemento no vetor
    -- reg, sendo o banco de registradores
    DataRP1 <= reg(to_integer(unsigned(AdRP1)));
    DataRP2 <= reg(to_integer(unsigned(AdRP2)));
end Behavioral;
