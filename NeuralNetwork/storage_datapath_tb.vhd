library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use std.env.stop;

entity storage_datapath_tb is
generic (	ramA: integer:=8;
				K: integer:=24; 
				layA: integer:=4
				);
end entity;

architecture tb of storage_datapath_tb is

signal clk : std_logic := '0';

signal stor_in			: std_logic_vector(K-1 downto 0) := (others => '0'); -- 24 bits
	 
signal stor_sel		: std_logic_vector(3 downto 0) := (others => '0'); -- 4 bits 
signal stor_addr		: std_logic_vector(ramA-1 downto 0) := (others => '0');
signal stor_wr			: std_logic := '0'; 

signal stor_out		: std_logic_vector(K-1 downto 0) := (others => '0');

signal index		: unsigned(7 downto 0) := (others => '0');
signal data			: unsigned(K-1 downto 0) := (others => '0');



begin
	clk <= not clk after 10 ns;
	
	
	process
	begin
	--prop <= '0';		; -- 1 bit
	
	--------------------- writing--------------------------
		wait for 100 ns;
		
		stor_wr <= '1'; -- 1bit
		stor_sel	<= "0000"; -- 4 bits
				
		for i in 0 to 15 loop -- this would be a testament of skills to find a way to do this without an external counter
	
--				 
			stor_in <=	std_logic_vector(data);
			stor_addr <= std_logic_vector(to_unsigned(i,stor_addr'length));
			data <= data + 5;
			
			wait for 20 ns;
      end loop;
		
		index <= (others => '0');
		--con_wr <= '0'; -- 1 bit
		
		wait for 100 ns;
		
		
	
		--stor_wr <= '1'; -- 1bit
		stor_sel	<= "0001"; -- 4 bits -- weights 
		
		for i in 0 to 15 loop -- this would be a testament of skills to find a way to do this without an external counter
				
			stor_in <=	std_logic_vector(data); -- 24 bits -- by 8 bits go to differt perceptrons -- inputs
			stor_addr <= std_logic_vector(to_unsigned(i,stor_addr'length)); -- 8 bits for 256 bit ram
			data <= data + 5;
			
			wait for 20 ns;
		
      end loop;
		
		
		
		wait for 100 ns;
		
		--stor_wr <= '1'; -- 1bit
		stor_sel	<= "0010"; -- 4 bits -- activation 
		
		for i in 0 to 15 loop -- this would be a testament of skills to find a way to do this without an external counter
				
			stor_in <=	std_logic_vector(data); -- 24 bits -- by 8 bits go to differt perceptrons -- inputs
			stor_addr <= std_logic_vector(to_unsigned(i,stor_addr'length)); -- 8 bits for 256 bit ram
			data <= data + 5;
			
			wait for 20 ns;
				
      end loop;
		
		wait for 100 ns;
	
		stor_wr <= '0';
				
		---------------- Reading -------------------------- 
		
		wait for 300 ns;
		stor_wr <= '0';
		
		stor_sel	<= "0000";
		
		for i in 0 to 16 loop -- this would be a testament of skills to find a way to do this without an external counter		
			stor_addr <= std_logic_vector(to_unsigned(i,stor_addr'length)); -- 8 bits for 256 bit ram
			
			wait for 20 ns;
	
      end loop;
		
		
		wait for 100 ns;
		
		stor_sel	<= "0001";
		
		for i in 0 to 16 loop -- this would be a testament of skills to find a way to do this without an ex
			stor_addr <= std_logic_vector(to_unsigned(i,stor_addr'length)); -- 8 bits for 256 bit ram
			
			wait for 20 ns;
				
      end loop;
		
		wait for 200 ns;
		
		stor_sel	<= "0010";
		
		for i in 0 to 16 loop -- this would be a testament of skills to find a way to do this without an external counte
			stor_addr <= std_logic_vector(to_unsigned(i,stor_addr'length)); -- 8 bits for 256 bit ram
			
			wait for 20 ns;
				
      end loop;
		
		
		wait for 200 ns;
		
		assert false report "Test: OK" severity failure;
		
		--wait; -- this waits forever
	end process;
	
	uut : entity work.storage_datapath
	port map(
		stor_clk => clk, inValue => stor_in, ramSelect => stor_sel, address => stor_addr, 
		writeEnable => stor_wr,  outValue => stor_out
		);
			
	 

end tb;
		