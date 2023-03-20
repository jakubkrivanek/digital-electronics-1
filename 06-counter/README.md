# Lab 6: Jakub Krivanek

### Bidirectional counter

1. Listing of VHDL code of the completed process `p_cnt_up_down`. Always use syntax highlighting, meaningful comments, and follow VHDL guidelines:

```vhdl
    --------------------------------------------------------
    -- p_cnt_up_down:
    -- Clocked process with synchronous reset which implements
    -- n-bit up/down counter.
    --------------------------------------------------------
    p_cnt_up_down : process (clk) is
    begin
      if rising_edge(clk) then
        if (rst = '1') then           -- Synchronous reset
          sig_cnt <= (others => '0'); -- Clear all bits
        elsif (en = '1') then         -- Test if counter is enabled

          -- TEST COUNTER DIRECTION HERE

            if (cnt_up = '1') then 
          sig_cnt <= (sig_cnt + 1);
        else
          sig_cnt <= (sig_cnt - 1);
             
        end if;
      end if;
    end process p_cnt_up_down;
```

2. Screenshot with simulated time waveforms. Test: (a) reset, (b) counter direction, (c) enable. Always display all inputs and outputs (display the inputs at the top of the image, the outputs below them) at the appropriate time scale!

   ![cnt_up_down](https://user-images.githubusercontent.com/124684744/226170109-86c0c76d-1376-4739-ac97-8397dca7e7dc.png)

### Two counters

1. Image of the top layer structure including both counters, ie a 4-bit bidirectional counter from *Part 4* and a 12-bit counter with a 10 ms time base from *Experiments on your own*. The image can be drawn on a computer or by hand. Always name all inputs, outputs, components and internal signals!

   ![4bit](https://user-images.githubusercontent.com/124684744/226469562-ce0df5a4-ec3d-461a-ba20-f04926fd0f64.png)
   ![12bit](https://user-images.githubusercontent.com/124684744/226469616-1e62db59-4cb6-46cd-a308-efc19dfcfd5d.png)