library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RAM is
	generic (K: integer:=24; -- number of bits per word
				A: integer:=8); -- number of address bits; N = 2^A
	port (
		ram_clk : in std_logic;
		WR: in std_logic; -- active high write enable
		ADDR: in std_logic_vector (A-1 downto 0); -- RAM address
		DIN: in std_logic_vector (K-1 downto 0); -- write data
		DOUT: out std_logic_vector (K-1 downto 0)); -- read data
end entity RAM;

architecture RAMBEHAVIOR of RAM is
	type MEMORY is array (0 to 2**A-1) of std_logic_vector(K-1 downto 0); -- define size of MEMORY
	signal RAM256: MEMORY; -- := (others => (others => '0')); -- RAM256 as signal of type MEMORY
	
	
	begin
	process  (WR, DIN, ADDR) -- (ram_clk)-- 
			begin
--				if rising_edge(ram_clk) then
					--RAM_ADDR_IN  to_integer(UNSIGNED(ADDR)); -- convert address to integer
					if WR='1' then -- write operation to RAM
						RAM256 (to_integer(UNSIGNED(ADDR))) <= DIN; -- when this write is active the write to the layer register should be low
						DOUT <= (others => '0');
					else
						DOUT <= RAM256 (to_integer(UNSIGNED(ADDR)));
				
					end if;
					
					
--				end if;
	end process;
end architecture RAMBEHAVIOR;

