#Implementation of a stack machine without using the MIPS stack.
# The number of push instructions  is not specified and static memory cannot be used.
# Finally, the value on the stack is printed.
# This machine contains these instructions:
# push , pop , add , sub , mul , ext
#input:
# psh
# 4
# psh
# 10
# psh
# 0
# psh
# -7
# sub
# add
# mul
# pop
# ext
#output:
# 68
.data
buffer: .space 20       
cmd_psh: .asciiz "psh"   
cmd_pop: .asciiz "pop"  
cmd_add: .asciiz "add"     
cmd_sub: .asciiz "sub"   
cmd_mul: .asciiz "mul"   
cmd_ext: .asciiz "ext"     



.text
.globl main

main:

    li $v0, 9               
    li $a0, 1024            
    syscall
    move $t0, $v0         
    move $t1, $t0          

read_instruction:

    li $v0, 8               
    la $a0, buffer         
    li $a1, 20             
    syscall


    jal strip_newline


    la $t2, cmd_psh
    jal compare_cmd
    beq $v0, 1, handle_psh


    la $t2, cmd_pop
    jal compare_cmd
    beq $v0, 1, handle_pop


    la $t2, cmd_add
    jal compare_cmd
    beq $v0, 1, handle_add


    la $t2, cmd_sub
    jal compare_cmd
    beq $v0, 1, handle_sub


    la $t2, cmd_mul
    jal compare_cmd
    beq $v0, 1, handle_mul


    la $t2, cmd_ext
    jal compare_cmd
    beq $v0, 1, handle_exit

    j read_instruction

handle_psh:

    li $v0, 5               
    syscall
    move $a0, $v0
    jal push
    j read_instruction

handle_pop:

    jal pop

    move $a0, $v0
    li $v0, 1             
    syscall
    

    li $a0, 10      
    li $v0, 11         
    syscall
    
    j read_instruction

handle_add:

    jal pop
    move $t2, $v0
    jal pop
    add $a0, $v0, $t2
    jal push
    j read_instruction

handle_sub:

    jal pop
    move $t2, $v0
    jal pop
    sub $a0, $v0, $t2
    jal push
    j read_instruction

handle_mul:

    jal pop
    move $t2, $v0
    jal pop
    mul $a0, $v0, $t2
    jal push
    j read_instruction

handle_exit:

    li $v0, 10        
    syscall

push:

    sw $a0, 0($t1)
    addi $t1, $t1, 4        
    jr $ra

pop:

    beq $t0, $t1, read_instruction


    addi $t1, $t1, -4       
    lw $v0, 0($t1)         
    jr $ra



strip_newline:
    
    la $t3, buffer
strip_loop:
    lb $t4, 0($t3)
    beqz $t4, strip_done   
    beq $t4, 10, strip_null 
    addi $t3, $t3, 1
    j strip_loop
strip_null:
    sb $zero, 0($t3)        
strip_done:
    jr $ra

compare_cmd:
    
    la $t3, buffer         
    li $v0, 1               
compare_loop:
    lb $t4, 0($t3)          
    lb $t5, 0($t2)          
    bne $t4, $t5, compare_not_equal 
    beqz $t4, compare_equal        
    addi $t3, $t3, 1     
    addi $t2, $t2, 1
    j compare_loop
compare_not_equal:
    li $v0, 0               
    jr $ra
compare_equal:
    li $v0, 1              
    jr $ra
