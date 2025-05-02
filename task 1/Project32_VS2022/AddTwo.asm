; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example
Include Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
    dataArray DWORD 5 DUP(?)              
    arraySum  DWORD 0                      
    prompt1   BYTE "Enter a number: ", 0   
    prompt2   BYTE "Enter a number for comparison: ", 0  
    mssg1  BYTE "Sum is Greater than EAX", 0
    mssg2  BYTE "Sum is Less than EAX", 0
    mssg3 BYTE "Comparison Result", 0

.code
main PROC
    mov esi, OFFSET dataArray          
    mov ecx, 5                         ;because array is 5 integers
l1:
    mov edx, OFFSET prompt1            
    call WriteString
    call ReadInt                        
    mov [esi], eax                      
    add esi, 4                          
    loop l1

   
    mov esi, OFFSET dataArray          
    mov ecx, 5                         
    xor eax, eax                        ; clear eax
l2:
    add eax, [esi]                     
    add esi, 4                         
    loop l2
    mov arraySum, eax                

   
    mov edx, OFFSET prompt2           
    call WriteString
    call ReadInt                       

   
    mov edx, arraySum                  
    cmp edx, eax
    je exit_program                    
    ja greater_than                     
    jb less_than                        

greater_than:
    call message1
    jmp exit_program

less_than:
    call message2

exit_program:
    call ExitProcess
main ENDP



message1 PROC
    push 0
    push OFFSET mssg1
    push OFFSET mssg3
    push 0
    call MessageBoxA
    ret
message1 ENDP

message2 PROC
    push 0
    push OFFSET mssg2
    push OFFSET mssg3
    push 0
    call MessageBoxA
    ret
message2 ENDP

END main
