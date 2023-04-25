data segment
    A1   DB 'AbcdaEFgh'
N=$-A1
    A2   DB N DUP('$')
data ends

codesg segment
           ASSUME DS:data,CS:codesg
    start: 
    ;在此添加源代码
           MOV    AX,data
           MOV    DS,AX
           LEA    SI,A1
           LEA    DI,A2
           MOV    CX,N
    LOP:   
           MOV    AL,[SI]
           INC    SI
           CMP    AL,'z'
           JA     NEXT
           CMP    AL,'a'
           JB     NEXT
           MOV    [DI],AL
           INC    DI
    NEXT:  
           LOOP   LOP
           LEA    DX,A2
           MOV    AH,9
           INT    21H

           MOV    AH,4CH
           INT    21H
codesg ends
end start