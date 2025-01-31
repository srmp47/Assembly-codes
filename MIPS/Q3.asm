#Using the sw ,lw and logic instructions, an array of length 7 is read from memory.
# If the array is palindrome, register a0 becomes one, otherwise it becomes zero.
 	.data
	array: .word 10, 20, 30, 40, 50, 60, 70 # arbitrary array of length 7
	length: .word 7
	one: .word 1

	.text
	
	.globl main
main:
	la $t0, array
	
	lw $t1 , ($t0)
	lw $t2 , 24($t0)
	xor $t3 , $t1 , $t2
	xori $t4 , $t3 , -1
	srl $t3 , $t3 , 31
	addi $t4 , $t4 , 1
	srl $t4 , $t4 , 31
	or $t5 , $t3 , $t4
	
	lw $t1 , 4($t0)
	lw $t2 , 20($t0)
	xor $t3 , $t1 , $t2
	xori $t4 , $t3 , -1
	srl $t3 , $t3 , 31
	addi $t4 , $t4 , 1
	srl $t4 , $t4 , 31
	or $t6 , $t3 , $t4
	
	lw $t1 , 8($t0)
	lw $t2 , 16($t0)
	xor $t3 , $t1 , $t2
	xori $t4 , $t3 , -1
	srl $t3 , $t3 , 31
	addi $t4 , $t4 , 1
	srl $t4 , $t4 , 31
	or $t7 , $t3 , $t4
	
	or $t5 , $t5 , $t6
	or $t5 , $t5 , $t7
	
	xori $t5 , $t5 , 1
	move $a0 , $t5
	
	li $v0 , 1
	syscall