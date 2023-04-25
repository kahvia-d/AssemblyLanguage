DATA SEGMENT
       BIN   DW 358CH
       ASDEC DB 5 DUP(?),'$'
       PWTAB DW 10000,1000,100,10,1       ;这个被除数用word存的，16位
DATA ENDS

CODESG SEGMENT
              ASSUME DS:DATA,CS:CODESG
       START: 
              MOV    AX,DATA                 ;设置数据段
              MOV    DS,AX

              LEA    SI,PWTAB                ;被除数的保存地址
              LEA    DI,ASDEC                ;结果数组保存地址
              MOV    CX,5                    ;循环五次
              MOV    AX,BIN                  ;存储被除数
       LOP:   
              MOV    DX,0
              DIV    WORD PTR [SI]           ;[SI]是除数，16位，使用的时候要用强制类型转换，除数16位所以被除数32位，高16位存在DX中，低16位存在AX中
              INC    SI                      ;除数是16位，所以要自增两次才是下一个除数
              INC    SI
              OR     AL,30H                  ;AX中存放的是商，把它加上0030H，就可以转换成对应的ASCII码
              MOV    [DI],AL                 ;转换好了之后存到结果数组中
              INC    DI                      ;结果数组的当前指针后移
              MOV    AX,DX                   ;余数移动到AX中，作为下一次除法的被除数
              LOOP   LOP                     ;继续循环

              LEA    DX,ASDEC
              MOV    AH,9                    ;打印结果,即DX寄存器保存的地址处的字符串
              INT    21H

              MOV    AH,4CH                  ;结束程序
              INT    21H
CODESG ENDS
END START