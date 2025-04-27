# maximum.asm program
# CS 64, Z.Matni
#
# Get 3 integer inputs from the user (std.in)
# Reveal the maximum absolute value (e.g., entering -3, 2, 1 will give the answer 3)
# See assignment description for details

#Data Area (i.e. memory setup directive)
.data
	# TODO: Complete these incomplete declarations / initializations

	.asciiz "Enter the next number:\n"
    .asciiz "\n"

#Text Area (i.e. instructions/code directive)
.text

main:
	# TODO: Write your code here
    # You can have other labels expressed here, if you need to
	li $v0, 5
	syscall
	move $t0, $v0
	li $v0, 5
	syscall
	move $t1, $v0
	li $v0, 5
	syscall
	move $t2, $v0
	
setT0Pos:
	slt $t4, $t0, $zero
	beq $t4, $zero, setT1Pos
	#Flip all bits with logical not through nor since there is no not op
	nor $t0, $t0, $zero
	#Add 1
	addi $t0, $t0, 1

setT1Pos:
	slt $t4, $t1, $zero
	beq $t4, $zero, setT2Pos
	#Flip all bits with logical not through nor since there is no not op
	nor $t1, $t1, $zero
	#Add 1
	addi $t1, $t1, 1

setT2Pos:
	slt $t4, $t2, $zero
	beq $t4, $zero, findLargest
	#Flip all bits with logical not through nor since there is no not op
	nor $t2, $t2, $zero
	#Add 1
	addi $t2, $t2, 1

findLargest:
	slt $t4, $t0, $t1
	bne $t4, $zero, t0LTt1 		#if $t0<$t1 --> 1, go to t0 less than t1
	slt $t4, $t0, $t2			#else t0 > t1, see if it's greater than t2
	beq $t4, $zero, print_t0   	#if $t0>=$t2, print_t0
	j print_t2 					#else print_t2
	
t0LTt1:
	slt $t4, $t1, $t2
	bne $t4, $zero,	print_t2	#if $t1<$t2 --> 1, print_t2
	j print_t1					#else $t1 is greatest, print_t1

print_t0:
	li $v0, 1
	move $a0, $t0
	syscall
	j exit

print_t1:
	li $v0, 1
	move $a0, $t1
	syscall
	j exit

print_t2:
	li $v0, 1
	move $a0, $t2
	syscall

exit:
	li $v0, 10
	syscall