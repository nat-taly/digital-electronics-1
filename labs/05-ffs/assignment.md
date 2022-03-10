# Lab 5: NATALIE VYCHODILOVA

### Flip-flops

1. Listing of VHDL architecture for T-type flip-flop. Always use syntax highlighting, meaningful comments, and follow VHDL guidelines:

```vhdl
architecture Behavioral of t_ff_rst is
signal s_q : std_logic;
signal s_q_bar : std_logic;
begin
    p_t_ff_rst : process(clk)
    begin
        if rising_edge(clk) then  -- Synchronous process
            if(rst='1') then 
                s_q     <= '0';
                s_q_bar <= '1';
            else
                if(t='0') then
                    s_q <= s_q;
                    s_q_bar <= s_q_bar;
                else
                    s_q <= not s_q;
                    s_q_bar <= not s_q_bar;
            end if;  
            end if;   
        end if;
        
    end process p_t_ff_rst;
end architecture Behavioral;
```

2. Screenshot with simulated time waveforms. Try to simulate both flip-flops in a single testbench with a maximum duration of 200 ns, including reset. Always display all inputs and outputs (display the inputs at the top of the image, the outputs below them) at the appropriate time scale!

   ![your figure]()

### Shift register

1. Image of the shift register `top` level schematic. The image can be drawn on a computer or by hand. Always name all inputs, outputs, components and internal signals!

   ![your figure]()
