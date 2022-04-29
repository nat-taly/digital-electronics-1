------------------------------------------------------------
--
-- 7-segment display decoder
-- Nexys A7-50T, Vivado v2020.1, EDA Playground
--
-- Copyright (c) 2018-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

------------------------------------------------------------
-- Entity declaration for seven7-segment display decoder
------------------------------------------------------------
entity number_7seg is
    Port ( number_i : in STD_LOGIC_VECTOR (3 downto 0);
           seg_o : out STD_LOGIC_VECTOR (6 downto 0));
end number_7seg;

------------------------------------------------------------
-- Architecture body for seven-segment display decoder
------------------------------------------------------------
architecture Behavioral of number_7seg is
begin
    --------------------------------------------------------
    -- p_7seg_decoder:
    -- A combinational process for 7-segment display (Common
    -- Anode) decoder. Any time "hex_i" is changed, the process
    -- is "executed". Output pin seg_o(6) controls segment A,
    -- seg_o(5) segment B, etc.
    --       segment A
    --        | segment B
    --        |  | segment C
    --        +-+|  |   ...   segment G
    --          ||+-+          |
    --          |||            |
    -- seg_o = "0000001"-------+
    --------------------------------------------------------
    p_7seg_decoder : process(number_i)
    begin
        case number_i is
            when "0000" =>
                seg_o <= "0000001"; -- 0
            when "0001" =>
                seg_o <= "1001111"; -- 1
            when "0010" =>
                seg_o <= "0010010"; -- 2
            when "0011" =>
                seg_o <= "0000110"; -- 3
            when "0100" =>
                seg_o <= "1001100"; -- 4
            when "0101" =>
                seg_o <= "0100100"; -- 5
            when "0110" =>
                seg_o <= "0100000"; -- 6
            when "0111" =>
                seg_o <= "0001111"; -- 7
            when "1000" =>
                seg_o <= "0000000"; -- 8
            when "1001" =>
                seg_o <= "0000100"; -- 9
            when others =>
                seg_o <= "1111111"; -- blank space (other values)
        end case;
    end process p_7seg_decoder;

end architecture Behavioral;
