------------------------------------------------------------
--
-- Template for 4-digit 7-segment display driver testbench.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2020-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------
entity tb_controler_7seg is
    -- Entity of testbench is always empty
end entity tb_controler_7seg;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture testbench of tb_controler_7seg is

    -- Local constants
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    -- Local signals
    signal s_clk_100MHz : std_logic;
    signal s_reset : std_logic;
    
    signal s_bcd0 : std_logic_vector(3 downto 0);
    signal s_bcd1 : std_logic_vector(3 downto 0);
    signal s_bcd2 : std_logic_vector(3 downto 0);
    signal s_bcd3 : std_logic_vector(3 downto 0);
    signal s_bcd4 : std_logic_vector(3 downto 0);
    signal s_bcd5 : std_logic_vector(3 downto 0);
    signal s_bcd6 : std_logic_vector(3 downto 0);
    signal s_bcd7 : std_logic_vector(3 downto 0);
    
    signal s_seg   : std_logic_vector(6 downto 0);
    signal s_dig   : std_logic_vector(7 downto 0);

begin
    -- Connecting testbench signals with controler_7seg
    -- entity (Unit Under Test)

    uut_controler_7seg : entity work.controler_7seg
        port map(
            clk     => s_clk_100MHz,
            reset   => s_reset,
            bcd0_i => s_bcd0,
            bcd1_i => s_bcd1,
            bcd2_i => s_bcd2,
            bcd3_i => s_bcd3,
            bcd4_i => s_bcd4,
            bcd5_i => s_bcd5,
            bcd6_i => s_bcd6,
            bcd7_i => s_bcd7,
            
            seg_o   => s_seg,
            dig_o   => s_dig
        );


    --------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 750 ns loop -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

    --------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------
    p_reset_gen : process
    begin
        s_reset <= '0';
        wait for 12 ns;
         
        -- Reset activated
        s_reset <= '1';
        wait for 73 ns;
 
        -- Reset deactivated
        s_reset <= '0';
 
        wait;
    end process p_reset_gen;

    --------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
        s_bcd7 <= "0111";
        s_bcd6 <= "0110";
        s_bcd5 <= "0101";
        s_bcd4 <= "0100";
        s_bcd3 <= "0011";
        s_bcd2 <= "0010";
        s_bcd1 <= "0001";
        s_bcd0 <= "0000";
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
       
end architecture testbench;