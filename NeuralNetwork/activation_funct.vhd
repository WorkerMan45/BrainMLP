library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity activation_funct is
port(
  i_clk          : in  std_logic;
  i_rstb         : in  std_logic;
  i_x            : in  std_logic_vector( 3 downto 0);
  o_exp          : out std_logic_vector( 7 downto 0));
end activation_funct;

architecture rtl of activation_funct is
constant C_LUT_DEPTH    : integer := 4;  -- 16 word
constant C_LUT_BIT      : integer := 8;     -- 8 bit LUT

type t_lut_exp is array(0 to (2**C_LUT_DEPTH)-1) of integer range 0 to (2**C_LUT_BIT)-1;

constant C_LUT_ADDR_OFFSET         : unsigned(C_LUT_DEPTH-1 downto 0):= to_unsigned(2**(C_LUT_DEPTH-1),C_LUT_DEPTH);

signal lut_addr                    : unsigned(C_LUT_DEPTH-1 downto 0);
signal lut_value                   : std_logic_vector(C_LUT_BIT-1 downto 0);--(32 - 32(1.1^-x) x in range of 0 to 80 find a way to have float values

constant C_LUT_EXP : t_lut_exp :=(
   39,
   44,
   50,
   57,
   64,
   73,
   83,
   94,
  106,
  120,
  136,
  155,
  175,
  199,
  225,
  255);

begin

p_rom : process(i_clk)
begin
 if(rising_edge(i_clk)) then
    lut_addr   <= C_LUT_ADDR_OFFSET + unsigned(i_x);
    lut_value  <= std_logic_vector(to_signed(C_LUT_EXP(to_integer(lut_addr)),C_LUT_BIT));
  end if;
end process p_rom;

p_exp : process(i_clk,i_rstb)
begin
  if(i_rstb='0') then
    o_exp     <= (others=>'0');
  elsif(rising_edge(i_clk)) then
    o_exp     <= lut_value;
  end if;
end process p_exp;

end rtl;