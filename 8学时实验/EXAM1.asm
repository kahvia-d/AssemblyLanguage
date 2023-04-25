data segment
    BUF  DB 'How are you! $'
data ends

codesg segment
           assume cs: codesg, ss:data
    start: 
    ;在此添加源代码
           MOV    AX,DATA
           MOV    DS,AX
           MOV    DX,OFFSET BUF
           MOV    AH,9
           INT    21H

           MOV    AX,4C00H
           INT    21H
codesg ends
end start
