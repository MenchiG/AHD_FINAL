----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:20:31 12/06/2016 
-- Design Name: 
-- Module Name:    Final_TOP - Behavioral 
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
use work.nyu_p.ALL;
use WORK.Nexys_4_p.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Final_TOP is
	PORT(
		clk : in  STD_LOGIC;
		
		lo : IN std_logic;
		hi : IN std_logic;
		wrtToRam : IN std_logic;
		rst : IN std_logic;
		run : IN std_logic;
		
		sw : IN std_logic_vector(15 downto 0);          

      seg : out  STD_LOGIC_VECTOR (6 downto 0);
      an : out  STD_LOGIC_VECTOR (7 downto 0);
		led : out STD_LOGIC_VECTOR (15 downto 0)
		);
end Final_TOP;

architecture Behavioral of Final_TOP is
SIGNAL	cpuState : CPUStateType;
SIGNAL	ram_clk : STD_LOGIC;
SIGNAL	cpu_clk : STD_LOGIC;

SIGNAL	div_clk : STD_LOGIC_vector(3 downto 0);

SIGNAL	s_inputRamAddr : std_logic_vector(31 downto 0);
SIGNAL	s_inputRamWrtData : std_logic_vector(31 downto 0);
SIGNAL	s_ramData : std_logic_vector(31 downto 0);
SIGNAL	s_halt : STD_LOGIC;
signal 	s_pc : std_logic_vector(31 downto 0);
signal 	s_display : std_logic_vector(31 downto 0);
begin

	Inst_NYU_TOP: NYU_TOP PORT MAP(
		clk => cpu_clk,
		clr => rst,
		state => cpuState,
		inputRamAddr => s_inputRamAddr,
		inputRamWrtData => s_inputRamWrtData,
		ramData => s_ramData,
		halt => s_halt,
		pc_o => s_pc
	);
	
	Inst_Nexys_4_sevenseg: Nexys_4_sevenseg PORT MAP(
		display => s_display,
		clk => clk,
		seg => seg,
		an => an
	);
	
	clockDivider: process(clk)
   begin
		IF(rst = '1') THEN 
			div_clk <= (others => '0');
		ELSE
			if clk'event and clk = '1' then
				div_clk <= div_clk + '1';
			end if;
		end if;
   end process clockDivider;
	
	hi_lo_p : process(rst, lo, hi) begin
		IF(rst = '1') THEN 
			s_inputRamWrtData <= (others => '0');
		ELSE
			if lo'EVENT and lo = '1' then
				s_inputRamWrtData(15 downto 0) <= sw;
			elsif hi'EVENT and hi = '1' then
				s_inputRamWrtData(31 downto 16) <= sw;
			end if;
		end if;
	end process hi_lo_p;
	
	wrtToRam_p : process(rst, wrtToRam) begin
		IF(rst = '1') THEN 
			ram_clk <= '0';
		ELSE
			if wrtToRam'EVENT and wrtToRam = '1' then
				if(ram_clk = '0') then
					ram_clk <= '1';
				else
					ram_clk <= '0';
				end if;
			end if;
		end if;
	end process wrtToRam_p;
	
	run_p : process(rst, run) begin
		IF(rst = '1') THEN 
			cpuState <= ST_IDLE;
		ELSE
			if run'EVENT and run = '1' then
				if cpuState = ST_IDLE then
					cpuState <= ST_RUNNING;
				elsif cpuState = ST_RUNNING and s_halt = '1' then
					cpuState <= ST_HALT;
				end if;
			end if;
		end if;
	end process run_p;
	
	
cpu_clk <= div_clk(3) when cpuState = ST_RUNNING else
			  ram_clk;
				
With cpuState SELECT
	s_display <= s_inputRamWrtData WHEN ST_IDLE,
					 s_pc WHEN ST_RUNNING,
					 s_ramData WHEN ST_HALT,
					 unaffected when others;
				 
s_inputRamAddr <= x"0000" & sw;

led(0) <= ram_clk;
led(1) <= '1' when cpuState = ST_IDLE else
			 '0';
led(2) <= '1' when cpuState = ST_RUNNING else
			 '0';
led(3) <= '1' when cpuState = ST_HALT else
			 '0';	
led(4) <= '1' when s_halt = '1' else
			 '0';			 			 
led(15 downto 5) <= (others => '0');	
end Behavioral;

