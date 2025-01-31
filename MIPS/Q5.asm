#Without any jumps or conditional statements, it is checked whether the values
# ​​in registers t1 , t2 and t3 can be the lengths of the sides of a triangle. 
#If so, the value of register t4 becomes one, otherwise the value of this register becomes
# zero.
.data
num1: .word 2
num2: .word 6
num3 : .word 50

.text
.globl  main
main:
    lw $t1,num1
    lw $t2,num2
    lw $t3,num3
    li $t4 , 0
    add $t5 , $t1 , $t2
    sub $t5 , $t5 , $t3
    move $t0 , $t5
    srl $t5 , $t5 , 31
    or $t4 , $t4 , $t5
    add $t5 , $t2 , $t3
    sub $t5 , $t5 , $t1
    move $t6 , $t5
    srl $t5 , $t5 , 31
    or $t4 , $t4 , $t5
    add $t5 , $t1 , $t3
    sub $t5 , $t5 , $t2
    move $t7 , $t5
    srl $t5 , $t5 , 31
    or $t4 , $t4 , $t5
    xori $t4 , $t4 , 1
    
    srl $t1 , $t0 , 31
    xori $t0 , $t0 ,-1
    addi $t0 , $t0 , 1
    srl $t0 , $t0 , 31
    or $t0 , $t0, $t1
    
    srl $t1 , $t7 , 31
    xori $t7 , $t7 ,-1
    addi $t7 , $t7 , 1
    srl $t7 , $t7 , 31
    or $t7 , $t7, $t1
    
    srl $t1 , $t6 , 31
    xori $t6 , $t6 ,-1
    addi $t6 , $t6 , 1
    srl $t6 , $t6 , 31
    or $t6 , $t6, $t1
    
    and $t0 , $t0 , $t6
    and $t0, $t0 ,$t7
    
    and $t4 , $t0 , $t4
    
    li $v0, 10             
    syscall
