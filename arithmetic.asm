# arithmetic.asm program
# CS 64, Z.Matni
#
# 1. Prompt the user for 3 inputs: a, b, c
# 2. Calculate 16*( a - 8*b) + 7*c using only one mult instruction
# 3. Print out the result

.text
main:
	# TODO: Write your code here!
	li $v0, 5
	syscall #capture a
	move $t0, $v0
	li $v0, 5
	syscall #capture b
	move $t1, $v0
	li $v0, 5
	syscall #capture c
	move $t2, $v0

	#Set b'=8b; 8 = 2^3 so 8b = b*2^3 = b << 3
	sll $t1, $t1, 3
	#Set a' = (a-8b)
	sub $t0, $t0, $t1
	#a''=16*a' = 2^4 * a' = a'<<4
	sll $t0, $t0, 4
	#c'=7*c
	li $t3, 7
	mult $t2, $t3
	mflo $t2
	#a0=a''+c'
	add $a0, $t0, $t2
	li $v0, 1
	syscall

exit:
	# Exit SPIM: Write your code here!
	li $v0, 10
	syscall
