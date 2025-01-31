
#Adding and subtracting 32-bit numbers using logical instructions (and , nor , or , xor)
#input:
# 25
# +
# 36
# output:
# 61
# input:
# -17
# -
# 5
# output:
# -22


.text

.globl main

main:
	li $v0 , 5
	syscall
	add $t1 , $zero , $v0
	
	li $v0 , 12
	syscall
	add $t2 , $zero , $v0
	
	li $v0 , 5
	syscall
	add $t3 , $zero , $v0
	
	li $t4 , 44
	li $t6 , 1
	sub $t2 , $t4 , $t2
	and $t5 , $t3 , $t6
	add $t7 , $t5 , $t1
	xor $t0 , $t2 , $t3
	add $t7 , $t7 , $t0
	sub $t5 , $t5 , $t6
	and $t5 , $t5 , $t2
	sub $t7 , $t7 , $t5
	
	add $a0 , $zero , $t7
	li $v0 , 1
	syscall 