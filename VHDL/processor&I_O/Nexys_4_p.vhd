----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:58:21 10/21/2016 
-- Design Name: 
-- Module Name:    Nexys_4_p - Behavioral 
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

package Nexys_4_p is
	TYPE StateType is (ST_IDLE, ST_EXP, ST_ENC, ST_DEC);
	
	COMPONENT Nexys_4_sevenseg is
	PORT(
		display : IN std_logic_vector(31 downto 0);
		clk : IN std_logic;          
		seg : OUT std_logic_vector(6 downto 0);
		an : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	


end Nexys_4_p;


