Include Irvine32.inc

.data  
    myArray DWORD -8, 6, 5, 10, -22, 0, 87, 6, 9, -90, 0  
    myArraySize DWORD 10                                    
    largestNumber DWORD ?  
    msg1 BYTE "Original array: ", 0  
    msg2  BYTE "Updated array: ", 0  

.code
main PROC  
    mov edx, OFFSET msg1  
    call WriteString  
    call Crlf  
    call DisplayArray  

    call FindLargest  

    call ShiftAndInsert  
    
    inc myArraySize

    mov edx, OFFSET msg2
    call WriteString  
    call Crlf  
    call DisplayArray  

    INVOKE ExitProcess, 0
main ENDP  

FindLargest PROC  
    mov ecx, myArraySize    
    mov esi, OFFSET myArray 
    mov eax, [esi]         
    add esi, 4              
    dec ecx              

find_loop:  
    cmp ecx, 0  
    je store_largest       

    mov edx, [esi]          
    cmp edx, eax  
    jle next_element        

    mov eax, edx           

next_element:  
    add esi, 4            
    dec ecx                 
    jnz find_loop          

store_largest:  
    mov largestNumber, eax        
    ret  
FindLargest ENDP  

ShiftAndInsert PROC  
 
    mov ecx, myArraySize    
    mov esi, OFFSET myArray 
    mov eax, myArraySize      
    dec eax               
    imul eax, 4            
    add esi, eax        
    
shift_loop:  
    mov edx, [esi]          
    mov [esi + 4], edx    
    sub esi, 4           
    dec ecx             
    jnz shift_loop        
    
    mov eax, largestNumber        
    mov [myArray], eax      
    ret  
ShiftAndInsert ENDP  

DisplayArray PROC
    mov ecx,   
    mov esi, OFFSET myArray  

display_loop:  
    mov eax, [esi]         
    call WriteInt          
    mov al, ' '           
    call WriteChar         
    add esi, 4          
    dec ecx                
    jnz display_loop       

    call Crlf             
    ret  
DisplayArray ENDP  

END main