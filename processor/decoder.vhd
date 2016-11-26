----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:32:11 10/18/2016 
-- Design Name: 
-- Module Name:    decoder - Behavioral 
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
use work.nyu_p.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder is
    Port ( opcode_i : in  STD_LOGIC_VECTOR (5 downto 0);
			  isItype_o : out  STD_LOGIC;
           isLoad_o : out  STD_LOGIC;
           isStore_o : out  STD_LOGIC;
           wrtEnble_o : out  STD_LOGIC;
           aluop_o : out  STD_LOGIC_VECTOR (2 downto 0);
           aluOpBSrc_o : out  STD_LOGIC;
			  isHal_o : out STD_LOGIC;
           isJtype_o : out  STD_LOGIC);
end decoder;

architecture Behavioral of decoder is

begin
	
	process(opcode_i) is
	begin
		isLoad_o 	<= '0';
      isStore_o <= '0';
		isItype_o <= '0';
      wrtEnble_o <= '0';
      aluop_o 	<= "000";
		aluOpBSrc_o <= '0';
      isJtype_o 		<= '0';
		isHal_o <= '0';
		case opcode_i is
			when  R_TypeInstr => 
				wrtEnble_o <= '1';
				aluop_o 	<= "000";
				aluOpBSrc_o <= '0';
			when  ADDI => 
				wrtEnble_o <= '1';
				aluop_o 	<= "000"; 
				isItype_o <= '1';
				aluOpBSrc_o <= '1';
			when  SUBI =>
				wrtEnble_o <= '1';
				isItype_o <= '1';
				aluop_o 	<= "000"; 
				aluOpBSrc_o <= '1';
			when  ANDI =>
				wrtEnble_o <= '1';
				isItype_o <= '1';
				aluop_o 	<= "000";
				aluOpBSrc_o <= '1'; 
			when  ORI =>
				wrtEnble_o <= '1';
				isItype_o <= '1';
				aluop_o 	<= "000";
				aluOpBSrc_o <= '1';
			when  SHL => 
				wrtEnble_o <= '1';
				isItype_o <= '1';
				aluop_o 	<= "010";
				aluOpBSrc_o <= '1';
			when  SHR =>
				wrtEnble_o <= '1';
				isItype_o <= '1';
				aluop_o 	<= "011";
				aluOpBSrc_o <= '1';
			when  LW => 
				isLoad_o 	<= '1';
				isStore_o <= '0';
				isItype_o <= '1';
				wrtEnble_o <= '1';
				aluop_o 	<= "001"; 
				aluOpBSrc_o <= '1';
			when  SW => 
				isLoad_o  <= '0';
				isStore_o <= '1';
				isItype_o <= '1';
				wrtEnble_o <= '0';
				aluop_o 	<= "001";
				aluOpBSrc_o <= '1';

			when  BLT => 
				aluop_o 	<= "100"; 
				aluOpBSrc_o <= '0';
				isItype_o <= '1';
			when  BEQ => 
				aluop_o 	<= "101"; 
				aluOpBSrc_o <= '0';
				isItype_o <= '1';
			when  BNE => 
				aluop_o 	<= "111"; 
				aluOpBSrc_o <= '0';
				isItype_o <= '1';
			when  JMP => 
				isJtype_o <= '1'; 
			when  HAL => 
				isJtype_o <= '1'; 
				isHal_o <= '1';
			when others =>
		       NULL;
		end case;
	end process;


end Behavioral;

