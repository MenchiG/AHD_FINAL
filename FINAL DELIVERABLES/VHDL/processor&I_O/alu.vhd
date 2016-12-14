----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:58:58 10/18/2016 
-- Design Name: 
-- Module Name:    alu - Behavioral 
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
use work.NYU_P.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alucore is
    Port ( oprand1_i : in  STD_LOGIC_VECTOR (31 downto 0);
           oprand2_i : in  STD_LOGIC_VECTOR (31 downto 0);
           aluop_i : in  STD_LOGIC_VECTOR (2 downto 0);
			  alufun_i : in STD_LOGIC_VECTOR (2 downto 0);
			  aluresult_o : out STD_LOGIC_VECTOR (31 downto 0);
			  branch_o : out STD_LOGIC);
end alucore;

architecture Behavioral of alucore is

begin
process(aluop_i, alufun_i, oprand1_i, oprand2_i) 
	variable v_result : std_logic_vector(31 downto 0); 
begin
	aluresult_o <= (others =>'0');
	branch_o <= '0';
	v_result := (others =>'0');
	case aluop_i is
		when "000" =>
			case alufun_i is
			--add
				when AADD => aluresult_o <= oprand1_i + oprand2_i;
			--sub
				when ASUB => aluresult_o <= oprand1_i - oprand2_i;
			--and
				when AAND => aluresult_o <= oprand1_i and oprand2_i;
			--or
				when AOR => aluresult_o <= oprand1_i or oprand2_i;
			--nor
				when ANOR => aluresult_o <= oprand1_i nor oprand2_i;
				when others => Null;
				
			end case;
		when "001" =>
			aluresult_o <= oprand1_i + oprand2_i;
		--SHL
		when "010" =>
			case oprand2_i(4 downto 0) IS
				WHEN "00001" => aluresult_o <= oprand1_i(30 downto 0) & oprand1_i(31) ;
				WHEN "00010" => aluresult_o <= oprand1_i(29 downto 0) & oprand1_i(31 downto 30) ;
				WHEN "00011" => aluresult_o <= oprand1_i(28 downto 0) & oprand1_i(31 downto 29) ;
				WHEN "00100" => aluresult_o <= oprand1_i(27 downto 0) & oprand1_i(31 downto 28) ;
				WHEN "00101" => aluresult_o <= oprand1_i(26 downto 0) & oprand1_i(31 downto 27) ;
				WHEN "00110" => aluresult_o <= oprand1_i(25 downto 0) & oprand1_i(31 downto 26) ;
				WHEN "00111" => aluresult_o <= oprand1_i(24 downto 0) & oprand1_i(31 downto 25) ;
				WHEN "01000" => aluresult_o <= oprand1_i(23 downto 0) & oprand1_i(31 downto 24) ;
				WHEN "01001" => aluresult_o <= oprand1_i(22 downto 0) & oprand1_i(31 downto 23) ;
				WHEN "01010" => aluresult_o <= oprand1_i(21 downto 0) & oprand1_i(31 downto 22) ;
				WHEN "01011" => aluresult_o <= oprand1_i(20 downto 0) & oprand1_i(31 downto 21) ;
				WHEN "01100" => aluresult_o <= oprand1_i(19 downto 0) & oprand1_i(31 downto 20) ;
				WHEN "01101" => aluresult_o <= oprand1_i(18 downto 0) & oprand1_i(31 downto 19) ;
				WHEN "01110" => aluresult_o <= oprand1_i(17 downto 0) & oprand1_i(31 downto 18) ;
				WHEN "01111" => aluresult_o <= oprand1_i(16 downto 0) & oprand1_i(31 downto 17) ;
				WHEN "10000" => aluresult_o <= oprand1_i(15 downto 0) & oprand1_i(31 downto 16) ;
				WHEN "10001" => aluresult_o <= oprand1_i(14 downto 0) & oprand1_i(31 downto 15) ;
				WHEN "10010" => aluresult_o <= oprand1_i(13 downto 0) & oprand1_i(31 downto 14) ;
				WHEN "10011" => aluresult_o <= oprand1_i(12 downto 0) & oprand1_i(31 downto 13) ;
				WHEN "10100" => aluresult_o <= oprand1_i(11 downto 0) & oprand1_i(31 downto 12) ;
				WHEN "10101" => aluresult_o <= oprand1_i(10 downto 0) & oprand1_i(31 downto 11) ;
				WHEN "10110" => aluresult_o <= oprand1_i(9 downto 0) & oprand1_i(31 downto 10) ;
				WHEN "10111" => aluresult_o <= oprand1_i(8 downto 0) & oprand1_i(31 downto 9) ;
				WHEN "11000" => aluresult_o <= oprand1_i(7 downto 0) & oprand1_i(31 downto 8) ;
				WHEN "11001" => aluresult_o <= oprand1_i(6 downto 0) & oprand1_i(31 downto 7) ;
				WHEN "11010" => aluresult_o <= oprand1_i(5 downto 0) & oprand1_i(31 downto 6) ;
				WHEN "11011" => aluresult_o <= oprand1_i(4 downto 0) & oprand1_i(31 downto 5) ;
				WHEN "11100" => aluresult_o <= oprand1_i(3 downto 0) & oprand1_i(31 downto 4) ;
				WHEN "11101" => aluresult_o <= oprand1_i(2 downto 0) & oprand1_i(31 downto 3) ;
				WHEN "11110" => aluresult_o <= oprand1_i(1 downto 0) & oprand1_i(31 downto 2) ;
				WHEN "11111" => aluresult_o <= oprand1_i(0) & oprand1_i(31 downto 1) ;
				WHEN OTHERS => NULL;
			end case;
		--SHR
		when "011" =>
			case oprand2_i(4 downto 0) IS
				WHEN "00001" => aluresult_o <= oprand1_i(0) & oprand1_i(31 downto 1) ;
				WHEN "00010" => aluresult_o <= oprand1_i(1 downto 0) & oprand1_i(31 downto 2) ;
				WHEN "00011" => aluresult_o <= oprand1_i(2 downto 0) & oprand1_i(31 downto 3) ;
				WHEN "00100" => aluresult_o <= oprand1_i(3 downto 0) & oprand1_i(31 downto 4) ;
				WHEN "00101" => aluresult_o <= oprand1_i(4 downto 0) & oprand1_i(31 downto 5) ;
				WHEN "00110" => aluresult_o <= oprand1_i(5 downto 0) & oprand1_i(31 downto 6) ;
				WHEN "00111" => aluresult_o <= oprand1_i(6 downto 0) & oprand1_i(31 downto 7) ;
				WHEN "01000" => aluresult_o <= oprand1_i(7 downto 0) & oprand1_i(31 downto 8) ;
				WHEN "01001" => aluresult_o <= oprand1_i(8 downto 0) & oprand1_i(31 downto 9) ;
				WHEN "01010" => aluresult_o <= oprand1_i(9 downto 0) & oprand1_i(31 downto 10) ;
				WHEN "01011" => aluresult_o <= oprand1_i(10 downto 0) & oprand1_i(31 downto 11) ;
				WHEN "01100" => aluresult_o <= oprand1_i(11 downto 0) & oprand1_i(31 downto 12) ;
				WHEN "01101" => aluresult_o <= oprand1_i(12 downto 0) & oprand1_i(31 downto 13) ;
				WHEN "01110" => aluresult_o <= oprand1_i(13 downto 0) & oprand1_i(31 downto 14) ;
				WHEN "01111" => aluresult_o <= oprand1_i(14 downto 0) & oprand1_i(31 downto 15) ;
				WHEN "10000" => aluresult_o <= oprand1_i(15 downto 0) & oprand1_i(31 downto 16) ;
				WHEN "10001" => aluresult_o <= oprand1_i(16 downto 0) & oprand1_i(31 downto 17) ;
				WHEN "10010" => aluresult_o <= oprand1_i(17 downto 0) & oprand1_i(31 downto 18) ;
				WHEN "10011" => aluresult_o <= oprand1_i(18 downto 0) & oprand1_i(31 downto 19) ;
				WHEN "10100" => aluresult_o <= oprand1_i(19 downto 0) & oprand1_i(31 downto 20) ;
				WHEN "10101" => aluresult_o <= oprand1_i(20 downto 0) & oprand1_i(31 downto 21) ;
				WHEN "10110" => aluresult_o <= oprand1_i(21 downto 0) & oprand1_i(31 downto 22) ;
				WHEN "10111" => aluresult_o <= oprand1_i(22 downto 0) & oprand1_i(31 downto 23) ;
				WHEN "11000" => aluresult_o <= oprand1_i(23 downto 0) & oprand1_i(31 downto 24) ;
				WHEN "11001" => aluresult_o <= oprand1_i(24 downto 0) & oprand1_i(31 downto 25) ;
				WHEN "11010" => aluresult_o <= oprand1_i(25 downto 0) & oprand1_i(31 downto 26) ;
				WHEN "11011" => aluresult_o <= oprand1_i(26 downto 0) & oprand1_i(31 downto 27) ;
				WHEN "11100" => aluresult_o <= oprand1_i(27 downto 0) & oprand1_i(31 downto 28) ;
				WHEN "11101" => aluresult_o <= oprand1_i(28 downto 0) & oprand1_i(31 downto 29) ;
				WHEN "11110" => aluresult_o <= oprand1_i(29 downto 0) & oprand1_i(31 downto 30) ;
				WHEN "11111" => aluresult_o <= oprand1_i(30 downto 0) & oprand1_i(31) ;
				WHEN OTHERS => NULL;
			end case;
		--BLT
		when "100" => 
			v_result := oprand2_i - oprand1_i;
			if v_result(31) = '0' then
				branch_o <= '1';
			else 
				branch_o <= '0';
			end if;
			aluresult_o <= (others =>'0');
		--BEQ
		when "101" =>
			v_result := oprand1_i - oprand2_i;
			if v_result = x"00000000" then
				branch_o <= '1';
			else 
				branch_o <= '0';
			end if;
			aluresult_o <= (others =>'0');
		--BNE
		when "111" =>
			v_result := oprand1_i - oprand2_i;
			if v_result /= x"00000000" then
				branch_o <= '1';
			else 
				branch_o <= '0';
			end if;
			
		
		when others => Null;
	end case;
end process;
end Behavioral;

