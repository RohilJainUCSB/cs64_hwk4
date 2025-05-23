# swap_array.asm program
# CS 64, Z.Matni
#
# IMPORTANT: READ, BUT DO NOT CHANGE ANY OF THE CODE IN THIS PROGRAM
#           THAT IS ALREADY THERE! ONLY ADD YOUR NEW CODE WHERE 
#           IT SAYS TODO SO, i.e. IN THE doSwap: AREA.

.data
# Data Area.  Note that while this is typically only
# For global immutable data, for SPIM, this also includes
# mutable data.        

incorrect:  .asciiz "---TEST FAILED---\n"
before:     .asciiz "Before:\n"
after:      .asciiz "After:\n"
comma:      .asciiz ", "
newline:    .asciiz "\n"
        
expectedMyArray:
        .word 17 29 20 27 22 25 24 23 26 21 28 19
myArray:
        .word 29 17 27 20 25 22 23 24 21 26 19 28

.text
# Print everything in the array (without use of a loop)
# Used as a function/sub-routine

printArray: # Again: DO NOT CHANGE THIS CODE BLOCK!
        la $t0, myArray

        li $v0, 1
        lw $a0, 0($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall
        
        li $v0, 1
        lw $a0, 4($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 8($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 12($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 16($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 20($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 24($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 28($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 32($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall
		
	li $v0, 1
        lw $a0, 36($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 40($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 44($t0)
        syscall
        li $v0, 4
        la $a0, newline
        syscall

        jr $ra
        
checkArrays:  # Again: DO NOT CHANGE THIS CODE BLOCK!
        # $t0: p1
        # $t1: p2
        # $t2: limit
        
        la $t0, expectedMyArray
        la $t1, myArray
        addiu $t2, $t0, 44

checkArrays_loop:  # Again: DO NOT CHANGE THIS CODE BLOCK!
        slt $t3, $t0, $t2
        beq $t3, $zero, checkArrays_exit

        lw $t4, 0($t0)
        lw $t5, 0($t1)
        bne $t4, $t5, checkArrays_nonequal
        addiu $t0, $t0, 4
        addiu $t1, $t1, 4
        j checkArrays_loop
        
checkArrays_nonequal: # Again: DO NOT CHANGE THIS CODE BLOCK!
        li $v0, 0
        jr $ra
        
checkArrays_exit: # Again: DO NOT CHANGE THIS CODE BLOCK!
        li $v0, 1
        jr $ra
        
main:   # Again: DO NOT CHANGE THIS CODE BLOCK!
        # Print array "before"
        la $a0, before
        li $v0, 4
        syscall

        jal printArray
        
        # Do swap function 
        jal doSwap

        # Print array "after"
        la $a0, after
        li $v0, 4
        syscall
        
        jal printArray

        # Perform check on array
        jal checkArrays
        beq $v0, $zero, main_failed
        j main_exit
        
main_failed: # Again: DO NOT CHANGE THIS CODE BLOCK!
        la $a0, incorrect
        li $v0, 4
        syscall
        
main_exit:      
	li $v0, 10
    syscall

        
# COPYFROMHERE - DO ___NOT___ REMOVE THIS LINE

doSwap:
        # TODO: translate the following C/C++ code 
        # into MIPS assembly here.
        # Use only regs $v0-$v1, $t0-$t7, $a0-$a3.
        # You may assume nothing about their starting values.
        #
        #
        # unsigned int x = 0; 
        # unsigned int y = 1; 
        # while (x < 11) { 
        #    int temp = myArray[x]; 
        #    myArray[x] = myArray[y]; 
        #    myArray[y] = temp; 
        #    x+=2; 
        #    y+=2; 
        # }

        # TODO: fill in the assembly code here:
        li $t0, 0               #x = 0
        li $t1, 1               #y = 1

        li $a1, 11 #this is a preinitialization for the loop to reduce operations (11 is the max bound)
loop:
        bge $t0, $a1, finished          #exit the loop if x >= 11
        
        sll $t3 $t0 2                   #convert index to bytes to find offset
        sll $t4 $t1 2                   #convert index to bytes to find offset
        la $t6, myArray
        addu $t5, $t6, $t3          #add offset to address (unsigned since it is an address)
        addu $t6, $t6, $t4          #add offset to address

        lw $t3, 0($t5)                   #store the actual deref value
        lw $t4, 0($t6)                   #store the actual deref value

        sw $t3, 0($t6)                  #set t6 address element to be t3
        sw $t4, 0($t5)                  #set t5 address element to be t4    #no need for a temp because the deref values are already stored

        addiu $t0, $t0, 2               #increment index (unsigned since it is an index)
        addiu $t1, $t1, 2               #increment index

        j loop

finished:
        # do ___NOT___ remove this last line
        jr $ra
