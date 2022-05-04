library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_16bit is
generic(
  N             : integer := 16);
port (
  add_clk       : in     std_logic;
  i_add1      : in     std_logic_vector(N-1 downto 0);
  i_add2      : in     std_logic_vector(N-1 downto 0);
  o_sum       : out    std_logic_vector(N-1 downto 0));
end adder_16bit;

architecture rtl of adder_16bit is

signal r_add1   : unsigned(N-1 downto 0);
signal r_add2   : unsigned(N-1 downto 0);
signal w_sum    : unsigned(N-1 downto 0);

begin

-- combinatorial adder
  w_sum <= r_add1 + r_add2;

r_process : process (w_sum,i_add1,i_add2 ) is --(add_clk)
begin
--  if(rising_edge(add_clk)) then
  
  -- register input and extend sign
    r_add1      <=  unsigned(i_add1);
    r_add2      <=  unsigned(i_add2);
    
  -- register output
    o_sum       <= std_logic_vector(w_sum);
    
-- end if;
end process r_process;

end rtl;