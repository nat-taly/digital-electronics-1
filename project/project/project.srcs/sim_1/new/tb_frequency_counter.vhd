library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity tb_frequency_counter is
--  Port ( );
end tb_frequency_counter;

architecture Behavioral of tb_frequency_counter is

    COMPONENT frequency_counter
    PORT(
        HZ_CLK      : in std_logic;
        M_SIGNAL    : in std_logic;
        RESET       : in std_logic;
        
        F_OUT       : out std_logic_vector(27 downto 0)
    );
    END COMPONENT;

    --inputs
    signal clk : std_logic := '0';
    signal measured_signal : std_logic := '0';
    signal reset : std_logic := '0';

    --outputs   
    signal output_f : std_logic_vector(27 downto 0);

    -- set period for 1hz
    constant clk_period : time := 1000000000 ns;
    -- set period for measured signal
    constant measured_signal_period : time := 10 ns;

    begin

    uut: frequency_counter PORT MAP(
        HZ_CLK     => clk,
        M_SIGNAL    => measured_signal,
        RESET       => reset,
        F_OUT       => output_f
    );

    -- PROCESS
    clk_process : process
    begin 
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;
    

    -- PROCESS
    measured_process : process
    begin 
        measured_signal <= '0';
        wait for measured_signal_period / 2;
        measured_signal <= '1';
        wait for measured_signal_period / 2;
    end process;
    
    --STIMULUS PROCESS
    stim_proc : process
    begin
        wait for 100 ns;
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait;
    end process;

end Behavioral;
