# First, two polynomials are taken from the user. In this way, for each polynomial,
# its degree is first obtained and then its coefficients are taken from the highest #
to the lowest coefficient. Then the product of the two polynomials is printed as a string.
# So that: Terms with zero coefficients are not displayed. Coefficient 1 is not displayed.
# If the term on the left is positive, its sign is not displayed.
#input:
# 3
# 1
# 1
# 0
# 5
# 2
# -2
# 0
# 2
# output:
# -2x^5-2x^4+2x^3-8x^2+10
.data
array1: .space 404          
array2: .space 404          
result_array: .space 808    
negative_sign: .asciiz "-"  
positive_sign: .asciiz "+"  
power_sign: .asciiz "x^"    


.text
.globl main

main:
    
    la $t5, result_array   
    li $t6, 202             
clear_result_array:
    beqz $t6, start_input   
    sw $zero, 0($t5)        
    addi $t5, $t5, 4       
    subi $t6, $t6, 1     
    j clear_result_array

start_input:

    li $v0, 5
    syscall
    move $t0, $v0
    li $t1, -1
    la $s0, array1
    la $s1, array2
get_first_numbers:
    beq $t0, $t1, end_get_first_numbers
    addi $t1, $t1, 1
    li $v0, 5
    syscall
    li $t3, 4
    mul $t2, $t1, $t3
    add $t2, $t2, $s0
    sw $v0, 0($t2)
    j get_first_numbers
end_get_first_numbers:


    li $v0, 5
    syscall
    move $t1, $v0
    li $t4, -1
get_second_numbers:
    beq $t1, $t4, end_get_second_numbers
    addi $t4, $t4, 1
    li $v0, 5
    syscall
    li $t3, 4
    mul $t2, $t4, $t3
    add $t2, $t2, $s1
    sw $v0, 0($t2)
    j get_second_numbers
end_get_second_numbers:


    add $t2, $t0, $t1     
    
    
    li $t5, 0   
    addi $s7 , $t0 , 1            
multiply_terms:
    beq $t5, $s7, end_multiply_terms  
    li $t6, 0            
     addi $s6 , $t1 , 1
inner_loop:
    beq $t6, $s6, end_inner_loop    
    

    sub $t7, $t0, $t5       
    sub $t8, $t1, $t6       
    add $t9, $t7, $t8      
    

    li $t3, 4               
    mul $t7, $t5, $t3      
    mul $t8, $t6, $t3       
    add $t7, $t7, $s0       
    add $t8, $t8, $s1       
    lw $t4, 0($t7)          
    lw $t7, 0($t8)          
    

    mul $t4, $t4, $t7       
    

    sub $t7, $t2, $t9      
    mul $t7, $t7, $t3       
    la $t8, result_array    
    add $t8, $t8, $t7       
    lw $t9, 0($t8)          
    add $t9, $t9, $t4       
    sw $t9, 0($t8)          
    
 
    addi $t6, $t6, 1
    j inner_loop
end_inner_loop:

    addi $t5, $t5, 1
    j multiply_terms
end_multiply_terms:


    la $t5, result_array
    move $t6, $t2
    li $t7, 0
print_result:
    bgez $t6, print_term    
    j end_print_result     

print_term:
    li $t3, 4               
    sub $t8, $t2, $t6       
    mul $t8, $t8, $t3       
    add $t9, $t5, $t8    
    lw $t4, 0($t9)          


    beqz $t4, skip_term


    beq $t7, 0, check_first_term


    bltz $t4, print_minus
    bgtz $t4, print_plus   
    j print_coefficient

check_first_term:

    bltz $t4, print_minus

    addi $t7, $t7, 1        
    j print_coefficient

print_plus:

    la $a0, positive_sign
    li $v0, 4
    syscall
    addi $t7, $t7, 1        
    j print_coefficient

print_minus:
    
    la $a0, negative_sign
    li $v0, 4
    syscall
    addi $t7, $t7, 1        
    j negate_coefficient

negate_coefficient:
   
    negu $t4, $t4

print_coefficient:
    
    li $s6, 1
    beq $t4, $s6, skip_coefficient_if_one


    li $v0, 1
    move $a0, $t4
    syscall

skip_coefficient_if_one:

    beq $t6 , $zero , print_one
    j print_degree

print_one:
bne $t4 , $s6 , skip_term
li $a0 , 1
li $v0 ,1
syscall
j skip_term

print_degree:

    la $a0, power_sign
    li $v0, 4
    syscall
    li $v0, 1
    move $a0, $t6
    syscall

skip_term:
    
    subi $t6, $t6, 1
    j print_result



end_print_result:
    li $v0, 10              
    syscall
