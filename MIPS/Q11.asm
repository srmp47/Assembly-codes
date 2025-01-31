#Two numbers A and B are received from the user and A to the power of B is calculated recursively.
# The order of execution of this code is O(log(b))
.text
.globl main

main:
    li $v0 , 5
    syscall 
    move $a0 , $v0
    li $v0 , 5
    syscall
    move $a1 , $v0
    
    jal power          
    move $t2, $v0      
      
    li $v0, 1          
    move $a0, $t2      
    syscall

    li $v0, 10
    syscall

power:

    addi $sp, $sp, -8     
    sw $ra, 0($sp)         
    sw $a0, 4($sp)         

    beq $a1, $zero, base_case

    rem $t0, $a1, 2     
    beq $t0, $zero, even_case

    subi $a1, $a1, 1       
    jal power              
    lw $a0, 4($sp)        
    mul $v0, $v0, $a0      
    j end_power            

even_case:
    div $a1, $a1, 2        
    jal power              
    mul $v0, $v0, $v0      
    j end_power           

base_case:
    li $v0, 1              

end_power:

    lw $ra, 0($sp)         
    addi $sp, $sp, 8       
    jr $ra                 
