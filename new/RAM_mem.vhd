library IEEE;
use ieee.std_logic_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use std.textio.all;
use work.aux_functions.all;

entity RAM_mem is
      generic(START_ADDRESS: wires32 := (others=>'0'));
      port( ce_n: in std_logic;      -- sinal de chip enable negado
            we_n: in std_logic;      --  sinal de write enable negado
            oe_n:in std_logic;       -- sinal de output enable negado
            bw: in std_logic;        -- sinal de byte write
            address: in wires32;     -- endereco de memoria a ser acessado
            data: inout wires32);    -- leitura e escrita de dados na memoria
end RAM_mem;

architecture RAM_mem of RAM_mem is 
    signal RAM : memory;            -- sinal interno (RAM usada pelo componente)
    signal tmp_address: wires32;    -- sinal para ajustar o endereco
    alias  low_address: wires16 is tmp_address(15 downto 0);-- baixa para 16 bits devido ao CONV_INTEGER

begin
    tmp_address <= address - START_ADDRESS;   -- calculando offset do enderecamento
    
    -- ***Processo assincrono que fica responsavel pela escrita na memoria*** 
    -- writes in memory ASYNCHRONOUSLY  -- LITTLE ENDIAN -------------------
   process(ce_n, we_n, low_address) -- Modification in 16/05/2012 for monocycle processors only
        begin
        if ce_n='0' and we_n='0' then -- verifica se o chip esta habilitado (ce_n='0') e a escrita esta habilitada (we_n='0')
            if CONV_INTEGER(low_address)>=0 and CONV_INTEGER(low_address)<=MEMORY_SIZE-3 then -- Verifica se o endereco esta dentro dos limites validos da memoria
                if bw='1' then -- verifica se a escrita eh de um byte (bw='1')
                    RAM(CONV_INTEGER(low_address+3)) <= data(31 downto 24); -- Escreve o byte mais significativo no endereco + 3
                    RAM(CONV_INTEGER(low_address+2)) <= data(23 downto 16); -- Escreve o segundo byte mais significativo no endereco + 2
                    RAM(CONV_INTEGER(low_address+1)) <= data(15 downto 8);  -- Escreve o segundo byte menos significativo no endereco + 1
                end if;
                RAM(CONV_INTEGER(low_address)) <= data(7 downto 0); -- Escreve o byte menos significativo no endereco atual
            end if;
        end if;  
    end process;
    -- read from memory
    process(ce_n, oe_n, low_address)
        begin
            ---- Verifica se o chip esta habilitado (ce_n='0'), a leitura esta habilitada (oe_n='0') e o endereco esta dentro dos limites validos da memoria
            if ce_n='0' and oe_n='0' and CONV_INTEGER(low_address)>=0 and CONV_INTEGER(low_address)<=MEMORY_SIZE-3 then 
                data(31 downto 24) <= RAM(CONV_INTEGER(low_address+3)); -- Lendo o byte mais significativo do endereco + 3
                data(23 downto 16) <= RAM(CONV_INTEGER(low_address+2)); -- Lendo o segundo byte mais significativo do endereco + 2
                data(15 downto 8) <= RAM(CONV_INTEGER(low_address+1)); -- Lendo o segundo byte menos significativo do endereco + 1
                data(7 downto 0) <= RAM(CONV_INTEGER(low_address)); -- Lendo o byte menos significativo do endereco atual
            else
                -- Define os bits como 'Z' (alta impedancia) quando a leitura nao esta habilitada ou o endereco esta fora dos limites
                data(31 downto 24) <= (others=>'Z');
                data(23 downto 16) <= (others=>'Z');
                data(15 downto 8) <= (others=>'Z');
                data(7 downto 0) <= (others=>'Z');
            end if;
        end process;

end RAM_mem;