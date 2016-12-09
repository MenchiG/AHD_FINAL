I----------------------------------------------------------------------------------
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
"00000000","10100101","00101000","00010001", --0 a
"00000000","11100111","00111000","00010001", --4 b
"00000001","10001100","01100000","00010001", --8 s[0]
"00000001","01101011","01011000","00010001", --12 s[1]  
"00000001","01001010","01010000","00010001", --16 a+s[0]

"00000100","00001101","00000000","01101000", --20 b+s[1]
"00000100","00001110","00000000","00010000", --24 i<12
"00000100","00001111","00000000","01001110", --28 i=1

"00011101","01000110","00000000","00100001", --32 !a
"00000000","10100111","00101000","00010000", --36 !b
"00000000","10100110","00101000","00010000", --40
"00010100","10100101","00000000","00000011", --44

"00011101","01101000","00000000","10001001", --48 a xor b
"00000000","10100111","00111000","00010000", --52 j=amount
"00000000","00000111","01001000","00010000", --56 j==0? 
"00000000","11101000","00111000","00010000", --60 <<1

"00001101","00101001","00000000","00011111", --64 j--
"00101000","00001001","00000000","00000011", --68 j==0?
"00010100","11100111","00000000","00000001", --72 i*2*4
"00001001","00101001","00000000","00000001", --76 s[i*2*4]
"00101000","00000000","11111111","11111100", --80 a1

"00100001","01000101","00000000","00100001", --84 !a
"00100001","01100111","00000000","10001001", --88 !b

"00000101","01001010","00000000","00000100", --92
"00101101","10101010","00000000","00000001", --96
"00000001","01001010","01010000","00010001", --100 b xor a

"00000101","01101011","00000000","00000100", --104 j=amount
"00101101","01101110","00000000","00000001", --108 j==0? 
"00000001","01101011","01011000","00010001", --112 <<1

"00000101","10001100","00000000","00000001", --116 j--
"00101101","11101100","11111111","11101001", --120 j==0?

"00011100","00010000","00000000","00100001", --124
"00011100","00010001","00000000","10001001", --128


--"11111100","00000000","00000000","00000000",	--124 s[i*2*4+4]

--"00000001","01001110","00010000","00010000", --128 b1
--"00000100","10100101","00000000","00000001", --132 i++
--"00101100","10000101","11111111","10010100", --136
--"11111111","11111111","11111111","11111111"
--key generation end

--enc
"00000000","00100001","00001000","00010001", --132
"00000000","01000010","00010000","00010001", --136
"00000000","01100011","00011000","00010001", --140
"00000000","10000100","00100000","00010001",--144
"00000000","10100101","00101000","00010001",--148
"00000000","11000110","00110000","00010001",--152
"00000000","11100111","00111000","00010001",--156
"00000001","00001000","01000000","00010001",--160
"00000001","00101001","01001000","00010001",--164
"00000001","01001010","01010000","00010001",--168
"00000001","01101011","01011000","00010001",--172
"00000001","10001100","01100000","00010001",--176
"00000001","10101101","01101000","00010001",--180
"00000001","11001110","01110000","00010001",--184
"00000001","11101111","01111000","00010001",--188
"00000010","00010000","10000000","00010001",--192
"00000010","00110001","10001000","00010001",--196
"00000010","01010010","10010000","00010001",--200
"00000010","01110011","10011000","00010001",--204
"00000010","10010100","10100000","00010001",--208
--end
"00000010","01010010","10010000","00010001",--212
"00000010","10110101","10101000","00010001",--216
"00011100","00010010","00000000","00010001",--220
"00000100","00010101","00000000","00000001",--224
"00101010","10110010","00000000","00100101",--228

"00011100","00000001","00000000","00000001",--lw,232
"00011100","00000010","00000000","00000101",--lw,236
"00011100","00000011","00000000","00100001",--lw,240
"00011100","00000100","00000000","00100101",--lw,244
"00000000","00100011","00101000","00010000",--add,248

"00000000","01000100","00110000","00010000",--add,252

"00000100","00000111","00000000","00000000",--addi,256
"00000100","11100111","00000000","00000001",--addi,260
"00000100","00001000","00000000","00001100",--addi,264
"00000000","10100000","01001000","00010100",--nor,268
"00000000","11000000","01010000","00010100",--nor,272,
"00000000","10101010","01011000","00010010",--and276,


"00000001","00100110","01100000","00010010",--and,280


"00000001","01101100","01101000","00010011",--284
"00001100","11001110","00000000","00011111",--288
"00101000","00001110","00000000","00000011",--292
"00010101","10101101","00000000","00000001",--296
"00001001","11001110","00000000","00000001",--300
"00101100","00001110","11111111","11111101",--bne,304
"00010100","11101111","00000000","00000011",--shl,308
"00011101","11110000","00000000","00100001",--lw,312
"00000001","10110000","00101000","00010000",--Add,316
"00100000","00000101","00000000","00001001",--sw,320

"00000000","10100000","01001000","00010100",--nor,324
"00000000","11001001","01011000","00010010",--and,328

"00000001","01000101","01100000","00010010",--and,332
"00000001","01101100","01101000","00010011",--336
"00001100","10101110","00000000","00011111",--andi,340
"00101000","00001110","00000000","00000011",--344
"00010101","10101101","00000000","00000001",--348
"00001001","11001110","00000000","00000001",--352
"00101100","00001110","11111111","11111101",--bne,356
"00011101","11110011","00000000","00100101",--lw,360
"00000001","10110011","00110000","00010000",--add,364
"00100000","00000110","00000000","00001101",--sw,368
"00101101","00000111","11111111","11100011",--bne,372
"00110000","00000000","00000000","10010111",--376 jump to HAL


--"11111100","00000000","00000000","00000000",  --hal

--enc end

--dec 
"00000000","00100001","00001000","00010001", -- initialization,376
"00000000","01000010","00010000","00010001", --380
"00000000","01100011","00011000","00010001", --384
"00000000","10000100","00100000","00010001", --388,
"00000000","10100101","00101000","00010001", --392
"00000000","11000110","00110000","00010001", --396
"00000000","11100111","00111000","00010001", --400
"00000001","00001000","01000000","00010001", --404
"00000001","00101001","01001000","00010001", --408
"00000001","01001010","01010000","00010001", --412
"00000001","01101011","01011000","00010001", --416
"00000001","10001100","01100000","00010001", --420
"00000001","10101101","01101000","00010001", --424
"00000001","11001110","01110000","00010001", --428
"00000001","11101111","01111000","00010001", --432
"00000010","00010000","10000000","00010001", --436
"00000010","00110001","10001000","00010001", --440
"00000010","01010010","10010000","00010001", --444
"00000010","01110011","10011000","00010001", --448
"00011100","00000001","00000000","00000001", --452 a12
"00011100","00000010","00000000","00000101", --456 b12 
"00011100","00000011","00000000","00100001", --460 s[0]
"00011100","00000100","00000000","00100101", --464 s[1]
"00000100","00000101","00000000","00001101", --468 i=13
"00001000","10100101","00000000","00000001", --472 i--
"00000100","00000110","00000000","00000001", --476 R6=1
"00010100","10100111","00000000","00000011", --480, 1042*i*4
"00011100","11101000","00000000","00100001", --484 s[24]
"00011100","11101001","00000000","00100101", --488 s[25]
"00000000","01001001","01010000","00010001", --492 b12-s[25]
"00001100","00101011","00000000","00011111", --496 a12(4 downto 0)
"00101000","00001011","00000000","00000011", --500 jump to 136
"00011001","01001010","00000000","00000001", --504 b rotate
"00001001","01101011","00000000","00000001", --508 a12--
"00101100","00001011","11111111","11111101", --512 jump to 128
"00000000","00001010","01100000","00010100", --516 !b
"00000000","00000001","01101000","00010100", --520 !a12
"00000001","10000001","01110000","00010010", --524 (!b)&a12
"00000001","01001101","01111000","00010010", --528 b&(!a12)
"00000001","11101110","00010000","00010011", --532 b11
"00000000","00101000","01010000","00010001", --536 a12-s[24]
"00001100","01001011","00000000","00011111", --540 b11(4 downto 0)
"00101000","00001011","00000000","00000011", --544 jump to 180
"00011001","01001010","00000000","00000001", --548 a rotate
"00001001","01101011","00000000","00000001", --552 b11--
"00101100","00001011","11111111","11111101", --556 jump to 172
"00000001","01000000","01100000","00010100", --560 !a
"00000000","01000000","10000000","00010100", --564 !b11
"00000001","01010000","01110000","00010010", --568 a&(!b11)
"00000001","10000010","01111000","00010010", --572 (!a)&b11
"00000001","11001111","00001000","00010011", --576 a11
"00101100","11000101","11111111","11100100", --580 jump to i--
"00000000","01000100","10010000","00010001", --584 b0-s[1]
"00100000","00010010","00000000","00001001", --588 output B in R18
"00000000","00100011","10011000","00010001", --592 a0-s[0]
"00000000","00010011","00000000","00001101", --596 output A in R19
"11111100","00000000","00000000","00000000"  --600
--dec end
);
begin


	 data_o <= Instruction(conv_integer(address_i)) & Instruction(conv_integer(address_i) + 1) & Instruction(conv_integer(address_i) + 2) & Instruction(conv_integer(address_i) + 3);
	 
end Behavioral;

