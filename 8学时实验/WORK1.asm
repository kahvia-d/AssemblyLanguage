;1、变量BUF1中存放着9个数据，编程统计偶数、奇数、零的个数并输出。
DSEG SEGMENT
        BUF    DW 0,1,2,3               ;测试数组
BUFFLENGTH=($-BUF)/2                    ;数组长度
        RESULT DB 3 DUP(30H),'$'        ;三个空间，分别保存偶数，奇数，0的个数
DSEG ENDS

SSEG SEGMENT
SSEG ENDS

CSEG SEGMENT
                ASSUME DS:DSEG,SS:SSEG,CS:CSEG
        START:  
                MOV    AX,DSEG                        ;保存数据段地址到对应的段地址寄存器
                MOV    DS,AX

                MOV    CX,BUFFLENGTH                  ;循环次数置为数组长度
                MOV    SI,OFFSET BUF                  ;把原数组偏移地址保存至原变址寄存器
                MOV    DI,OFFSET RESULT               ;把结果数组保存至目的变址寄存器

                MOV    DH,2                           ;保存除数2

        MYLOOP: 
                MOV    AX,[SI]
                CMP    AX,0                           ;被除数如果是0就跳入添加0个数的代码段
                JE     ADDZERO
        MYDIV:  
                DIV    DH                             ;除数8位，结果里商放AL，余数放AH
                CMP    AH,0
                JE     ADDOU
                JMP    ADDJI

        ADDZERO:
                MOV    DL,[DI+2]                      ;获取计数数组的目标值
                INC    DL                             ;计数加一
                MOV    [DI+2],DL                      ;覆写内存的计数值
                INC    SI                             ;指向下一个数组元素
                INC    SI
                LOOP   MYLOOP                         ;继续循环
                JMP    DONE                           ;无需继续循环则结束程序
        ADDJI:  
                MOV    DL,[DI+1]
                INC    DL
                MOV    [DI+1],DL
                INC    SI
                INC    SI
                LOOP   MYLOOP

                JMP    DONE
        ADDOU:  
                MOV    DL,[DI]
                INC    DL
                MOV    [DI],DL
                INC    SI
                INC    SI
                LOOP   MYLOOP
                JMP    DONE
        DONE:   
                LEA    DX,RESULT                      ;打印结果
                MOV    AH,9
                INT    21H
                                  
                MOV    AH,4CH                         ;结束程序
                INT    21H

CSEG ENDS
END START