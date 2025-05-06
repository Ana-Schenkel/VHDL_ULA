library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ULA_tb is
end ULA_tb;

architecture Behavioral of ULA_tb is

component ULA

	Port( clk : in std_logic;
			button : in std_logic;
--			sw0     : in std_logic;
--			sw1     : in std_logic;
--			sw2     : in std_logic;
--			sw3     : in std_logic;
--			led0   : out std_logic;
--			led1   : out std_logic;
--			led2   : out std_logic;
--			led3   : out std_logic;
--			led4   : out std_logic;
--			led5   : out std_logic;
--			led6   : out std_logic;
--			led7   : out std_logic);
			switches : in std_logic_vector(3 downto 0);
			leds_out: out std_logic_vector(7 downto 0));

end component;

signal clk, button: std_logic;
--signal led0, led1, led2, led3, led4, led5, led6, led7: std_logic;
--signal sw0, sw1, sw2, sw3: std_logic;
signal leds: std_logic_vector(7 downto 0);
signal switches : std_logic_vector(3 downto 0);

begin

	dut: ULA port map	(
		clk => clk, 
		button => button,
		switches => switches,
		leds_out => leds);
		
--		sw0 => sw0,
--		sw1 => sw1,
--		sw2 => sw2,
--		sw3 => sw3,
--
--		led0 => led0,
--		led1 => led1,
--		led2 => led2,
--		led3 => led3,
--		led4 => led4,
--		led5 => led5,
--		led6 => led6,
--		led7 => led7);
   
	
-- Clock process definitions
clock_process :process
begin
     clk <= '0';
     wait for 1 ns;
     clk <= '1';
     wait for 1 ns;
end process;


-- Stimulus process
stim_proc: process
begin        
   -- hold reset state for 100 ns.
	
--	button <= '0';
--	sw3 <= '0'; sw2 <= '1'; sw1 <= '0'; sw0 <= '1';  -- switches <= "0101"
--	wait for 60 ns;
--
--	button <= '1';
--	wait for 60 ns;
--
--	button <= '0';
--	sw3 <= '0'; sw2 <= '0'; sw1 <= '1'; sw0 <= '1';  -- switches <= "1111"
--	wait for 60 ns;
--
--	button <= '1';
--	wait for 60 ns;
--
--	button <= '0';
--	sw3 <= '0'; sw2 <= '0'; sw1 <= '1'; sw0 <= '0';  -- switches <= "1110"
--	wait for 60 ns;
--
--	button <= '1';
--	wait for 60 ns;
--
--	button <= '0';
--	wait for 60 ns;
--
--	button <= '1';
--	wait for 60 ns;

	button <= '0';
	switches <= "0111";
	wait for 60 ns;
	button <= '1';
	wait for 60 ns;
	button <= '0';
	switches <= "1111";
	wait for 60 ns;
	button <= '1';
	wait for 60 ns;
	button <= '0';
	switches <= "0011";
	wait for 60 ns;
	button <= '1';
	wait for 60 ns;
	button <= '0';
	wait for 60 ns;
	button <= '1';
	wait for 60 ns;

	
   wait;
end process;
end Behavioral;
