----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:58:54 10/19/2016 
-- Design Name: 
-- Module Name:    NYU_TOP - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.all;

use work.nyu_p.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NYU_TOP is 
	port( clk : in STD_LOGIC;
			clr : in STD_LOGIC;
			
			pc_o : out STD_LOGIC_VECTOR(31 downto 0)
			
			);
end NYU_TOP;

architecture Behavioral of NYU_TOP is

		
		signal   s_Opcode:  std_logic_vector(5 downto 0);
		signal   s_isItype:  std_logic;
		signal   s_isLoad:  std_logic;
		signal   s_isStore:  std_logic;
		signal   s_wrtEnble:  std_logic;
		signal   s_aluop:  std_logic_vector(2 downto 0);
		signal   s_aluOpBSrc: std_logic;
		signal   s_isJtype:  std_logic;
		signal 	s_ramData : std_logic_vector(31 downto 0);
		signal 	s_ramWrtData : std_logic_vector(31 downto 0);
		signal 	s_romData : std_logic_vector(31 downto 0);
		signal 	s_ramAddr : std_logic_vector(31 downto 0);
		signal 	s_romAddr : std_logic_vector(31 downto 0);
		signal	s_halt : std_logic;
		
begin
	
	NYU_decoder : decoder
		port map(
			opcode_i => s_Opcode,        
			isItype_o => s_isItype,
			isLoad_o => s_isLoad,
			isStore_o => s_isStore,
			wrtEnble_o => s_wrtEnble,
			aluop_o => s_aluop,
			aluOpBSrc_o => s_aluOpBSrc,
			isHal_o => s_halt,
			isJtype_o => s_isJtype);
			
	NYU_RAM : RAM
		port map(
			clk => clk,
			clr => clr,
			address_i => s_ramAddr,
			writedata_i => s_ramWrtData,
			readmem_i => s_isLoad,
			writemem_i => s_isStore,
			readdata_o => s_ramData);


	NYU_ROM : ROM
		port map(
			address_i => s_romAddr,       
			data_o => s_romData);

	NYU_datapath : datapath
		port map(
			clk => clk,
			clr => clr,
			rom_i => s_romData,
			ram_i => s_ramData,
			aluop_i => s_aluop,
			aluOpBSrc_i => s_aluOpBSrc,
			wrtEnble_i => s_wrtEnble,
			isItype_i => s_isItype,
			isLoad_i => s_isLoad,
			isJump_i => s_isJtype,          
			PC_o => s_romAddr,
			opCode_o => s_Opcode,
			writeram_o => s_ramWrtData,
			address_o => s_ramAddr);



pc_o <= s_romAddr;
end Behavioral;

