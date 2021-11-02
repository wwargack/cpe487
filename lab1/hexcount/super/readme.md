# Super Hexcount

A combination of [leddec](./../../leddec) and [hexcount](./..) from [lab1](./../../..).

The display digit counts up from 0 to F in roughly 2.67 seconds.

Use switches 13, 14, and 15 (U12, U11, V10) to change the display by 1, 2, and 4 segments respectively.

![super hexcount.gif](./superhexcount.gif)

---

Differences between hexcount and super hexcount include:

Move
```
	-- Turn on anode of 7-segment display addressed by 3-bit digit selector dig
	anode <= "11111110" WHEN dig = "000" ELSE -- 0
	         "11111101" WHEN dig = "001" ELSE -- 1
	         "11111011" WHEN dig = "010" ELSE -- 2
	         "11110111" WHEN dig = "011" ELSE -- 3
	         "11101111" WHEN dig = "100" ELSE -- 4
	         "11011111" WHEN dig = "101" ELSE -- 5
	         "10111111" WHEN dig = "110" ELSE -- 6
	         "01111111" WHEN dig = "111" ELSE -- 7
	         "11111111";
```
from leddec.vhd to hexcount.vhd under the `ARCHITECTURE Behavioral OF hexcount IS` under `BEGIN`

This is to prevent anode from being declared twice, and it allows hexcount to modify the value of anode when dig equals something rather than leddec doing this.

---

hexcount.xdc has the addition of
```
set_property -dict {PACKAGE_PIN U12 IOSTANDARD LVCMOS33} [get_ports {dig[0]}]
set_property -dict {PACKAGE_PIN U11 IOSTANDARD LVCMOS33} [get_ports {dig[1]}]
set_property -dict {PACKAGE_PIN V10 IOSTANDARD LVCMOS33} [get_ports {dig[2]}]
```
so that hexcount is able to track switches 13, 14, and 15 to change the display digit.