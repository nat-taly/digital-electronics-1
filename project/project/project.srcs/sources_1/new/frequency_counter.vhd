LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

entity frequency_counter is
    port (
        HZ_CLK : in std_logic;
        
        -- measured signal
        M_SIGNAL : in std_logic;
        RESET : in std_logic;
        
        -- max measured value can be 2^27 - 1 => 134217727, change the width of the output signal if needed
        F_OUT : out std_logic_vector(27 downto 0)
    );
end frequency_counter;


architecture Behavioral of frequency_counter is
    signal count : unsigned (27 downto 0):=(others => '0');
    signal frequency_output : std_logic_vector(27 downto 0);

begin
    --counts rising edges of measured signals for 1 seconds, thus the number of rising edges corresponds to the frequency of input singal (M_SIGNAl)
    
    bintobcd : entity work.bin_to_bcd
        port map (
            clk => HZ_CLK,
            reset => RESET,
            binary_in => frequency_output
        );
    
    count_p : process(HZ_CLK, M_SIGNAL, RESET)
    begin
        if(RESET = '1') then
            count <=  (others => '0');
        elsif(rising_edge(HZ_CLK)) then
            F_OUT <= std_logic_vector(count);
            frequency_output <= std_logic_vector(count);
            count <=  (others => '0');
        elsif(rising_edge(M_SIGNAL)) then
            count <= count + 1;
        end if;
    end process;   
    
end Behavioral;