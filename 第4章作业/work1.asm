;求无符号数组BUF中的最大值存放于MAX中。
DSEG SEGMENT
    BUF  DB 1,2,3,4,5,6    ;初始数组
BUFFLENGTH=$-BUF           ;符号常量，不会更改，可以接等号
    MAX  DB ?
DSEG ENDS

SSEG SEGMENT
SSEG ENDS

CSEG SEGMENT
           ASSUME DS:DSEG,SS:SSEG,CS:CSEG
    MAIN:  
           MOV    AX,DSEG
           MOV    DS,AX                      ;绑定数据段

           MOV    CX,BUFFLENGTH-1            ; 循环次数
           MOV    SI,OFFSET BUF              ; 保存数组的起始地址
           MOV    DL,[SI]                    ;把数组第一个值作为初始最大值
    MYLOOP:
           CMP    CX,0                       ;
           JLE    ENDING                     ;无需循环了就跳出循环阶段
           DEC    CX                         ;还需循环次数减一
           INC    SI                         ;变址寄存器值加一，即数组索引加一
           CMP    DL,[SI]                    ;比较已保存的最大值和当前数组值
           JGE    MYLOOP                     ;已保存的更大就进入下一个循环
           MOV    DL,[SI]                    ;否则覆盖最大值
           JMP    MYLOOP
    ENDING:
           MOV    MAX,DL                     ;保存最大值至最终结果变量
           MOV    AH,4CH                     ;设置退出程序指令
           INT    21H                        ;调用DOS系统中止服务，执行退出程序指令
CSEG ENDS
    END MAIN