library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    Port ( 
        -- clock, measured signal and reset button
        CLK100MHz : in STD_LOGIC;
        M_SIGNAL : in STD_LOGIC;
        BTNC : in STD_LOGIC;
        
        --outputs (all segments and all anodes (8 digits))
        CA : out STD_LOGIC;
        CB : out STD_LOGIC;
        CC : out STD_LOGIC;
        CD : out STD_LOGIC;
        CE : out STD_LOGIC;
        CF : out STD_LOGIC;
        CG : out STD_LOGIC;
        DP : out STD_LOGIC;
        AN : out std_logic_vector(7 downto 0)
     );
end entity top;

architecture Behavioral of top is
    signal s_number : std_logic_vector(3 downto 0);

begin

   freq_count : entity work.frequency_counter
      port map(
          HZ_CLK   => CLK100MHZ, 
          M_SIGNAL => M_SIGNAL,
          RESET  => BTNC
       );  
       

   AN <= b"0000_0000";
       
end Behavioral;
