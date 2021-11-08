#Hex Calculator Modifications

It's 12:04 AM on Nov 8 2021. I have to wake up at 6:45 AM for scheduling at 7 AM. I will write a description in the morning.

I will write all of the modifications I've made in detail in the morning, but in short,

The display data was changed from 16 bits to 32 bits. Display is now 8 bits instead of 4 bits.

![leddec32.gif](./leddec32.gif)

Leading 0s were suppressed.

![suppressleading0s.gif](./suppressleading0s.gif)

Subtraction was added to the operations you can perform. I tried adding multiplication too but when performing the math, my input was a 64 bit number while the display was a 32 bit number so I ran into an error. I want to ask my professor how I can solve this problem in class on tuesday.

![hexcalcmodplusminus.gif](./hexcalcmodplusminus.gif)