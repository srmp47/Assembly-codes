#Extracting the maximum values ​​of num1 and num2 and placing it in max_value
# using addi , xor , mul , add , sub , sw , lw instructions
	.data
	num1 : .word 7
	num2 : .word 7
	max_value : .word 0
	.text
	
	.globl main
main:
	lw $t0 , num1
	lw $t1 , num2
	sub $t2 , $t0 , $t1
	sub $t3 , $t1 , $t0
	srl $t4 , $t2 , 31
	srl $t5 , $t3 , 31
	mul $t2 , $t1 , $t4
	mul $t3 , $t0 , $t5
	add $t6 , $t2 , $t3
	
	xor $t2, $t0 , $t1
	sub $t3 , $zero , $t2
	srl $t2 , $t2 , 31
	srl $t3 , $t3 , 31
	xor $t2 , $t2 , $t3
	addi $t2 , $t2 , -1
	mul $t2 , $t2 , $t2
	mul $t0 , $t0 , $t2
	add $t6 , $t6 , $t0
		
	sw $t6 , max_value
	move $a0 , $t6