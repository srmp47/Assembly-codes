#Implementing instructions sra and srav without using arithmetic shift and left shift
# and multiplication and division instructions
.text

.macro shra($arg,%number)
li $s0 , %number
shrav($arg,$s0)
.end_macro 

.macro shrav($arg,$n)
li $t0 , 0
loop:
	beq $n , $t0 , finish
	shift($arg)
	addi $t0 , $t0 , 1
	j loop
finish:
move $a0 , $arg
.end_macro 

.macro shift($arg)
slt $t1 , $arg , $zero
bne $t1 , $zero , ltz
srl $arg , $arg , 1
j end
ltz:
xori $arg , $arg , -1
srl $arg , $arg , 1
xori $arg , $arg , -1
end:
.end_macro

.globl main
main:
	li $v0 , 1
	li $s1 , 64
	li $t5 , 4
	
	shrav($s1,$t5)
	syscall
	shra($s1,1)
	syscall
