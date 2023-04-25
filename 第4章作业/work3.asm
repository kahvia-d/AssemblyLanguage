;统计数组BUF中正数、负数、0的个数顺序存放在变量NUM中。
DSEG SEGMENT
    BUF  DB 0,-1,2,4,0,-2,-5    ;初始数组
BUFFLENGTH=$-BUF                ;符号常量，不会更改，可以接等号
    NUM  DB 3 DUP(0)            ;定义计数数组，分别存放正数、负数、零的个数，初始值为0
DSEG ENDS

SSEG SEGMENT
SSEG ENDS

CSEG SEGMENT
                ASSUME DS:DSEG,SS:SSEG,CS:CSEG
    MAIN:       
                MOV    AX,DSEG
                MOV    DS,AX                      ;绑定数据段
                MOV    CX,BUFFLENGTH              ; 循环次数
                MOV    SI,OFFSET BUF              ; 保存数组的起始地址
                MOV    BX,OFFSET NUM              ; 保存计数数组的起始地址
    MYLOOP:     
                CMP    CX,0                       ;
                JLE    ENDING                     ;无需循环了就跳出循环阶段
                DEC    CX                         ;还需循环次数减一
                CMP    BYTE PTR [SI],0            ;比较当前数组值和0
                JG     ADDPOSITIVE
                JL     ADDNEGATIVE
                JE     ADDZERO
    ADDPOSITIVE:                                  ;添加正数个数,INC不能直接操作内存，所以要取出内存中的数，放在寄存器中自增后，再写入内存进行覆盖
                MOV    AX,[BX]
                INC    AX
                MOV    [BX],AX
                INC    SI                         ;变址寄存器值加一，即数组索引加一
                JMP    MYLOOP
    ADDNEGATIVE:                                  ;添加负数个数
                MOV    AX,[BX+1]
                INC    AX
                MOV    [BX+1],AX
                INC    SI
                JMP    MYLOOP
    ADDZERO:                                      ;添加零的个数
                MOV    AX,[BX+2]
                INC    AX
                MOV    [BX+2],AX
                INC    SI
                JMP    MYLOOP
    ENDING:     
                MOV    AH,4CH                     ;设置退出程序指令
                INT    21H                        ;调用DOS系统中止服务，执行退出程序指令
CSEG ENDS
    END MAIN