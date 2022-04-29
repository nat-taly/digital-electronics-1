
library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------
entity tb_number_7seg is
    -- Entity of testbench is always empty
end entity tb_number_7seg;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture testbench of tb_number_7seg is

    -- Local signals
    signal s_number  : std_logic_vector(4 - 1 downto 0);
    signal s_seg  : std_logic_vector(7 - 1 downto 0);

begin
    -- Connecting testbench signals with decoder entity
    -- (Unit Under Test)
    uut_7seg : entity work.number_7seg
        port map(
            number_i => s_number,
            seg_o => s_seg
        );

    --------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;

        -- First test case - 0
        s_number <= "0000"; wait for 25 ns;
        assert (s_seg = "0000001")
        report "Input combination 000000 FAILED" severity error;

        -- Test case - 1
        s_number <= "0001"; wait for 25 ns;
        assert (s_seg = "1001111")
        report "Input combination 0001 FAILED" severity error;

        -- Test case - 2
        s_number <= "0010"; wait for 25 ns;
        assert (s_seg = "0010010")
        report "Input combination 000010 FAILED" severity error;

        -- Test case - 3
        s_number <= "0011"; wait for 25 ns;
        assert (s_seg = "0000110")
        report "Input combination 000011 FAILED" severity error;

        -- Test case - 4
        s_number <= "0100"; wait for 25 ns;
        assert (s_seg = "1001100")
        report "Input combination 000100 FAILED" severity error;
        
        -- Test case - 5
        s_number <= "0101"; wait for 25 ns;
        assert (s_seg = "0100100")
        report "Input combination 000101 FAILED" severity error;

        -- Test case - 6
        s_number <= "0110"; wait for 25 ns;
        assert (s_seg = "0100000")
        report "Input combination 000110 FAILED" severity error;

        -- Test case - 7
        s_number <= "0111"; wait for 25 ns;
        assert (s_seg = "0001111")
        report "Input combination 000111 FAILED" severity error;

        -- Test case - 8
        s_number <= "1000"; wait for 25 ns;
        assert (s_seg = "0000000")
        report "Input combination 001000 FAILED" severity error;

        -- Test case - 9
        s_number <= "1001"; wait for 25 ns;
        assert (s_seg = "0000100")
        report "Input combination 001001 FAILED" severity error;
        wait for 25 ns;
    end process p_stimulus;
end architecture testbench;