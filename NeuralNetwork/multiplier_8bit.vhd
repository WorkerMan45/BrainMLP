library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier_8bit is
generic(
  N             : integer := 8;
  N_P 			 : integer := 15);
port (
  mul_clk       : in     std_logic;
  i_mul1      : in     std_logic_vector(N-1 downto 0);
  i_mul2      : in     std_logic_vector(N-1 downto 0);
  o_prod       : out    std_logic_vector(N_P downto 0));
end multiplier_8bit;

architecture rtl of multiplier_8bit is

signal r_mul1   : unsigned(N-1 downto 0);
signal r_mul2   : unsigned(N-1 downto 0);
signal w_prod    : unsigned(N_P downto 0);

begin

-- multiplier 
  w_prod <= r_mul1 * r_mul2;

r_process : process (w_prod, i_mul1, i_mul2) is-- (mul_clk )
begin
--	if(rising_edge(mul_clk)) then
  
  -- register input and extend sign
    r_mul1      <=  unsigned(i_mul1);
    r_mul2      <=  unsigned(i_mul2);
    
  -- register output
    o_prod       <= std_logic_vector(w_prod);
    
-- end if;
end process r_process;

end rtl;