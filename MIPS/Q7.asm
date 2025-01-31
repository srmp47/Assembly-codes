#In the first line of input, a 6-bit binary number is received,
# and in the second line, a natural number between 0 and 63 is received. 
#In the first two lines of output, the binary number is first displayed in decimal
# and hexadecimal form, and then in the next two lines, the decimal number is displayed
# in binary and hexadecimal form. 
#The binary number is unsigned, and conditional statements, loops, and division
# are not used in this code.
# input:
# 111111
# 6
# output:
# 63
# 3f
# 000110
# 06
.data
	nline : .asciiz "\n"
	
	str : .space 6
.text

.macro newline
	la $t4, nline
	lw $a0 , 0($t4)
	li $v0 , 11
	syscall
.end_macro 
.macro HexaDecimalBitFromBase10($arg)
subi $t1,$arg,10
srl $t1,$t1,31
li $t0, -10
mul $t0,$t0,$t1
addi $v0,$t0,11
li $t0 , -87
mul $t0,$t0,$t1
addi $t0,$t0,87
add $a0,$t0,$arg
syscall
.end_macro 

.macro binayToDecimal($arg1,$arg2)

.end_macro 

.globl main
main:
	#-------------------------------
	
	la $a0 , str
	li $a1 , 7
	li $v0 , 8
	syscall
	
	la $a0 , str
		
	lb $t1 , 0($a0)
	
	li $s0 , 0

	subi $t1 , $t1 , 48
	mul $t0 , $t1 , 32
	add $s0 , $s0 , $t0
	
	lb $t1 , 1($a0)
	
	subi $t1 , $t1 , 48
	mul $t0 , $t1 , 16
	add $s0 , $s0 , $t0
	
	lb $t1 , 2($a0)
	
	subi $t1 , $t1 , 48
	mul $t0 , $t1 , 8
	add $s0 , $s0 , $t0
	
	lb $t1 , 3($a0)
	
	subi $t1 , $t1 , 48
	mul $t0 , $t1 , 4
	add $s0 , $s0 , $t0
	
	lb $t1 , 4($a0)
	
	subi $t1 , $t1 , 48
	mul $t0 , $t1 , 2
	add $s0 , $s0 , $t0
	
	lb $t1 , 5($a0)
	
	subi $t1 , $t1 , 48
	mul $t0 , $t1 , 1
	add $s0 , $s0 , $t0
	
	#----------------------------------
	
	li $v0 , 5
	syscall
	move $s1 , $v0
	
	#----------------------------------
	
	li $v0 , 1
	move $a0 , $s0
	syscall
	
	newline
		
	srl $t3 , $s0 , 4
	HexaDecimalBitFromBase10($t3)
	
	andi $t4 , $s0 , 15
	HexaDecimalBitFromBase10($t4)
	
	#----------------------------------
	
	newline
	
	li $v0 , 1
	
	andi $t1 , $s1 , 32
	srl $t1 , $s1 , 5
	move $a0 , $t1
	syscall
	
	andi $t1 , $s1 , 16
	srl $t1 , $t1 , 4
	move $a0 , $t1
	syscall

	andi $t1 , $s1 , 8
	srl $t1 , $t1 , 3
	move $a0 , $t1
	syscall

	andi $t1 , $s1 , 4
	srl $t1 , $t1 , 2
	move $a0 , $t1
	syscall
	
	andi $t1 , $s1 , 2
	srl $t1 , $t1 , 1
	move $a0 , $t1
	syscall
	
	andi $t1 , $s1 , 1
	srl $t1 , $t1 , 0
	move $a0 , $t1
	syscall
	
	newline
	
	srl $t3 , $s1 , 4
	HexaDecimalBitFromBase10($t3)
	
	andi $t4 , $s1 , 15
	HexaDecimalBitFromBase10($t4)
	
	#----------------------------------
