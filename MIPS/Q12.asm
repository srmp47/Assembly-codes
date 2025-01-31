#The input is first the number n which represents the number of members of the array.
# Then n numbers which are members of this array are received. 
#The output is the number of pairs of numbers which are prime to each other.
.data 
array: .space 400
.text
.globl main

main:

li $v0 , 5
syscall

move $t0 , $v0 
li $t1 , 0

li $s0 , 0

la $t2 , array
move $t3 , $t2


input_loop:
beq $t1 , $t0 , end_input
addi $t1 , $t1 , 1
li $v0 , 5
syscall
sw $v0 , 0($t3)
addi $t3 , $t3 , 4
j input_loop

end_input:

li $t1 , 0 
first_loop:
move  $t3 , $t1 
addi $t3 , $t3 , 1
beq $t1 , $t0 end_loops
addi $t1 , $t1 , 1
li $t6 , 4
mul $t4 , $t1 , $t6
subi $t4 , $t4, 4
add $t4 , $t2, $t4
lw $a0 , 0($t4)
second_loop:
beq $t3 , $t0 , first_loop
addi $t3 , $t3 , 1
li $t6 , 4
mul $t5 , $t3 , $t6
subi $t5,$t5,4
add $t5 , $t2 , $t5
lw $a1 , 0($t5)
jal get_remaining
li $t6 , 1
move $t7, $v0
bne $t6 , $t7 , second_loop

addi $s0 , $s0 , 1
j second_loop


end_loops:
move $a0 , $s0
li $v0 , 1
syscall
li $v0 , 10
syscall




get_remaining:
subi $sp , $sp , 24
sw $ra , 0($sp)
sw  $t0 , 4($sp)
sw $t1 , 8($sp)
sw $t2 , 16($sp)
sw $t3 , 20($sp)

move $t1 , $a0
move $t2 , $a1
loop:
# check a0 % a1
div $t1 , $t2
mfhi $t0
beqz $t0 , end_function
move $t1 , $t2
move $t2 , $t0
j loop
end_function:
move $v0 , $t2
lw $ra , 0($sp)
lw  $t0 , 4($sp)
lw $t1 , 8($sp)
lw $t2 , 16($sp)
lw $t3 , 20($sp)
addi $sp , $sp , 24
jr $ra



