----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:55:18 11/24/2023 
-- Design Name: 
-- Module Name:    LCD_senha - arq_LCD_senha 
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

entity LCD_senha is
generic (fclk: natural := 50_000_000); -- 50MHz , cristal do kit EE03
		port ( game_state    : in std_logic_vector(6 downto 0);
		       clk         :     in bit; 
				 RS, RW      :    out bit;
		       E           : buffer bit;  
		       DB          :    out bit_vector(7 downto 0)); 
end LCD_senha;

architecture arq_LCD_senha of LCD_senha is
	type state is (FunctionSetl, FunctionSet2, FunctionSet3,
	 FunctionSet4,FunctionSet5,FunctionSet6,FunctionSet7,FunctionSet8,FunctionSet9,FunctionSet10,FunctionSet11,FunctionSet12,
	 FunctionSet13,FunctionSet14,FunctionSet15,FunctionSet16,FunctionSet17,FunctionSet18,FunctionSet19,ClearDisplay, DisplayControl, EntryMode, 
	 WriteDatal, WriteData2, WriteData3, WriteData4, WriteData5,WriteData6,WriteData7,WriteData8,WriteData9,WriteData10,WriteData11,
	 WriteData12,SetAddress,SetAddress1, ReturnHome, forca_state1,forca_state2,forca_state3,forca_state4,forca_state5,forca_state6);
	
	signal pr_state, nx_state: state; 

signal gm_st: std_logic_vector(6 downto 0) := "0000000";


		
begin

gm_st <= game_state;

---—Clock generator (E->500Hz) :---------
		process (clk)
		variable count: natural range 0 to fclk/1000; 
		begin
			if (clk' event and clk = '1') then 
				count := count + 1;
				if (count=fclk/1000) then 
				 E <= not E; 
				 count := 0; 
				end if; 
			end if; 
		end process;

-----Lower section of FSM:---------------
		process (E) 
		begin
			if (E' event and E = '1') then 
			--	IF (rst= '0') THEN
				pr_state <= FunctionSetl; 
		--ELSE
		pr_state <= nx_state; 
		--END IF; 
		end if; 
		end process;
		
-----Upper section of FSX:---------------
		process (pr_state,gm_st) 
		begin
		case pr_state is

		when FunctionSetl => 
		RS<= '0'; RW<= '0'; 
		DB<= "00111000"; 
		nx_state <= FunctionSet2; 
		when FunctionSet2 => 
		RS<= '0'; RW<= '0'; 
		DB <= "00111000";
		nx_state <= FunctionSet3; 
		when FunctionSet3 => 
		RS <= '0'; RW<='0'; 
		DB <= "00111000"; 
		nx_state <= FunctionSet4;

		when   FunctionSet4   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet5;

		when   FunctionSet5   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet6;

		when   FunctionSet6   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet7;

		when   FunctionSet7   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet8;

		when   FunctionSet8   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet9;

		when   FunctionSet9   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet10;

		when   FunctionSet10   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet11;

		when   FunctionSet11   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet12;

		when   FunctionSet12   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet13;

		when   FunctionSet13   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet14;

		when   FunctionSet14   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet15;

		when   FunctionSet15   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet16;

		when   FunctionSet16   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet17;

		when   FunctionSet17   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet18;

		when   FunctionSet18   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet19;


		when   FunctionSet19   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= ClearDisplay ;



		when ClearDisplay =>
		RS<= '0'; RW<= '0';
		DB <= "00000001";
		nx_state   <=   DisplayControl; 
		when   DisplayControl   =>
		RS<= '0';   RW<=  '0';
		DB   <=  "00001100";
		nx_state <= EntryMode; 
		when EntryMode =>
		RS<= '0'; RW<= '0';
		DB <= "00000110";
		nx_state   <=  WriteDatal; 

		when  WriteDatal =>
		RS<=   '1';   RW <='0';
		DB   <=   "00100000";   --'ESCREVE UM ESPAÇO EM BRANCO
		nx_state <= SetAddress1; 

		when SetAddress1 =>
		RS<=   '0';   RW<=   '0';
		DB   <=  "10000101";   --COMANDO PARA POSICIONAR O CURSOR NA LINHA 2 COLUNA 6
		nx_state  <= forca_state1; 
	
		when forca_state1 =>
		RS<=   '1';   RW <='0';
		if (gm_st(6) = '1') then
		DB <= X"37";                  --'ESCREVE 7'
		else 
		DB <= X"5F";                  --'ESCREVE -'
		end if;
		nx_state  <= forca_state2; 
		
		when forca_state2 =>
		RS<=   '1';   RW <='0';
		if (gm_st(5) = '1') then
		DB <= X"31";                  --'ESCREVE 1'
		else 
		DB <= X"5F";                  --'ESCREVE -'
		end if;
		nx_state  <= forca_state3; 
		
		when forca_state3 =>
		RS<=   '1';   RW <='0';
		if (gm_st(4) = '1') then
		DB <= X"36";                  --'ESCREVE 6'
		else 
		DB <= X"5F";                  --'ESCREVE -'
		end if;
		nx_state  <= forca_state4; 
		
		when forca_state4 =>
		RS<=   '1';   RW <='0';
		if (gm_st(3) = '1') then
		DB <= X"35";                  --'ESCREVE 5'
		else 
		DB <= X"5F";                  --'ESCREVE -'
		end if;
		nx_state  <= forca_state5;
		
		when forca_state5 =>
		RS<=   '1';   RW <='0';
		if (gm_st(2) = '1') then
		DB <= X"30";                  --'ESCREVE 0'
		else 
		DB <= X"5F";                  --'ESCREVE -'
		end if;
		nx_state  <= forca_state6;
		
		when forca_state6 =>
		RS<=   '1';   RW <='0';
		if (gm_st(1 downto 0) = "00") then
			DB <= X"50";                  --'ESCREVE P'
		elsif (gm_st(6 downto 2) = "11111") then
			DB <= X"47";                  --'ESCREVE G'
		else 
			DB <= X"5F";                  --'ESCREVE -'
		end if;
		nx_state  <= ReturnHome;
		
		when WriteData2 =>
		RS<= '1'; RW<= '0';
		DB <= X"5F";                    --'-'
		nx_state <= WriteData3; 
		when WriteData3 =>
		RS<= '1'; RW<= '0';
		DB <= X"5F";                    --'-'
		nx_state  <= WriteData4; 
		when  WriteData4   =>
		RS<=   '1';   RW<=   '0';
		DB   <=  X"5F";                 --'-'
		nx_state  <= WriteData5; 

		when  WriteData5   =>
		RS<=   '1';   RW<=   '0';
		DB   <=  X"5F";                 --'-'
		nx_state  <= WriteData6;

		when  WriteData6   =>
		RS<=   '1';   RW<=   '0';
		DB   <=  X"5F";                 --'-'
		nx_state  <= SetAddress;
		
		when SetAddress =>

		RS<=   '0';   RW<=   '0';
		DB   <=  "11000101";   --COMANDO PARA POSICIONAR O CURSOR NA LINHA 2 COLUNA 6
		nx_state  <= WriteData7;

		when  WriteData7   =>
		RS<=   '1';   RW<=   '0';
		DB   <=  X"50";                 --'P'
		nx_state  <= WriteData8;

		when  WriteData8   =>
		RS<=   '1';   RW<=   '0';
		DB   <=  X"65";                 --'e'
		nx_state  <= WriteData9;

		
		when WriteData9 =>
		RS<= '1'; RW<= '0';
		DB <= X"72";                    --'r'
		nx_state <= WriteData10; 

		when WriteData10 =>
		RS<= '1'; RW<= '0';
		DB <= X"64";                    --'d'
		nx_state <= WriteData11; 


		when WriteData11 =>
		RS<= '1'; RW<= '0';
		DB <= X"65";                    --'e'
		nx_state <= WriteData12;

		when WriteData12 =>
		RS<= '1'; RW<= '0';
		DB <= X"75";                    --'u'
		nx_state <= ReturnHome;



		when   ReturnHome   =>
		RS<=   '0';   RW<=  '0';
		DB   <=  "10000000";
		nx_state <= WriteDatal; 
		end case; 
		end process;

end arq_LCD_senha;

