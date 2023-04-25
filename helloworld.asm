DSEG SEGMENT
    MESS DB 'HELLO,WORLD !',0DH,0AH,24H
DSEG ENDS

CSEG SEGMENT
          ASSUME DS:DSEG,CS:CSEG
    BEGIN:
          MOV    AX,DSEG
          MOV    DS,AX

          MOV    DX,OFFSET MESS
          MOV    AH,9
          INT    21H

          MOV    AH,4CH
          INT    21
CSEG ENDS
END BEGIN