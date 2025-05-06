-- Libraries required for the operation of the Debounce
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Description of the ULA inputs and outputs
entity ULA_debounce is

	 generic(delay: integer := 0); -- Clock delay constant
    
	 Port ( clk: in std_logic; -- Clock input
			  input: in std_logic; -- Button input
			  debounce: out std_logic); -- Debounced pulse output
	  
end ULA_debounce;

-- Description of the ULA_debounce behavior
architecture Behavioral of ULA_debounce is

	signal sample_pulse: std_logic := '0'; -- Signal that generates the delayed clock
	signal sample: std_logic_vector(9 downto 0) := "0001111000"; -- Signal that collects the input samples
	signal debounce_s: std_logic := '0'; -- Debounced pulse signal

begin

-- Links the signal of debounced pulse signal with the debounce output (outputs should be assigned outside the process)
debounce <= debounce_s;

process(clk) --Clock Divider

variable count: integer := 0; -- Clock cycle repetition counter

begin
	if (clk'event and clk = '1') then -- On the rising edge of the clock
		
		-- Waits for the number of cycle repetition defined in the delay to generate a pulse of the delayed clock
		if (count < delay) then
			count := count + 1;
			sample_pulse <= '0';
		else
			count := 0;
			sample_pulse <= '1';
		end if;
		
	end if;
end process;


process(clk) --Sampling Process
begin
	if (clk'event and clk = '1') then -- On the rising edge of the clock
		
		if (sample_pulse = '1') then -- On the delayed clock pulse
			sample(9 downto 1) <= sample(8 downto 0); -- Left Shift
			sample(0) <= input; -- Fills the next bit with the input value
		end if;
		
	end if;
end process;

process(clk) --Button Debouncing 

-- Debounced pulse generated control variable
variable flag: std_logic := '0';

begin
	if (clk'event and clk = '1') then -- On the rising edge of the clock
	
		if (sample = "1111111111") then --Active High Pulse Out, when the sample is stable at 1, button pressed
			
			if (flag = '0') then -- If no debounced pulse was generated in the previous clock cycle
				
				debounce_s <= '1'; -- Generates pulse
				flag := '1'; -- Registers pulse
			
			else -- If a debounced pulse was generated
				debounce_s <= '0'; -- Ends pulse
			end if;
			
		else -- If the sample is not stable at 1, button released
			debounce_s <= '0'; -- Does not generate a pulse
			flag := '0'; -- Registers that no pulse was generated
		end if;
		
	end if;
end process;

end Behavioral;
