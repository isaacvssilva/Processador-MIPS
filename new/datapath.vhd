library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
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
    signal result, R1, R2, ext32, reg_dest, op2 : bus32;
    signal adD : std_logic_vector(4 downto 0);
    signal instR, zero : std_logic;
begin
    -- sinal auxiliar que define quando instrução é tipo R
    instR <= '1' when uins.i=ADDU or uins.i=SUBU or uins.i=AAND or uins.i=OOR or uins.i=XXOR or uins.i=NNOR else'0'; 
    
    -- Mux: gera endereço de escrita no banco
    adD <= instruction(15 downto 11) when instR='1' else instruction(20 downto 16); 
    
    -- escolha da instrucao de execucao 
    REGS: entity work.bancoRegistradores port map(
        clk=>clk,
        rst=>rst, 
        en=>uins.wreg, 
        AdRP1=>instruction(25 downto 21),
        AdRP2=>instruction(20 downto 16), 
        AdWP=>adD,
        DataWP=>reg_dest, 
        DataRP1=>R1, 
        DataRP2=>R2 );
    
    
    -- extensao de 32 bits 
    ext32 <= x"FFFF" & instruction(15 downto 0) when 
            (instruction(15)='1' and (uins.i=LW or uins.i=SW)) 
        else x"0000" & instruction(15 downto 0);
        
    -- sinal da ula 
    
    op2 <= R2 when instR='1' else ext32;
    
    inst_alu: entity work.ula port map (
    op1=>R1, 
    op2=>op2,
    resultado=>result, 
    zero=>zero, 
    ope_ula=>uins.i);
  
    -- operacoes de memoria de dados
    d_address <= result;
    
    data <= R2 when uins.en='1' and uins.rw='0' else (others=>'Z');
    
    -- Mux: gera entrada da porta de escrita do Banco de Registradores
    reg_dest <= data when uins.i=LW else result;

end Behavioral;
