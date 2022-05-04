library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use std.env.stop;

entity pLayer_tb is
generic (	ramA: integer:=8;
				K: integer:=24; 
				layA: integer:=4
				);
end entity;

architecture tb of pLayer_tb is

signal clk : std_logic := '0';

signal layer_in		: std_logic_vector(K-1 downto 0) := (others => '0'); -- 24 bits
	  
signal layer_addr		: std_logic_vector(layA-1 downto 0) := (others => '0');
signal layer_wr		: std_logic := '0'; 
 
signal out_p1			: std_logic_vector(15 downto 0) := (others => '0');	
signal out_p2			: std_logic_vector(15 downto 0) := (others => '0');	
signal out_p3			: std_logic_vector(15 downto 0) := (others => '0');	
signal out_p4			: std_logic_vector(15 downto 0) := (others => '0');	
signal out_p5			: std_logic_vector(15 downto 0) := (others => '0');			


--signal data		: integer ;
signal data			: unsigned(K-1 downto 0) := (others => '0');
--signal con_index		: unsigned(7 downto 0) := (others => '0');



begin
	clk <= not clk after 20 ns;
	
	
	process
	begin
	--prop <= '0';		; -- 1 bit
		wait for 100 ns;
		
		--data <= "010101011010101010101010";
		
		
		layer_wr <= '1';
		
		wait for 100 ns;
		
		for i in 0 to 15 loop -- this would be a testament of skills to find a way to do this without an external counte
			layer_in <= std_logic_vector(data);
			layer_addr <= std_logic_vector(to_unsigned(i,layer_addr'length)); -- value 0 - 15
			data <= data + 5;
		
		wait for 20 ns;
      end loop;
		
		wait for 200 ns;
		
		layer_wr <= '0';
		
		
		
		wait for 200 ns;
		
		assert false report "Test: OK" severity failure;
		
		--wait; -- this waits forever
	end process;
	
	uut : entity work.pLayer
	port map(
		clk, reg_input => layer_in, reg_addr => layer_addr,  reg_wr => layer_wr, 
		outP1 => out_p1, outP2 => out_p2, outP3 => out_p3,  
		outP4 => out_p4, outP5 => out_p5
		);
	
	

end tb;
		