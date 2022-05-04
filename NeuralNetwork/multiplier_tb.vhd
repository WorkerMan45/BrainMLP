library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use std.env.stop;

entity multiplier_tb is
generic(
  N             : integer := 8;
  N_P 			 : integer := 15);
end entity;

architecture tb of multiplier_tb is

signal clk : std_logic := '0';

signal mult1		:  std_logic_vector(N-1 downto 0) ; -- 24 bits
	  
signal mult2		: std_logic_vector(N-1 downto 0);
signal prod			: std_logic_vector(N_P downto 0); 

		


--signal data		: integer ;
--signal data			: unsigned(K-1 downto 0) := (others => '0');
--signal con_index		: unsigned(7 downto 0) := (others => '0');



begin
	clk <= not clk after 20 ns;
	
	
	process
	begin
	--prop <= '0';		; -- 1 bit
		wait for 100 ns;
		
		
		mult1	<= std_logic_vector(to_unsigned(145,mult1'length)); -- 24 bits
	  
		mult2	<= std_logic_vector(to_unsigned(245,mult2'length));
		
		
		wait for 200 ns;
		
		assert false report "Test: OK" severity failure;
		
		--wait; -- this waits forever
	end process;
	
	uut : entity work.multiplier_8bit
	port map(
		 mul_clk => clk, i_mul1 => mult1, i_mul2 => mult2,  o_prod => prod 
		
		);
	
	 
end tb;
		