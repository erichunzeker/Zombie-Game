emh128 - README.txt

.
..
...

Eric Hunzeker 
/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
CS0447 - 1030 (1037 Recitation) 
/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
MW 4:30 - 5:45
/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
***********************************
*				  *
*	 			  *
*	 Project 1 ReadMe:	  *
*				  *
*				  *
***********************************

My zombie maze game consists of a series of polling loops and branches. When the program is first assembled and run, the maze in constructed by a series of loading addresses, followed by the looping of loading addresses, then finally another series of loading addresses. The first and last part of building the maze was not included in the loop due to the difference in structure in the beginning and end (to allow player to start and finish the game).

					***

Next, the four zombies are placed at the center of each quadrant. At first, I thought that the zombies each had to spawn in random locations within each of their quadrants. However, upon asking in class, I figured that we could set the position of all four.

After the last zombie is placed on the board, the program jumps to ‘startLoop’ where it indefinitely loops until the center (‘b’) button is pressed. When pressed, the game jumps to the ‘play’ procedure. The ‘play’ procedure places a green player at (0, 0), initializes the game counter to 1, and saves the player’s coordinates to $s0 and $s1. After that, the current time is saved to the $a0 register. The code then jumps to the poll loop.

The poll loops always begins by checking to see if the player’s X - coordinate is at 63. If it is, then the program will jump to the win loop, where it will check to see if the Y - coordinate is also 63. If so, the game counter is displayed and the game will end. If not, the program jumps up to the second part of the polling loop (to avoid an infinite loop of checking for a win). Here, the program checks to see if a button is pressed. If a button is not pressed, it will go to the loop which will then send it to the ‘zombie’ procedure. This is where the initial time gets subtracted from the current time to determine if 500ms has passed and it is time to move the zombies. 

This is where the program jumps to ‘zom1Move’. At the beginning of this procedure, a random number from 0 to 3 is generated. The number corresponds to a direction (0 - right, 1 - left, 2 - down, 3 - up). Four branch statements come next and send the zombie into the loop of whatever direction is generated. 

Inside the ‘right’ loop, the program loads the zombie’s last move into a register to ensure that this next move will not be the opposite of it (a.k.a. backtracking). The zombies coordinates are loaded into registers next. After that, the program checks to see if the zombies next location will be a wall, player, or out of bounds. If so, the program jumps back to ‘zom1Move’ to choose another number, unless the next move will be into a player, then the program jumps to the loss procedure where the score is displayed and the game is finished. If the next position is out of bounds and backtracking is necessary, the program jumps to ‘reset’, where the last move is set to 5 to allow the zombie to move in any direction. Then, once a valid move is selected, the old position’s LED is set to black, and the new one is set to red. Once this has been successfully completed, the program moves to zom2Move, then zom3Move, and finally zom4 move; where the same process is repeated and finally sent back up to the poll loop.

					***
issue:

the game used to glitch if a zombie got caught in the upper right corner of a piece of a maze, so for my aboveRight procedure, getLED checks two above and two to the right of the zombie, and if it is yellow, the zombie can move randomly. Sometimes, the zombie will move radomly when it should be tracked.
