# Lab 1: Jakub Krivanek

### De Morgan's laws

1. Equations of all three versions of logic function f(c,b,a):

   \begin{align*}
   f_{\textup{ORIG}}(c,b,a) =&~ \overline{b}\cdot a + c\cdot\overline{(b+\overline{a})}\\
   f_{\textup{(N)AND}}(c,b,a) =&~ \overline{\overline{(\overline{b}\cdot a)}\cdot \overline{(c\cdot(\overline{b}\cdot a))}} \\   
   f_{\textup{(N)OR}}(c,b,a) =&~ \overline{(b + \overline{a})} + \overline{(\overline{c} + (b + \overline{a}))} \\
\end{align*}

2. Listing of VHDL architecture from design file (`design.vhd`) for all three functions. Always use syntax highlighting, meaningful comments, and follow VHDL guidelines:

```vhdl
architecture dataflow of gates is
begin
    f_orig_o <= (not(b_i) and a_i) or (c_i and not(b_i or not(a_i)));
    f_nand_o <= not(not(not(b_i) and a_i) and not(c_i and (not(b_i) and a_i)));
    f_nor_o  <= not(b_i or not(a_i)) or not(not(c_i) or (b_i or not(a_i)));
end architecture dataflow;
```

3. Complete table with logic functions' values:

   | **c** | **b** |**a** | **f_ORIG** | **f_(N)AND** | **f_(N)OR** |
   | :-: | :-: | :-: | :-: | :-: | :-: |
   | 0 | 0 | 0 | 0 | 0 | 0 |
   | 0 | 0 | 1 | 1 | 1 | 1 |
   | 0 | 1 | 0 | 0 | 0 | 0 |
   | 0 | 1 | 1 | 0 | 0 | 0 |
   | 1 | 0 | 0 | 0 | 0 | 0 |
   | 1 | 0 | 1 | 1 | 1 | 1 |
   | 1 | 1 | 0 | 0 | 0 | 0 |
   | 1 | 1 | 1 | 0 | 0 | 0 |

### Distributive laws

1. Screenshot with simulated time waveforms. Always display all inputs and outputs (display the inputs at the top of the image, the outputs below them) at the appropriate time scale!

   ![This is and image](file:///C:/Users/Jakub/Desktop/Screenshot_1.png)

2. Link to your public EDA Playground example:

   [https://www.edaplayground.com/x/hiLC](https://www.edaplayground.com/x/hiLC)