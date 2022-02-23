# Lab 2: NATALIE VYCHODILOVA

### 2-bit comparator

1. Karnaugh maps for other two functions:
   
   Greater than:

   ![K-maps](images/greater.png)

   Less than:

   ![K-maps](images/less.png)

2. Equations of simplified SoP (Sum of the Products) form of the "greater than" function and simplified PoS (Product of the Sums) form of the "less than" function.

   ![Logic functions](images/equal.png)

### 4-bit comparator

1. Listing of VHDL stimulus process from testbench file (`testbench.vhd`) with at least one assert (use BCD codes of your student ID digits as input combinations). Always use syntax highlighting, meaningful comments, and follow VHDL guidelines:

   Last two digits of my student ID: **230911**

```vhdl
    p_stimulus : process
    begin
        -- Report a note at the beginning of stimulus process
        report "Stimulus process started" severity note;

        
        -- My VUT ID: 230911
        s_b <= "0001"; -- 1 DEC to BCD -> 0001
        s_a <= "0001"; -- 1 DEC to BCD -> 0001
        wait for 100 ns;
        
        -- Expected output
        assert ((s_B_greater_A = '0') and
                (s_B_equals_A  = '1') and
                (s_B_less_A    = '0'))
                
        -- If false, then report an error
        report "Input combination COMPLETE_THIS_TEXT FAILED" severity error;

        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
```

2. Text console screenshot during your simulation, including reports.

   1. Correct simulation:

   ![Correct](images/corect.png)

   2. Error simulation:

   ![Error](images/error.png)


3. Link to your public EDA Playground example:

   [https://www.edaplayground.com/...](https://www.edaplayground.com/x/HPZZ)

