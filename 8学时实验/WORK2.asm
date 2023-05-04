;变量BUF2中存放着10个无符号字节数据，编程求出最小值存入变量MIN中。
DSEG SEGMENT
    BUF2 DB 13,92,48,67,6,25,54,73,42,31    ;初始数组
BUFFLENGTH=$-BUF2                           ;符号常量，不会更改，可以接等号
    MIN  DB ?
DSEG ENDS

SSEG SEGMENT
SSEG ENDS

CSEG SEGMENT
           ASSUME DS:DSEG,SS:SSEG,CS:CSEG
    MAIN:  
           MOV    AX,DSEG
           MOV    DS,AX                      ;绑定数据段

           MOV    CX,BUFFLENGTH-1            ; 循环次数
           MOV    SI,OFFSET BUF2             ; 保存数组的起始地址
           MOV    DL,[SI]                    ;把数组第一个值作为初始最小值
    MYLOOP:
           CMP    CX,0                       ;
           JLE    ENDING                     ;无需循环了就跳出循环阶段
           DEC    CX                         ;还需循环次数减一
           INC    SI                         ;变址寄存器值加一，即数组索引加一
           CMP    DL,[SI]                    ;比较已保存的最小值和当前数组值
           JLE    MYLOOP                     ;已保存的更小就进入下一个循环
           MOV    DL,[SI]                    ;否则覆盖最小值
           JMP    MYLOOP
    ENDING:
           MOV    MIN,DL                     ;保存最小值至最终结果变量
           MOV    AH,4CH                     ;设置退出程序指令
           INT    21H                        ;调用DOS系统中止服务，执行退出程序指令
CSEG ENDS
    END MAIN