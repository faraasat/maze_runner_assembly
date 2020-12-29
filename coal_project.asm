ORG 100H
.MODEL SMALL
.STACK 100H

;-------------------------DATA AND VARIABLES-------------------------
.DATA
WELCOME_MSG DB "================================================================================", 0 
            DB "   ++++++++++++++++++++++    MAZE PATH FINDER GAME    +++++++++++++++++++++     ", 0 
            DB "================================================================================                            ", 0
CREATED_BY  DB "                        CREATED BY :-                                                        "            
            DB "      FARASAT ALI  004                                      "
            DB "       SHAFAI TAHIR 050                                     "
            DB "        BABAR ALI    015                                             "
PROMPT      DB "  PRESS ANY KEY TO CONTINUE ....  ", 0            
MAIN_MENU   DB "                                                ", 0
            DB "   ***********    START GAME     ************   ", 0            
            DB "                                                ", 0
            DB "   ***********    INSTRUCTIONS   ************   ", 0
            DB "                                                ", 0 
            DB "   ***********    HIGH SCORES    ************   ", 0
            DB "                                                ", 0 
            DB "   ***********    QUIT GAME      ************   ", 0
            DB "                                                ", 0 
INSTRUCTS   DB " Find The Path With In MAX Moves Given And "
            DB " Navigate With Minimum Moves To Score Extra.Use"
            DB " Arow Keys To Control Directions And "
            DB " Use 'escape key' To Quit Any Time. "     
GREETINGS   DB "CONGRATULATIONS !!!", 0      
SCORE_NOTE  DB "YOUR SCORES: "
TOTAL_POINT DW '0'    ;scores for eaCH level
GAME_POINT  DW '0'    ;scores of the game
GAME_GONE   DB "* GAME OVER!!! ", 0
LEVEL_NOTE  DB "Do You Want To play Next level?(y/n)"
CONGO_EXIT  DB "Thanks For Playing ", 0
            DB "TotAL Scores:", 0
EXIT_NOTE   DB "Do You Want TO quit ?", 0
            DB "Press Enter Key To Quit", 0     
BOOLEAN     DB 0          ;used in boundry CHecks
P1_COUNT    DB '0'
P2_COUNT    DB '0'        ;counter digite
P3_COUNT    DB '0'
COUNT_MAX   DW 0          ;counter mAX=500
LINE_NO     DB 0          ;used in CHecking line no
LEVEL_CHK   DB 0          ;used for CHeckin level number
EXIST_CHK   DB 0          ;used in exiting from levels     
;--------------------------------------------------------------------     
     
;-------------------------CODE AREA----------------------------------     
.CODE
      
;++++++++++++++++++++++++++++ MAIN METHOD +++++++++++++++++++++++++++
MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    CALL RESET
    CALL HEAD
    CALL NAMES
    CALL INPUT
    CALL RESET
    CALL HEAD
    
    MOV DL, 8
    MOV DH, 10
    
    CALL MENU
    
    MOV AH, 0
    MOV AL, 3
    INT 10H
    
    MOV AH, 4CH
    INT 21H   
    
MAIN ENDP 
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
;++++++++++++++++++++++++++++ RESET METHOD ++++++++++++++++++++++++++
RESET PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV AH, 0            ; To set video mode
    MOV AL, 2            ; Changes cursor position
    INT 10H              ; Call interrupt for graphic

    Mov AH, 06H          ; Scroll Lines Up from bottom
    MOV AL, 0            ; Scroll all lines

    MOV BH, 01010000B    ; Background color

    MOV CH, 0            ; Upper row
    MOV CL, 0            ; Upper Column
    MOV DI, 1            ; Rows on screen -1, 
    MOV DH, [DI]         ; Lower Row (byte).
    MOV DI, 0            ; Columns on screen 
    MOV DL, [DI]         ; Lower Column
    ;DEC DL               
    INT 10H

    POP DX
    POP CX
    POP BX
    POP AX
    RET
RESET ENDP 
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;++++++++++++++++++++++++++++ HEAD METHOD ++++++++++++++++++++++++++
HEAD PROC
    PUSH AX
    PUSH CX

    MOV AX, 47104d
    LEA SI, WELCOME_MSG
    MOV CX, 80
    CALL DISP
    
    MOV AX, 47104d
    LEA SI, WELCOME_MSG
    MOV CX, 80
    CALL DISP

    MOV AX, 47104d
    LEA SI, WELCOME_MSG+80
    MOV CX, 80                          ;upper headings
    CALL DISP

    MOV AX, 47104d
    LEA SI, WELCOME_MSG+162
    MOV CX, 80
    CALL DISP
    
    MOV AX, 47104d
    LEA SI, WELCOME_MSG+162
    MOV CX, 80
    CALL DISP

    POP CX
    POP AX
    RET
HEAD ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 

;++++++++++++++++++++++++++++ NAME METHOD +++++++++++++++++++++++++++
NAMES PROC
    PUSH AX
    PUSH CX

    MOV AX, 0B814H
    LEA SI, CREATED_BY
    MOV CX, 24
    CALL DISP
    MOV AX, 0B81BH
    LEA SI, CREATED_BY+18
    MOV CX, 24
    CALL DISP
    MOV AX, 0B822H
    LEA SI, CREATED_BY+36
    MOV CX, 24
    CALL DISP

    MOV AX, 0B84AH
    LEA SI, CREATED_BY+59
    MOV CX, 32
    CALL DISP
    MOV AX, 0B850H
    LEA SI, CREATED_BY+90
    MOV CX, 32
    CALL DISP 
    MOV AX, 0B856H
    LEA SI, CREATED_BY+120
    MOV CX, 32
    CALL DISP 
    MOV AX, 0B85CH
    LEA SI, CREATED_BY+151
    MOV CX, 32
    CALL DISP
    MOV AX, 0B862H
    LEA SI, CREATED_BY+180
    MOV CX, 32
    CALL DISP 
    MOV AX, 0B868H
    LEA SI, CREATED_BY+212
    MOV CX, 32
    CALL DISP 
    MOV AX, 0B86EH
    LEA SI, CREATED_BY+237
    MOV CX, 32
    CALL DISP
            
    MOV AX, 0B899H
    LEA SI, PROMPT
    MOV CX, 34
    CALL DISP

    POP CX
    POP AX
    RET

NAMES ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
;+++++++++++++++++++++++++++++ DISP METHOD ++++++++++++++++++++++++++
DISP PROC
    PUSH AX

    MOV ES, AX
    MOV AH, 31 
    
    DO:
    LODSB                ;diplays on ram
    STOSW
    LOOP DO

    POP AX
    RET
DISP ENDP 
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   
;++++++++++++++++++++++++++++ INPUT METHOD ++++++++++++++++++++++++++
INPUT PROC
    PUSH AX
    PUSH BX
    PUSH DX

    MOV BH, 0       ;current page.
    MOV DL, 33      ;col.
    MOV DH, 23      ;row.

    MOV AH, 02      ;CHanges cursor position
    INT 10H

    MOV AH, 0
    INT 16H         ;prompts for input

    POP DX
    POP BX
    POP AX
    RET
INPUT ENDP 
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;++++++++++++++++++++++++++++ MENU METHOD +++++++++++++++++++++++++++
MENU PROC
    PUSH AX
    PUSH CX

    MOV AX, 0B82AH
    LEA SI, MAIN_MENU
    MOV CX, 48
    CALL DISP
    MOV AX, 0B82EH
    LEA SI, MAIN_MENU+49                     ;menue on main screen
    MOV CX, 48
    CALL DISP
    MOV AX, 0B832H
    LEA SI, MAIN_MENU+98
    MOV CX, 48
    CALL DISP
    MOV AX, 0B836H
    LEA SI, MAIN_MENU+147
    MOV CX, 48
    CALL DISP
    MOV AX, 0B83AH
    LEA SI, MAIN_MENU+195
    MOV CX, 48
    CALL DISP 
    MOV AX, 0B83EH
    LEA SI, MAIN_MENU+245
    MOV CX, 48
    CALL DISP
    MOV AX, 0B842H
    LEA SI, MAIN_MENU+294
    MOV CX, 48
    CALL DISP
    MOV AX, 0B846H
    LEA SI, MAIN_MENU+343
    MOV CX, 48
    CALL DISP
    MOV AX, 0B84AH
    LEA SI, MAIN_MENU+294
    MOV CX, 48
    CALL DISP

    CALL SELECT

    POP CX
    POP AX
    RET
MENU ENDP 
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;+++++++++++++++++++++++++++ SELECT METHOD ++++++++++++++++++++++++++ 
SELECT PROC

    MOV AH, 2
    MOV BH, 0
    INT 10H

    MOV AH, 0                   ;user selections from the menue
    INT 16H

    CMP AH, 1CH
    JE ENTERANCE

    CMP AH, 72
    JE UP

    CMP AH, 80
    JE DOWN

    CMP AH, 01
    JNE EXIT_OUT

    MOV DH, 16
    JMP EXIT_OUT

    ENTERANCE:
        CMP DH, 10
        JE  STRT_GAME
        CMP DH, 16
        JE  CONFIRM
        CMP DH, 12
        JE  INSTRUCTIONS
        CMP DH, 14
        JE  SCORE_JUMP

        JMP EXIT_OUT

    DOWN:
        CMP DH, 16
        JE  EXIT_OUT
        ADD DH, 2
        JMP EXIT_OUT


    UP:
        CMP DH, 10
        JE  EXIT_OUT
        SUB DH, 2
        JMP EXIT_OUT



    SCORE_JUMP:
        CALL RESET
        CALL HEAD

        MOV AX, 0B82fH
        LEA SI, SCORE_NOTE
        MOV CX, 12
        CALL DISP

        PUSH AX
        PUSH DX
        PUSH BX
        SUB GAME_POINT, 48
        MOV AX, GAME_POINT  
        MOV CX, 10
        CWD
        DIV CX
        ADD DX, 48
        PUSH DX
        CWD
        DIV CX
        ADD DX, 48                 ;using DECimAL output method for displaying 2 digit totAL score
        PUSH DX
        MOV BH, 0    ; current page.
        MOV DL, 20   ; col.
        MOV DH, 11   ; row.
        MOV AH, 02
        INT 10H
        MOV AH, 2
        POP DX
        INT 21H
        MOV BH, 0    ; current page.
        MOV DL, 21   ; col.
        MOV DH, 11   ; row.
        MOV AH, 02
        INT 10H
        MOV AH, 2
        POP DX
        INT 21H
        POP BX
        POP DX
        POP AX

        MOV AX, 0B850H
        LEA SI, PROMPT
        MOV CX, 30
        CALL DISP
        CALL INPUT
        ADD GAME_POINT, 48

        JMP EXIT_OUT

    INSTRUCTIONS:
        CALL RESET
        CALL HEAD

        MOV AX, 0B82EH
        LEA SI, INSTRUCTS
        MOV CX, 159
        CALL DISP

        MOV AX, 0B852H
        LEA SI, PROMPT
        MOV CX, 30
        CALL DISP
        CALL INPUT
        JMP EXIT_OUT

    STRT_GAME:
        MOV  LEVEL_CHK, 1
        CALL LEVEL1
        CALL GAME1
        MOV EXIST_CHK, 0         ;x=0 reseting exit signAL
        MOV LEVEL_CHK, 1         ;l=1 reset level vALue to 1 for 1st level


    EXIT_OUT:
        CALL RESET
        CALL HEAD
        CALL MENU       ;nested loops "menue->select " "select->menue"
        JMP OK

    CONFIRM:
        CALL WARN
        MOV AH, 0
        INT 16H
        CMP AH, 1CH
        JE OK
        JMP EXIT_OUT

    OK:
        RET
SELECT ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;+++++++++++++++++++++++++++ DISPLAY METHOD +++++++++++++++++++++++++
DISPLAY PROC
    PUSH AX
    PUSH CX
    PUSH DX
    PUSH BX

    D1:
        PUSH CX
        D2:
            INT 10h
            INC CX
            DEC BL
            CMP BL, 0       ;display  bALl of order 5x5
            JNE D2
        DEC BH
        INC DX
        POP CX
        MOV BL, 5
        CMP BH, 0
        JNE D1

    POP BX
    POP DX
    POP CX
    POP AX
    RET
DISPLAY ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;+++++++++++++++++++++++++++ WARN METHOD ++++++++++++++++++++++++++++
WARN PROC
    PUSH CX

    CALL RESET
    CALL HEAD

    MOV AX, 0B82FH
    LEA SI, EXIT_NOTE
    MOV CX, 25
    CALL DISP

    MOV AX, 0B868H        ;asks for exit confermation
    LEA SI, EXIT_NOTE +25
    MOV CX, 23
    CALL DISP

    POP CX

    RET
WARN ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;+++++++++++++++++++++++++++ CHECK METHOD ++++++++++++++++++++++++++++
CHECK proc
    PUSH  BX

    MOV AH, 0DH
    MOV BH, 0
    INT 10H

    CMP AL, 10             ;reads the pixel colour to b used for boundry CHeck
    JNE ex
    MOV BOOLEAN, 1
    ex:
    POP BX
    RET
CHECK endp
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;+++++++++++++++++++++++++++ LINE METHOD ++++++++++++++++++++++++++++
LINE PROC

   CMP DX, 21
   JE KL
   CMP DX, 32
   JE KL
   CMP DX, 43
   JE KL
   CMP DX, 54
   JE KL
   CMP DX, 65
   JE KL
   CMP DX, 76
   JE KL
   CMP DX, 87
   JE KL                         ;CHeck these lines for skiping to next five lines
   CMP DX, 98                     ;leaving horizontAL coloured boundry lines
   JE KL
   CMP DX, 109
   JE KL
   CMP DX, 120
   JE KL
   CMP DX, 131
   JE KL
   CMP DX, 142
   JE KL
   CMP DX, 153
   JE KL
   CMP DX, 164
   JE KL
   CMP DX, 175
   JE KL
   CMP DX, 186
   JNE EF

   KL:
   MOV LINE_NO, 1

   EF:
   RET
LINE ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;+++++++++++++++++++++++++ COUNTER METHOD +++++++++++++++++++++++++++
COUNTER PROC

    PUSH CX
    PUSH DX
    PUSH BX

    MOV AH, 2

    MOV DL, P1_COUNT
    INT 21h
    MOV DL, P2_COUNT               ; counter digits display
    INT 21h
    MOV DL, P3_COUNT
    INT 21h

    MOV DL, 6
    MOV DH, 0
    MOV AH, 02               ;MOVe cursor back to position
    MOV BH, 0
    INT 10h

    CMP P3_COUNT, '9'
    JE nex1

    INC  P3_COUNT
    JMP sec

    nex1:
    CMP P2_COUNT, '9'
    JE NEX2

    MOV P3_COUNT, '0'
    INC P2_COUNT

    JMP SEC
    NEX2:
    INC P1_COUNT
    MOV P2_COUNT, '0'
    MOV P3_COUNT, '0'

    sec:
    ADD COUNT_MAX, 1
    POP BX
    POP DX
    POP CX

    RET
COUNTER ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;++++++++++++++++++++++++ GAME_OVER METHOD ++++++++++++++++++++++++++
GAME_OVER PROC

    CALL RESET
    CALL HEAD

    MOV AX, 0B82aH
    LEA SI, GAME_GONE
    MOV CX, 16
    CALL DISP                        ;displays game over mesage

    MOV AX, 0B832H
    LEA SI, SCORE_NOTE
    MOV CX, 14
    CALL DISP

    MOV COUNT_MAX, 0
    MOV P1_COUNT, '0'
    MOV P2_COUNT, '0'
    MOV P3_COUNT, '0'

    MOV AH, 0
    INT 16H

    RET
GAME_OVER ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;+++++++++++++++++++++++++ RESTORE METHOD +++++++++++++++++++++++++++
RESTORE proc
    MOV COUNT_MAX, 0
    MOV P1_COUNT, '0'
    MOV P2_COUNT, '0'
    MOV P3_COUNT, '0'
    CALL reset                        ;reset the vALus for new session
    CALL head
    RET
RESTORE endp
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;++++++++++++++++++++++++++ KBHIT METHOD ++++++++++++++++++++++++++++
KBHIT proc
    MOV AH, 00h
    INT 16h              ;waits for user input

    CMP aH, 01
    JE exit

    CMP AH, 72
    JZ up1
    CMP AH, 80
    JZ down1
    CMP AH, 75
    JZ left
    CMP AH, 77
    JZ right
    JMP EXIT

    UP1:
    PUSH DX
    SUB DX, 1
    CALL CHeck
    CMP BOOLEAN, 1
    POP DX
    JE exit

    MOV AX, 0C00H
    CALL display

    DEC DX
    CALL LINE
    SUB DX, 4
    CMP LINE_NO, 1
    JNE EXIT
    MOV LINE_NO, 0
    DEC DX
    CALL COUNTER
    JMP EXIT

    DOWN1:
    PUSH DX
    ADD DX, 5
    CALL CHeck
    CMP BOOLEAN, 1
    POP DX
    JE exit

    MOV AX, 0C00H
    CALL display
    ADD DX, 5

    CALL LINE
    CMP LINE_NO, 1
    JNE EXIT
    MOV LINE_NO, 0
    INC DX

    CALL COUNTER
    JMP EXIT

    LEFT:
    PUSH CX
    SUB CX, 1
    CALL CHeck
    CMP BOOLEAN, 1
    POP CX
    JE exit

    MOV AX, 0C00H
    CALL display
    SUB CX, 5
    CALL COUNTER
    JMP EXIT

    RIGHT:
    PUSH CX
    ADD  CX, 9
    CALL CHeck
    CMP BOOLEAN, 1
    POP CX
    JE exit

    CMP AL, 14          ; CMP for exit line with colour 14
    Jne fff

    CMP LEVEL_CHK, 1
    MOV EXIST_CHK, 1
    JE ps
    CALL congRETs
    CALL input
    JMP exit
    ps:
    MOV EXIST_CHK, 0
    CALL next_level      ;prompt for next level continue

    ask:
    MOV AH, 0
    INT 16h

    CMP AH, 1CH
    JE lvl2              ; waits untill "enter -> continue to 2nd level" " escape -> main menue"
    CMP AH, 1
    JNE ask

    MOV EXIST_CHK, 1
    JMP exit

    lvl2:
    CALL restore
    CALL LEVEL2
    MOV CX, 1
    MOV DX, 11
    MOV LEVEL_CHK, 2
    jMP EXIT

    fff:
    MOV AX, 0C00H
    CALL display
    ADD CX, 5
    CALL COUNTER

    exit:
    MOV BOOLEAN, 0
    RET
KBHIT ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;++++++++++++++++++++++++++ GAME1 METHOD ++++++++++++++++++++++++++++
GAME1 PROC

    MOV DX, 11
    MOV CX, 1
    MOV BX, 0505H          ;obJEct size

    DRW:
    CMP COUNT_MAX, 500
    JNE CON               ;loops for 500 MOVes
    CALL GAME_OVER
    JMP F

    CON:
    MOV AX, 0C0FH
    CALL DISPLAY
    CALL KBHIT

    CMP EXIST_CHK, 1               ;exit signAL from any level
    JE f

    CMP AH, 1              ;escape INTruption for quting
    JE  PMT

    JMP DRW

    PMT:
    CALL WARN
    MOV AH, 0               ; user confermation for exiting level
    INT 16H

    CMP AH, 1CH
    JE  F
    PUSH CX
    PUSH DX                ; storing obJEct location
    PUSH BX
    CMP LEVEL_CHK, 1                ; draws levels agains according to level vALue 'L'
    JNE S2ND
    CALL LEVEL1
    JMP OI

    S2ND:
    CALL LEVEL2
    OI:
    POP BX
    POP DX
    POP CX
    CALL DRW

    F:
    CALL restore
    MOV DL, 8
    MOV DH, 10

    RET
GAME1 ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;++++++++++++++++++++++++ CONGRETS METHOD +++++++++++++++++++++++++++
CONGRETS PROC
    PUSH CX

    CALL reset
    CALL head

    CMP COUNT_MAX, 390
    JB FIRST                ; CHecks MOVes for scores
    CMP COUNT_MAX, 420
    JB SECOND
    CMP COUNT_MAX, 450
    JB THIRD

    MOV GAME_POINT, '3'
    JMP CONTINUE

    FIRST:
    MOV GAME_POINT, '9'
    JMP CONTINUE
    SECOND:
    MOV GAME_POINT, '7'
    JMP CONTINUE
    THIRD:
    MOV GAME_POINT, '5'


    PUSH CX
    PUSH DX
    MOV CX, GAME_POINT
    MOV DX, TOTAL_POINT             ; swaping poINT and totAL as poINT hold totAL marks of both levels
    MOV GAME_POINT, DX            ; and totAL hold scores for single level
    MOV TOTAL_POINT, CX
    POP DX
    POP CX


    CONTINUE:
    MOV AX, 0B82aH
    LEA SI, GREETINGS
    MOV CX, 18
    CALL DISP

    MOV AX, 0B832H
    LEA SI, SCORE_NOTE
    MOV CX, 14
    CALL DISP

    MOV AX, 0B849H
    LEA SI, CONGO_EXIT
    MOV CX, 18
    CALL DISP

    MOV AX, 0B85bH
    LEA SI, CONGO_EXIT + 20
    MOV CX, 13
    CALL DISP

    SUB TOTAL_POINT, 48
    MOV CX, TOTAL_POINT
    SUB GAME_POINT , 48
    ADD GAME_POINT , CX

    PUSH DX
    PUSH BX
    MOV AX, GAME_POINT ; decimAL output method for displaying two digits totAL scores
    MOV CX, 10
    CWD
    DIV CX
    ADD DX, 48
    PUSH DX
    CWD
    DIV CX
    ADD DX, 48
    PUSH DX
    MOV BH, 0    ; current page.
    MOV DL, 23   ; col.
    MOV DH, 21   ; row.
    MOV AH, 02
    INT 10h
    MOV AH, 2
    POP DX
    INT 21h
    MOV BH, 0    ; current page.
    MOV DL, 24   ; col.
    MOV DH, 21   ; row.
    MOV AH, 02
    INT 10h
    MOV AH, 2
    POP DX
    INT 21h
    POP BX
    POP DX



    POP CX

    RET
CONGRETS ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;+++++++++++++++++++++++ NEXT_LEVEL METHOD ++++++++++++++++++++++++++
NEXT_LEVEL PROC
    PUSH CX

    CALL reset
    CALL head

    CMP COUNT_MAX, 304
    JB FIRST_1
    CMP COUNT_MAX, 330
    JB SECOND_1
    CMP COUNT_MAX, 460
    JB THIRD_1

    MOV TOTAL_POINT, '3'
    JMP CONTINUE_1

    FIRST_1:
    MOV TOTAL_POINT, '9'
    JMP CONTINUE_1
    SECOND_1:
    MOV TOTAL_POINT, '7'
    JMP CONTINUE_1
    THIRD_1:
    MOV TOTAL_POINT, '5'

    CONTINUE_1:
    MOV AX, 0B82aH
    LEA SI, GREETINGS
    MOV CX, 18
    CALL DISP

    MOV AX, 0B832H
    LEA SI, SCORE_NOTE
    MOV CX, 14
    CALL DISP

    MOV AX, 0B861H
    LEA SI, LEVEL_NOTE
    MOV CX, 36
    CALL DISP

    POP CX

    RET
NEXT_LEVEL ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
;+++++++++++++++++++++++++++ LEVEL1 METHOD ++++++++++++++++++++++++++
LEVEL1 PROC
    MOV AH, 0
    MOV AL, 13H
    INT 10H

    MOV AH, 0CH
    MOV AL, 10

    ;draws borders
    MOV CX, 0
    MOV DX, 0
    MOV BX, 0

    HORIZONTAL:           ;upper and lower horizontAL line  
        MOV DX, 10
        INT 10H

        MOV DX, 199
        INT 10H

        INC CX
        CMP CX, 320

        JNE HORIZONTAL

        MOV DX, 0

    VERTICLE:             ; left and right vertiCLe line
        MOV CX, 0
        INT 10H

        MOV CX, 319
        INT 10H 

        INC DX
        CMP DX, 199
        JNE VERTICLE

    ;ALl of the centrAL horizontAL lines

    MOV CX, 0
    
    ;;l1
    LINE_1:
        MOV DX, 21
        INT 10H
        INC CX
        CMP CX, 300
        JNE LINE_1

    ;;l2
    MOV CX, 0
    LINE_2A:
        MOV DX, 32
        INT 10H
        INC CX
        CMP CX, 70
        JNE LINE_2A
        ADD CX, 16
        
    LINE_2B:
        MOV DX, 32
        INT 10H
        INC CX
        CMP CX, 300
        JNE LINE_2B

    ;;l3
    MOV CX, 16
    LINE_3A:
        MOV DX, 43
        INT 10H
        INC CX
        CMP CX, 35
        JNE LINE_3A 
    
        ADD CX, 16 
         
    LINE_3B:
        MOV DX, 43
        INT 10H
        INC CX
        CMP CX, 120
        JNE LINE_3A

    ADD CX, 16
    LINE_3C:
        MOV DX, 43
        INT 10H
        INC CX
        CMP CX, 300
        JNE LINE_3C

    ;;l4
    MOV CX, 16
    LINE_4A:
        MOV DX, 54
        INT 10H
        INC CX
        CMP CX, 100
        JNE LINE_4A

        ADD CX, 16
        
    LINE_4B:
        MOV DX, 54
        INT 10H
        INC CX
        CMP CX, 300
        JNE LINE_4B

    ;;l5
    MOV CX, 0
    LINE_5A:
        MOV DX, 65
        INT 10H
        INC CX
        CMP CX, 50
        JNE LINE_5A

        ADD CX, 16 
        
    LINE_5B:
        MOV DX, 65
        INT 10H
        INC CX
        CMP CX, 300
        JNE LINE_5B

    ;;l6
    MOV CX, 16
    LINE_6:
        MOV DX, 76
        INT 10H
        INC CX
        CMP CX, 319
        JNE LINE_6 

    ;;l7
    MOV CX, 16
    LINE_7A:
        MOV DX, 87
        INT 10H
        INC CX
        CMP CX, 70
        JNE LINE_7A

        ADD CX, 16
        
    LINE_7B:
        MOV DX, 87
        INT 10H
        INC CX
        CMP CX, 300
        JNE LINE_7B

    ;;l8
    MOV CX, 0
    LINE_8A:
        MOV DX, 98
        INT 10H
        INC CX
        CMP CX, 270
        JNE LINE_8A

        ADD CX, 16 
        
    LINE_8B:
        MOV DX, 98
        INT 10H
        INC CX
        CMP CX, 300
        JNE LINE_8B

    ;;l9
    MOV CX, 0
    LINE_9A:
        MOV DX, 109
        INT 10H
        INC CX
        CMP CX, 20
        JNE LINE_9A

        ADD CX, 16
    
    LINE_9B:
        MOV DX, 109
        INT 10H
        INC CX
        CMP CX, 285
        JNE LINE_9B

    ;l10
    MOV CX, 0
    LINE_10A:
        MOV DX, 120
        INT 10H
        INC CX
        CMP CX, 70
        JNE LINE_10A

        ADD CX, 16 
    
    LINE_10B:
        MOV DX, 120
        INT 10H
        INC CX
        CMP CX, 300
        JNE LINE_10B

    ;;L11
    MOV CX, 0
    LINE_11A:
        MOV DX, 131
        INT 10H
        INC CX
        CMP CX, 55
        JNE LINE_11A

        ADD CX, 16
        
    LINE_11B:
        MOV DX, 131
        INT 10H
        INC CX
        CMP CX, 100
        JNE LINE_11B

        ADD CX, 16 
        
    LINE_11C:
        MOV DX, 131
        INT 10H
        INC CX
        CMP CX, 319
        JNE LINE_11C

    ;;L12
    MOV CX, 16
    LINE_12A:
        MOV DX, 142
        INT 10H
        INC CX
        CMP CX, 80
        JNE LINE_12A

        ADD CX, 16
    LINE_12B:
        MOV DX, 142
        INT 10H
        INC CX
        CMP CX, 260
        JNE LINE_12B

        ADD CX, 16
    
    LINE_12C:
        MOV DX, 142
        INT 10H
        INC CX
        CMP CX, 319
        JNE LINE_12C

    ;;L13
    MOV CX, 16
    LINE_13A:
        MOV DX, 153
        INT 10H
        INC CX
        CMP CX, 70
        JNE LINE_13A

        ADD CX, 16

    LINE_13B:
        MOV DX, 153
        INT 10H
        INC CX
        CMP CX, 300
        JNE LINE_13B

    ;;l14
    MOV CX, 16
    LINE_14A:
        MOV DX, 164
        INT 10H
        INC CX
        CMP CX, 70
        JNE LINE_14A

        ADD CX, 16

    LINE_14B:
        MOV DX, 164
        INT 10H
        INC CX
        CMP CX, 170
        JNE LINE_14B

        ADD CX, 16

    LINE_14C:
        MOV DX, 164
        INT 10H
        INC CX
        CMP CX, 300
        JNE LINE_14C

    ;;l15
    MOV CX, 16
    LINE_15A:
        MOV DX, 175
        INT 10H
        INC CX
        CMP CX, 70
        JNE LINE_15A

        ADD CX, 16

    LINE_15B:
        MOV DX, 175
        INT 10H
        INC CX
        CMP CX, 255
        JNE LINE_15B

        ADD CX, 16

    LINE_15C:
        MOV DX, 175
        INT 10H
        INC CX
        CMP CX, 319
        JNE LINE_15C

    ;;L16
    MOV CX, 16
    LINE_16:
        MOV DX, 186
        INT 10H
        INC CX
        CMP CX, 270
        JNE LINE_16

    ;;l17
    MOV CX, 0
    LINE_17:
        MOV DX, 197
        INT 10H
        INC CX
        CMP CX, 319
        JNE LINE_17

    ; draws ALl of the vertiCLe

    MOV CX, 300
    MOV DX, 21
    VERTICLE_1000:
        INT 10h
        INC DX
        CMP DX, 32
        JNE VERTICLE_1000

        MOV DX, 43

    VERTICLE_1001:
        INT 10h
        INC DX
        CMP DX, 55
        JNE VERTICLE_1001

        MOV DX, 87

    VERTICLE_1002:
        INT 10h
        INC DX
        CMP DX, 120
        JNE VERTICLE_1002

        MOV DX, 32
        MOV CX, 90

    VERTICLE_1003:
        INT 10h
        INC DX
        CMP DX, 43
        JNE VERTICLE_1003

        MOV DX, 43

    VERTICLE_1004:
        MOV CX, 35
        INT 10h
        MOV CX, 120
        INT 10h
        INC DX
        CMP DX, 54
        JNE VERTICLE_1004

    VERTICLE_1005:
        MOV CX, 200
        INT 10H
        INC DX
        CMP DX, 65
        JNE VERTICLE_1005

        MOV DX, 76

    VERTICLE_1006:
        MOV CX, 35
        INT 10h
        MOV CX, 90
        INT 10h
        INC DX
        CMP DX, 87
        JNE VERTICLE_1006

        MOV DX, 109

    VERTICLE_1007:
        MOV CX, 70
        INT 10h
        INC DX
        CMP DX, 120
        JNE VERTICLE_1007

        MOV DX, 131

    VERTICLE_1008:
        MOV CX, 80
        INT 10h
        MOV CX, 100
        INT 10h
        INC DX
        CMP DX, 142
        JNE VERTICLE_1008

        MOV DX, 153

    VERTICLE_1009:
        MOV CX, 70
        INT 10h
        MOV CX, 90
        INT 10h
        MOV CX, 255
        INT 10h
        INC DX
        CMP DX, 164
        JNE VERTICLE_1009

    VERTICLE_1010:
        MOV CX, 18
        INT 10h
        MOV CX, 255
        INT 10h
        INC DX
        CMP DX, 175
        JNE VERTICLE_1010

        MOV DX, 142

    VERTICLE_1011:
        MOV CX, 20
        INT 10h
        INC DX
        CMP DX, 153
        JNE VERTICLE_1011

        MOV DX, 175
	VERTICLE_1012:
        MOV CX, 160
        INT 10H
        INC DX
        CMP DX, 186
        JNE VERTICLE_1012

    VERTICLE_1013:
        MOV CX, 180
        INT 10H
        INC DX
        CMP DX, 197
        JNE VERTICLE_1013

    ;END line:
    MOV CX, 305
    MOV DX, 197
    MOV AL, 14
    END_20:
        MOV AH, 0CH
        INT 10h
        DEC DX
        CMP DX, 175
        JA END_20

    ;WRIRING
    MOV BH, 0
    MOV DH, 0
    MOV DH, 0
    MOV AH, 02
    INT 10H

    MOV AH, 2
    MOV DH, "M"
    INT 21H
    MOV DH, "O"
    INT 21H
    MOV DH, "V"
    INT 21H
    MOV DH, "E"
    INT 21H
    MOV DH, "S"
    INT 21H
    MOV DH, ":"
    INT 21H

    MOV BH, 0
    MOV DH, 9
    MOV DH, 0
    MOV AH, 02
    INT 10H

    MOV AH, 2
    MOV DH, "/"
    INT 21H
    MOV DH, "5"
    INT 21H
    MOV DH, "0"
    INT 21H
    MOV DH, "0"
    INT 21H

    MOV BH, 0
    MOV DH, 32
    MOV DH, 0
    MOV AH, 02
    INT 10H

    MOV AH, 2
    MOV DH, "L"
    INT 21H
    MOV DH, "e"
    INT 21H
    MOV DH, "v"
    INT 21H
    MOV DH, "e"
    INT 21H
    MOV DH, "l"
    INT 21H
    MOV DH, ":"
    INT 21H
    MOV DH, "1"
    INT 21H

    MOV BH, 0
    MOV DH, 6
    MOV DH, 0
    MOV AH, 02
    INT 10H

    RET
LEVEL1 ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;+++++++++++++++++++++++ NEXT_LEVEL METHOD ++++++++++++++++++++++++++
LEVEL2 proc
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV AH, 0
    MOV AL, 13h
    INT 10h

    MOV AH, 0CH
    MOV AL, 10

    MOV DX, 0
    MOV BX, 0
;ALl of the vertiCLe lines
    MOV CX, 0
    verti:
    INT 10h
    INC DX
    CMP DX, 197
    JNE verti

    MOV DX, 11
    MOV CX, 20
    verti1:
    INT 10h
    INC DX
    CMP DX, 175
    JNE verti1

    MOV DX, 22
    MOV CX, 30
    verti2:
    INT 10h
    INC DX
    CMP DX, 164
    JNE verti2

    MOV DX, 33
    MOV CX, 40
    vertI3:
    INT 10h
    INC DX
    CMP DX, 153
    JNE verti3

    MOV DX, 44
    MOV CX, 50
    verti4:
    INT 10h
    INC DX
    CMP DX, 142
    JNE verti4

    MOV DX, 55
    MOV CX, 60
    verti5:
    INT 10h
    INC DX
    CMP DX, 131
    JNE verti5

    MOV DX, 66
    MOV CX, 70
    verti6:
    INT 10h
    INC DX
    CMP DX, 120
    JNE verti6

    MOV DX, 11
    MOV BX, 0

    MOV CX, 319
    vertii:
    INT 10h
    INC DX
    CMP DX, 197
    JNE vertii

    MOV DX, 22
    MOV CX, 300
    verti11:
    INT 10h
    INC DX
    CMP DX, 186
    JNE verti11

    MOV DX, 33
    MOV CX, 285
    verti22:
    INT 10h
    INC DX
    CMP DX, 175
    JNE verti22

    MOV DX, 44
    MOV CX, 275
    verti33:
    INT 10h
    INC DX
    CMP DX, 164
    JNE verti33

    MOV DX, 55
    MOV CX, 265
    verti44:
    INT 10h
    INC DX
    CMP DX, 153
    JNE verti44

    MOV DX, 66
    MOV CX, 250
    verti55:
    INT 10h
    INC DX
    CMP DX, 142
    JNE verti55

    MOV DX, 77
    MOV CX, 240
    verti66:
    INT 10h
    INC DX
    CMP DX, 131
    JNE verti66

    MOV DX, 88
    MOV CX, 230
    verti77:
    INT 10h
    INC DX
    CMP DX, 120
    JNE verti77

    MOV DX, 88
    MOV CX, 95
    verti88:
    INT 10h
    INC DX
    CMP DX, 131
    JNE verti88

    MOV DX, 98
    MOV CX, 170
    verti99:
    INT 10h
    INC DX
    CMP DX, 197
    JNE verti99

    MOV DX, 76
    MOV CX, 85
    verti10:
    INT 10h
    INC DX
    CMP DX, 131
    JNE verti10

    MOV DX, 165
    vertii11:
    MOV CX, 160
    INT 10h
    MOV CX, 180
    INT 10h
    INC DX
    CMP DX, 186
    JNE vertii11



; ALl of the horizontAL lines

    MOV DX, 186
    MOV CX, 0
    horii:
    INT 10h
    INC CX
    CMP CX, 161
    JNE horii

    MOV DX, 175
    MOV CX, 16
    horii1:
    INT 10h
    INC CX
    CMP CX, 148
    JNE horii1

    MOV DX, 164
    MOV CX, 26
    horii2:
    INT 10h
    INC CX
    CMP CX, 161
    JNE horii2

    MOV DX, 153
    MOV CX, 36
    horii3:
    INT 10h
    INC CX
    CMP CX, 168
    JNE horii3


    MOV DX, 10
    MOV CX, 0
    hori:
    INT 10h            ;uper
    INC CX
    CMP CX, 319
    JNE hori


    MOV DX, 197
    hri:
    INT 10h
    dec CX                  ;lower
    CMP CX, 0
    JNE hri

    MOV DX, 21
    MOV CX, 26
    hori1:
    INT 10h
    INC CX
    CMP CX, 301
    JNE hori1

    MOV DX, 32
    MOV CX, 36
    hori2:
    INT 10h
    INC CX
    CMP CX, 286
    JNE hori2

    MOV DX, 43
    MOV CX, 46
    hori3:
    INT 10h
    INC CX
    CMP CX, 276
    JNE hori3

    MOV DX, 54
    MOV CX, 56
    hori4:
    INT 10h
    INC CX
    CMP CX, 266
    JNE hori4

    MOV DX, 65
    MOV CX, 66
    hori5:
    INT 10h
    INC CX
    CMP CX, 251
    JNE hori5

    MOV DX, 76
    MOV CX, 77
    hori6:
    INT 10h
    INC CX
    CMP CX, 241
    JNE hori6

    MOV DX, 87
    MOV CX, 91
    hori7:
    INT 10h
    INC CX
    CMP CX, 231
    JNE hori7


    MOV DX, 98
    MOV CX, 106
    hori8:
    INT 10h
    INC CX
    CMP CX, 220
    JNE hori8

    MOV DX, 142
    MOV CX, 46
    horii4:
    INT 10h
    INC CX
    CMP CX, 155
    JNE horii4

    MOV DX, 186
    MOV CX, 176
    horiii:
    INT 10h
    INC CX
    CMP CX, 301
    JNE horiii

    MOV DX, 175
    MOV CX, 190
    horiii1:
    INT 10h
    INC CX
    CMP CX, 286
    JNE horiii1

    MOV DX, 164
    MOV CX, 176
    horiii2:
    INT 10h
    INC CX
    CMP CX, 276
    JNE horiii2

    MOV DX, 153
    MOV CX, 168
    horiii3:
    INT 10h
    INC CX
    CMP CX, 266
    JNE horiii3

    MOV DX, 142
    MOV CX, 179
    horiii4:
    INT 10h
    INC CX
    CMP CX, 251
    JNE horiii4

    MOV DX, 131
    MOV CX, 91
    horiii5:
    INT 10h
    INC CX
    CMP CX, 241
    JNE horiii5

    MOV DX, 120
    MOV CX, 181
    horiii6:
    INT 10h
    INC CX
    CMP CX, 231
    JNE horiii6

    MOV DX, 109
    MOV CX, 170
    horiii7:
    INT 10h
    INC CX
    CMP CX, 220
    JNE horiii7

    MOV DX, 109
    MOV CX, 101
    horiii8:
    INT 10h
    INC CX
    CMP CX, 170
    JNE horiii8

    MOV DX, 131
    MOV CX, 56
    horiii11:
    INT 10h
    INC CX
    CMP CX, 86
    JNE horiii11

;end line
MOV DX, 109
    MOV AL, 14
    vertii12:
    MOV CX, 150
    INT 10h
    INC DX
    CMP DX, 131
    JNE vertii12

; writing

    MOV BH, 0
    MOV DL, 0
    MOV DH, 0
    MOV AH, 02
    INT 10h

    MOV AH, 2
    MOV DL, "M"
    INT 21h
    MOV DL, "O"
    INT 21h
    MOV DL, "V"
    INT 21h
    MOV DL, "E"
    INT 21h
    MOV DL, "S"
    INT 21h
    MOV DL, ":"
    INT 21h

    MOV BH, 0
    MOV DL, 9
    MOV DH, 0
    MOV AH, 02
    INT 10h

    MOV AH, 2
    MOV DL, "/"
    INT 21h
    MOV DL, "5"
    INT 21h
    MOV DL, "0"
    INT 21h
    MOV DL, "0"
    INT 21h

    MOV BH, 0
    MOV DL, 33
    MOV DH, 0
    MOV AH, 02
    INT 10h

    MOV AH, 2
    MOV DL, "L"
    INT 21h
    MOV DL, "e"
    INT 21h
    MOV DL, "v"
    INT 21h
    MOV DL, "e"
    INT 21h
    MOV DL, "l"
    INT 21h
    MOV DL, ":"
    INT 21h
    MOV DL, "2"
    INT 21h

    MOV BH, 0
    MOV DL, 6
    MOV DH, 0
    MOV AH, 02
    INT 10h


    POP DX
    POP CX
    POP BX
    POP AX
    RET
LEVEL2 endp
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
END MAIN
;--------------------------------------------------------------------     
           