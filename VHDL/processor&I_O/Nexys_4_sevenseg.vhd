----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:26:25 10/21/2016 
-- Design Name: 
-- Module Name:    Nexys_4_sevenseg - Behavioral 
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

-- Segment encoding
--      0
--     ---  
--  5 |   | 1
--     ---   <- 6
--  4 |   | 2
--     ---
--      3
--  Decimal Point = 7

--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Nexys_4_sevenseg is
    Port ( display : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
           seg : out  STD_LOGIC_VECTOR (6 downto 0);
           an : out  STD_LOGIC_VECTOR (7 downto 0));
end Nexys_4_sevenseg;

architecture Behavioral of Nexys_4_sevenseg is
	
	signal number : std_logic_vector(63 downto 0);
	signal hex: std_logic_vector(7 downto 0); 
	signal intAn: std_logic_vector(7 downto 0); 
	signal cnt: std_logic_vector(19 downto 0); -- divider counter for ~95.3Hz refresh rate (with 100MHz main clock)
	
	
	Type segnumType is array(0 to 15) of std_logic_vector(6 downto 0);
	constant segnum : segnumType := segnumType'(
		"1000000", "1111001", "0100100", "0110000",
		"0011001", "0010010", "0000010", "1111000",
		"0000000", "0011000", "0001000", "0000011",
		"1000110", "0100001", "0000110", "0001110");
begin

   -- Assign outputs
   an <= intAn;
   seg <= hex(6 downto 0);

   clockDivider: process(clk)
   begin
      if clk'event and clk = '1' then
         cnt <= cnt + '1';
      end if;
   end process clockDivider;

	decode: process(display)
	begin
	
		for i in 0 to 7 loop
			number(7 + i*8 downto 0 + i*8) <= '0' & segnum(CONV_INTEGER( display((3 + i*4) downto (0 + i*4))));
		end loop;
	end process decode;
   -- Anode Select
	
   with cnt(19 downto 17) select -- 100MHz/2^20 = 95.3Hz
      intAn <=    
         "11111110" when "000",
         "11111101" when "001",
         "11111011" when "010",
         "11110111" when "011",
         "11101111" when "100",
         "11011111" when "101",
         "10111111" when "110",
         "01111111" when others;
			
	with cnt(19 downto 17) select -- 100MHz/2^20 = 95.3Hz
      hex <=      
         number(7 downto 0)   when "000",
         number(15 downto 8)  when "001",
         number(23 downto 16) when "010",
         number(31 downto 24) when "011",
         number(39 downto 32) when "100",
         number(47 downto 40) when "101",
         number(55 downto 48) when "110",
         number(63 downto 56) when others;

			
end Behavioral;

