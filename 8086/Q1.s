;A string is taken from user input and the largest substring without duplicate 
;characters is printed.
global asm_main

section .data
scan_format db "%s", 0          
print_length_format db "Length: %d", 10, 0 
string resb 80                 
output resb 80
print_format db "%s", 10, 0      
r8_print_format db "NUMBER:%d %d", 10, 0 
output_length db "le : %d" ,10 , 0

section .text
extern scanf, printf , fgets , stdin
asm_main:
    sub rsp, 8
    lea rdi, [string]  
    mov esi, 256         
    mov rdx, [stdin]     
    call fgets
    lea rsi, [string]
    call strip_newline
    lea rsi, [string]  
    xor rcx, rcx    
        lea rsi, [string]    
convert_to_lowercase:
    mov al, byte [rsi]     
    test al, al            
    je convert_done       
    cmp al, 'A'            
    jl skip_conversion     
    cmp al, 'Z'            
    jg skip_conversion     
    add byte [rsi], 32     
skip_conversion:
    inc rsi                
    jmp convert_to_lowercase
convert_done:

  lea rsi , [string]
  xor rcx , rcx

length_loop:
    cmp byte [rsi], 0            
    je end_loop                  
    inc rcx                      
    inc rsi                      
    jmp length_loop
end_loop:

    mov r8, 0                    
    mov r9, 0                   
    mov r14 , 0
    mov r15 , 0
    

first_loop:
     cmp r9, rcx 
    je end_first_loop
    add r9, 1
    mov r10, r8
second_loop:
    cmp r10, r9
    je end_second_loop
    lea r11, [string]
    add r11, r10
    mov r11b, byte [r11]
    lea r12, [string]
    add r12, r9
    mov r12b, byte[r12]
    cmp r12, r11
    je add_to_start
    add r10, 1
    jmp second_loop
add_to_start:
    mov rsi , r15
    sub rsi , r14
    mov r13 , r9
    sub r13 , r8
    cmp r13 , rsi
    jg update_output
    add r10 , 1
    mov r8, r10
   jmp second_loop
 update_output:
 mov r14 , r8
 mov r15 , r9
 add r10 , 1
 mov r8 , r10
 jmp second_loop

end_second_loop:
    jmp first_loop
end_first_loop:
 mov rsi , r15
    sub rsi , r14
    mov r13 , r9
    sub r13 , r8
    cmp r13 , rsi
    jg update
    jmp go
    update:
     mov r14 , r8
 mov r15 , r9
    go:



      mov r8, 0                 
   mov r9, r15             
   sub r9, r14               
   mov r10, string          
   add r10, r14             

output_loop:
    cmp r8, r9              
    je end_output_loop      
    movzx rax, byte [r10]    
    mov rsi, r10            
    mov rdi, 1              
    mov rdx, 1              
    mov rax, 1              
    syscall                 
    inc r10                 
    inc r8                  
    jmp output_loop          

end_output_loop:

   mov rdi , output
   call printf
    

    add rsp, 8


    mov rax, 60                 
    xor rdi, rdi                  
    syscall



strip_newline:



    xor rdi, rdi         
newline_loop:
    mov al, [rsi + rdi]  
    test al, al           
    je strip_done
    cmp al, 0x0A         
    jne next_char
    mov byte [rsi + rdi], 0 
    jmp strip_done
next_char:
    inc rdi
    jmp newline_loop
strip_done:
    ret

