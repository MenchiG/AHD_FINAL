--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:20:33 12/13/2016
-- Design Name:   
-- Module Name:   C:/Users/limurui/NYU_processor/alutest.vhd
-- Project Name:  NYU_processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: datapath
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY alutest IS
END alutest;
 
ARCHITECTURE behavior OF alutest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT datapath
    PORT(
         clk : IN  std_logic;
         clr : IN  std_logic;
         rom_i : IN  std_logic_vector(31 downto 0);
         ram_i : IN  std_logic_vector(31 downto 0);
         aluop_i : IN  std_logic_vector(2 downto 0);
         aluOpBSrc_i : IN  std_logic;
         wrtEnble_i : IN  std_logic;
         isItype_i : IN  std_logic;
         isLoad_i : IN  std_logic;
         isJump_i : IN  std_logic;
         PC_o : OUT  std_logic_vector(31 downto 0);
         opCode_o : OUT  std_logic_vector(5 downto 0);
         writeram_o : OUT  std_logic_vector(31 downto 0);
         address_o : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal clr : std_logic := '0';
   signal rom_i : std_logic_vector(31 downto 0) := (others => '0');
   signal ram_i : std_logic_vector(31 downto 0) := (others => '0');
   signal aluop_i : std_logic_vector(2 downto 0) := (others => '0');
   signal aluOpBSrc_i : std_logic := '0';
   signal wrtEnble_i : std_logic := '0';
   signal isItype_i : std_logic := '0';
   signal isLoad_i : std_logic := '0';
   signal isJump_i : std_logic := '0';

 	--Outputs
   signal PC_o : std_logic_vector(31 downto 0);
   signal opCode_o : std_logic_vector(5 downto 0);
   signal writeram_o : std_logic_vector(31 downto 0);
   signal address_o : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: datapath PORT MAP (
          clk => clk,
          clr => clr,
          rom_i => rom_i,
          ram_i => ram_i,
          aluop_i => aluop_i,
          aluOpBSrc_i => aluOpBSrc_i,
          wrtEnble_i => wrtEnble_i,
          isItype_i => isItype_i,
          isLoad_i => isLoad_i,
          isJump_i => isJump_i,
          PC_o => PC_o,
          opCode_o => opCode_o,
          writeram_o => writeram_o,
          address_o => address_o
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		clr <= '0';
		wait for clk_period;
		clr <= '1';
--		oprand1_i <= X"00000001";
--		oprand1_i <= X"00000002";
		aluop_i <= "000";
--		alufun_i <= "000";
--      wait for 100 ns;	
		
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
