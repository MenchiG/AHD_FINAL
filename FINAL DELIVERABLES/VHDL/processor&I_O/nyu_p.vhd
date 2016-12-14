----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:53:12 10/18/2016 
-- Design Name: 
-- Module Name:    lib - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


package  NYU_P is   


		TYPE CPUStateType is (ST_IDLE, ST_RUNNING, ST_HALT);

		constant  R_TypeInstr  : std_logic_vector(5 downto 0) := "000000";
		constant  ADDI         : std_logic_vector(5 downto 0) := "000001";
		constant  SUBI         : std_logic_vector(5 downto 0) := "000010";
		constant  ANDI         : std_logic_vector(5 downto 0) := "000011";
		constant  ORI          : std_logic_vector(5 downto 0) := "000100";
		constant  SHL          : std_logic_vector(5 downto 0) := "000101";
		constant  SHR          : std_logic_vector(5 downto 0) := "000110";
		constant  LW           : std_logic_vector(5 downto 0) := "000111";
		constant  SW           : std_logic_vector(5 downto 0) := "001000";
  		constant  BLT          : std_logic_vector(5 downto 0) := "001001";
  		constant  BEQ          : std_logic_vector(5 downto 0) := "001010";
  		constant  BNE          : std_logic_vector(5 downto 0) := "001011";
  		constant  JMP          : std_logic_vector(5 downto 0) := "001100";
  		constant  HAL          : std_logic_vector(5 downto 0) := "111111";


		constant AADD 	:std_logic_vector(2 downto 0) := "000";	
		constant ASUB 	:std_logic_vector(2 downto 0) := "001";
		constant AAND	:std_logic_vector(2 downto 0) := "010";	
		constant AOR 	:std_logic_vector(2 downto 0) := "011";	
		constant ANOR	:std_logic_vector(2 downto 0) := "100";
		
	COMPONENT NYU_TOP
	PORT(
		clk : IN std_logic;
		clr : IN std_logic;
		state : IN CPUStateType;
		inputRamAddr : IN std_logic_vector(31 downto 0);
		inputRamWrtData : IN std_logic_vector(31 downto 0);          
		ramData : OUT std_logic_vector(31 downto 0);
		halt : OUT std_logic;
		pc_o : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;	
	
	COMPONENT register_file is
	PORT(
		RdReg1_i : IN std_logic_vector(4 downto 0);
		RdReg2_i : IN std_logic_vector(4 downto 0);
		WrtReg_i : IN std_logic_vector(4 downto 0);
		WrtData_i : IN std_logic_vector(31 downto 0);
		WrtEnable_i : IN std_logic;
		clk : IN std_logic;
		clr : IN std_logic;          
		ReadData1_o : OUT std_logic_vector(31 downto 0);
		ReadData2_o : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT alucore is
	PORT(
		oprand1_i : IN std_logic_vector(31 downto 0);
		oprand2_i : IN std_logic_vector(31 downto 0);
		aluop_i : IN std_logic_vector(2 downto 0);
		alufun_i : IN std_logic_vector(2 downto 0);          
		aluresult_o : OUT std_logic_vector(31 downto 0);
		branch_o : out STD_LOGIC
		);
	END COMPONENT;

	COMPONENT datapath is
	PORT(
		clk : IN std_logic;
		clr : IN std_logic;
		rom_i : IN std_logic_vector(31 downto 0);
		ram_i : IN std_logic_vector(31 downto 0);
		aluop_i : IN std_logic_vector(2 downto 0);
		aluOpBSrc_i : in  STD_LOGIC;
		wrtEnble_i : IN std_logic;
		isItype_i : IN std_logic;
		isLoad_i : in  STD_LOGIC;
		isJump_i : IN std_logic;
		isHalt_i : in  STD_LOGIC;		
		PC_o : OUT std_logic_vector(31 downto 0);
		opCode_o : OUT std_logic_vector(5 downto 0);
		writeram_o : OUT std_logic_vector(31 downto 0);
		address_o : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT decoder is
	PORT(
		opcode_i : IN std_logic_vector(5 downto 0);          
		isItype_o : OUT std_logic;
		isLoad_o : OUT std_logic;
		isStore_o : OUT std_logic;
		wrtEnble_o : OUT std_logic;
		aluop_o : OUT std_logic_vector(2 downto 0);
		aluOpBSrc_o : OUT  STD_LOGIC;
		isHal_o : out STD_LOGIC;
		isJtype_o : OUT std_logic
		
		);
	END COMPONENT;

	COMPONENT RAM is
	PORT(
		clk : IN std_logic;
		clr : IN std_logic;
		address_i : IN std_logic_vector(31 downto 0);
		writedata_i : IN std_logic_vector(31 downto 0);
		readmem_i : IN std_logic;
		writemem_i : IN std_logic;          
		readdata_o : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	
	COMPONENT ROM is
	PORT(
		address_i : IN std_logic_vector(31 downto 0);          
		data_o : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

end NYU_P;


