library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_file is -- This will be a serial in and parallel out of 16 

-- The connections of the layers are the location of the what data is stored in what registers 
generic (K: integer:=24; 
			A: integer:=4); 
  port(
	 reg_clk         : in  std_logic;
	 input       : in  std_logic_vector(K-1 downto 0);
    writeEnable : in  std_logic;
    addr			 : in  std_logic_vector(A-1 downto 0);
	 startAddr	 : in std_logic_vector(A-1 downto 0); -- needs to be factor of 16
	 
	 outP1,outP2,outP3,outP4,
	 outP5,outP6,outP7,outP8,
	 outP9,outP10,outP11,outP12,
	 outP13,outP14,outP15,outP16 : out std_logic_vector(K-1 downto 0)
    
    );
end reg_file;


architecture behavioral of reg_file is
  type registerFile is array(0 to 2**A-1) of std_logic_vector(K-1 downto 0);
  signal registers : registerFile := (others => (others => '0'));

 begin
--  regFile : process (reg_clk) is
process(input, writeEnable, addr, startAddr) is 
  begin
--    if rising_edge(reg_clk) then
      if writeEnable = '1' then
        registers(to_integer(unsigned(addr))) <= input;  -- Write
        outP1 <= (others => '0');
		  outP2 <= (others => '0');
		  outP3 <= (others => '0');
		  outP4 <= (others => '0');
		  outP5 <= (others => '0');
		  outP6 <= (others => '0');
		  outP7 <= (others => '0');
		  outP8 <= (others => '0');
		  outP9 <= (others => '0');
		  outP10 <= (others => '0');
		  outP11 <= (others => '0');
		  outP12 <= (others => '0');
		  outP13 <= (others => '0');
		  outP14 <= (others => '0');
		  outP15 <= (others => '0');
		  outP16 <= (others => '0');
		  --outP1 <= (others => '0');
		 else
		  outP1 <= registers(to_integer(unsigned(startAddr)));
		  outP2 <= registers(to_integer(unsigned(startAddr))+1);
		  outP3 <= registers(to_integer(unsigned(startAddr))+2);
		  outP4 <= registers(to_integer(unsigned(startAddr))+3);
		  outP5 <= registers(to_integer(unsigned(startAddr))+4);
		  outP6 <= registers(to_integer(unsigned(startAddr))+5);
		  outP7 <= registers(to_integer(unsigned(startAddr))+6);
		  outP8 <= registers(to_integer(unsigned(startAddr))+7);
		  outP9 <= registers(to_integer(unsigned(startAddr))+8);
		  outP10 <= registers(to_integer(unsigned(startAddr))+9);
		  outP11 <= registers(to_integer(unsigned(startAddr))+10);
		  outP12 <= registers(to_integer(unsigned(startAddr))+11);
		  outP13 <= registers(to_integer(unsigned(startAddr))+12);
		  outP14 <= registers(to_integer(unsigned(startAddr))+13);
		  outP15 <= registers(to_integer(unsigned(startAddr))+14);
		  outP16 <= registers(to_integer(unsigned(startAddr))+15);
      end if;
--    end if;
  end process;
end behavioral;