----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:30:32 11/14/2023 
-- Design Name: 
-- Module Name:    FSM - Behavioral 
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM is
Port ( 	input : in STD_LOGIC_VECTOR (2 downto 0); --char
			clk : in std_logic;
			reset : in std_logic;
			state : out STD_LOGIC_VECTOR (6 downto 0) --estado, -- 5 primeiros bits são as letras, ultimos dois as vidas;
		);
end FSM;

architecture Behavioral of FSM is

signal st : STD_LOGIC_VECTOR (4 downto 0) := "00000";

signal lifes_cnt : unsigned (1 downto 0) := "11";
signal lifes : STD_LOGIC_VECTOR (1 downto 0);


begin

lifes(0) <= lifes_cnt(0);
lifes(1) <= lifes_cnt(1);
state <= st & lifes;

process (clk, reset, lifes_cnt, input, st) begin --71650
	if reset = '1' then
		lifes_cnt <= "11";
		st <= "00000";
	elsif rising_edge(clk) then
		if(lifes_cnt = 0) then 
			st <= "00000";
			lifes_cnt <= "11";
		else 
			case (input) is 
			when "111" =>
				--if st(4) = '1' then 
					--lifes_cnt <= lifes_cnt - 1;
					--else 
					st(4) <= '1';
				--end if;
			when "001" =>
				--if st(3) = '1' then 
					--lifes_cnt <= lifes_cnt - 1;
					--else 
					st(3) <= '1';
				--end if;
			when "110" =>
				--if st(2) = '1' then 
					--lifes_cnt <= lifes_cnt - 1;
					--else 
					st(2) <= '1';
				--end if;
			when "101" =>
				--if st(1) = '1' then 
					--lifes_cnt <= lifes_cnt - 1;
					--else 
					st(1) <= '1';
				--end if;
			when "000" =>
				--if st(0) = '1' then 
					--lifes_cnt <= lifes_cnt - 1;
					--else 
					st(0) <= '1';
			--	end if;
			when others =>
				lifes_cnt <= lifes_cnt - 1;
				
			end case;
			
		end if;
	end if;
end process;

end Behavioral;

