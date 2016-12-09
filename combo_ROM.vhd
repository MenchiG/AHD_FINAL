----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:00:27 10/17/2016 
-- Design Name: 
-- Module Name:    ROM - Behavioral 
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

entity ROM is
    Port ( address_i : in  STD_LOGIC_VECTOR (31 downto 0);
           data_o : out  STD_LOGIC_VECTOR (31 downto 0));
end ROM;

architecture Behavioral of ROM is

Type InstrMemType is array(natural range<>) of std_logic_vector(7 downto 0);  

constant Instruction : InstrMemtype:= (	
--key generation
--"00000000","10100101","00101000","00010001", --0 a
--"00000000","11100111","00111000","00010001", --4 b
--"00000001","10001100","01100000","00010001", --8 s[0]
--"00000001","01101011","01011000","00010001", --12 s[1]  
--"00000001","01001010","01010000","00010001", --16 a+s[0]
--
--"00000100","00001101","00000000","01101000", --20 b+s[1]
--"00000100","00001110","00000000","00010000", --24 i<12
--"00000100","00001111","00000000","01001110", --28 i=1
--
--"00011101","01000110","00000000","00100001", --32 !a
--"00000000","10100111","00101000","00010000", --36 !b
--"00000000","10100110","00101000","00010000", --40
--"00010100","10100101","00000000","00000011", --44
--
--"00011101","01101000","00000000","10001001", --48 a xor b
--"00000000","10100111","00111000","00010000", --52 j=amount
--"00000000","00000111","01001000","00010000", --56 j==0? 
--"00000000","11101000","00111000","00010000", --60 <<1
--
--"00001101","00101001","00000000","00011111", --64 j--
--"00101000","00001001","00000000","00000011", --68 j==0?
--"00010100","11100111","00000000","00000001", --72 i*2*4
--"00001001","00101001","00000000","00000001", --76 s[i*2*4]
--"00101000","00000000","11111111","11111100", --80 a1
--
--"00100001","01000101","00000000","00100001", --84 !a
--"00100001","01100111","00000000","10001001", --88 !b
--
--"00000101","01001010","00000000","00000100", --92
--"00101101","10101010","00000000","00000001", --96
--"00000001","01001010","01010000","00010001", --100 b xor a
--
--"00000101","01101011","00000000","00000100", --104 j=amount
--"00101101","01101110","00000000","00000001", --108 j==0? 
--"00000001","01101011","01011000","00010001", --112 <<1
--
--"00000101","10001100","00000000","00000001", --116 j--
--"00101101","11101100","11111111","11101001", --120 j==0?
--"00011100","00010000","00000000","00100001",
--"00011100","00010001","00000000","10001001",
--
--


--enc
-- new
"00000000","00100001","00001000","00010001",
"00000000","01000010","00010000","00010001",
"00000000","01100011","00011000","00010001",
"00000000","10000100","00100000","00010001",
"00000000","10100101","00101000","00010001",
"00000000","11000110","00110000","00010001",
"00000000","11100111","00111000","00010001",
"00000001","00001000","01000000","00010001",
"00000001","00101001","01001000","00010001",
"00000001","01001010","01010000","00010001",
"00000001","01101011","01011000","00010001",
"00000001","10001100","01100000","00010001",
"00000001","10101101","01101000","00010001",
"00000001","11001110","01110000","00010001",
"00000001","11101111","01111000","00010001",
"00000010","00010000","10000000","00010001",
"00000010","00110001","10001000","00010001",
"00000010","01010010","10010000","00010001",
"00000010","01110011","10011000","00010001",
"00000010","10010100","10100000","00010001",
--end
"00011100","00000001","00000000","00000001",--lw
"00011100","00000010","00000000","00000101",--lw
"00011100","00000011","00000000","00100001",--lw
"00011100","00000100","00000000","00100101",--lw
"00000000","00100011","00101000","00010000",--add

"00000000","01000100","00110000","00010000",--add

"00000100","00000111","00000000","00000000",--addi
"00000100","11100111","00000000","00000001",--addi
"00000100","00001000","00000000","00001100",--addi
"00000000","10100000","01001000","00010100",--nor
"00000000","11000000","01010000","00010100",--nor
"00000000","10101010","01011000","00010010",--and


"00000001","00100110","01100000","00010010",--and


"00000001","01101100","01101000","00010011",
"00001100","11001110","00000000","00011111",
"00101000","00001110","00000000","00000011",
"00010101","10101101","00000000","00000001",
"00001001","11001110","00000000","00000001",
"00101100","00001110","11111111","11111101",--bne
"00010100","11101111","00000000","00000011",--shl
"00011101","11110000","00000000","00100001",--lw
"00000001","10110000","00101000","00010000",--Add
"00100000","00000101","00000000","00001001",--sw

"00000000","10100000","01001000","00010100",--nor
"00000000","11001001","01011000","00010010",--and

"00000001","01000101","01100000","00010010",--and
"00000001","01101100","01101000","00010011",
"00001100","10101110","00000000","00011111",--andi
"00101000","00001110","00000000","00000011",
"00010101","10101101","00000000","00000001",
"00001001","11001110","00000000","00000001",
"00101100","00001110","11111111","11111101",--bne
"00011101","11110011","00000000","00100101",--lw
"00000001","10110011","00110000","00010000",--add
"00100000","00000110","00000000","00001101",--sw
"00101101","00000111","11111111","11100011",--bne


"11111100","00000000","00000000","00000000"  --hal

);
begin


	 data_o <= Instruction(conv_integer(address_i)) & Instruction(conv_integer(address_i) + 1) & Instruction(conv_integer(address_i) + 2) & Instruction(conv_integer(address_i) + 3);
	 
end Behavioral;
