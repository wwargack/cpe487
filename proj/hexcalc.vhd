LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY hexcalc IS
	PORT (
		clk_50MHz : IN STD_LOGIC; -- system clock (50 MHz)
		SEG7_anode : OUT STD_LOGIC_VECTOR (7 DOWNTO 0); -- anodes of eight 7-seg displays
		SEG7_seg : OUT STD_LOGIC_VECTOR (6 DOWNTO 0); -- common segments of 7-seg displays

                btUp : in std_logic; -- up button BTNU
                -- sw0 plus, sw1 and
                
                btLeft : in std_logic; -- left button BTNL
                -- sw0 multiplication, sw1 or
                
                btCenter : in std_logic; -- center button BTNC
                -- sw0 equals, sw1 clear
                
                btRight : in std_logic; -- right button BTNR
                -- sw0 division, sw1 xor
                
                btDown : in std_logic; -- down button BTND
                -- sw0 minus, sw1 nand

                --switch to have more than 5 operations
                swOp : in std_logic_vector (0 downto 0);
                
                
		KB_col : OUT STD_LOGIC_VECTOR (4 DOWNTO 1); -- keypad column pins
	    KB_row : IN STD_LOGIC_VECTOR (4 DOWNTO 1) -- keypad row pins
	);
END hexcalc;

ARCHITECTURE Behavioral OF hexcalc IS
	COMPONENT keypad IS
		PORT (
			samp_ck : IN STD_LOGIC;
			col : OUT STD_LOGIC_VECTOR (4 DOWNTO 1);
			row : IN STD_LOGIC_VECTOR (4 DOWNTO 1);
			value : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
			hit : OUT STD_LOGIC
		);
	END COMPONENT;
	COMPONENT leddec32 IS
		PORT (
			dig : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
			data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			anode : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			seg : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
		);
	END COMPONENT;
	SIGNAL cnt : std_logic_vector(20 DOWNTO 0); -- counter to generate timing signals
	SIGNAL kp_clk, kp_hit, sm_clk : std_logic;
	SIGNAL kp_value : std_logic_vector (3 DOWNTO 0);
	SIGNAL nx_acc, acc : std_logic_vector (31 DOWNTO 0); -- accumulated sum
	SIGNAL nx_operand, operand : std_logic_vector (31 DOWNTO 0); -- operand
	SIGNAL display : std_logic_vector (31 DOWNTO 0); -- value to be displayed
	SIGNAL led_mpx : STD_LOGIC_VECTOR (2 DOWNTO 0); -- 7-seg multiplexing clock
	TYPE state IS (ENTER_ACC, ACC_RELEASE, START_OP, OP_RELEASE, 
	ENTER_OP, SHOW_RESULT); -- state machine states
	SIGNAL pr_state, nx_state : state; -- present and next states
	SIGNAL op : STD_LOGIC_VECTOR (2 DOWNTO 0); --signal to track operations. + is 0, - is 1,
                                                   --* is 2, / is 3, and is 4,
                                                   --nand is 5, or is 6, xor is 7
	SIGNAL mul_val : STD_LOGIC_VECTOR (63 DOWNTO 0); -- signal to hold the 64 bit multiplication value when multiplying two 32 bit inputs.
 
BEGIN
	ck_proc : PROCESS (clk_50MHz)
	BEGIN
		IF rising_edge(clk_50MHz) THEN -- on rising edge of clock
			cnt <= cnt + 1; -- increment counter
		END IF;
	END PROCESS;
	kp_clk <= cnt(15); -- keypad interrogation clock
	sm_clk <= cnt(20); -- state machine clock
	led_mpx <= cnt(19 DOWNTO 17); -- 7-seg multiplexing clock
	kp1 : keypad
	PORT MAP(
		samp_ck => kp_clk, col => KB_col, 
		row => KB_row, value => kp_value, hit => kp_hit
		);
		led1 : leddec32
		PORT MAP(
			dig => led_mpx, data => display, 
			anode => SEG7_anode, seg => SEG7_seg
		);
		sm_ck_pr : PROCESS (btCenter, sm_clk, swOp) -- state machine clock process
		BEGIN
               
			IF btCenter = '1' THEN -- reset to known state
				IF swOp = "1" THEN
					acc <= X"00000000";
					operand <= X"00000000";
					pr_state <= ENTER_ACC;
				END IF;
			ELSIF rising_edge (sm_clk) THEN -- on rising clock edge
				pr_state <= nx_state; -- update present state
				acc <= nx_acc; -- update accumulator
				operand <= nx_operand; -- update operand
			END IF;
		END PROCESS;
		-- state maching combinatorial process
		-- determines output of state machine and next state
		sm_comb_pr : PROCESS (kp_hit, kp_value, btUp, btLeft, btRight, btDown, btCenter, acc, operand, pr_state)
		BEGIN
			nx_acc <= acc; -- default values of nx_acc, nx_operand & display
			nx_operand <= operand;
			display <= acc;
			CASE pr_state IS -- depending on present state...
				WHEN ENTER_ACC => -- waiting for next digit in 1st operand entry
					IF kp_hit = '1' THEN
						nx_acc <= acc(27 DOWNTO 0) & kp_value;
						nx_state <= ACC_RELEASE;
					ELSIF btUp = '1' then
						--plus
						if swOp = "0" then
							op <= "000";
						--and
						elsif swOp = "1" then
							op <= "100";
						end if;
						nx_state <= START_OP;
					ELSIF btLeft = '1' then
						--times
						if swOp = "0" then
							op <= "010";
						--or
						elsif swOp = "1" then
							op <= "110";
						end if;
						nx_state <= START_OP;
					ELSIF btRight = '1' then
						--divide
						if swOp = "0" then
							op <= "011";
						--xor
						elsif swOp = "1" then
							op <= "111";
						end if;
						nx_state <= START_OP;
					elsif btDown = '1' then
						--subtract
						if swOp = "0" then
							op <= "001";
						--nand
						elsif swOp = "1" then
							op <= "101";
						end if;
						nx_state <= START_OP;
					ELSE
						nx_state <= ENTER_ACC;
					END IF;
				WHEN ACC_RELEASE => -- waiting for button to be released
					IF kp_hit = '0' THEN
						nx_state <= ENTER_ACC;
					ELSE nx_state <= ACC_RELEASE;
					END IF;
				WHEN START_OP => -- ready to start entering 2nd operand
					IF kp_hit = '1' THEN
						nx_operand <= X"0000000" & kp_value;
						nx_state <= OP_RELEASE;
						display <= operand;
					ELSE nx_state <= START_OP;
					END IF;
				WHEN OP_RELEASE => -- waiting for button ot be released
					display <= operand;
					IF kp_hit = '0' THEN
						nx_state <= ENTER_OP;
					ELSE nx_state <= OP_RELEASE;
					END IF;
				WHEN ENTER_OP => -- waiting for next digit in 2nd operanxxd
					display <= operand;
					IF btCenter = '1' THEN
						IF swOp = "0" THEN
							IF op = "000" THEN --plus
								nx_acc <= acc + operand;
							ELSIF op = "001" THEN --minus
								nx_acc <= acc - operand;
							ELSIF op = "010" THEN --times
							    mul_val <= acc * operand;
								nx_acc <= mul_val (31 DOWNTO 0); --ignore bits overflowed past 32 bits for now. working on a solution to this.
							ELSIF op = "011" THEN --divide with rounding
								nx_acc <= std_logic_vector(to_signed(to_integer((signed(acc) + (signed(operand) / 2)) / signed(operand)), 32));
							ELSIF op = "100" THEN --and
							    nx_acc <= acc and operand;
							ELSIF op = "101" THEN --nand
								nx_acc <= acc nand operand;
							ELSIF op = "110" THEN --or
								nx_acc <= acc or operand;
							ELSIF op = "111" THEN --xor
                                nx_acc <= acc xor operand;
							END IF;                          
					   nx_state <= SHOW_RESULT;
					   END IF;
					ELSIF kp_hit = '1' THEN
						nx_operand <= operand(27 DOWNTO 0) & kp_value;
						nx_state <= OP_RELEASE;
					ELSE nx_state <= ENTER_OP;
					END IF;
				WHEN SHOW_RESULT => -- display result
					IF kp_hit = '1' THEN
						nx_acc <= X"0000000" & kp_value;
						nx_state <= ACC_RELEASE;
					ELSE nx_state <= SHOW_RESULT;
					END IF;
			END CASE;
		END PROCESS;
END Behavioral;
