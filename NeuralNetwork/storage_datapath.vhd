library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity storage_datapath is -- got to have a statemachine  should be able to input and output 3 things at the same time
  port(
    stor_clk			 	: in std_logic;
	 ramSelect		: in std_logic_vector(3 downto 0); -- which ram it will go to 
	 address			: in std_logic_vector(7 downto 0);
	 
	 writeEnable 	: in  std_logic;
	 
	 inValue			: in std_logic_vector(23 downto 0); -- holds 3 8 bit values for data wieghts, activation values are 16 bit and only one 
	 
	 outValue		: out std_logic_vector(23 downto 0) -- 

    );
end storage_datapath;


architecture behavioral of storage_datapath is
  
  --signal in_clk	 : std_logic; -- maybe should initial to 0 for all of these
  signal in_wr		 : std_logic;
  signal in_ADDR	 : std_logic_vector (7 downto 0);
  signal in_DIN	 : std_logic_vector (23 downto 0);
  signal in_DOUT	 : std_logic_vector (23 downto 0);
  
  --signal wt_clk	 : std_logic; -- maybe should initial to 0 for all of these
  signal wt_wr		 : std_logic;
  signal wt_ADDR	 : std_logic_vector (7 downto 0);
  signal wt_DIN	 : std_logic_vector (23 downto 0);
  signal wt_DOUT	 : std_logic_vector (23 downto 0);
  
  --signal in_clk	 : std_logic; -- maybe should initial to 0 for all of these
  signal con_wr		 : std_logic;
  signal con_ADDR	 : std_logic_vector (7 downto 0);
  signal con_DIN	 : std_logic_vector (23 downto 0);
  signal con_DOUT	 : std_logic_vector (23 downto 0);
  
  signal act_wr		 : std_logic;
  signal act_ADDR	 : std_logic_vector (7 downto 0);
  signal act_DIN	 : std_logic_vector (23 downto 0);
  signal act_DOUT	 : std_logic_vector (23 downto 0);
  
  
  --signal in_clk	 : std_logic; -- maybe should initial to 0 for all of these
  signal out_wr		 : std_logic;
  signal out_ADDR	 : std_logic_vector (7 downto 0);
  signal out_DIN	 : std_logic_vector (23 downto 0);
  signal out_DOUT	 : std_logic_vector (23 downto 0);
  
  
  
  
  component RAM
	port (
		ram_clk		: in std_logic;
		WR			: in std_logic; 
		ADDR		: in std_logic_vector (7 downto 0); 
		DIN		: in std_logic_vector (23 downto 0); 
		DOUT		: out std_logic_vector (23 downto 0) 
		);
		end component;
begin

	inputRam 			:  RAM port map(stor_clk, in_wr, in_ADDR, in_DIN, in_DOUT);
	weightRam 			:  RAM port map(stor_clk, wt_wr, wt_ADDR, wt_DIN, wt_DOUT);
	connectionRam 		:  RAM port map(stor_clk, con_wr, con_ADDR, con_DIN, con_DOUT);
	activationRam 		:  RAM port map(stor_clk, act_wr, act_ADDR, act_DIN, act_DOUT);
	outputRam 			:  RAM port map(stor_clk, out_wr, out_ADDR, out_DIN, out_DOUT);

  process (writeEnable, address, inValue, in_DOUT, wt_DOUT, act_DOUT, out_DOUT) is --(stor_clk) is
  begin
-- if rising_edge(stor_clk) then
	 
      if (ramSelect="0000") then -- input ram
			in_wr		 <= writeEnable;
			in_ADDR	 <= address;
			in_DIN	 <= inValue;
			outValue	 <= in_DOUT;
		elsif (ramSelect="0001") then -- weight Ram
			wt_wr		 <= writeEnable;
			wt_ADDR	 <= address;
			wt_DIN	 <= inValue;
			outValue	 <= wt_DOUT;
--		elsif (ramSelect="0010") then -- probaly get rid of this 
--			con_wr		 <= writeEnable;
--			con_ADDR	 <= address;
--			con_DIN	 <= inValue;
--			outValue	 <= con_DOUT;
		elsif (ramSelect="0010") then -- activation ram
			act_wr	 <= writeEnable;
			act_ADDR	 <= address;
			act_DIN	 <= inValue;
			outValue	 <= act_DOUT;
		else									-- out ram 4 or above 
			out_wr	 <= writeEnable;
			out_ADDR	 <= address;
			out_DIN	 <= inValue;
			outValue	 <= out_DOUT;
		end if;
		
--	end if;
	
  end process;
end behavioral;