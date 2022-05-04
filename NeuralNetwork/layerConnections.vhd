library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity layerConnections is -- got to have a statemachine  should be able to input and output 3 things at the same time
generic (	ramA: integer:=8;
				K: integer:=24; 
				layA: integer:=4;
				oS	: integer:=16
				); 
  port(
    c_clk			 	: in std_logic;
	 
	 num_Layers			: in std_logic_vector(7 downto 0); -- can hold 256 layers
	 
	 inValue_stor	: in std_logic_vector(K-1 downto 0); 
	 
	 storage_sel				: in std_logic_vector(3 downto 0); -- which ram it will go to 
	 storage_addr			: in std_logic_vector(ramA-1 downto 0);
	 storage_wr			: in std_logic; -- layers and storage
	 
	 inValue_con		: in std_logic_vector(K-1 downto 0);			
	 
	 conns_wr				: in std_logic;
	 conns_addr			: in std_logic_vector(ramA-1 downto 0);
	 
	 propogate			: in std_logic; -- used to start propogation
	 
	
	 conns_out 		: out std_logic_vector(K-1 downto 0);
	 storage_out		: out std_logic_vector(K-1 downto 0);
	 
	 testOutput		:out std_logic_vector(K-1 downto 0)
	 
	 
    );
	 
end layerConnections;


architecture behavioral of layerConnections is
 
signal inLay_wr		:  std_logic;
signal inLay_addr		: 	std_logic_vector(layA-1 downto 0);
signal inLay_input	:	std_logic_vector(K-1 downto 0); 
signal inlay_outP1   : 	std_logic_vector(oS-1 downto 0); 
signal inlay_outP2   : 	std_logic_vector(oS-1 downto 0);	
signal inlay_outP3   : 	std_logic_vector(oS-1 downto 0);
signal inlay_outP4   : 	std_logic_vector(oS-1 downto 0);
signal inlay_outP5   : 	std_logic_vector(oS-1 downto 0);


signal stor_ramSel	:	std_logic_vector(3 downto 0); -- 0 = in, 1= weights, 2 = con, 3 = activate, 4 = out 
signal stor_address	: 	std_logic_vector(ramA-1 downto 0); 
signal stor_wr		 	:  std_logic;
signal stor_inV		: 	std_logic_vector(23 downto 0); 	 
signal stor_outV		: 	std_logic_vector(23 downto 0);

--signal con_ramSel	:	std_logic_vector(3 downto 0); -- 0 = in, 1= weights, 2 = con, 3 = activate, 4 = out 
signal con_address	: 	std_logic_vector(ramA-1 downto 0); 
signal con_wr		 	:  std_logic;
signal con_inV		: 	std_logic_vector(23 downto 0); 	 
signal con_outV		: 	std_logic_vector(23 downto 0);

-------------signals used to for propagition ---------------------

signal stateHolder	: std_logic_vector(3 downto 0); -- is used to control the layers, potential for 15 unique layers 

signal alternAddr 	: unsigned(3 downto 0):= (others => '0') ;
signal currentAddr 	: unsigned(ramA-1 downto 0) := (others => '0');
signal layerAddr		: unsigned(layA-1 downto 0) := (others => '0');
signal outAddr			: unsigned(layA-1 downto 0):= (others => '0') ;
signal pastInput		: std_logic := '0' ;

signal conAddrCounter : unsigned(ramA-1 downto 0):= (others => '0') ;
signal outAddrCounter :	unsigned(ramA-1 downto 0):= (others => '0') ;
signal layerCounter  : unsigned(7 downto 0);
signal outOfBounds	: std_logic := '0';

subtype stor_lower is integer range oS-1 downto 0; 

component storage_datapath is-- connections can be hard coded locations in the con ram 
  port(
    stor_clk			 	: in std_logic;
	 ramSelect		: in std_logic_vector(3 downto 0); -- 0 = in, 1= weights, 2 = con, 3 = activate, 4 = out 
	 address			: in std_logic_vector(ramA-1 downto 0);
	 
	 writeEnable 	: in  std_logic;
	 
	 inValue			: in std_logic_vector(23 downto 0); -- holds 3 8 bit values for data wieghts, activation values are 16 bit and only one 
	 
	 outValue		: out std_logic_vector(23 downto 0) -- 

    );
end component storage_datapath;

component pLayer 
port
(
	perl_clk        		:in    	std_logic;

	reg_wr				:in		std_logic;
	reg_addr				:in  		std_logic_vector(layA-1 downto 0);  
	reg_input			:in    	std_logic_vector(K-1 downto 0); 
	
	
	outP1            	:out   	std_logic_vector(oS-1 downto 0); 
	outP2            	:out   	std_logic_vector(oS-1 downto 0); 
	outP3            	:out   	std_logic_vector(oS-1 downto 0); 
	outP4            	:out   	std_logic_vector(oS-1 downto 0); 
	outP5            	:out   	std_logic_vector(oS-1 downto 0)

);
end component pLayer;

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
	
	--stor_wr <= ram_wr;
	
	cons : RAM port map(c_clk, con_wr, con_address,  con_inV, con_outV); -- going to have to 
	stor : storage_datapath port map(c_clk, stor_ramSel, stor_address, stor_wr, stor_inV, stor_outV);


	reusableLayer : pLayer port map(c_clk, inLay_wr,inLay_addr, inLay_input, inlay_outP1, 
	inlay_outP2, inlay_outP3,inlay_outP4,inlay_outP5); -- address layers should only be controlled in  here not externally
	

process(c_clk) is
	
	begin
		if rising_edge(c_clk) then
		
			if propogate='0' then -- controls when all the data has been loaded 
				con_wr <= conns_wr;
				con_address <= conns_addr;
				con_inV <= inValue_con;
				conns_out <= con_outV;
				-- output not necessary but good for testing
				stor_ramSel <= storage_sel; 
				stor_address <= storage_addr; 
				stor_wr <= storage_wr;
				stor_inV <= inValue_stor;
				storage_out <= stor_outV;
				
				inLay_wr <= '0';
				inLay_addr <= (others => '0');
				inLay_input	<= (others => '0');
				
				--stateHolder <= "0000";
				
				stateHolder <= "0000";
				alternAddr 	<= (others => '0');
				currentAddr <= (others => '0');
				layerAddr	<= (others => '0');
				outAddr		<= (others => '0');
				pastInput <= '0';
				outAddrCounter <= (others => '0');
				conAddrCounter <= (others => '0');
				layerCounter <= (others => '0');
				outOfBounds <= '0';
				
			else -- when start Prop  
			
				con_wr <= '0'; -- read
				
				if stateHolder="0000" then -- can not do this in parallel -- we can reuse the layer -- not 
					
					stor_wr <= '0'; -- read
					
					con_address <= std_logic_vector(conAddrCounter); -- cons should alternate input, wieghts, activation 1 1 1, 2 2 2 , 3 3 3 ... for standard
					
					
					
					if(alternAddr < 4) then  alternAddr <= (others => '0');
					end if;
					
					if pastInput = '0' then -- 
					
						if   (alternAddr < 1) then stor_ramSel <= "0000"; -- input ram
						elsif(alternAddr < 2) then stor_ramSel <= "0001"; -- weights ram 
						else  stor_ramSel<= "0010"; -- activation ram
						end if;
						
					else
						if   (alternAddr < 1) then stor_ramSel <= "0100"; -- output ram
						elsif(alternAddr < 2) then stor_ramSel <= "0001"; -- weights ram
						else  stor_ramSel<= "0010"; -- activation ram 
						end if;
					end if;
					
					
					stor_address <= con_outV(ramA-1 downto 0); -- input,  wieght, activation value 
					
					inLay_wr <= '1';
					inLay_addr <= std_logic_vector(layerAddr);
					inLay_input	<= stor_outV;
					
					 --
					
					alternAddr <= alternAddr + 1;
					layerAddr <= layerAddr +1;
					currentAddr <= currentAddr +1;
					conAddrCounter <= conAddrCounter + 1;
					
					if layerCounter > unsigned(num_Layers) then 
						stateHolder <= "1111";
					
					elsif conAddrCounter > 255 then
						stateHolder <= "1000"; -- state write out
						alternAddr <= (others => '0');
						layerAddr <= (others => '0');
						currentAddr <= (others => '0');
						inLay_wr <= '0';
						outOfBounds <= '1';
					
					
					elsif currentAddr > 15 then  
						stateHolder <= "1000"; -- state write out
						alternAddr <= (others => '0');
						layerAddr <= (others => '0');
						currentAddr <= (others => '0');
						inLay_wr <= '0';
						
					
					end if;
					
					
					-- Should have a buffer
						
				--elsif stateHolder="0001" then -- hidden layer 
					
					
					
				
				elsif stateHolder="1000" then 
					
					stor_ramSel <= "0100"; -- output ram 
					stor_wr <= '1'; -- write
					
					if   (outAddr < 1) then stor_inV(stor_lower) <= inlay_outP1;
					elsif(outAddr < 2 ) then stor_inV(stor_lower) <= inlay_outP2;
					elsif(outAddr < 2 ) then stor_inV(stor_lower) <= inlay_outP3;
					elsif (outAddr < 4) then stor_inV(stor_lower) <= inlay_outP4;
					else  stor_inV(stor_lower) <= inlay_outP5;
					end if;
					
					
					stor_address <= std_logic_vector(outAddrCounter);
					
					inLay_wr <= '0';
					inLay_addr <= (others => '0');
					inLay_input	<= (others => '0');
											
				
					outAddr <= outAddr +1;
					outAddrCounter <= outAddrCounter + 1;
					
--					if outOfBounds = '1' and outAddr > 4 then 
--						stateHolder <= "1111";
--					end if;
					
					if outAddrCounter <= 255 and outAddr > 4 then  
						stateHolder <= "0000"; -- state write out
						outAddr <= (others => '0');
						pastInput <= '1';
						layerCounter <= layerCounter + 1;
						
					elsif (outAddr > 4) or (outOfBounds = '1' and outAddr > 4) then
						stateHolder <= "1111";
					
					end if;
					
					testOutput(ramA-1 downto 0) <= std_logic_vector(outAddrCounter);
					
					 -- std_logic_vector(outAddr); -- 
				
				elsif stateHolder = "1111" then -- run this whole thing 3 times  
					
					
					if (conns_wr = '0' or storage_wr = '0') and propogate = '0' then
						
					end if;
				
				end if;
				
			end if;
		
		end if;
		
	end process;		
	

end behavioral;