		.data
firstTop: 	.word 0xaaaaaa0a #initialize all board patterns
ones:		.word 0xaaaaaaaa
zeros:		.word 0x00000000
secondTop:	.word 0x02800200
second:		.word 0x02800280
third:		.word 0xa28aa28a
fourth:		.word 0x22882288
fifth:		.word 0x22882288
sixth:		.word 0xa28aa28a
seventh:	.word 0x00000080
eighth:		.word 0x02000000
ninth: 		.word 0xaa8aaa8a
eightBottom:	.word 0xa0aaaaaa
zom1:		.space 8
zom2:		.space 8
zom3:		.space 8
zom4:		.space 8
lastMove:	.space 4
lastMove2:	.space 4
lastMove3:	.space 4
lastMove4:	.space 4

msgWon:		.asciiz "\nSuccess! You won! Your score is "
msgMove:	.asciiz " moves."
msgLost:	.asciiz "\nSorry. You were captured."



	.text
main:
	jal setBoard 	#set board to begin (only first pattern)
	jal loopy 	#loop through and create 6 same blocks of patterns
begin:
	jal setZombie1 	#place each zombie on the board
	
play:
	li $a0, 0 	# 'b' key has been pressed, set the player (green) to (0, 0)
	li $a1, 0
	li $a2, 3
	jal _setLED
	
	addi $s0, $s0, 0 #player x coordinate
	addi $s1, $s1, 0 #player y coordinate
	addi $s2, $s2, 0 #player move count
	
	li $t5, 3	 # no backtracking - last move set to up
	sw $t5, lastMove
	
	li $v0, 30	#save current time
	syscall
	move $s7, $a0
	
	jal poll	#begin checking for player moves & time to move zombies
							
exit:					
	li $v0, 10	
	syscall
	
startLoop: 
	lw $t4, 0xffff0000
	
	beqz $t4, sLoop 	#no key has been pressed
	bnez $t4, checkKey 	#key pressed
	
sLoop:
	j startLoop		#loop indefinitely (is that the correct use of indefinitely? hmm, maybe)
	
checkKey:
	lw $t5, 0xffff0004 
	beq $t5, 0x42, play	 #if key pressed is 'b', begin game
	j startLoop 		#if not, wait for 'b' to be pressed

setBoard:
	li $t2, 0xffff0008

	la $t1, firstTop
	lw $t1, ($t1)
	sw $t1, 0($t2)

	la $t1, ones
	lw $t1, ($t1)
	sw $t1, 4($t2)
	sw $t1, 8($t2)
	sw $t1, 12($t2)

	la $t1, secondTop
	lw $t1, ($t1)
	sw $t1, 16($t2)
	
	la $t1, second
	lw $t1, ($t1)
	sw $t1, 20($t2)
	sw $t1, 24($t2)
	sw $t1, 28($t2)
	
	la $t1, third
	lw $t1, ($t1)
	sw $t1, 32($t2)
	sw $t1, 36($t2)
	sw $t1, 40($t2)
	sw $t1, 44($t2)

	la $t1, fourth
	lw $t1, ($t1)
	sw $t1, 48($t2)
	sw $t1, 52($t2)
	sw $t1, 56($t2)
	sw $t1, 60($t2)
	
	la $t1, fifth
	lw $t1, ($t1)
	sw $t1, 64($t2)
	sw $t1, 68($t2)
	sw $t1, 72($t2)
	sw $t1, 76($t2)

	la $t1, sixth
	lw $t1, ($t1)
	sw $t1, 80($t2)
	sw $t1, 84($t2)
	sw $t1, 88($t2)
	sw $t1, 92($t2)
	
	addi $t2, $t2, 92
	
	jr $ra
	
	
loopy:
	
	la $t1, seventh
	lw $t1, ($t1)
	sw $t1, 4($t2)
	
	la $t1, zeros
	lw $t1, ($t1)
	sw $t1, 8($t2)
	sw $t1, 12($t2)
	
	la $t1, eighth
	lw $t1, ($t1)
	sw $t1, 16($t2)
	
	la $t1, ninth
	lw $t1, ($t1)
	sw $t1, 20($t2)
	sw $t1, 24($t2)
	sw $t1, 28($t2)
	sw $t1, 32($t2)
	sw $t1, 36($t2)
	sw $t1, 40($t2)
	sw $t1, 44($t2)
	sw $t1, 48($t2)
	
	la $t1, second
	lw $t1, ($t1)
	sw $t1, 52($t2)
	sw $t1, 56($t2)
	sw $t1, 60($t2)
	sw $t1, 64($t2)

	la $t1, third
	lw $t1, ($t1)
	sw $t1, 68($t2)
	sw $t1, 72($t2)
	sw $t1, 76($t2)
	sw $t1, 80($t2)	
	
	la $t1, fourth
	lw $t1, ($t1)
	sw $t1, 84($t2)
	sw $t1, 88($t2)
	sw $t1, 92($t2)
	sw $t1, 96($t2)
	
	la $t1, fifth
	lw $t1, ($t1)
	sw $t1, 100($t2)
	sw $t1, 104($t2)
	sw $t1, 108($t2)
	sw $t1, 112($t2)
	
	la $t1, sixth
	lw $t1, ($t1)
	sw $t1, 116($t2)
	sw $t1, 120($t2)
	sw $t1, 124($t2)
	sw $t1, 128($t2)
	
	addi $t2, $t2, 128
	
	bge $t2, 0xffff0348, exitLoopy #jump to make last pattern
	j loopy 
	
	
exitLoopy:
	la $t1, seventh
	lw $t1, ($t1)
	sw $t1, 4($t2)
	
	la $t1, zeros
	lw $t1, ($t1)
	sw $t1, 8($t2)
	sw $t1, 12($t2)
	
	la $t1, eighth
	lw $t1, ($t1)
	sw $t1, 16($t2)
	
	la $t1, ninth
	lw $t1, ($t1)
	sw $t1, 20($t2)
	sw $t1, 24($t2)
	sw $t1, 28($t2)
	sw $t1, 32($t2)
	sw $t1, 36($t2)
	sw $t1, 40($t2)
	sw $t1, 44($t2)
	sw $t1, 48($t2)
	
	la $t1, second
	lw $t1, ($t1)
	sw $t1, 52($t2)
	sw $t1, 56($t2)
	sw $t1, 60($t2)
	sw $t1, 64($t2)

	la $t1, third
	lw $t1, ($t1)
	sw $t1, 68($t2)
	sw $t1, 72($t2)
	sw $t1, 76($t2)
	sw $t1, 80($t2)	
	
	la $t1, fourth
	lw $t1, ($t1)
	sw $t1, 84($t2)
	sw $t1, 88($t2)
	sw $t1, 92($t2)
	sw $t1, 96($t2)
	
	la $t1, fifth
	lw $t1, ($t1)
	sw $t1, 100($t2)
	sw $t1, 104($t2)
	sw $t1, 108($t2)
	sw $t1, 112($t2)
	
	la $t1, sixth
	lw $t1, ($t1)
	sw $t1, 116($t2)
	sw $t1, 120($t2)
	sw $t1, 124($t2)
	sw $t1, 128($t2)
	
	la $t1, seventh
	lw $t1, ($t1)
	sw $t1, 132($t2)
	
	la $t1, zeros
	lw $t1, ($t1)
	sw $t1, 136($t2)
	sw $t1, 140($t2)
	sw $t1, 144($t2)
	
	la $t1, ones
	lw $t1, ($t1)
	sw $t1, 148($t2)
	sw $t1, 152($t2)
	sw $t1, 156($t2)	
	
	la $t1, eightBottom #bottom of board is different from the middle and top
	lw $t1, ($t1)
	sw $t1, 160($t2)
	
		
	j begin 
	
poll:
	beq $s0, 63, win	#check if player's x = 63, there's a chance they won
pollNext:
	lw $t4, 0xffff0000
	
	beqz $t4, loop		#if no key is pressed loop back
	bnez $t4, checkKeyPressed #find key pressed
zombie:
	li $v0, 30 		#get current time
	syscall
	sub $a0, $a0, $s7	#get elapsed time
	
	bge $a0, 500, zom1Move 	#test if it's been 500ms - if so, move zombie
	j poll			#back to poll loop to wait for key
	
loop:
	j zombie
	
checkKeyPressed:
	lw $t5, 0xffff0004
	beq $t5, 0xe0, up	
	beq $t5, 0xe1, down
	beq $t5, 0xe2, left
	beq $t5, 0xe3, right
	j zombie

right:
	addi $a0, $s0, 1	#add to x coordinate
	add $a1, $0, $s1	#put y in a register
	
	bge $s0, 63, poll
	
	jal _getLED		
	
	beq $v0, 2, poll	#if there's a wall pick different direction
	beq $v0, 1, lost	#if there's a zombie there, you lose
	
	add $a0, $0, $s0	
	add $a1, $0, $s1
	
	li $a2, 0
	
	jal _setLED		#make old location black led
	
	addi $s0, $s0, 1	#add 1 to x
	add $a0, $0, $s0
	add $a1, $0, $s1
	li $a2, 3
	
	jal _setLED		#make led green
	
	addi $s2, $s2, 1	#update count
	
	j zombie

left:
	addi $a0, $s0, -1	#test if you can go left
	add $a1, $0, $s1
	
	ble $s0, 0, poll
	
	jal _getLED
		
	beq $v0, 2, poll	#if there's a wall wait for different key
	beq $v0, 1, lost	#if there's a zombie then game over
		
	add $a0, $0, $s0
	add $a1, $0, $s1
	li $a2, 0
	
	jal _setLED		#make current black
	
	subi $s0, $s0, 1
	add $a0, $0, $s0
	add $a1, $0, $s1
	li $a2, 3
	  
	jal _setLED
	
	addi $s2, $s2, 1
	
	j zombie	
down:

	add $a0, $0, $s0
	addi $a1, $s1, 1
	
	bge $s1, 63, poll
	
	jal _getLED		#test led down one
	
	beq $v0, 2, poll	#can't go down - wait for different key 
	beq $v0, 1, lost	#zombie - game over
	
	add $a0, $0, $s0
	add $a1, $0, $s1
	li $a2, 0
	
	jal _setLED		#make current led black
	
	addi $s1, $s1, 1	#move led down one
	add $a0, $0, $s0
	add $a1, $0, $s1
	li $a2, 3
	
	jal _setLED
	
	addi $s2, $s2, 1	#count
	
	j zombie
	
up:
	add $a0, $0, $s0
	addi $a1, $s1, -1
	
	ble $s1, 0, poll
	
	jal _getLED		#test current posistion
	
	beq $v0, 2, poll	#wall - can't move up
	beq $v0, 1, lost	#zombie - game over
	
	add $a0, $0, $s0
	add $a1, $0, $s1
	li $a2, 0
	
	jal _setLED		#make current led black
	
	addi $s1, $s1, -1
	add $a0, $0, $s0
	add $a1, $0, $s1
	li $a2, 3
	
	jal _setLED		#make led green above old one
	
	addi $s2, $s2, 1
	
	j zombie

win:	
	bne $s1, 63, pollNext #player is above final position, go back
	
	la $a0, msgWon 	#display win message
	li $v0, 4
	syscall
	
	la $a0, ($s2)	#display win count
	li $v0, 1
	syscall
	
	la $a0, msgMove
	li $v0, 4
	syscall
	
	j exit
	
lost: 
	la $a0, msgLost	#display loss message
	li $v0, 4
	syscall
	
	j exit
		
		
setZombie1:
	li $a0, 17
	li $a1, 14
	
	li $t0, 4
	sw $a0, zom1
	sw $a1, zom1($t0) #store zombie's location 

	li $a2, 1
	jal _setLED
	
	j setZombie2 #do next zombie 
	
setZombie2:
	li $a0, 49
	li $a1, 14
	
	li $t0, 4
	sw $a0, zom2
	sw $a1, zom2($t0)
	
	li $a2, 1
	jal _setLED
	
	j setZombie3
	
setZombie3:
	li $a0, 17
	li $a1, 46
	
	li $t0, 4
	sw $a0, zom3
	sw $a1, zom3($t0)

	li $a2, 1
	jal _setLED
		
	j setZombie4
	
setZombie4:
	li $a0, 49
	li $a1, 46
	
	li $t0, 4
	sw $a0, zom4
	sw $a1, zom4($t0)

	li $a2, 1
	jal _setLED
	
	j startLoop #board is set
		

zom1Move:
	li $a1, 0	
	li $a1, 4
	li $v0, 42
	syscall
	move $a3, $a0	#generate random direction
	
	li $t5, 31
	
	slt $t0, $s0, $t5
	slt $t1, $s1, $t5
	
	add $t0, $t0, $t1
	
	beq $t0, 2, trackPlayer1AboveLeft
	
	beq $a3, 0, goRight
	beq $a3, 1, goLeft
	beq $a3, 2, goDown
	beq $a3, 3, goUp
	
	j exit
	
trackPlayer1AboveLeft:
	
	bge $s0, 31, zom1Move
	bge $s1, 31, zom1Move
	
	li $t0, 4		#word offset
	lw $a0, zom1		#load zombie1's X
	lw $a1, zom1($t0) 	#load zombie1's Y
	
	slt $t1, $s0, $a0
	slt $t2, $s1, $a1
	add $t1, $t1, $t2
	
	beq $s0, $a0, random	#player and zombie are in line, not left/right/above/below
	beq $s1, $a1, random
	
	beq $t1, 1, trackPlayer1AboveRight
	beqz $t1, trackPlayer1BelowRight
	
	li $a1, 0
	li $a1, 2
	li $v0, 42
	syscall
	move $a3, $a0
	
	li $t4, 6	
	sw $t4, lastMove
	
	beq $a3, 0, goLeft
	beq $a3, 1, goUp
	
trackPlayer1AboveRight:
	
	bge $s0, 31, zom1Move
	bge $s1, 31, zom1Move	
	
	li $t0, 4		#word offset
	lw $a0, zom1		#load zombie1's X
	lw $a1, zom1($t0) 	#load zombie1's Y
	
	sgt $t1, $s0, $a0
	slt $t2, $s1, $a1
	add $t1, $t1, $t2
	
	beq $s0, $a0, random
	beq $s1, $a1, random
	
	beq $t1, 1, trackPlayer1AboveRight
	beqz $t1, trackPlayer1BelowLeft
	
	li $a1, 0
	li $a1, 2
	li $v0, 42
	syscall
	move $a3, $a0
	
	li $t4, 6	
	sw $t4, lastMove
	
	addi $a0, $a0, 1
	addi $a1, $a1, 1	#do not let zombie get trapped in corner
	jal _getLED
	add $t6, $v0, 0		
	
	addi $a0, $a0, 2
	addi $a1, $a1, 2	#do not let zombie get trapped in corner
	jal _getLED
	add $t6, $t6, $v0
	
	beq $t6, 4, random
	
	beq $a3, 0, goRight
	beq $a3, 1, goUp


trackPlayer1BelowLeft:
	
	bge $s0, 31, zom1Move
	bge $s1, 31, zom1Move

	li $t0, 4		#word offset
	lw $a0, zom1		#load zombie1's X
	lw $a1, zom1($t0) 	#load zombie1's Y
	
	slt $t1, $s0, $a0
	sgt $t2, $s1, $a1
	add $t1, $t1, $t2
	
	beq $s0, $a0, random
	beq $s1, $a1, random
	
	beq $t1, 1, trackPlayer1BelowRight
	beqz $t1, trackPlayer1AboveRight
	
	li $a1, 0	
	li $a1, 2
	li $v0, 42
	syscall
	move $a3, $a0
	
	li $t4, 6	
	sw $t4, lastMove
	
	beq $a3, 0, goLeft
	beq $a3, 1, goDown
	
	 	 
	
trackPlayer1BelowRight:
	
	bge $s0, 31, zom1Move
	bge $s1, 31, zom1Move
	
	li $t0, 4		#word offset
	lw $a0, zom1		#load zombie1's X
	lw $a1, zom1($t0) 	#load zombie1's Y
	
	sgt $t1, $s0, $a0
	sgt $t2, $s1, $a1
	add $t1, $t1, $t2
	
	beq $s0, $a0, random
	beq $s1, $a1, random
	
	beq $t1, 1, trackPlayer1BelowLeft
	beqz $t1, trackPlayer1AboveLeft
	
	li $a1, 0	
	li $a1, 2
	li $v0, 42
	syscall
	move $a3, $a0
	
	li $t4, 6	
	sw $t4, lastMove
	
	beq $a3, 0, goRight
	beq $a3, 1, goDown
	
random:
	li $a1, 0	
	li $a1, 4
	li $v0, 42
	syscall
	move $a3, $a0	#generate random direction
	
	beq $a3, 0, goRight
	beq $a3, 1, goLeft
	beq $a3, 2, goDown
	beq $a3, 3, goUp

	
goRight:
	lw $t4, lastMove	#get last direction moved
	
	li $v0, 30		#update time
	syscall
	move $s7, $a0		
	
	li $t0, 4		#word offset
	lw $a0, zom1		#load zombie1's X
	lw $a1, zom1($t0) 	#load zombie1's Y
	
	
	
	bge $a0, 31, reset	#if zombie is at boundary, go to reset 
	beq $t4, 1, zom1Move	#if last direction was left, can't backtrack and go right
	
	li $a2, 0
	jal _setLED

	addi $a0, $a0, 1	#look at next zombie placement
	
	jal _getLED		
	
	beq $v0, 3, lost	#if zombie runs into player, player loses
	beq $v0, 2, zom1Move	#if there's a wall, pick another random direction
	
	li $a2, 1	
	li $t0, 4
	sw $a0, zom1
	sw $a1, zom1($t0)	#save new zombie position
	
	jal _setLED
	li $t4, 0	
	sw $t4, lastMove	#update most recent move
	
	j zom2Move		#move the next zombie *SAME CODE BUT OPPOSITE DIRECTIONS BELOW*

goLeft:
	lw $t4, lastMove
	
	li $v0, 30
	syscall
	move $s7, $a0
	
	
	li $t0, 4
	lw $a0, zom1
	lw $a1, zom1($t0) 
	
	ble $a0, 1, reset	#special case - do not allow zombie to leave the board in upper left corner
	beq $t4, 0, zom1Move
	
	addi $a0, $a0, -1
	
	jal _getLED
	
	beq $v0, 3, lost
	beq $v0, 2, zom1Move
	
	addi $a0, $a0, 1
	
	li $a2, 0
	jal _setLED

	addi $a0, $a0, -1
	
	li $a2, 1
	li $t0, 4
	sw $a0, zom1
	sw $a1, zom1($t0)
	
	jal _setLED
	
	li $t4, 1
	sw $t4, lastMove
	
	j zom2Move
	
goDown:
	lw $t4, lastMove
	
	li $v0, 30
	syscall
	move $s7, $a0
	
	
	li $t0, 4
	lw $a0, zom1
	lw $a1, zom1($t0) 
	
	bge $a1, 31, reset
	beq $t4, 3, zom1Move
	
	li $a2, 0
	jal _setLED

	addi $a1, $a1, 1
	
	jal _getLED
	
	beq $v0, 3, lost
	beq $v0, 2, zom1Move
	
	li $a2, 1
	
	li $t0, 4
	sw $a0, zom1
	sw $a1, zom1($t0)
	
	jal _setLED
	li $t4, 2
	sw $t4, lastMove
	
	j zom2Move
	
goUp:
	lw $t4, lastMove
	
	li $v0, 30
	syscall
	move $s7, $a0
	
	li $t0, 4
	lw $a0, zom1
	lw $a1, zom1($t0) 
	
	ble $a1, 1, reset	#special case - do not allow zombie to leave the board in upper left corner
	beq $t4, 2, zom1Move
	
	addi $a1, $a1, -1
	
	jal _getLED
	
	beq $v0, 3, lost
	beq $v0, 2, zom1Move
	
	addi $a1, $a1, 1
	
	li $a2, 0
	jal _setLED

	addi $a1, $a1, -1
	
	li $a2, 1
	li $t0, 4
	sw $a0, zom1
	sw $a1, zom1($t0)
	
	jal _setLED
	
	li $t4, 3
	sw $t4, lastMove
	
	j zom2Move
	
reset:
	li $t4, 5	#*allows backtracking* 
	sw $t4, lastMove
	j zom1Move
	
	
zom2Move:
	li $a1, 0	
	li $a1, 4
	li $v0, 42
	syscall
	move $a3, $a0	#generate random direction
	
	li $t5, 31
	
	sge $t0, $s0, $t5
	slt $t1, $s1, $t5
	
	add $t0, $t0, $t1
	
	beq $t0, 2, trackPlayer2AboveLeft
	
	beq $a3, 0, goRight2
	beq $a3, 1, goLeft2
	beq $a3, 2, goDown2
	beq $a3, 3, goUp2
	
	j exit
	
trackPlayer2AboveLeft:
	
	blt $s0, 31, zom2Move
	bge $s1, 31, zom2Move
	
	li $t0, 4		#word offset
	lw $a0, zom2		#load zombie1's X
	lw $a1, zom2($t0) 	#load zombie1's Y
	
	slt $t1, $s0, $a0
	slt $t2, $s1, $a1
	add $t1, $t1, $t2
	
	beq $s0, $a0, random2
	beq $s1, $a1, random2
	
	beq $t1, 1, trackPlayer2AboveRight
	beqz $t1, trackPlayer2BelowRight
	
	li $a1, 0
	li $a1, 2
	li $v0, 42
	syscall
	move $a3, $a0
	
	li $t4, 6	
	sw $t4, lastMove2
	
	beq $a3, 0, goLeft2
	beq $a3, 1, goUp2
	
trackPlayer2AboveRight:
	
	blt $s0, 31, zom2Move
	bge $s1, 31, zom2Move	
	
	li $t0, 4		#word offset
	lw $a0, zom2		#load zombie1's X
	lw $a1, zom2($t0) 	#load zombie1's Y
	
	sgt $t1, $s0, $a0
	slt $t2, $s1, $a1
	add $t1, $t1, $t2
	
	beq $s0, $a0, random2
	beq $s1, $a1, random2
	
	beq $t1, 1, trackPlayer2AboveRight
	beqz $t1, trackPlayer2BelowLeft
	
	li $a1, 0
	li $a1, 2
	li $v0, 42
	syscall
	move $a3, $a0
	
	li $t4, 6	
	sw $t4, lastMove2
	
	addi $a0, $a0, 1
	addi $a1, $a1, 1	#do not let zombie get trapped in corner
	jal _getLED
	add $t6, $v0, 0		
	
	addi $a0, $a0, 2
	addi $a1, $a1, 2	#do not let zombie get trapped in corner
	jal _getLED
	add $t6, $t6, $v0
	
	beq $t6, 4, random2
	
	beq $a3, 0, goRight2
	beq $a3, 1, goUp2


trackPlayer2BelowLeft:
	
	blt $s0, 31, zom2Move
	bge $s1, 31, zom2Move

	li $t0, 4		#word offset
	lw $a0, zom2		#load zombie1's X
	lw $a1, zom2($t0) 	#load zombie1's Y
	
	slt $t1, $s0, $a0
	sgt $t2, $s1, $a1
	add $t1, $t1, $t2
	
	beq $s0, $a0, random2
	beq $s1, $a1, random2
	
	beq $t1, 1, trackPlayer2BelowRight
	beqz $t1, trackPlayer2AboveRight
	
	li $a1, 0	
	li $a1, 2
	li $v0, 42
	syscall
	move $a3, $a0
	
	li $t4, 6	
	sw $t4, lastMove2
	
	beq $a3, 0, goLeft2
	beq $a3, 1, goDown2
	
	 	 
	
trackPlayer2BelowRight:
	
	blt $s0, 31, zom2Move
	bge $s1, 31, zom2Move
	
	li $t0, 4		#word offset
	lw $a0, zom2		#load zombie1's X
	lw $a1, zom2($t0) 	#load zombie1's Y
	
	sgt $t1, $s0, $a0
	sgt $t2, $s1, $a1
	add $t1, $t1, $t2
	
	beq $s0, $a0, random2
	beq $s1, $a1, random2
	
	beq $t1, 1, trackPlayer2BelowLeft
	beqz $t1, trackPlayer2AboveLeft
	
	li $a1, 0	
	li $a1, 2
	li $v0, 42
	syscall
	move $a3, $a0
	
	li $t4, 6	
	sw $t4, lastMove2
	
	beq $a3, 0, goRight2
	beq $a3, 1, goDown2
	
random2:
	li $a1, 0	
	li $a1, 4
	li $v0, 42
	syscall
	move $a3, $a0	#generate random direction
	
	beq $a3, 0, goRight2
	beq $a3, 1, goLeft2
	beq $a3, 2, goDown2
	beq $a3, 3, goUp2
	

goRight2:
	lw $t4, lastMove2
	
	li $v0, 30
	syscall
	move $s7, $a0
	
	li $t0, 4
	lw $a0, zom2
	lw $a1, zom2($t0) 
	
	beq $t4, 1, zom2Move
	
	li $a2, 0
	jal _setLED

	addi $a0, $a0, 1
	
	jal _getLED
	
	beq $v0, 3, lost
	beq $v0, 2, zom2Move
	
	li $a2, 1
	li $t0, 4
	sw $a0, zom2
	sw $a1, zom2($t0)
	
	jal _setLED
	li $t4, 0
	sw $t4, lastMove2
	
	j zom3Move

goLeft2:
	lw $t4, lastMove2
	
	li $v0, 30
	syscall
	move $s7, $a0
	
	
	li $t0, 4
	lw $a0, zom2
	lw $a1, zom2($t0) 
	
	
	ble $a0, 32, reset2
	beq $t4, 0, zom2Move
	
	addi $a0, $a0, -1
	
	jal _getLED
	
	beq $v0, 3, lost
	beq $v0, 2, zom2Move
	
	addi $a0, $a0, 1
	
	li $a2, 0
	jal _setLED

	addi $a0, $a0, -1
	
	li $a2, 1
	li $t0, 4
	sw $a0, zom2
	sw $a1, zom2($t0)
	
	jal _setLED
	
	li $t4, 1
	sw $t4, lastMove2
	
	j zom3Move
	
goDown2:
	lw $t4, lastMove2
	
	li $v0, 30
	syscall
	move $s7, $a0
	
	
	li $t0, 4
	lw $a0, zom2
	lw $a1, zom2($t0) 
	
	bge $a1, 31, reset2
	beq $t4, 3, zom2Move
	
	li $a2, 0
	jal _setLED

	addi $a1, $a1, 1
	
	jal _getLED
	
	beq $v0, 3, lost
	beq $v0, 2, zom2Move
	
	li $a2, 1
	
	li $t0, 4
	sw $a0, zom2
	sw $a1, zom2($t0)
	
	jal _setLED
	li $t4, 2
	sw $t4, lastMove2
	
	j zom3Move
	
goUp2:
	lw $t4, lastMove2
	
	li $v0, 30
	syscall
	move $s7, $a0
	
	li $t0, 4
	lw $a0, zom2
	lw $a1, zom2($t0) 
	
	beq $t4, 2, zom2Move
	
	addi $a1, $a1, -1
	
	jal _getLED
	
	beq $v0, 3, lost
	beq $v0, 2, zom2Move
	
	addi $a1, $a1, 1
	
	li $a2, 0
	jal _setLED

	addi $a1, $a1, -1
	
	li $a2, 1
	li $t0, 4
	sw $a0, zom2
	sw $a1, zom2($t0)
	
	jal _setLED
	
	li $t4, 3
	sw $t4, lastMove2
	
	j zom3Move
	
reset2:
	li $t4, 5
	sw $t4, lastMove2
	j zom2Move
	
zom3Move:
	li $a1, 0	
	li $a1, 4
	li $v0, 42
	syscall
	move $a3, $a0	#generate random direction
	
	li $t5, 31
	
	slt $t0, $s0, $t5
	sge $t1, $s1, $t5
	
	add $t0, $t0, $t1
	
	beq $t0, 2, trackPlayer3AboveLeft
	
	beq $a3, 0, goRight3
	beq $a3, 1, goLeft3
	beq $a3, 2, goDown3
	beq $a3, 3, goUp3
	
	j exit
	
trackPlayer3AboveLeft:
	
	bge $s0, 31, zom3Move
	blt $s1, 31, zom3Move
	
	li $t0, 4		#word offset
	lw $a0, zom3		#load zombie1's X
	lw $a1, zom3($t0) 	#load zombie1's Y
	
	slt $t1, $s0, $a0
	slt $t2, $s1, $a1
	add $t1, $t1, $t2
	
	beq $s0, $a0, random3
	beq $s1, $a1, random3
	
	beq $t1, 1, trackPlayer3AboveRight
	beqz $t1, trackPlayer3BelowRight
	
	li $a1, 0
	li $a1, 2
	li $v0, 42
	syscall
	move $a3, $a0
	
	li $t4, 6	
	sw $t4, lastMove3
	
	beq $a3, 0, goLeft3
	beq $a3, 1, goUp3
	
trackPlayer3AboveRight:
	
	bge $s0, 31, zom3Move
	blt $s1, 31, zom3Move	
	
	li $t0, 4		#word offset
	lw $a0, zom3		#load zombie1's X
	lw $a1, zom3($t0) 	#load zombie1's Y
	
	sgt $t1, $s0, $a0
	slt $t2, $s1, $a1
	add $t1, $t1, $t2
	
	beq $s0, $a0, random3
	beq $s1, $a1, random3
	
	beq $t1, 1, trackPlayer3AboveRight
	beqz $t1, trackPlayer3BelowLeft
	
	li $a1, 0
	li $a1, 2
	li $v0, 42
	syscall
	move $a3, $a0
	
	li $t4, 6	
	sw $t4, lastMove3
	
	addi $a0, $a0, 1
	addi $a1, $a1, 1	#do not let zombie get trapped in corner
	jal _getLED
	add $t6, $v0, 0		
	
	addi $a0, $a0, 2
	addi $a1, $a1, 2	#do not let zombie get trapped in corner
	jal _getLED
	add $t6, $t6, $v0
	
	beq $t6, 4, random3
	
	beq $a3, 0, goRight3
	beq $a3, 1, goUp3


trackPlayer3BelowLeft:
	
	bge $s0, 31, zom3Move
	blt $s1, 31, zom3Move

	li $t0, 4		#word offset
	lw $a0, zom3		#load zombie1's X
	lw $a1, zom3($t0) 	#load zombie1's Y
	
	slt $t1, $s0, $a0
	sgt $t2, $s1, $a1
	add $t1, $t1, $t2
	
	beq $s0, $a0, random3
	beq $s1, $a1, random3
	
	beq $t1, 1, trackPlayer3BelowRight
	beqz $t1, trackPlayer3AboveRight
	
	li $a1, 0	
	li $a1, 2
	li $v0, 42
	syscall
	move $a3, $a0
	
	li $t4, 6	
	sw $t4, lastMove3
	
	beq $a3, 0, goLeft3
	beq $a3, 1, goDown3
	
	 	 
	
trackPlayer3BelowRight:
	
	bge $s0, 31, zom3Move
	blt $s1, 31, zom3Move
	
	li $t0, 4		#word offset
	lw $a0, zom3		#load zombie1's X
	lw $a1, zom3($t0) 	#load zombie1's Y
	
	sgt $t1, $s0, $a0
	sgt $t2, $s1, $a1
	add $t1, $t1, $t2
	
	beq $s0, $a0, random3
	beq $s1, $a1, random3
	
	beq $t1, 1, trackPlayer3BelowLeft
	beqz $t1, trackPlayer3AboveLeft
	
	li $a1, 0	
	li $a1, 2
	li $v0, 42
	syscall
	move $a3, $a0
	
	li $t4, 6	
	sw $t4, lastMove3
	
	beq $a3, 0, goRight3
	beq $a3, 1, goDown3
	
random3:
	li $a1, 0	
	li $a1, 4
	li $v0, 42
	syscall
	move $a3, $a0	#generate random direction
	
	beq $a3, 0, goRight3
	beq $a3, 1, goLeft3
	beq $a3, 2, goDown3
	beq $a3, 3, goUp3
	
goRight3:
	lw $t4, lastMove3
	
	li $v0, 30
	syscall
	move $s7, $a0
	
	li $t0, 4
	lw $a0, zom3
	lw $a1, zom3($t0) 
	
	
	bge $a0, 31, reset3
	beq $t4, 1, zom3Move
	
	li $a2, 0
	jal _setLED

	addi $a0, $a0, 1
	
	jal _getLED
	
	beq $v0, 3, lost
	beq $v0, 2, zom3Move
	
	li $a2, 1
	li $t0, 4
	sw $a0, zom3
	sw $a1, zom3($t0)
	
	jal _setLED
	li $t4, 0
	sw $t4, lastMove3
	
	j zom4Move

goLeft3:
	lw $t4, lastMove3
	
	li $v0, 30
	syscall
	move $s7, $a0
	
	
	li $t0, 4
	lw $a0, zom3
	lw $a1, zom3($t0) 
	
	
	beq $t4, 0, zom3Move
	
	addi $a0, $a0, -1
	
	jal _getLED
	
	beq $v0, 3, lost
	beq $v0, 2, zom3Move
	
	addi $a0, $a0, 1
	
	li $a2, 0
	jal _setLED

	addi $a0, $a0, -1
	
	li $a2, 1
	li $t0, 4
	sw $a0, zom3
	sw $a1, zom3($t0)
	
	jal _setLED
	
	li $t4, 1
	sw $t4, lastMove3
	
	j zom4Move
	
goDown3:
	lw $t4, lastMove3
	
	li $v0, 30
	syscall
	move $s7, $a0
	
	
	li $t0, 4
	lw $a0, zom3
	lw $a1, zom3($t0) 
	
	beq $t4, 3, zom3Move
	
	li $a2, 0
	jal _setLED

	addi $a1, $a1, 1
	
	jal _getLED
	
	beq $v0, 3, lost
	beq $v0, 2, zom3Move
	
	li $a2, 1
	
	li $t0, 4
	sw $a0, zom3
	sw $a1, zom3($t0)
	
	jal _setLED
	li $t4, 2
	sw $t4, lastMove3
	
	j zom4Move
	
goUp3:
	lw $t4, lastMove3
	
	li $v0, 30
	syscall
	move $s7, $a0
	
	li $t0, 4
	lw $a0, zom3
	lw $a1, zom3($t0) 
	
	ble $a1, 32, reset3
	beq $t4, 2, zom3Move
	
	addi $a1, $a1, -1
	
	jal _getLED
	
	beq $v0, 3, lost
	beq $v0, 2, zom3Move
	
	addi $a1, $a1, 1
	
	li $a2, 0
	jal _setLED

	addi $a1, $a1, -1
	
	li $a2, 1
	li $t0, 4
	sw $a0, zom3
	sw $a1, zom3($t0)
	
	jal _setLED
	
	li $t4, 3
	sw $t4, lastMove3
	
	j zom4Move
	
reset3:
	li $t4, 5
	sw $t4, lastMove3
	j zom3Move
	
	
zom4Move:
	li $a1, 0	
	li $a1, 4
	li $v0, 42
	syscall
	move $a3, $a0	#generate random direction
	
	li $t5, 31
	
	sge $t0, $s0, $t5
	sge $t1, $s1, $t5
	
	add $t0, $t0, $t1
	
	beq $t0, 2, trackPlayer4AboveLeft
	
	beq $a3, 0, goRight4
	beq $a3, 1, goLeft4
	beq $a3, 2, goDown4
	beq $a3, 3, goUp4
	
	j exit
	
trackPlayer4AboveLeft:
	
	blt $s0, 31, zom4Move
	blt $s1, 31, zom4Move
	
	li $t0, 4		#word offset
	lw $a0, zom4		#load zombie1's X
	lw $a1, zom4($t0) 	#load zombie1's Y
	
	slt $t1, $s0, $a0
	slt $t2, $s1, $a1
	add $t1, $t1, $t2
	
	beq $s0, $a0, random4
	beq $s1, $a1, random4
	
	beq $t1, 1, trackPlayer4AboveRight
	beqz $t1, trackPlayer4BelowRight
	
	li $a1, 0
	li $a1, 2
	li $v0, 42
	syscall
	move $a3, $a0
	
	li $t4, 6	
	sw $t4, lastMove4
	
	beq $a3, 0, goLeft4
	beq $a3, 1, goUp4
	
trackPlayer4AboveRight:
	
	blt $s0, 31, zom4Move
	blt $s1, 31, zom4Move	
	
	li $t0, 4		#word offset
	lw $a0, zom4		#load zombie1's X
	lw $a1, zom4($t0) 	#load zombie1's Y
	
	sgt $t1, $s0, $a0
	slt $t2, $s1, $a1
	add $t1, $t1, $t2
	
	beq $s0, $a0, random4
	beq $s1, $a1, random4
	
	beq $t1, 1, trackPlayer4AboveRight
	beqz $t1, trackPlayer4BelowLeft
	
	li $a1, 0
	li $a1, 2
	li $v0, 42
	syscall
	move $a3, $a0
	
	li $t4, 6	
	sw $t4, lastMove4
	
	addi $a0, $a0, 1
	addi $a1, $a1, 1	#do not let zombie get trapped in corner
	jal _getLED
	add $t6, $v0, 0		
	
	addi $a0, $a0, 2
	addi $a1, $a1, 2	#do not let zombie get trapped in corner
	jal _getLED
	add $t6, $t6, $v0
	
	beq $t6, 4, random4
	
	beq $a3, 0, goRight4
	beq $a3, 1, goUp4


trackPlayer4BelowLeft:
	
	blt $s0, 31, zom4Move
	blt $s1, 31, zom4Move

	li $t0, 4		#word offset
	lw $a0, zom4		#load zombie1's X
	lw $a1, zom4($t0) 	#load zombie1's Y
	
	slt $t1, $s0, $a0
	sgt $t2, $s1, $a1
	add $t1, $t1, $t2
	
	beq $s0, $a0, random4
	beq $s1, $a1, random4
	
	beq $t1, 1, trackPlayer4BelowRight
	beqz $t1, trackPlayer4AboveRight
	
	li $a1, 0	
	li $a1, 2
	li $v0, 42
	syscall
	move $a3, $a0
	
	li $t4, 6	
	sw $t4, lastMove4
	
	beq $a3, 0, goLeft4
	beq $a3, 1, goDown4
	
	 	 
	
trackPlayer4BelowRight:
	
	blt $s0, 31, zom4Move
	blt $s1, 31, zom4Move
	
	li $t0, 4		#word offset
	lw $a0, zom4		#load zombie1's X
	lw $a1, zom4($t0) 	#load zombie1's Y
	
	sgt $t1, $s0, $a0
	sgt $t2, $s1, $a1
	add $t1, $t1, $t2
	
	beq $s0, $a0, random4
	beq $s1, $a1, random4
	
	beq $t1, 1, trackPlayer4BelowLeft
	beqz $t1, trackPlayer4AboveLeft
	
	li $a1, 0	
	li $a1, 2
	li $v0, 42
	syscall
	move $a3, $a0
	
	li $t4, 6	
	sw $t4, lastMove4
	
	beq $a3, 0, goRight4
	beq $a3, 1, goDown4
	
random4:
	li $a1, 0	
	li $a1, 4
	li $v0, 42
	syscall
	move $a3, $a0	#generate random direction
	
	beq $a3, 0, goRight4
	beq $a3, 1, goLeft4
	beq $a3, 2, goDown4
	beq $a3, 3, goUp4


goRight4:
	lw $t4, lastMove4
	
	li $v0, 30
	syscall
	move $s7, $a0
	
	li $t0, 4
	lw $a0, zom4
	lw $a1, zom4($t0) 
	
	bge $a0, 62, reset4	#special case - do not allow zombie to leave the board in lower right corner
	beq $t4, 1, zom4Move
	
	li $a2, 0
	jal _setLED

	addi $a0, $a0, 1
	
	jal _getLED
	
	beq $v0, 3, lost
	beq $v0, 2, zom4Move
	
	li $a2, 1
	li $t0, 4
	sw $a0, zom4
	sw $a1, zom4($t0)
	
	jal _setLED
	li $t4, 0
	sw $t4, lastMove4
	
	j poll

goLeft4:
	lw $t4, lastMove4
	
	li $v0, 30
	syscall
	move $s7, $a0
	
	
	li $t0, 4
	lw $a0, zom4
	lw $a1, zom4($t0) 
	
	ble $a0, 32, reset4
	beq $t4, 0, zom4Move
	
	addi $a0, $a0, -1
	
	jal _getLED
	
	beq $v0, 3, lost
	beq $v0, 2, zom4Move
	
	addi $a0, $a0, 1
	
	li $a2, 0
	jal _setLED

	addi $a0, $a0, -1
	
	li $a2, 1
	li $t0, 4
	sw $a0, zom4
	sw $a1, zom4($t0)
	
	jal _setLED
	
	li $t4, 1
	sw $t4, lastMove4
	
	j poll
	
goDown4:
	lw $t4, lastMove4
	
	li $v0, 30
	syscall
	move $s7, $a0
	
	
	li $t0, 4
	lw $a0, zom4
	lw $a1, zom4($t0) 
	
	bge $a1, 62, reset4	#special case - do not allow zombie to leave the board in lower right corner
	beq $t4, 3, zom4Move
	
	li $a2, 0
	jal _setLED

	addi $a1, $a1, 1
	
	jal _getLED
	
	beq $v0, 3, lost
	beq $v0, 2, zom4Move
	
	li $a2, 1
	
	li $t0, 4
	sw $a0, zom4
	sw $a1, zom4($t0)
	
	jal _setLED
	li $t4, 2
	sw $t4, lastMove4
	
	j poll
	
goUp4:
	lw $t4, lastMove4
	
	li $v0, 30
	syscall
	move $s7, $a0
	
	li $t0, 4
	lw $a0, zom4
	lw $a1, zom4($t0) 
	
	ble $a1, 32, reset4
	beq $t4, 2, zom4Move
	
	addi $a1, $a1, -1
	
	jal _getLED
	
	beq $v0, 3, lost
	beq $v0, 2, zom4Move
	
	addi $a1, $a1, 1
	
	li $a2, 0
	jal _setLED

	addi $a1, $a1, -1
	
	li $a2, 1
	li $t0, 4
	sw $a0, zom4
	sw $a1, zom4($t0)
	
	jal _setLED
	
	li $t4, 3
	sw $t4, lastMove4
	
	j poll		#wait for next player move or 500ms to move zombies again
	
reset4:
	li $t4, 5
	sw $t4, lastMove4
	j zom4Move
	

	# void _setLED(int x, int y, int color)
	#   sets the LED at (x,y) to color
	#   color: 0=off, 1=red, 2=yellow, 3=green
	#
	# arguments: $a0 is x, $a1 is y, $a2 is color
	# trashes:   $t0-$t3
	# returns:   none
	#
_setLED:
	# byte offset into display = y * 16 bytes + (x / 4)
	sll	$t0,$a1,4      # y * 16 bytes
	srl	$t1,$a0,2      # x / 4
	add	$t0,$t0,$t1    # byte offset into display
	li	$t2,0xffff0008 # base address of LED display
	add	$t0,$t2,$t0    # address of byte with the LED
	# now, compute led position in the byte and the mask for it
	andi	$t1,$a0,0x3    # remainder is led position in byte
	neg	$t1,$t1        # negate position for subtraction
	addi	$t1,$t1,3      # bit positions in reverse order
	sll	$t1,$t1,1      # led is 2 bits
	# compute two masks: one to clear field, one to set new color
	li	$t2,3		
	sllv	$t2,$t2,$t1
	not	$t2,$t2        # bit mask for clearing current color
	sllv	$t1,$a2,$t1    # bit mask for setting color
	# get current LED value, set the new field, store it back to LED
	lbu	$t3,0($t0)     # read current LED value	
	and	$t3,$t3,$t2    # clear the field for the color
	or	$t3,$t3,$t1    # set color field
	sb	$t3,0($t0)     # update display
	jr	$ra
	
	# int _getLED(int x, int y)
	#   returns the value of the LED at position (x,y)
	#
	#  arguments: $a0 holds x, $a1 holds y
	#  trashes:   $t0-$t2
	#  returns:   $v0 holds the value of the LED (0, 1, 2 or 3)
	#
_getLED:
	# byte offset into display = y * 16 bytes + (x / 4)
	sll  $t0,$a1,4      # y * 16 bytes
	srl  $t1,$a0,2      # x / 4
	add  $t0,$t0,$t1    # byte offset into display
	la   $t2,0xffff0008
	add  $t0,$t2,$t0    # address of byte with the LED
	# now, compute bit position in the byte and the mask for it
	andi $t1,$a0,0x3    # remainder is bit position in byte
	neg  $t1,$t1        # negate position for subtraction
	addi $t1,$t1,3      # bit positions in reverse order
    	sll  $t1,$t1,1      # led is 2 bits
	# load LED value, get the desired bit in the loaded byte
	lbu  $t2,0($t0)
	srlv $t2,$t2,$t1    # shift LED value to lsb position
	andi $v0,$t2,0x3    # mask off any remaining upper bits
	jr   $ra
