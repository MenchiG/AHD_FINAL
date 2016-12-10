----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:21:34 10/18/2016 
-- Design Name: 
-- Module Name:    datapath - Behavioral 
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
use work.nyu_p.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity datapath is
    Port ( clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           rom_i : in  STD_LOGIC_VECTOR (31 downto 0);
           ram_i : in  STD_LOGIC_VECTOR (31 downto 0);
           aluop_i : in  STD_LOGIC_VECTOR (2 downto 0);
           aluOpBSrc_i : in  STD_LOGIC;
		   wrtEnble_i : in  STD_LOGIC;
		   isItype_i : in  STD_LOGIC;
		   isLoad_i : in  STD_LOGIC;
		   isJump_i : in  STD_LOGIC;
			isHalt_i : in  STD_LOGIC;
           PC_o : out  STD_LOGIC_VECTOR (31 downto 0);
           opCode_o : out  STD_LOGIC_VECTOR (5 downto 0);
           writeram_o : out  STD_LOGIC_VECTOR (31 downto 0);
           address_o : out  STD_LOGIC_VECTOR (31 downto 0));
			  
end datapath;

architecture Behavioral of datapath is
    signal	s_WriteRegA	: std_logic_vector(4  downto 0);
	 signal	s_WriteData	: std_logic_vector(31 downto 0);
	 signal	s_ReadData1	: std_logic_vector(31 downto 0);
	 signal	s_ReadData2	: std_logic_vector(31 downto 0);
	 signal s_SignExt15to0	: std_logic_vector(31 downto 0);
	 signal s_RomData	: std_logic_vector(31 downto 0);
	 signal	s_ALUfunc	: std_logic_vector(2 downto 0);
	 signal	s_ALUOpB		: std_logic_vector(31 downto 0);
	 signal	s_ALUOut		: std_logic_vector(31 downto 0); 
	 signal s_isBranchPC 	: std_logic;   
	 signal s_PC			: std_logic_vector(31 downto 0);
	 signal s_PCplus4	:	std_logic_vector(31 downto 0);
	 signal	s_BranchPC	: std_logic_vector(31 downto 0);
	 signal	s_JumpPC		: std_logic_vector(31 downto 0);
begin
		Regs_file : register_file
		port map(  
		     RdReg1_i 		=> s_RomData(25 downto 21),
	       	 RdReg2_i 		=> s_RomData(20 downto 16), 
			 WrtReg_i 		=> s_WriteRegA,
			 WrtData_i		=> s_WriteData,
			 WrtEnable_i	=> wrtEnble_i,	
			 clk      		=> clk,
			 clr	    	=> clr,
			 ReadData1_o	=> s_ReadData1, 
			 ReadData2_o	=> s_ReadData2);
		
		ALU : alucore
		port map(
			oprand1_i 		=> s_ReadData1,
			oprand2_i 		=> s_ALUOpB,
			aluop_i 		=> aluop_i,
			alufun_i 		=> s_ALUfunc,        
			aluresult_o 	=> s_ALUOut,
			branch_o 		=> s_isBranchPC);

		s_RomData <= rom_i;

		opCode_o <= s_RomData(31 downto 26);

		address_o <= s_ALUOut;
		writeram_o <= s_ReadData2;

		s_WriteRegA <= s_RomData(15 downto 11) when isItype_i = '0' else    
					   s_RomData(20 downto 16);								
		
		s_SignExt15to0 <= 	"0000000000000000" & s_RomData(15 downto 0) when s_RomData(15) = '0' else
							"1111111111111111" & s_RomData(15 downto 0);
		
		

		with s_RomData(29 downto 26) select
			s_ALUfunc <= 	s_RomData(2 downto 0) when  "0000",
							AADD when "0001",
							ASUB when "0010",
							AAND when "0011",
							AOR  when "0100",
							"001" when OTHERS;



		s_ALUOpB <= s_ReadData2 when aluOpBSrc_i = '0' else
					s_SignExt15to0;

		s_WriteData <= s_ALUOut when isLoad_i = '0' else
					ram_i;


		s_PCplus4 <= s_PC + 4;

		s_BranchPC <= s_PCplus4 + (s_SignExt15to0(29 downto 0) & "00") when s_isBranchPC = '1' else
					  s_PCplus4;


		s_JumpPC <= s_PCplus4(31 downto 28) & s_RomData(25 downto 0) & "00" when isJump_i = '1' else
					s_BranchPC;

		PC_o <= s_PC;



		updatePC : process(clr,clk) begin
		if clr = '1' then
			   s_PC <= (others=>'0') ;
         elsif clk'event and clk = '1'then
				if isHalt_i = '1' then
					s_PC <= s_PC;
				else
					s_PC <= s_JumpPC;
				end if;
         end if;
        end process;
			
end Behavioral;

