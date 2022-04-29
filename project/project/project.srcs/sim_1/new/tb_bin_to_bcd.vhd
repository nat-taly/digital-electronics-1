LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_bin_to_bcd IS
END tb_bin_to_bcd;
 
ARCHITECTURE behavior OF tb_bin_to_bcd IS
 
    --Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT bin_to_bcd
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         binary_in : IN  std_logic_vector(28-1 downto 0);
        
         bcd0_o : OUT  std_logic_vector(3 downto 0);
         bcd1_o : OUT  std_logic_vector(3 downto 0);
         bcd2_o : OUT  std_logic_vector(3 downto 0);
         bcd3_o : OUT  std_logic_vector(3 downto 0);
         bcd4_o : OUT  std_logic_vector(3 downto 0);
         bcd5_o : OUT  std_logic_vector(3 downto 0);
         bcd6_o : OUT  std_logic_vector(3 downto 0);
         bcd7_o : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
 
   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal binary_in : std_logic_vector(28-1 downto 0) := (others => '0');
 
    --Outputs
   signal bcd0_o : std_logic_vector(3 downto 0);
   signal bcd1_o : std_logic_vector(3 downto 0);
   signal bcd2_o : std_logic_vector(3 downto 0);
   signal bcd3_o : std_logic_vector(3 downto 0);
   signal bcd4_o : std_logic_vector(3 downto 0);
   signal bcd5_o : std_logic_vector(3 downto 0);
   signal bcd6_o : std_logic_vector(3 downto 0);
   signal bcd7_o : std_logic_vector(3 downto 0);
 
   --Clock period definitions
   constant clk_period : time := 5 ns;
  
begin
 
     --Instantiate the Unit Under Test (UUT)
   uut: bin_to_bcd PORT MAP (
          clk => clk,
          reset => reset,
          binary_in => binary_in,
          
          bcd0_o => bcd0_o,
          bcd1_o => bcd1_o,
          bcd2_o => bcd2_o,
          bcd3_o => bcd3_o,
          bcd4_o => bcd4_o,
          bcd5_o => bcd5_o,
          bcd6_o => bcd6_o,
          bcd7_o => bcd7_o
        );
 
   --Clock process definitions
   clk_process :process
   begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
   end process;
 
   --Stimulus process
   stim_proc: process
   begin
      --hold reset state for 100 ns.
        reset <= '1';
      wait for 5 ns;
        reset <= '0';
 
      binary_in <= "0101111101011110000011111111";
      wait for 200 ns;
      binary_in <= "0011011110110100010100010000";
      wait for 200 ns;
      binary_in <= "0000000011010100011101110000";
      wait for 200 ns;
 
    end process;
 
END;