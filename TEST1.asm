;x为1234H，y为2345H，两者相加给z
DSEG SEGMENT
    X    DW 1234H
    Y    DW 2345H
    Z    DW ?
DSEG ENDS

SSEG SEGMENT
SSEG ENDS

CSEG SEGMENT
          ASSUME DS:DSEG,CS:CSEG
    START:
          MOV    AX,DSEG
          MOV    DS,AX

          MOV    AX,X
          ADD    AX,Y
          MOV    Y,AX

          MOV    AH,9
          INT    21H

          MOV    AH,4CH
          INT    21H
CSEG ENDS
END START