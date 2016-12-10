----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:28:15 10/17/2016 
-- Design Name: 
-- Module Name:    register_file - Behavioral 
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

entity register_file is
    Port ( RdReg1_i : in  STD_LOGIC_VECTOR (4 downto 0);
           RdReg2_i : in  STD_LOGIC_VECTOR (4 downto 0);
           WrtReg_i : in  STD_LOGIC_VECTOR (4 downto 0);
           WrtData_i : in  STD_LOGIC_VECTOR (31 downto 0);
           WrtEnable_i : in  STD_LOGIC;
           ReadData1_o : out  STD_LOGIC_VECTOR (31 downto 0);
           ReadData2_o : out  STD_LOGIC_VECTOR (31 downto 0);
			  clk : in STD_LOGIC;
			  clr : in STD_LOGIC);
end register_file;

architecture Behavioral of register_file is

TYPE regType IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL reg : regType;

begin
	readRegs: PROCESS(RdReg1_i,RdReg2_i, reg) BEGIN
		ReadData1_o <= reg(CONV_INTEGER(RdReg1_i));
		ReadData2_o <= reg(CONV_INTEGER(RdReg2_i));
	end PROCESS;
	
	writeRegs: PROCESS(clk,clr) BEGIN
		IF(clr = '1') THEN  
			FOR i IN 0 TO 31 LOOP
				reg(i) <= (others => '0');
			END LOOP;
		ELSIF (clk'EVENT AND clk='1') THEN
			IF (WrtEnable_i = '1') THEN 
				reg(CONV_INTEGER(WrtReg_i)) <= WrtData_i;
			END IF;
		END IF;
	END PROCESS;
end Behavioral;

