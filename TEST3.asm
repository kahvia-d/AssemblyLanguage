;为长度100字节的数组，分别赋值0-99
DSEG SEGMENT
    ARRAY DB 100 DUP(?)
DSEG ENDS

SSEG SEGMENT
SSEG ENDS

CSEG SEGMENT
           ASSUME DS:DSEG,SS:SSEG,CS:CSEG
    MAIN:  
           MOV    AX,DSEG
           MOV    DS,AX
           MOV    AL,0
           MOV    SI,OFFSET ARRAY
           MOV    CX,100
    MYLOOP:
           MOV    [SI],AL
           INC    SI
           INC    AL
           LOOP   MYLOOP
    MAIN2: 
           MOV    AH,4CH
           INT    21H
CSEG ENDS
    END MAIN