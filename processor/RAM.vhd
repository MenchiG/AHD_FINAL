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
constant Data :  DataMemType:= (  x"00",x"00",x"00",x"00",
											 x"00",x"00",x"00",x"00",
											 x"46",x"F8",x"E8",x"C5",
											 x"46",x"0C",x"60",x"85",
											 x"70",x"F8",x"3B",x"8A",
											 x"28",x"4B",x"83",x"03",
											 x"51",x"3E",x"14",x"54",
											 x"F6",x"21",x"ED",x"22",
											 x"31",x"25",x"06",x"5D",
											 x"11",x"A8",x"3A",x"5D",
											 x"D4",x"27",x"68",x"6B",
											 x"71",x"3A",x"D8",x"2D",
											 x"4B",x"79",x"2F",x"99",
											 x"27",x"99",x"A4",x"DD",
											 x"A7",x"90",x"1C",x"49",
											 x"DE",x"DE",x"87",x"1A",
											 x"36",x"C0",x"31",x"96",
											 x"A7",x"EF",x"C2",x"49",
											 x"61",x"A7",x"8B",x"B8",
											 x"3B",x"0A",x"1D",x"2B",
											 x"4D",x"BF",x"CA",x"76",
											 x"AE",x"16",x"21",x"67",
											 x"30",x"D7",x"6B",x"0A",
											 x"43",x"19",x"23",x"04",
											 x"F6",x"CC",x"14",x"31",
											 x"65",x"04",x"63",x"80",
											 x"00",x"00",x"00",x"00",
											 x"00",x"00",x"00",x"00",
											 x"00",x"00",x"00",x"01",
											 x"00",x"00",x"00",x"0D");
begin

	process(clk, clr, address_i, writedata_i, readmem_i, writemem_i)
		variable DataMem: DataMemType(0 to 1023);
		variable v_ReadMem1,v_WriteMem1: natural;
	begin
	
	if(clr = '1') then
		DataMem := (others =>(others => '0'));
		DataMem(0 to 119) := Data;
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

