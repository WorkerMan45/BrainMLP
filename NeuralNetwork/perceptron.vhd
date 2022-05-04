library ieee;
use ieee.std_logic_1164.all;

entity perceptron is 
port
(
	per_clk        			:in    	std_logic;
	
	input_1					:in    	std_logic_vector(7 downto 0);
	weight_1					:in		std_logic_vector(7 downto 0);
	
	input_2					:in    	std_logic_vector(7 downto 0);
	weight_2					:in		std_logic_vector(7 downto 0);
	
	input_3					:in    	std_logic_vector(7 downto 0);
	weight_3					:in		std_logic_vector(7 downto 0);

	activationValue  		:in    	std_logic_vector(15 downto 0);

	
	action_potential     :out   	std_logic_vector(15 downto 0)


);

end entity;



---------------------------------------------------------
--  Structural coding
---------------------------------------------------------


architecture rtl of perceptron is

signal m_out1	: std_logic_vector(15 downto 0);
signal m_out2	: std_logic_vector(15 downto 0);
signal m_out3	: std_logic_vector(15 downto 0);

signal a_out1	: std_logic_vector(15 downto 0);
signal a_out2	: std_logic_vector(15 downto 0);

signal totalSum : std_logic_vector(15 downto 0);
-- signal a_out3	: std_logic_vector(16 downto 0);

component multiplier_8bit
	port (
		  mul_clk       : in     std_logic;
		  i_mul1      : in     std_logic_vector(7 downto 0);
		  i_mul2      : in     std_logic_vector(7 downto 0);
		  o_prod       : out    std_logic_vector(15 downto 0)
		  );
		end component;
		
component adder_16bit
	port (
		  add_clk       : in     std_logic;
		  i_add1      : in     std_logic_vector(15 downto 0);
		  i_add2      : in     std_logic_vector(15 downto 0);
		  o_sum       : out    std_logic_vector(15 downto 0)
		);
		end component;
		

begin

	mult1: multiplier_8bit PORT MAP(per_clk, input_1, weight_1, m_out1);
	mult2: multiplier_8bit PORT MAP(per_clk, input_2, weight_2, m_out2);
	mult3: multiplier_8bit PORT MAP(per_clk, input_3, weight_3, m_out3);
	
	add1: adder_16bit PORT MAP(per_clk, m_out1, m_out2, a_out1);
	add2: adder_16bit PORT MAP(per_clk, a_out1, m_out3, a_out2);
	
	totalSum <= a_out2;--(16 downto 1);

	
comparison : process( totalSum ) is -- maybe just when(per_clk) is-- , activationValue 
begin
--if rising_edge(per_clk) then
	if totalSum >= activationValue then -- maybe add a divisor here 
	  action_potential <= totalSum;
	else
	  action_potential <= (others => '0');
	  --output <= 'Z' ;
	end if;
--end if;
end process comparison;


end rtl;