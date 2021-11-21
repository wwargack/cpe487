# VGA Ball

Displays a ball that bounces on the edges of the screen akin to a "[dvd logo](https://www.youtube.com/watch?v=5mGuCdlCcNM)".

Uses the built in clock to refresh the screen and convert it to a VGA display.

Because the ball and background are created with red, green, and blue values, it is possible to modify which colors are used to draw the ball and background. By default, the ball is red on a cyan background. I have modified the ball to now be blue on a green background.

Use '1' on a color to add the color to the ball and 'NOT ball_on' to not add the color to the ball in ball.vhd
```
red <= '1';
green <= NOT ball_on;
blue <= NOT ball_on;
```
for a red ball.

To set the background color use `vga_\[color\](1 downto 0)` <= "00"; and to not consider the color for the background use `vga_\[color\](0) <= '0'` 
```
vga_red(0) <= '0';
vga_green(0) <= '0';
vga_blue (1 downto 0) <= "00";
```
