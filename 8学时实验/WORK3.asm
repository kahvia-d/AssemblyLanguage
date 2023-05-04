;变量BUF3中存放着10个有符号的字节数据，编程将这10个数按从小到大排序。
DSEG SEGMENT
    BUF3       DB 10,9,8,7,6,5,4,3,2,1
    BUFFLENGTH DB $-BUF3
DSEG ENDS

SSEG SEGMENT
SSEG ENDS

CSEG SEGMENT
                   ASSUME DS:DSEG,SS:SSEG,CS:CSEG
    START:         
                   MOV    AX,DSEG
                   MOV    DS,AX

                   MOV    BP,OFFSET BUF3             ;用以指向BUF数组需要放置最小数的位置
                   LEA    SI,BUF3                    ;移动这个指针来寻找最小值

                   MOV    DH,BUFFLENGTH              ;外循环次数

    ;MOV    DL,BUFFLENGTH-1            ;不能直接这么写，这样会把BUFFLENGTH处理为地址。地址减一，就成数组的最后一个值的地址了。
                   MOV    DL,BUFFLENGTH
                   DEC    DL                         ;DL是内循环次数

    OUTERLOOP:     
                   CMP    DH,0                       ;查看是否需要进行外循环
                   JE     ENDLOOP
                   DEC    DH
                   MOV    DL,DH                      ;重置内循环次数

                   MOV    SI,BP                      ;需要则，将用以移动寻找最小值的指针SI重置到需要放置最小值的指针处
                   JMP    INNERLOOP

    INNERLOOP:     
                   INC    SI                         ;让SI自增，指向下一个数组元素
                   MOV    AL,DS:[BP]
                   CMP    DS:[SI],AL
                   JLE    UPDATEMIN
                   JMP    BEFORENEXTLOOP
    
    UPDATEMIN:                                       ;把到目前为止的最小值交换到目标最小值位置
                   MOV    AL,DS:[BP]
                   XCHG   AL,DS:[SI]
                   MOV    DS:[BP],AL

    BEFORENEXTLOOP:                                  ;在内循环进行下一次之前
                   DEC    DL                         ;内循环剩余次数自减
                   CMP    DL,0                       ;判断是否需要还需要进行内循环
                   JG     INNERLOOP                  ;需要则进行

                   INC    BP                         ;否则自增外循环初始数组地址
                   JMP    OUTERLOOP                  ;进行外循环
    ENDLOOP:       
                   MOV    AH,4CH
                   INT    21H

CSEG ENDS
END START