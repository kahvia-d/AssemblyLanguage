;寻找最大值
DSEG SEGMENT
    X    DW 1234H
    Y    DW 2345H
    Z    DW -1234H
    D    DW ?
DSEG ENDS

SSEG SEGMENT
SSEG ENDS

CSEG SEGMENT
          ASSUME DS:DSEG,SS:SSEG,CS:CSEG
    START:
          MOV    AX,DSEG
          MOV    DS,AX

          MOV    AX,X
          CMP    AX,Y
          JGE    PART1
          MOV    AX,Y
    PART1:
          CMP    AX,Z
          JGE    PART2
          MOV    AX,Z
    PART2:
          MOV    D,AX
          MOV    AH,4CH
          INT    21H
CSEG ENDS
END START