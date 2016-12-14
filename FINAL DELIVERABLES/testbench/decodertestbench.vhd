--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:00:39 12/13/2016
-- Design Name:   
-- Module Name:   C:/Users/limurui/NYU_processor/decodertestbench.vhd
-- Project Name:  NYU_processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: decoder
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
 
ENTITY decodertestbench IS
END decodertestbench;
 
ARCHITECTURE behavior OF decodertestbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT decoder
    PORT(
         opcode_i : IN  std_logic_vector(5 downto 0);
         isItype_o : OUT  std_logic;
         isLoad_o : OUT  std_logic;
         isStore_o : OUT  std_logic;
         wrtEnble_o : OUT  std_logic;
         aluop_o : OUT  std_logic_vector(2 downto 0);
         aluOpBSrc_o : OUT  std_logic;
         isHal_o : OUT  std_logic;
         isJtype_o : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal opcode_i : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal isItype_o : std_logic;
   signal isLoad_o : std_logic;
   signal isStore_o : std_logic;
   signal wrtEnble_o : std_logic;
   signal aluop_o : std_logic_vector(2 downto 0);
   signal aluOpBSrc_o : std_logic;
   signal isHal_o : std_logic;
   signal isJtype_o : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decoder PORT MAP (
          opcode_i => opcode_i,
          isItype_o => isItype_o,
          isLoad_o => isLoad_o,
          isStore_o => isStore_o,
          wrtEnble_o => wrtEnble_o,
          aluop_o => aluop_o,
          aluOpBSrc_o => aluOpBSrc_o,
          isHal_o => isHal_o,
          isJtype_o => isJtype_o
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
-- 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		opcode_i <= "000010";
      wait for 100 ns;	



--      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
