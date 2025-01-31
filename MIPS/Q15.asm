# A number of up to 10 digits is received from the user and recursively determined to be a palindrome.
.data
   array: .space 40
.text
.globl main

main:
    li $v0, 5         
    syscall
    move $a0, $v0     
    jal get_num_of_digits
    move $a0 , $v0
    li $t0 , 4
    mul $a0 , $a0 , $t0
    sub $a0 , $a0 , $t0
    li $a1, 0
    jal recursive_function
    move $a0 , $v0
    li $v0, 1
    syscall
    li $v0 ,10
    syscall

get_num_of_digits:
    subi $sp , $sp, 4
    sw $a0 , 0($sp)
    li $v0, 0           
    li $t1, 10       
    la $t2 , array   
    beqz $a0, zero_case 
lable:
    div $a0, $t1      
    mflo $a0 
    mfhi $t3   
    sw $t3 , 0($t2)
    addi $t2 , $t2 , 4        
    addi $v0, $v0, 1   
    bnez $a0, lable  
    lw $a0 , 0($sp)
    addi $sp , $sp , 4   
    jr $ra             
zero_case:
    li $v0, 1
    lw $a0 , 0($sp)
    addi $sp , $sp , 4            
    jr $ra              


recursive_function:
li $v0 , 1
subi $sp , $sp , 12
sw $ra , 0($sp)
sw $a0 , 4($sp)
sw $a1 , 8($sp)
sub $s0 , $a0 , $a1
li $t4 , 4
li $t5 , 2
div $s0 , $s0 , $t4
li $s5 , 1
beq $s0 , $zero , first_section
beq $s0 , $t5 , first_section
beq $s0 , $v0 , first_section
j main_section
first_section:
li $s5 , 0
main_section:
la $s0 , array
add $t0 , $s0 , $a0
add $t1 , $s0 , $a1
lw $t0 , 0($t0)
lw $t1 , 0($t1)
bne $t0 , $t1 , not_equal
beq $s5 , $zero , end
addi $a1 , $a1 , 4
subi $a0 , $a0 , 4
jal recursive_function
beq $v0 , 0 , not_equal
j end
not_equal:
li $v0 , 0
j end

end:
lw $ra , 0($sp)
lw $a0 , 4($sp)
lw $a1 , 8($sp)
addi $sp , $sp , 12
jr $ra


