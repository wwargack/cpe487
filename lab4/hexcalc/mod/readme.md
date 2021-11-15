# Hex Calculator Modifications

## 8 Digit Display

Modifies every 16 bit value over the main hexcalc loop and leddec16 to use 32 bits instead. leddec16 became leddec32.

8 hexadecimal digits can be displayed instead of 4.

![leddec32.gif](./leddec32.gif)

## Suppress Leading Zeroes

Leading 0s were suppressed. If the higher digits are not equal to zero, then turn their display on. If higher digits are equal to zero, turn their display off.
```
	-- Turn on anode of 7-segment display addressed by 3-bit digit selector dig. Suppress leading 0s.
	anode <= "11111110" WHEN dig = "000" and data /= X"00000000" ELSE -- 0
	         "11111101" WHEN dig = "001" and data (31 DOWNTO 4) /= X"0000000" ELSE -- 1
	         "11111011" WHEN dig = "010" and data (31 DOWNTO 8) /= X"000000" ELSE -- 2
	         "11110111" WHEN dig = "011" and data (31 DOWNTO 12) /= X"00000" ELSE -- 3
	         "11101111" WHEN dig = "100" and data (31 DOWNTO 16) /= X"0000" ELSE -- 4
	         "11011111" WHEN dig = "101" and data (31 DOWNTO 20) /= X"000" ELSE -- 5 
	         "10111111" WHEN dig = "110" and data (31 DOWNTO 24) /= X"00" ELSE -- 6
	         "01111111" WHEN dig = "111" and data (31 DOWNTO 28) /= X"0" ELSE -- 7
	         "11111111";
```

![suppressleading0s.gif](./suppressleading0s.gif)

## Subtraction and Multiplication

Subtraction and multiplication were added to the operations you can perform.

Two more buttons were tracked in the xdc constraint file which correspond to IN STD_LOGIC variables in the vhd file.
```
hexcalc.vhd
     bt_minus: IN STD_LOGIC; -- calculator "-" button
     bt_multiply: IN STD_LOGIC; -- calculator "*" button

hexcalc.xdc
     set_property -dict { PACKAGE_PIN M17   IOSTANDARD LVCMOS33 } [get_ports { bt_multiply }]; #IO_L10N_T1_D15_14 Sch=btnr
     set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports { bt_minus }]; #IO_L9N_T1_DQS_D13_14 Sch=btnd
```

Created a signal to track whether the addition, subtraction, or multiplication buttons were hit to be able to choose what operation to do after hitting the equals button.
```
	SIGNAL op : STD_LOGIC_VECTOR (1 DOWNTO 0); --signal to track operations. + is 0, - is 1, * is 2
```

Created a 64 bit signal to handle the multiplication of 2 32 bit numbers (operand * accumulator)
```
	SIGNAL sf : STD_LOGIC (63 DOWNTO 0);
```

Addded an if statement to figure out the current operation.
```
				WHEN ENTER_ACC => -- waiting for next digit in 1st operand entry
					IF kp_hit = '1' THEN
						nx_acc <= acc(27 DOWNTO 0) & kp_value;
						nx_state <= ACC_RELEASE;
					ELSIF bt_plus = '1' THEN
					    op <= "00";
						nx_state <= START_OP;
					ELSIF bt_minus = '1' THEN
					    op <= "01";
					    nx_state <= START_OP;
					ELSIF bt_multiply = '1' THEN
					    op <= "10";
					    nx_state <= START_OP;
					ELSE
						nx_state <= ENTER_ACC;
					END IF;
```

Perform addition, subtraction, or multiplication when the equals button is pushed. If multiplication was performed, cut off overflow past 32 bits.
```
					IF bt_eq = '1' THEN
					   IF op = "00" THEN
						  nx_acc <= acc + operand;
					   ELSIF op = "01" THEN
					      nx_acc <= acc - operand;
					   ELSIF op = "10" THEN
                                              sf <= acc * operand;
					      nx_acc <= sf (31 downto 0);
					   nx_state <= SHOW_RESULT;
					   END IF
```

![hexcalcmodplusminus.gif](./hexcalcmodplusminus.gif)