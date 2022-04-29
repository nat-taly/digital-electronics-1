------------------------------------------------------------
--
-- Driver for 8-character 7-segment display.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2020-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------
-- Entity declaration for display driver
--
--             +------------------+
--        -----|> clk             |
--        -----| reset            |
--             |       seg_o(6:0) |--/--
--        --/--| data0_i(3:0)     |  7
--        --/--| data1_i(3:0)     |
--        --/--| data2_i(3:0)     |
--        --/--| data3_i(3:0)     |
--        --/--| data4_i(3:0)     |
--        --/--| data5_i(3:0)     |
--        --/--| data6_i(3:0)     |
--        --/--| data7_i(3:0)     |
--          4  |        dig_o(7:0)|--/--
--             |                  |  8
--             +------------------+
--
-- Inputs:
--   clk
--   reset
--   dataX_i(3:0) -- Data values for individual digits
--
-- Outputs:
--   seg_o(6:0)   -- Cathode values for individual segments
--   dig_o(7:0)   -- Common anode signals to individual digits
--
------------------------------------------------------------

entity controler_7seg is
    port(
        clk     : in  std_logic;
        reset   : in  std_logic;
        
        bcd0_i : in  std_logic_vector(3 downto 0);
        bcd1_i : in  std_logic_vector(3 downto 0);
        bcd2_i : in  std_logic_vector(3 downto 0);
        bcd3_i : in  std_logic_vector(3 downto 0);
        bcd4_i : in  std_logic_vector(3 downto 0);
        bcd5_i : in  std_logic_vector(3 downto 0);
        bcd6_i : in  std_logic_vector(3 downto 0);
        bcd7_i : in  std_logic_vector(3 downto 0);
        
        seg_o   : out std_logic_vector(6 downto 0);
        dig_o   : out std_logic_vector(7 downto 0)
    );
end entity controler_7seg;

------------------------------------------------------------
-- Architecture declaration for display driver
------------------------------------------------------------
architecture Behavioral of controler_7seg is

    -- Internal clock enable
    signal s_en  : std_logic;
    -- Internal 3-bit counter for multiplexing 8 digits
    signal s_cnt : std_logic_vector(2 downto 0);
    -- Internal 6-bit value for 7-segment decoder
    signal s_number : std_logic_vector(3 downto 0);
    
begin
    --------------------------------------------------------
    -- Instance (copy) of clock_enable entity generates 
    -- an enable pulse every 4 ms
    clk_en0 : entity work.clock_enable
        generic map(
            g_MAX => 4    -- FOR SIMULATION, CHANGE THIS VALUE TO 4
            --g_MAX => 200000 -- FOR IMPLEMENTATION, KEEP THIS VALUE TO 400,000    
        )
        port map(
            clk   => clk,   -- Main clock
            reset => reset, -- Synchronous reset
            ce_o  => s_en
        );

    --------------------------------------------------------
    -- Instance (copy) of cnt_up_down entity performs a 3-bit
    -- up-down counter
    bin_cnt0 : entity work.cnt_up_down
        generic map(
            g_CNT_WIDTH => 3
        )
        port map(
            clk      => clk,        -- Main clock
            reset    => reset,      -- Synchronous reset
            en_i     => s_en,       -- Enable input
            cnt_up_i => '0',          -- Direction of the counter
            cnt_o    => s_cnt       -- Output of the counter 

        );

    --------------------------------------------------------
    -- Instance (copy) of alphabet_7seg entity performs a 7-segment
    -- display decoder
    number_7seg : entity work.number_7seg
        port map(
            number_i => s_number,
            seg_o => seg_o
        ); 

    --------------------------------------------------------
    -- p_mux:
    -- A sequential process that implements a multiplexer for
    -- selecting data for a single digit, a decimal point 
    -- signal, and switches the common anodes of each display.
    --------------------------------------------------------
    
    
    p_mux : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                s_number <= "1111";
                dig_o <= "11111110";
            else
                case s_cnt is
                    when "111" =>
                       s_number <= bcd7_i;
                        dig_o <= "01111111";

                    when "110" =>
                        s_number <= bcd6_i;
                        dig_o <= "10111111";

                    when "101" =>
                        s_number <= bcd5_i;
                        dig_o <= "11011111";

                    when "100" =>
                        s_number <= bcd4_i;
                        dig_o <= "11101111";

                    when "011" =>
                        s_number <= bcd3_i;
                        dig_o <= "11110111";
                        
                    when "010" =>
                        s_number <= bcd2_i;
                        dig_o <= "11111011";

                    when "001" =>
                        s_number <= bcd1_i;
                        dig_o <= "11111101";

                    when others =>
                        s_number <= bcd0_i;
                        dig_o <= "11111110";
                end case;
            end if;
        end if;
    end process p_mux;

end architecture Behavioral;
