; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example
Include Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
    prompt1       BYTE "Enter string for 'h' search: ",0
    prompt2       BYTE "Enter string for second input: ",0
    inputBuffer1  BYTE 50 DUP(0)   
    inputBuffer2  BYTE 50 DUP(0)    

.code
main PROC
    mov edx, OFFSET prompt1
    call WriteString

    mov edx, OFFSET inputBuffer1
    mov ecx, 50           ; maxmium characters to read
    call ReadString

    push 'h'                  ; search char first search
    push OFFSET inputBuffer1   
    call arrayFind             
    mov dl, al                

    mov edx, OFFSET prompt2
    call WriteString

    mov edx, OFFSET inputBuffer2
    mov ecx, 50
    call ReadString

    mov esi, OFFSET inputBuffer2
convert_loop:
    mov al, [esi]
    cmp al, 0
    je convert_done       ; end of string reached
    cmp al, 'a'
    jb next_char
    cmp al, 'z'
    ja next_char
    sub al, 32            
    mov [esi], al
next_char:
    inc esi
    jmp convert_loop
convert_done:

    push 'R'                   ; search char second search
    push OFFSET inputBuffer2  
    call arrayFind             
    mov dh, al                

    mov al, dl           
    add al, dh            
    cmp al, 25
    jg exit_program      
   
infinite_loop:
    jmp infinite_loop

exit_program:
    call ExitProcess
main ENDP

arrayFind PROC
    push ebp
    mov ebp, esp
    mov esi, [ebp+8]      ; esi points to the string
    mov bl, [ebp+12]      ; bl holds the search character
find_loop:
    mov al, [esi]
    cmp al, 0             
    je not_found
    cmp al, bl
    je found
    inc esi
    jmp find_loop
found:
    jmp cleanup
not_found:
    mov al, 0             
cleanup:
    pop ebp
    ret 8                 
arrayFind ENDP

END main
