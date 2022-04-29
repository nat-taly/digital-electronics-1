library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

------------------------------------------------------------
-- Entity declaration for display driver
--
--             +------------------+
--        -----|> clk             |
--        -----| reset            |
--             |                  |
--             |      bcd0_o(3:0) |--/--
--             |      bcd1_o(3:0) |--/--
--             |      bcd2_o(3:0) |--/--
--             |      bcd3_o(3:0) |--/--
--        --/--|      bcd4_o(3:0) |--/--
--   binary_in |      bcd5_o(3:0) |--/--
--        28   |      bcd6_o(3:0) |--/--
--             |      bcd7_o(3:0) |--/--
--             |                  |
--             |                  | 
--             +------------------+
--
-- Inputs:
--   clk
--   reset
--   binary_i(27:0) -- binary input from frequency counter
--
-- Outputs:
--   bcd outputs for every digit
--
------------------------------------------------------------

entity bin_to_bcd is
    port(
        clk : in std_logic; 
        reset: in std_logic;
        binary_in: in std_logic_vector(28-1 downto 0);
        
        bcd0_o : out std_logic_vector(3 downto 0);
        bcd1_o : out std_logic_vector(3 downto 0);
        bcd2_o : out std_logic_vector(3 downto 0);
        bcd3_o : out std_logic_vector(3 downto 0);
        bcd4_o : out std_logic_vector(3 downto 0);
        bcd5_o : out std_logic_vector(3 downto 0);
        bcd6_o : out std_logic_vector(3 downto 0);
        bcd7_o : out std_logic_vector(3 downto 0)
    );
end bin_to_bcd ;
 
 
architecture behaviour of bin_to_bcd is

    type states is (start, shift, done);
    signal state : states;
    signal state_next: states;
 
    signal binary : std_logic_vector(28-1 downto 0);
    signal binary_next: std_logic_vector(28-1 downto 0);
    signal bcds, bcds_reg, bcds_next: std_logic_vector(31 downto 0);
    
    --output register keep output constant during conversion
    signal bcds_out_reg, bcds_out_reg_next: std_logic_vector(31 downto 0);
    -- --need to keep track of shifts --need to keep track of shifts
    signal shift_counter, shift_counter_next: natural range 0 to 28;
   
    signal bcd0 : std_logic_vector(3 downto 0);
    signal bcd1 : std_logic_vector(3 downto 0);
    signal bcd2 : std_logic_vector(3 downto 0);
    signal bcd3 : std_logic_vector(3 downto 0);
    signal bcd4 : std_logic_vector(3 downto 0);
    signal bcd5 : std_logic_vector(3 downto 0);
    signal bcd6 : std_logic_vector(3 downto 0);
    signal bcd7 : std_logic_vector(3 downto 0);
     
begin

    contr_7seg : entity work.controler_7seg
        port map (
            clk => clk,
            reset => reset,
            bcd0_i => bcd0,
            bcd1_i => bcd1,
            bcd2_i => bcd2,
            bcd3_i => bcd3,
            bcd4_i => bcd4,
            bcd5_i => bcd5,
            bcd6_i => bcd6,
            bcd7_i => bcd7  
        );
    
    clk_set : process(clk, reset)
    begin
        -- if reset than binary number == 0 and outputs == 0
        if reset = '1' then
            binary <= (others => '0');
            bcds <= (others => '0');
            state <= start;
            bcds_out_reg <= (others => '0');
            shift_counter <= 0;
        elsif falling_edge(clk) then
            binary <= binary_next;
            bcds <= bcds_next;
            state <= state_next;
            bcds_out_reg <= bcds_out_reg_next;
            shift_counter <= shift_counter_next;
        end if;
    end process;
 
 
    convert: process(state, binary, binary_in, bcds, bcds_reg, shift_counter)
    begin
        state_next <= state;
        bcds_next <= bcds;
        binary_next <= binary;
        shift_counter_next <= shift_counter;
 
        case state is
            when start =>
                state_next <= shift;
                binary_next <= binary_in;
                bcds_next <= (others => '0');
                shift_counter_next <= 0;
            when shift =>
                if shift_counter = 28 then
                    state_next <= done;
                else
                    binary_next <= binary(28-2 downto 0) & 'L';
                    bcds_next <= bcds_reg(30 downto 0) & binary(28-1);
                    shift_counter_next <= shift_counter + 1;
                end if;
            when done =>
                state_next <= start;
        end case;
    end process;
    
    bcds_reg(31 downto 28) <= bcds(31 downto 28) + 3 when bcds(31 downto 28) > 4 else
                              bcds(31 downto 28);
    bcds_reg(27 downto 24) <= bcds(27 downto 24) + 3 when bcds(27 downto 24) > 4 else
                              bcds(27 downto 24);
    bcds_reg(23 downto 20) <= bcds(23 downto 20) + 3 when bcds(23 downto 20) > 4 else
                              bcds(23 downto 20);
    bcds_reg(19 downto 16) <= bcds(19 downto 16) + 3 when bcds(19 downto 16) > 4 else
                              bcds(19 downto 16);
    bcds_reg(15 downto 12) <= bcds(15 downto 12) + 3 when bcds(15 downto 12) > 4 else
                              bcds(15 downto 12);
    bcds_reg(11 downto 8)  <= bcds(11 downto 8) + 3 when bcds(11 downto 8) > 4 else
                              bcds(11 downto 8);
    bcds_reg(7 downto 4)   <= bcds(7 downto 4) + 3 when bcds(7 downto 4) > 4 else
                              bcds(7 downto 4);
    bcds_reg(3 downto 0)   <= bcds(3 downto 0) + 3 when bcds(3 downto 0) > 4 else
                              bcds(3 downto 0);
 
    bcds_out_reg_next <= bcds when state = done else bcds_out_reg;
 
    bcd7 <= bcds_out_reg(31 downto 28);
    bcd6 <= bcds_out_reg(27 downto 24);
    bcd5 <= bcds_out_reg(23 downto 20);
    bcd4 <= bcds_out_reg(19 downto 16);
    bcd3 <= bcds_out_reg(15 downto 12);
    bcd2 <= bcds_out_reg(11 downto 8);
    bcd1 <= bcds_out_reg(7 downto 4);
    bcd0 <= bcds_out_reg(3 downto 0);
    
    bcd7_o <= bcd7;
    bcd6_o <= bcd6;
    bcd5_o <= bcd5;
    bcd4_o <= bcd4;
    bcd3_o <= bcd3;
    bcd2_o <= bcd2;
    bcd1_o <= bcd1;
    bcd0_o <= bcd0;
    
    
end behaviour;