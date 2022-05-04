library ieee;
use ieee.std_logic_1164.all;

entity controlUnit is
port
(
	--i_clk        		:in    	std_logic;

	------------ KEY ------------
	KEY             	:in    	std_logic_vector(3 downto 0);

	------------ SW ------------
	SW              	:in    	std_logic_vector(9 downto 0);

	------------ LED ------------
	LEDR            	:out   	std_logic_vector(9 downto 0);

	------------ Seg7 ------------
	HEX0            	:out   	std_logic_vector(6 downto 0);
	HEX1            	:out   	std_logic_vector(6 downto 0)

);

end entity;



---------------------------------------------------------
--  Structural coding
---------------------------------------------------------


architecture rtl of controlUnit is

-- declare --

begin

-- body --

end rtl;