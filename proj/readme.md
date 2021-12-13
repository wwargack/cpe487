# Walter's Advanced Hexadecimal Calculator

A more advanced version of [Lab 4](../lab4/hexcalc)'s Hexadecimal Calculator.

Consists of 10 operations:
- Addition
  - Implemented from Lab 4
  - `nx_acc <= acc + operand`

[addition gif](./videos/addition.gif)

- Subtraction
  - Implemented from Lab 4 modifications
  - `nx_acc <= acc - operand`

[subtration gif](./videos/subtraction.gif)

- Multiplication
  - Implemented from Lab 4 modifications
  - `mul_val <= acc * operand`
  - `nx_acc <= mul_val (31 downto 0)`
  - Any digits past 8 digits are cut off and not displayed.

[multiplication gif](./videos/multiplication.gif)

- Division
  - There is no division operation for std_logic_vectors. As a workaround, I converted the std_logic_vector to a signed int, did division, then converted back to std_logic_vector.
  - `nx_acc <= std_logic_vector(to_signed(to_integer((signed(acc) + (signed(operand) / 2)) / signed(operand)), 32))`
  - Rounds the answer to the nearest integer. (i.e. 1/3 = 0.333 rounds to 0. 5/2 = 2.5 rounds to 3)

[division gif](./videos/division.gif)

- Bitwise AND
  - ANDing the two inputs
  - `nx_acc <= acc and operand`

[and gif](./videos/and.gif)

- Bitwise NAND
  - NANDing the two inputs
  - `nx_acc <= acc nand operand`

[nand gif](./videos/nand.gif)

- Bitwise OR
  - ORing the two inputs
  - `nx_acc <= acc or operand`

[or gif](./videos/or.gif)

- Bitwise XOR
  - XORing the two inputs
  - `nx_acc <= acc xor operand`

[xor gif](./videos/xor.gif)

To figure out the which operation to perform, a signal "op" is set a number when an operand button is pressed.
- Addition = 0
- Subtraction = 1
- Multiplication = 2
- Division = 3
- Bitwise AND = 4
- Bitwise NAND = 5
- Bitwise OR = 6
- Bitwise XOR = 7

Since there are only 5 buttons on the Nexys-A7 board, the rightmost switch (Switch J15) is checked to see if it is flipped to determine which set of operations are being done.

Let sw0 mean the switch is off, and sw1 mean the switch is on.
- Up Button
  - sw0 = plus
  - sw1 = and
- Left Button
  - sw0 = times
  - sw1 = or
- Center Button
  - sw0 = equals
  - sw1 = clear
- Right Button
  - sw0 = divide
  - sw1 = xor
- Down Button
  - sw0 = minus
  - sw1 = nand
