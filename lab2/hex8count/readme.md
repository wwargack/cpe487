# 8 Digit Hex Counter Modification

!["hex8count.gif"](./hex8count.gif)

Line 19 of hexcount.vhd in hex4count
`count : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);`

becomes
`count : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);`
in hex8count.vhd.

This accounts for the extra 16 bits that are needed for the next 4 displays.

---

Same thing happens on line 33.

`SIGNAL S : STD_LOGIC_VECTOR (15 DOWNTO 0);` becomes `SIGNAL S : STD_LOGIC_VECTOR (31 DOWNTO 0);`

---

The display variable on line 56 gains new lines in hex8count:
```    display <= S(3 DOWNTO 0) WHEN md = "000" ELSE
               S(7 DOWNTO 4) WHEN md = "001" ELSE
               S(11 DOWNTO 8) WHEN md = "010" ELSE
               S(15 DOWNTO 12) WHEN md = "011" ELSE
               S(19 DOWNTO 16) WHEN md = "100" ELSE
               S(23 DOWNTO 20) WHEN md = "101" ELSE
               S(27 DOWNTO 24) WHEN md = "110" ELSE
               S(31 DOWNTO 28);
```
			   
As opposed to hex4count:
```	   display <= S(3 DOWNTO 0) WHEN md = "000" ELSE
	           S(7 DOWNTO 4) WHEN md = "001" ELSE
	           S(11 DOWNTO 8) WHEN md = "010" ELSE
	           S(15 DOWNTO 12);
```