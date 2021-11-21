# Pong

Extends [Lab 3](./../../lab3/vgaball) to include a paddle/bat that can be controlled with a potentiometer that reflects the ball back when hit.

No major modifications were made except to the ball speed to make the game of hitting the ball harder. This was done by modifying line 24 of bat_n_ball.vhd

Original: `CONSTANT ball_speed : STD_LOGIC_VECTOR (10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR (6, 11);` which means that the ball has a speed  of 2^11/2^6 = 1984.

Can be increased/decreased by changing the values in `CONV_STD_LOGIC_VECTOR`