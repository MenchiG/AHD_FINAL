----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:32:35 10/18/2016 
-- Design Name: 
-- Module Name:    RAM - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM is
    Port ( clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           address_i : in  STD_LOGIC_VECTOR (31 downto 0);
           writedata_i : in  STD_LOGIC_VECTOR (31 downto 0);
           readmem_i : in  STD_LOGIC;
           writemem_i : in  STD_LOGIC;
           readdata_o : out  STD_LOGIC_VECTOR (31 downto 0));
end RAM;

architecture Behavioral of RAM is
	
Type DataMemType is array(natural range<>) of std_logic_vector(7 downto 0);
constant Data :  DataMemType:= (  x"00",
                                  x"00",x"00",x"00",x"00",    -- 1-4
											 x"00",x"00",x"00",x"00",    
											 x"46",x"F8",x"E8",x"C5",
											 x"46",x"0C",x"60",x"85",
											 x"70",x"F8",x"3B",x"8A",
											 x"28",x"4B",x"83",x"03",
											 x"51",x"3E",x"14",x"54",
											 x"F6",x"21",x"ED",x"22",    --29-32
											 x"B7",x"E1",x"51",x"63",    --33-36 :S[0]
											 x"56",x"18",x"CB",x"1C",
											 x"F4",x"50",x"44",x"D5",
											 x"92",x"87",x"BE",x"8E",
											 x"30",x"BF",x"38",x"47",
											 x"CE",x"F6",x"B2",x"00",
											 x"6D",x"2E",x"2B",x"B9",
											 x"0B",x"65",x"A5",x"72",
											 x"A9",x"9D",x"1F",x"2B",
											 x"47",x"D4",x"98",x"E4",
											 x"E6",x"0C",x"12",x"9D",   --S[10]
											 x"84",x"43",x"8C",x"56",
											 x"22",x"7B",x"06",x"0F",
											 x"C0",x"B2",x"7F",x"C8",
											 x"5E",x"E9",x"F9",x"81",
											 x"FD",x"21",x"73",x"3A",
											 x"9B",x"58",x"EC",x"F3",
											 x"39",x"90",x"66",x"AC",
											 x"D7",x"C7",x"E0",x"65",
											 x"75",x"FF",x"5A",x"1E",
											 x"14",x"36",x"D3",x"D7",   --S[20]
											 x"B2",x"6E",x"4D",x"90",
											 x"50",x"A5",x"C7",x"49",
											 x"EE",x"DD",x"41",x"02",
											 x"8D",x"14",x"BA",x"BB",
											 x"2B",x"4C",x"34",x"74",   --S[25]
											 x"00",x"00",x"00",x"00",   -- L[0]
											 x"00",x"00",x"00",x"00",
											 x"00",x"00",x"00",x"00",
											 x"00",x"00",x"00",x"00"   --L[3]
										
											 );
begin

	process(clk, clr, address_i, writedata_i, readmem_i, writemem_i)
		variable DataMem: DataMemType(0 to 1023);
		variable v_ReadMem1,v_WriteMem1: natural;
	begin
	
	if(clr = '1') then
		DataMem := (others =>(others => '0'));
		DataMem(0 to 152) := Data;
	else
		if(readmem_i ='1') then
			v_ReadMem1 := conv_integer(address_i(9 downto 0));
			readdata_o <= 	DataMem(v_ReadMem1) & 
								DataMem(v_ReadMem1 + 1) & 
								DataMem(v_ReadMem1 + 2) & 
								DataMem(v_ReadMem1 + 3);
		end if;
		if(clk'event and clk = '1')then
				  
			if (writemem_i = '1') then
				v_WriteMem1 := conv_integer(address_i(9 downto 0));
				DataMem(v_WriteMem1) 		:= 	writedata_i(31 downto 24);
				DataMem(v_WriteMem1 + 1) 	:= 	writedata_i(23 downto 16);
				DataMem(v_WriteMem1 + 2) 	:= 	writedata_i(15 downto  8);
				DataMem(v_WriteMem1 + 3) 	:= 	writedata_i(7  downto  0);
         end if;
		end if;
	end if;
	
	end process;
			

end Behavioral;

