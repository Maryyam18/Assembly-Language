Include irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
    marks DWORD ?           
    gradeA BYTE "A Grade", 0
    gradeB BYTE "B Grade", 0
    gradeC BYTE "C Grade", 0
    noGrade BYTE "No Grade", 0
    prompt BYTE "Enter student's marks: ", 0
    resultMessage BYTE "Student's Grade: ", 0

.code
main proc
    mov edx, OFFSET prompt
    call WriteString

    call ReadInt
    mov marks, eax 

    ; if marks <= 70
    cmp eax, 70
    jle noGradeCase  ; If marks <= 70, no grade

    ;if marks > 70 and <= 80
    cmp eax, 80
    jg checkBGrade  ; If marks > 80, check next condition

    ; assign C grade
    mov edx, OFFSET gradeC
    jmp displayGrade

checkBGrade:
    ; check if marks > 80 and <= 90
    cmp eax, 90
    jg checkAGrade  ;If marks > 90, check next condition

    ; assign B grade
    mov edx, OFFSET gradeB
    jmp displayGrade

checkAGrade:
    ; Assign A Grade (marks > 90)
    mov edx, OFFSET gradeA
    jmp displayGrade

noGradeCase:
    ; assign no grade for marks <= 70
    mov edx, OFFSET noGrade

displayGrade:
    ;print result message
    call Crlf
    mov edx, OFFSET resultMessage
    call WriteString

    ; Print the actual grade
    mov edx, OFFSET gradeA  ; temporarily store gradeA in edx
    cmp marks, 90
    jg printGrade
    mov edx, OFFSET gradeB
    cmp marks, 80
    jg printGrade
    mov edx, OFFSET gradeC
    cmp marks, 70
    jg printGrade
    mov edx, OFFSET noGrade

printGrade:
    call WriteString  
    call Crlf

    invoke ExitProcess, 0
main endp
end main