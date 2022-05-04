library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use std.env.stop;

entity LayerConnections_tb is
generic (	ramA: integer:=8;
				K: integer:=24; 
				layA: integer:=4
				);
end entity;

architecture tb of LayerConnections_tb is

signal clk : std_logic := '0';

signal numberOfLayers			: std_logic_vector(7 downto 0);

signal stor_in			: std_logic_vector(K-1 downto 0) := (others => '0'); -- 24 bits
	 
signal stor_sel		: std_logic_vector(3 downto 0) := (others => '0'); -- 4 bits 
signal stor_addr		: std_logic_vector(ramA-1 downto 0) := (others => '0');
signal stor_wr			: std_logic := '0'; 
 
signal con_in			: std_logic_vector(K-1 downto 0) := (others => '0');			
 
signal con_wr			: std_logic :=  '0';
signal con_addr		: std_logic_vector(ramA-1 downto 0):= (others => '0');
 
signal prop				: std_logic := '0'; 
 

signal con_out 		: std_logic_vector(K-1 downto 0) := (others => '0');
signal stor_out		: std_logic_vector(K-1 downto 0) := (others => '0');
signal test_out		: std_logic_vector(K-1 downto 0);


signal index		: unsigned(7 downto 0) := (others => '0');
signal data			: unsigned(K-1 downto 0) := (others => '0');
signal con_index		: unsigned(7 downto 0) := (others => '0');



begin
	clk <= not clk after 5 ns;
	
	numberOfLayers <= std_logic_vector(to_unsigned(5,numberOfLayers'length));
	
	process
	begin
		
--		stor_out <= (others => '0');
--		con_out <= (others => '0');
--		prop <= '0';		; -- 1 bit
		
		
		-------------------- writing--------------------------
--		wait for 100 ns;
--		
--		stor_wr <= '1'; -- 1bit
--		stor_sel	<= "0000"; -- 4 bits
--				
--		for i in 0 to 15 loop -- this would be a testament of skills to find a way to do this without an external counter
--	
--			 
--			stor_in <=	std_logic_vector(data);
--			stor_addr <= std_logic_vector(to_unsigned(i,stor_addr'length));
--			data <= data + 5;
--			
--			wait for 20 ns;
--      end loop;
--		
--		index <= (others => '0');
--		--con_wr <= '0'; -- 1 bit
--		
--		wait for 100 ns;
--		
--		
--	
--		--stor_wr <= '1'; -- 1bit
--		stor_sel	<= "0001"; -- 4 bits -- weights 
--		
--		for i in 0 to 15 loop -- this would be a testament of skills to find a way to do this without an external counter
--				
--			stor_in <=	std_logic_vector(data); -- 24 bits -- by 8 bits go to differt perceptrons -- inputs
--			stor_addr <= std_logic_vector(to_unsigned(i,stor_addr'length)); -- 8 bits for 256 bit ram
--			data <= data + 5;
--			
--			wait for 20 ns;
--		
--      end loop;
--		
--		
--		
--		wait for 100 ns;
--		
--		--stor_wr <= '1'; -- 1bit
--		stor_sel	<= "0010"; -- 4 bits -- activation 
--		
--		for i in 0 to 15 loop -- this would be a testament of skills to find a way to do this without an external counter
--				
--			stor_in <=	std_logic_vector(data); -- 24 bits -- by 8 bits go to differt perceptrons -- inputs
--			stor_addr <= std_logic_vector(to_unsigned(i,stor_addr'length)); -- 8 bits for 256 bit ram
--			data <= data + 5;
--			
--			wait for 20 ns;
--				
--      end loop;
--		
--		wait for 100 ns;
--	
--		stor_wr <= '0';
--				
--		---------------- Reading -------------------------- 
--		
--		wait for 300 ns;
--		stor_wr <= '0';
--		
--		stor_sel	<= "0000";
--		
--		for i in 0 to 16 loop -- this would be a testament of skills to find a way to do this without an external counter		
--			stor_addr <= std_logic_vector(to_unsigned(i,stor_addr'length)); -- 8 bits for 256 bit ram
--			
--			wait for 20 ns;
--	
--      end loop;
--		
--		
--		wait for 200 ns;
--		
--		stor_sel	<= "0001";
--		
--		for i in 0 to 16 loop -- this would be a testament of skills to find a way to do this without an ex
--			stor_addr <= std_logic_vector(to_unsigned(i,stor_addr'length)); -- 8 bits for 256 bit ram
--			
--			wait for 20 ns;
--				
--      end loop;
--		
--		wait for 200 ns;
--		
--		stor_sel	<= "0010";
--		
--		for i in 0 to 16 loop -- this would be a testament of skills to find a way to do this without an external counte
--			stor_addr <= std_logic_vector(to_unsigned(i,stor_addr'length)); -- 8 bits for 256 bit ram
--			
--			wait for 20 ns;
--				
--      end loop;
--		
--		
--		wait for 200 ns;
--		
--		
		
		
		
		
		
		
		
		
		wait for 100 ns;
		
		
		con_wr <= '1'; -- 1 bit 
		stor_wr <= '1'; -- 1bit
		stor_sel	<= "0000"; -- 4 bits
				
		for i in 0 to 16 loop -- this would be a testament of skills to find a way to do this without an external counter
				
            for j in 0 to 2 loop -- can assign them at the same time 
					stor_in <=	std_logic_vector(data);
					con_addr	<= std_logic_vector(index); -- 8 bit
					con_in <= std_logic_vector(to_unsigned(i,con_in'length));-- 24 bits only 8 bits for the address	of the inputs weights
					stor_addr <= std_logic_vector(to_unsigned(i,stor_addr'length));
					index <= index +1;
					data <= data + 5;
					
					wait for 20 ns;
					
				end loop;
				
				wait for 20 ns;
				
      end loop;
		
		index <= (others => '0');
		con_wr <= '0'; -- 1 bit
		
		wait for 100 ns;
		
--		stor_sel	<= "0100"; -- 4 bits -- weights 
--		
--		-----------------------------initalize output----------------------------
--		for i in 0 to 16 loop -- this would be a testament of skills to find a way to do this without an external counter
--				
--				stor_in <=	(others => '0'); --std_logic_vector(data); -- 24 bits -- by 8 bits go to differt perceptrons -- inputs
--				stor_addr <= std_logic_vector(to_unsigned(i,stor_addr'length)); -- 8 bits for 256 bit ram
--				
--				
--				wait for 20 ns;
--      end loop;
		-----------------------------------------------------
		
		wait for 100 ns;
	
		stor_sel	<= "0001"; -- 4 bits -- weights 
		
		for i in 0 to 16 loop -- this would be a testament of skills to find a way to do this without an external counter
				
				stor_in <=	std_logic_vector(data); -- 24 bits -- by 8 bits go to differt perceptrons -- inputs
				stor_addr <= std_logic_vector(to_unsigned(i,stor_addr'length)); -- 8 bits for 256 bit ram
				data <= data + 5;
				wait for 20 ns;
			
      end loop;
		
		
		
		wait for 100 ns;
		
		--stor_wr <= '1'; -- 1bit
		stor_sel	<= "0010"; -- 4 bits -- activation 
		
		for i in 0 to 16 loop -- this would be a testament of skills to find a way to do this without an external counter
		
			stor_in <=	std_logic_vector(data); -- 24 bits -- by 8 bits go to differt perceptrons -- inputs
			stor_addr <= std_logic_vector(to_unsigned(i,stor_addr'length)); -- 8 bits for 256 bit ram
			data <= data + 5;
			
			wait for 20 ns;
			
      end loop;
		
		stor_wr <= '0';
		stor_sel	<= "0001";
	
		for i in 0 to 16 loop -- this would be a testament of skills to find a way to do this without an external counter
				stor_addr <= std_logic_vector(to_unsigned(i,stor_addr'length)); -- 8 bits for 256 bit ram
			wait for 20 ns;
				
				
      end loop;
		
		wait for 100 ns;
		
		--con_wr <= '0'; 
		prop <= '1';
		--stor_wr <= '0';
				
		
		wait for 500 ns;
		
		con_wr <= '0'; 
		prop <= '0';
		stor_wr <= '0';
		
		wait for 300 ns;
		
		stor_sel	<= "0100";
		
		for i in 0 to 16 loop -- this would be a testament of skills to find a way to do this without an external counter
				stor_addr <= std_logic_vector(to_unsigned(i,stor_addr'length)); -- 8 bits for 256 bit ram
			wait for 20 ns;
		end loop; 
		
		wait for 100 ns;
		
		for i in 0 to 48 loop 
			con_addr <= std_logic_vector(to_unsigned(i,con_addr'length));
			wait for 20 ns;
				
      end loop;
		
		wait for 100 ns;
		
		stor_sel	<= "0001";
		
		for i in 0 to 16 loop -- this would be a testament of skills to find a way to do this without an external counter
				stor_addr <= std_logic_vector(to_unsigned(i,stor_addr'length)); -- 8 bits for 256 bit ram
			wait for 20 ns;
				
				
      end loop;
		
		
		wait for 200 ns;
		
		assert false report "Test: OK" severity failure;
		
		--wait; -- this waits forever
	end process;
	
	uut : entity work.layerConnections
	port map(
		c_clk => clk, num_Layers => numberOfLayers,  inValue_stor => stor_in, storage_sel => stor_sel, storage_addr => stor_addr, 
		storage_wr => stor_wr, inValue_con => con_in, conns_wr => con_wr, conns_addr => con_addr,  
		propogate => prop, conns_out => con_out, storage_out => stor_out, testOutput => test_out
		);
	

end tb;
		