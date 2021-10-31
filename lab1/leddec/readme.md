# leddec (LED decoder)

Consists of being able to flip 4 switches to represent a binary number in hexadecimal on the seven segment LED display

i.e. 0 being off, 1 being on: 1101 represented by d on the display

3 other switches can be flipped to change the position of the hexadecimal number on the seven segment LED display

Since there are 8 positions, the three switches being flipped can represent where the number is displayed

i.e. 0 being off, 1 being on: 101 represents the hex numebr being displayed in the 6th position from the right (because 0 is the first position)

!["leddec.gif"](./leddec.gif)

--------------
Original code has the 4 number switches on switches 0, 1, 2, and 3 (all the way on the right)
Original code has the 3 position switches on switches 13, 14, and 15 (all the way on the left)

I have applied modifications so that the 3 position switches are now on switches 6, 7, and 8 (in the middle)
This was done by changing values in the leddec.xdc file where the switches are represented by U18, R13, and T8 respectively.
