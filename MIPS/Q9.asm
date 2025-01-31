#Print the result of a cubic function by taking the function input from the user,
# assuming that the function coefficients are stored in memory.
.data
	A : .word 5
	B : .word 4
	C : .word 3
	D : .word 2

.text

.globl main

main:

	li $v0 , 5
	syscall
	move $t0 , $v0
	move $t6 , $v0
	
	lw $t1 , A
	lw $t2 , B
	lw $t3 , C
	lw $t4 , D
	
	add $a0 , $t4 , $zero
	
	mul $t5 , $t3 , $t6
	add $a0 , $a0 , $t5
	
	mul $t6 , $t6 , $t0
	
	mul $t5 , $t2 , $t6
	add $a0 , $a0 , $t5
	
	mul $t6 , $t6 , $t0
	
	mul $t5 , $t1 , $t6
	add $a0 , $a0 , $t5
	
	li $v0 , 1
	syscall
