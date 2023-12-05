----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:25:21 11/14/2023 
-- Design Name: 
-- Module Name:    forca - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity forca is
    Port ( 	--controles do LCD :
				input : in STD_LOGIC_VECTOR (2 downto 0); --char
				botao : in std_logic;
				clk : in bit;
				reset : in std_logic;
				lifes : out  STD_LOGIC_VECTOR (2 downto 0);
				R_S, R_W : out bit;
		      E_B : buffer bit;  
		      D_B : out bit_vector(7 downto 0)
			);
end forca;

architecture Behavioral of forca is

component FSM is
Port ( 	input : in STD_LOGIC_VECTOR (2 downto 0); --char
			clk : in std_logic;
			reset : in std_logic;
			state : out STD_LOGIC_VECTOR (6 downto 0) --estado, -- 5 primeiros bits são as letras, ultimos dois as vidas;
		);
end component;

component LCD_senha is 
		generic (fclk: natural := 50_000_000); -- 50MHz , cristal do kit EE03
		port ( game_state  : in std_logic_vector(6 downto 0);
		       clk         :     in bit; 
				 RS, RW      :    out bit;
		       E           : buffer bit;  
		       DB          :    out bit_vector(7 downto 0)); 
end component;


signal st : std_logic_vector  (6 downto 0);
signal RS, RW, E: bit;
signal DB: bit_vector(7 downto 0);

begin

FSM_label : FSM port map (input, botao, reset, st);
LCD_senha_label : LCD_senha port map (st, clk, RS, RW, E, DB);
process (st) 
begin 
	if (st(1 downto 0) = "00") then
		lifes <= "000";
	elsif (st(1 downto 0) = "01") then
		lifes <= "001";
	elsif (st(1 downto 0) = "10") then
		lifes <= "011";
	else lifes <= "111";
	end if;
end process;

R_S <= RS;
R_W <= RW;
E_B <= E;
D_B <= DB;
end Behavioral;

