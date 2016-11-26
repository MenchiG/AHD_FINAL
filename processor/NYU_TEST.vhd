--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:48:45 10/20/2016
-- Design Name:   
-- Module Name:   G:/ahd/NYU/NYU_TEST.vhd
-- Project Name:  NYU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: NYU_TOP
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
 
ENTITY NYU_TEST IS
END NYU_TEST;
 
ARCHITECTURE behavior OF NYU_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT NYU_TOP
    PORT(
         clk : IN  std_logic;
         clr : IN  std_logic
         --ram_o : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal clr : std_logic := '0';

 	--Outputs
   --signal ram_o : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: NYU_TOP PORT MAP (
          clk => clk,
          clr => clr
          --ram_o => ram_o
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
		clr <= '1';
      wait for 100 ns;	
		
		
		clr <= '0';
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
