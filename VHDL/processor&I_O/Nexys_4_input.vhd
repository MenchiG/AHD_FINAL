----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:25:21 10/21/2016 
-- Design Name: 
-- Module Name:    Input - Behavioral 
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
use WORK.Nexys_4_p.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity  Nexys_4_input is
    Port ( func : in  STD_LOGIC;
           wrt : in STD_LOGIC;
			  addr_inc : in STD_LOGIC;
           rst : in  STD_LOGIC;
			  run : in STD_LOGIC;
			  
           sw : in  STD_LOGIC_VECTOR (15 downto 0);
			  
			  key : out STD_LOGIC_VECTOR (127 downto 0);
           key_vld : out  STD_LOGIC;
			  enc : out STD_LOGIC;
           data_vld : out  STD_LOGIC;
           din : out  STD_LOGIC_VECTOR (63 downto 0);
			  
			  addr : out STD_LOGIC_VECTOR (2 downto 0);
			  state_o : out StateType);
			  
end Nexys_4_input;

architecture Behavioral of Nexys_4_input is
	
	
	SIGNAL state : StateType;
	
	SIGNAL s_key : STD_LOGIC_VECTOR (127 downto 0);
	SIGNAL s_data: STD_LOGIC_VECTOR (63 downto 0);
	
	SIGNAL key_addr : STD_LOGIC_VECTOR (2 downto 0);
	SIGNAL data_addr : STD_LOGIC_VECTOR (1 downto 0);
	
begin

	FSM: process(rst, func) begin
	
		IF(rst = '1') THEN 
			state <= ST_IDLE;
		ELSE
			if func'EVENT and func = '1' then
				case sw(1 downto 0) IS
					when "00" => state <= ST_IDLE;
					when "01" => state <= ST_ENC;
					when "10" => state <= ST_DEC;
					when "11" => state <= ST_EXP;
					when others => state <= ST_IDLE;
				END case;
			end if;
		end if;
	
	end process FSM;
	
	run_p : process(rst, run) begin
	
		IF(rst = '1') THEN 
			key_vld <= '0';
			data_vld <= '0';
		ELSE
			if run'EVENT and run = '1' then
				if (state = ST_EXP) then
					key_vld <= '1';
				elsif (state = ST_ENC or state = ST_DEC) then
					data_vld <= '1';
				elsif (state = ST_IDLE) then
					--key_vld <= '0';
				   data_vld <= '0';
				end if;
			end if;
		end if;
	end process run_p;
	
	
		
	addr_inc_p : process(rst, addr_inc) begin
	
		IF(rst = '1') THEN 
			key_addr <= "000";
			data_addr <= "00";
		ELSE
			if addr_inc'EVENT and addr_inc = '1' then
				if (state = ST_EXP) then
					key_addr <= key_addr + 1;
				elsif (state = ST_ENC or state = ST_DEC) then
					data_addr <= data_addr + 1;
				end if;
			end if;
		end if;
	end process addr_inc_p;
	
	
	wrt_p : process(rst, wrt) begin
	
		IF(rst = '1') THEN 
			s_key <= (others => '0');
			s_data <= (others => '0');
		ELSE
			if wrt'EVENT and wrt = '1' then
				if (state = ST_EXP) then
					case key_addr IS
						when "000" => s_key (15 downto 0)  <= sw;
						when "001" => s_key (31 downto 16) <= sw;
						when "010" => s_key (47 downto 32) <= sw;
						when "011" => s_key (63 downto 48) <= sw;
						when "100" => s_key (79 downto 64) <= sw;
						when "101" => s_key (95 downto 80) <= sw;
						when "110" => s_key (111 downto 96) <= sw;
						when "111" => s_key (127 downto 112) <= sw;
						when others => s_key <= (others => '0');
					END case;
				elsif (state = ST_ENC or state = ST_DEC) then
					case data_addr IS
						when "00" => s_data (15 downto 0)  <= sw;
						when "01" => s_data (31 downto 16) <= sw;
						when "10" => s_data (47 downto 32) <= sw;
						when "11" => s_data (63 downto 48) <= sw;
						when others => s_data <= (others => '0');
					END case;
				end if;
			end if;
		end if;
	end process wrt_p;
	
	WITH state SELECT
		addr <= key_addr WHEN ST_EXP,
			  ('0' & data_addr) WHEN ST_ENC | ST_DEC,
			  "000" When others;
			  
	din <= s_data;
	key <= s_key;
	
	WITH state SELECT
		enc <= '1' WHEN ST_ENC,
			    '0' When others;
				 
				 
	 state_o <= state;
end Behavioral;

