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
SELECT_INS  DB "PRESS 1 TO PLAY THE GAME,        ", 0  
            DB "PRESS 2 TO SEE THE INSTRUCTION,  ", 0 
            DB "PRESS 3 TO SEE THE SCORES,       ", 0
            DB "PRESS 4 TO EXIT.                 ", 0 
            DB "    Waiting For Key ...          ", 0            
MAIN_MENU   DB "                                                ", 0
            DB "   ***********    START GAME     ************   ", 0            
            DB "                                                ", 0
            DB "   ***********    INSTRUCTIONS   ************   ", 0
            DB "                                                ", 0 
            DB "   ***********    HIGH SCORES    ************   ", 0
            DB "                                                ", 0 
            DB "   ***********    QUIT GAME      ************   ", 0
            DB "                                                ", 0 
INSTRUCTS   DB "==================================================="
            DB "|                                              |   "
            DB "|  Find The Path With In MAX Moves Given And   |   "
            DB "|  Navigate With Minimum Moves To Score Extra. |   "
            DB "|  Use Arow Keys To Control Directions And     |   "
            DB "|  Use 'escape key' To Quit Any Time.          |   "
            DB "|                                              |   " 
            DB "==================================================="    
GREETINGS   DB "                                ", 0
            DB " **** !!CONGRATULATIONSS!! **** ", 0
            DB "                                ", 0     
SCORE_NOTE  DB "   YOUR SCORES:    "
TOTAL_POINT DW '0'    
GAME_POINT  DW '0'    
GAME_GONE   DB "                                ", 0
            DB " ****** !!!GAME OVER!!! ******* ", 0
            DB "                                ", 0
LEVEL_NOTE  DB "Do You Want To play Next level?(y/n)"
CONGO_EXIT  DB "                                ", 0
            DB " ** !!!THANKS FOR PLAYING!!! ** ", 0
            DB "                                ", 0
            DB "  TOTAL SCORES:   "
EXIT_NOTE   DB "Do You Want TO quit ?", 0
            DB "Press Enter Key To Quit", 0     
BOOLEAN     DB 0          
P1_COUNT    DB '0'
P2_COUNT    DB '0'        
P3_COUNT    DB '0'
COUNT_MAX   DW 0          
LINE_NO     DB 0          
LEVEL_CHK   DB 0          
EXIST_CHK   DB 0               
;--------------------------------------------------------------------         
     
;-------------------------CODE AREA----------------------------------     
.CODE
      
;++++++++++++++++++++++++++++ MAIN METHOD +++++++++++++++++++++++++++
MAIN PROC
    
    MOV AX, @DATA  ; It moves memory location of data to AX
    MOV DS, AX     ; It moves location in AX to DS
    
    CALL RESET     ; To Call RESET Method
    CALL HEAD      ; To Call HEAD Method
    CALL NAMES     ; To Call NAMES Method
    CALL INPUT     ; To Call INPUT Method
    CALL RESET   
    CALL HEAD
                   
    MOV DL, 35      ; Set cursor position Column
    MOV DH, 24     ; Set cursor position Row
    
    CALL MENU      ; To Call MENU Method
    
    MOV AH, 0      ; To set video mode
    MOV AL, 3      ; To set which video mode (text mode, 80x25, 16 colors, 8 pages) 
    INT 10H        ; Interrupt to initialize video mode
    
    MOV AH, 4CH    ; To set program return the controls
    INT 21H        ; Call Interrupt to return controls
    
MAIN ENDP 
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;++++++++++++++++++++++++++++ RESET METHOD ++++++++++++++++++++++++++
RESET PROC
    PUSH AX              ; Push previous AX value to stack
    PUSH BX              ; Push previous BX value to stack
    PUSH CX              ; Push previous CX value to stack
    PUSH DX              ; Push previous DX value to stack

    MOV AH, 0            ; To set video mode
    MOV AL, 2            ; Changes cursor position
    INT 10H              ; Call interrupt for graphic

    Mov AH, 06H          ; To scroll up the window
    MOV AL, 0            ; To set number of lines to scrolled (0 = to clear entire window)
    MOV BH, 01010000B    ; To write blank lines at bottom of window (Here we have given color>
    MOV CH, 0            ; Upper row
    MOV CL, 0            ; Upper Column
    MOV DI, 1            ; Rows on screen -1, 
    MOV DH, [DI]         ; Lower Row
    MOV DI, 0            ; Columns on screen 
    MOV DL, [DI]         ; Lower Column               
    INT 10H              ; Call interrupt for video mode

    POP DX               ; Pop previous DX value from stack
    POP CX               ; Pop previous CX value from stack
    POP BX               ; Pop previous BX value from stack
    POP AX               ; Pop previous AX value from stack
    RET
RESET ENDP 
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;++++++++++++++++++++++++++++ HEAD METHOD ++++++++++++++++++++++++++
HEAD PROC
    PUSH AX
    PUSH CX
    
    MOV AX, 0B800h             ; Set a displacement from current position
    LEA SI, WELCOME_MSG        ; To provide memory address of first character or array
    MOV CX, 80                 ; To set count (used to set how many times a loop execute>
    CALL DISP                  ; To call DISP method
    
    MOV AX, 0B800h
    LEA SI, WELCOME_MSG
    MOV CX, 80
    CALL DISP

    MOV AX, 0B800h
    LEA SI, WELCOME_MSG+80
    MOV CX, 80                   
    CALL DISP

    MOV AX, 0B800h
    LEA SI, WELCOME_MSG+162
    MOV CX, 80
    CALL DISP
    
    MOV AX, 0B800h
    LEA SI, WELCOME_MSG+162
    MOV CX, 80
    CALL DISP

    POP CX
    POP AX
    RET
HEAD ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;+++++++++++++++++++++++++++++ DISP METHOD ++++++++++++++++++++++++++
DISP PROC
    PUSH AX

    MOV ES, AX           ; Moving data in AX to Extra Segment
    MOV AH, 31           ; To set the text color
    
    DO:                  
    LODSB                ; It loads unit byte pointed by SI from the memory
    STOSW                ; STOSW Copy AX to memory
    LOOP DO              ; Loop until cx becomes 0

    POP AX
    RET
DISP ENDP 
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 

;+++++++++++++++++++++++++++ NAMES METHOD +++++++++++++++++++++++++++
NAMES PROC
    PUSH AX
    PUSH CX

    MOV AX, 0B814H            ; Set a displacement from current position
    LEA SI, CREATED_BY        ; To provide memory address of first character or array
    MOV CX, 24                ; To set count (used to set how many times a loop execute>
    CALL DISP                 ; To call DISP method
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
   
;++++++++++++++++++++++++++++ INPUT METHOD ++++++++++++++++++++++++++
INPUT PROC
    PUSH AX
    PUSH BX
    PUSH DX

    MOV BH, 0       ; To point towards current page
    MOV DL, 34      ; To which column to give offset to the cursor
    MOV DH, 24      ; To which row to give offset to the cursor
    MOV AH, 02      ; To change cursor position
    INT 10H         ; Interrupt to enter into graphical mode

    MOV AH, 0       ; Get keystroke from keyboard (no echo).
    INT 16H         ; Interrupt prompts for keybord input input

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

    MOV AX, 0B82AH           ; Set a displacement from current position
    LEA SI, MAIN_MENU        ; To provide memory address of first character or array
    MOV CX, 48               ; To set count (used to set how many times a loop execute>
    CALL DISP                ; To call DISP method
    MOV AX, 0B82EH
    LEA SI, MAIN_MENU+49                    
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
    
    MOV AX, 0B856H
    LEA SI, SELECT_INS
    MOV CX, 32
    CALL DISP
    MOV AX, 0B85CH
    LEA SI, SELECT_INS+34
    MOV CX, 32
    CALL DISP 
    MOV AX, 0B862H
    LEA SI, SELECT_INS+68
    MOV CX, 32
    CALL DISP
    MOV AX, 0B868H
    LEA SI, SELECT_INS+102
    MOV CX, 32
    CALL DISP
    MOV AX, 0B878H
    LEA SI, SELECT_INS+134
    MOV CX, 32
    CALL DISP

    MOV AH, 2                   ; To set Cursor Position
    MOV BH, 0                   ; To set Page Number
    INT 10H                     ; Intrupt

    MOV AH, 0                   ; Get keystroke from keyboard (no echo)
    INT 16H                     ; Interrupt to get from keyboard

    CMP AH, 02                  ; Comparing AH with 02
    JE STRT_GAME                ; If above comparison is Equal then jump to STRT_GAME 
    CMP AH, 03                  ; Comparing AH with 03
    JE INSTRUCTIONS             ; If above comparison is Equal then jump to INSTRUCTIONS
    CMP AH, 04                  ; Comparing AH with 04
    JE SCORE_JUMP               ; If above comparison is Equal then jump to SCORE_JUMP
    CMP AH, 05                  ; Comparing AH with 05
    JE QUIT                     ; If above comparison is Equal then jump to QUIT
    JMP EXIT_OUT                ; If above comparison is Equal to none then jump to EXIT_OUT
    
    STRT_GAME:
        CALL LEVEL1             ; Call LEVEL1 Methods
        CALL GAME1              ; Call GAME1 Methods
        CALL RESET
        CALL HEAD
        CALL SELECT
        
    INSTRUCTIONS:
        CALL RESET
        CALL HEAD

        MOV AX, 0B834H
        LEA SI, INSTRUCTS
        MOV CX, 48
        CALL DISP 
        MOV AX, 0B838H
        LEA SI, INSTRUCTS+51
        MOV CX, 48
        CALL DISP
        MOV AX, 0B83CH
        LEA SI, INSTRUCTS+102
        MOV CX, 48
        CALL DISP
        MOV AX, 0B840H
        LEA SI, INSTRUCTS+153
        MOV CX, 48
        CALL DISP
        MOV AX, 0B844H
        LEA SI, INSTRUCTS+204
        MOV CX, 48
        CALL DISP
        MOV AX, 0B848H
        LEA SI, INSTRUCTS+255
        MOV CX, 48
        CALL DISP
        MOV AX, 0B84CH
        LEA SI, INSTRUCTS+306
        MOV CX, 48
        CALL DISP
        MOV AX, 0B850H
        LEA SI, INSTRUCTS+357
        MOV CX, 48
        CALL DISP

        MOV AX, 0B88EH
        LEA SI, PROMPT
        MOV CX, 33
        CALL DISP
       
        CALL INPUT
        JMP EXIT_OUT
    
    SCORE_JUMP:
        CALL RESET
        CALL HEAD

        MOV AX, 0B835H
        LEA SI, SCORE_NOTE
        MOV CX, 16
        CALL DISP

        PUSH AX
        PUSH DX
        PUSH BX
        
        SUB GAME_POINT, 48   ; Converting number from ascii 1 to decimal 0
        MOV AX, GAME_POINT   ; Points will be in AX  
        MOV CX, 10           ; we will divide points by 10
        
        CWD                  ; Convert Word to Double Word
        DIV CX               ; This will divide value in AX with CX
        ADD DX, 48           ; Adding 48 to make it ascii 0
        PUSH DX              ; Push it to the stack
        
        CWD                  ; Convert Word to Double Word
        DIV CX               ; This will divide value in AX with CX
        ADD DX, 48           ; Adding 48 to make it ascii 0
        PUSH DX              ; Push it to the stack
        
        
        MOV BH, 0            ; To point towards current page
        MOV CH, 41           ; To initialize counter
        
        myLoop: 
            MOV DL, CH       ; To which column to give offset to the cursor
            MOV DH, 10       ; To which row to give offset to the cursor
            MOV AH, 02       ; To change cursor position
            INT 10H          ; Interrupt to enter into graphical mode
        
            MOV AH, 2        ; To write a character to standard output
            POP DX           ; Pop value from stack to DX
            INT 21H          ; Interrup to call to text mode 
            INC CH           ; Increment counter
            CMP CH, 43       ; Comparing counter with 43 
            JNE myLoop       ; Jump to myLoop if above comparison is not equal
            MOV CH, 0        ; Moving 0 to CH
        
        POP BX
        POP DX
        POP AX

        MOV AX, 0B8BCH       
        LEA SI, PROMPT
        MOV CX, 30 
        CALL DISP 
        
        CALL INPUT
        ADD GAME_POINT, 48   ; Again converting GAME_POINT to ascii 0
        JMP EXIT_OUT         ; Jump to EXIT_OUT

    EXIT_OUT:
        CALL RESET
        CALL HEAD
        CALL MENU
        
    QUIT:
        CALL RESET
        JMP OK 

    OK:
        RET
SELECT ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  
 
;+++++++++++++++++++++++++++ LEVEL1 METHOD ++++++++++++++++++++++++++
LEVEL1 PROC
    MOV AH, 0               ; Set video mode
    MOV AL, 13H             ; To set graphical mode, 40x25, 256 colors.
    INT 10H                 ; Interrupt to set video mode

    MOV AH, 0CH             ; change color for a single pixel
    MOV AL, 10              ; to set pixel color

    MOV CX, 0
    MOV DX, 0
    MOV BX, 0

    HORIZONTAL:             ; To draw Horizontal Border
        MOV DX, 10          ; Row
        INT 10H             ; Interrupt
        MOV DX, 199
        INT 10H
        INC CX
        CMP CX, 320
        JNE HORIZONTAL

    MOV DX, 0
    VERTICLE:               ; To draw Verticle Border
        MOV CX, 0
        INT 10H
        MOV CX, 319
        INT 10H 
        INC DX
        CMP DX, 199
        JNE VERTICLE

    ;;l1 
    MOV CX, 0
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
        JNE LINE_3B

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

    ;;l10
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
    
    ;;v1
    MOV CX, 300
    MOV DX, 21
    VERTICLE_0:
        INT 10h
        INC DX
        CMP DX, 32
        JNE VERTICLE_0
    
    ;;v2
    MOV DX, 43
    VERTICLE_1:
        INT 10h
        INC DX
        CMP DX, 55
        JNE VERTICLE_1
    
    ;;v3
    MOV DX, 87
    VERTICLE_2:
        INT 10h
        INC DX
        CMP DX, 120
        JNE VERTICLE_2
    
    ;;v4
    MOV DX, 32
    MOV CX, 90
    VERTICLE_3:
        INT 10h
        INC DX
        CMP DX, 43
        JNE VERTICLE_3
    
    ;;v5
    MOV DX, 43
    VERTICLE_4:
        MOV CX, 35
        INT 10h
        MOV CX, 120
        INT 10h
        INC DX
        CMP DX, 54
        JNE VERTICLE_4
    
    ;;v6
    VERTICLE_5:
        MOV CX, 200
        INT 10H
        INC DX
        CMP DX, 65
        JNE VERTICLE_5
    
    ;;v7
    MOV DX, 76
    VERTICLE_6:
        MOV CX, 35
        INT 10h
        MOV CX, 90
        INT 10h
        INC DX
        CMP DX, 87
        JNE VERTICLE_6
   
    ;;v8
    MOV DX, 109
    VERTICLE_7:
        MOV CX, 70
        INT 10h
        INC DX
        CMP DX, 120
        JNE VERTICLE_7
    
    ;;v9
    MOV DX, 131
    VERTICLE_8:
        MOV CX, 80
        INT 10h
        MOV CX, 100
        INT 10h
        INC DX
        CMP DX, 142
        JNE VERTICLE_8
    
    ;;v10
    MOV DX, 153
    VERTICLE_9:
        MOV CX, 70
        INT 10h
        MOV CX, 90
        INT 10h
        MOV CX, 255
        INT 10h
        INC DX
        CMP DX, 164
        JNE VERTICLE_9
    
    ;;v11
    VERTICLE_10:
        MOV CX, 18
        INT 10h
        MOV CX, 255
        INT 10h
        INC DX
        CMP DX, 175
        JNE VERTICLE_10
    
    ;;v12
    MOV DX, 142
    VERTICLE_11:
        MOV CX, 20
        INT 10h
        INC DX
        CMP DX, 153
        JNE VERTICLE_11
    
    ;;v13
    MOV DX, 175
	VERTICLE_12:
        MOV CX, 160
        INT 10H
        INC DX
        CMP DX, 186
        JNE VERTICLE_12
    
    ;;v14
    VERTICLE_13:
        MOV CX, 180
        INT 10H
        INC DX
        CMP DX, 197
        JNE VERTICLE_13
    
    ;;Ending Line
    MOV CX, 305
    MOV DX, 197
    MOV AL, 14
    END_20:
        MOV AH, 0CH
        INT 10h
        DEC DX
        CMP DX, 175
        JA END_20

    RET
LEVEL1 ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;++++++++++++++++++++++++++ GAME1 METHOD ++++++++++++++++++++++++++++
GAME1 PROC

    MOV DX, 11                    ; Row
    MOV CX, 1                     ; Column
    MOV BX, 0505H                 ; object size b/c bh = 05 & bl = 05

    DRW:
        CMP COUNT_MAX, 500        ; Comparing COUNT_MAX with 500
        JNE CON                   ; Loops for 500 moves
        CALL GAME_OVER            ; Call GAME_OVER method  
        JMP EXI                   ; Jump to F

    CON:
        MOV AX, 0C0FH             ; To change the color of single pixel
        CALL DISPLAY              ; Call DISPLAY method
        CALL KBHIT                ; Call KBHIT method
        CMP EXIST_CHK, 1          ; Exit signal from any level
        JE EXI                    ; Jump to F if above comparison is equal
        JMP DRW                   ; Jump to DRW
    
    EXI:
        RET
GAME1 ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++   

;+++++++++++++++++++++++++++ DISPLAY METHOD +++++++++++++++++++++++++
DISPLAY PROC
    PUSH AX
    PUSH CX
    PUSH DX
    PUSH BX

    D1:                     ; display  bAll of order 5x5
        PUSH CX
        D2:
            INT 10h         ; Interrupt to print colored pixel
            INC CX          ; Increment column
            DEC BL          ; Decrementing BL
            CMP BL, 0       ; Checking if BL is 0
            JNE D2          ; If above comparison is not equal then jump D2 
        DEC BH              ; Decrementing BH
        INC DX              ; Incrementing DX
        POP CX              ; POP CX
        MOV BL, 5           ; Moving 5 to BL
        CMP BH, 0           ; Checking if BH is 0
        JNE D1              ; If above comparison is not equal then jump D1

    POP BX
    POP DX
    POP CX
    POP AX
    RET
DISPLAY ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;++++++++++++++++++++++++ GAME_OVER METHOD ++++++++++++++++++++++++++
GAME_OVER PROC

    CALL RESET                       ; Call RESET Method
    CALL HEAD                        ; Call HEAD Method

    MOV AX, 0B82BH                   ; To give offset to text on screen 
    LEA SI, GAME_GONE                ; Move offset of variable in SI
    MOV CX, 32                       ; Initialize counter with 16
    CALL DISP                        ; Call DISP Method
    MOV AX, 0B831H                    
    LEA SI, GAME_GONE+33                
    MOV CX, 32                       
    CALL DISP 
    MOV AX, 0B837H                    
    LEA SI, GAME_GONE+66                
    MOV CX, 32                       
    CALL DISP
    
    MOV AX, 0B852H                   ; To give offset to text on screen 
    LEA SI, SCORE_NOTE               ; Move offset of variable in SI
    MOV CX, 16                       ; Initialize counter with 14
    CALL DISP                        ; Call DISP Method
    ADD COUNT_MAX, 48
    MOV AX, 0B852H                    
    LEA SI, COUNT_MAX               
    MOV CX, 2                       
    CALL DISP                        

    MOV COUNT_MAX, 0                 ; Mov 0 to COUNT_MAX
    MOV P1_COUNT, '0'
    MOV P2_COUNT, '0'
    MOV P3_COUNT, '0'

    MOV AX, 0B8B0H
    LEA SI, PROMPT
    MOV CX, 34
    CALL DISP

    RET
GAME_OVER ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;++++++++++++++++++++++++++ KBHIT METHOD ++++++++++++++++++++++++++++
KBHIT proc
    MOV AH, 00h          ; get keystroke from keyboard (no echo).
    INT 16h              ; Waits for user input

    CMP AH, 01           ; Comparing AX with 01
    JE EXIT              ; Jump to EXIT if above comparison is equal

    CMP AH, 72           ; Comparing AX with 72
    JZ UP1               ; Jump to UP1 if above comparison is equal
    CMP AH, 80           ; Comparing AX with 80
    JZ DOWN1             ; Jump to DOWN1 if above comparison is equal
    CMP AH, 75           ; Comparing AX with 75
    JZ LEFT              ; Jump to LEFT if above comparison is equal
    CMP AH, 77           ; Comparing AX with 77
    JZ RIGHT             ; Jump to RIGHT if above comparison is equal
    JMP EXIT             ; Else exit

    UP1:
        PUSH DX
        SUB DX, 1        ; Subtract DX to move row up 
        CALL CHECK       ; Call CHECK Method
        CMP BOOLEAN, 1   ; To check if line is being crossed or not
        POP DX
        JE EXIT          ; Jump to EXIT if ball tries to moves through the line

        MOV AX, 0C00H    ; Subroutine to change color of single pixel
        CALL DISPLAY     ; Call DISPLAY Method

        DEC DX           ; Decrementing DX
        CALL LINE        ; Call LINE Method
        SUB DX, 4        ; Subtracting 4 from DX to move 4 rows above
        CMP LINE_NO, 1   ; Comparing LINE_NO with 1
        JNE EXIT         ; Jump to EXIT if comparison is not equal
        MOV LINE_NO, 0   ; Moving 0 to LINE_NO
        DEC DX           ; Decrementing DX
        CALL COUNTER     ; Call COUNTER Method
        JMP EXIT         ; Jump to EXIT

    DOWN1:
        PUSH DX
        ADD DX, 5        ; Add 5 to DX to move 5 row down
        CALL CHECK       ; Call CHECK Method
        CMP BOOLEAN, 1   ; To check if line is being crossed or not
        POP DX
        JE EXIT          ; Jump to EXIT if ball tries to moves through the line

        MOV AX, 0C00H    ; Subroutine to change color of single pixel
        CALL DISPLAY     ; Call DISPLAY Method
        
        ADD DX, 5        ; Adding 5 to DX
        CALL LINE        ; Call LINE Method
        CMP LINE_NO, 1   ; Comparing LINE_NO with 1
        JNE EXIT         ; Jump to EXIT if comparison is not equal
        MOV LINE_NO, 0   ; Moving 0 to LINE_NO
        INC DX           ; Incrementing DX
        CALL COUNTER     ; Call COUNTER Method
        JMP EXIT         ; Jump to EXIT

    LEFT:
        PUSH CX
        SUB CX, 1        ; Subtract 1 from CX to move 1 column left
        CALL CHECK       ; Call CHECK method
        CMP BOOLEAN, 1   ; To check if line is being crossed or not
        POP CX
        JE EXIT          ; Jump to EXIT if ball tries to moves through the line

        MOV AX, 0C00H    ; Subroutine to change color of single pixel
        CALL DISPLAY     ; Call DISPLAY Method
        SUB CX, 5        ; Subtract 5 from CX
        CALL COUNTER     ; Call COUNTER Method
        JMP EXIT         ; Jump to EXIT

    RIGHT:
        PUSH CX
        ADD  CX, 9       ; Add 9 to CX to move 9 columns right
        CALL CHECK       ; Call CHECK Method
        CMP BOOLEAN, 1   ; To check if line is being crossed or not
        POP CX
        JE EXIT          ; Jump to EXIT if ball tries to moves through the line

        CMP AL, 14       ; CMP for exit line with colour 14
        JNE FFF          ; Jump to FFF if above comparison is not equal

        CALL CONGRETS    ; Call CONGRETS method
        JMP EXIT         ; Jump to EXIT

    FFF:
        MOV AX, 0C00H   ; Subroutine to change color of single pixel
        CALL DISPLAY    ; Call DISPLAY method
        ADD CX, 5       ; Add 5 to CX
        CALL COUNTER    ; Call COUNTER method

    EXIT:
        MOV BOOLEAN, 0  ; Moving 0 to BOOLEAN
        RET
KBHIT ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 

;+++++++++++++++++++++++++++ CHECK METHOD ++++++++++++++++++++++++++++
CHECK proc
    PUSH  BX

    MOV AH, 0DH            ; To get color of a single pixel
    MOV BH, 0              ; Page 0
    INT 10H                ; Interrupt to get color
          
    CMP AL, 10             ; Compare current pixel color with present pixel color
    JNE EX                 ; Jump to EX if above comparison is equal
    MOV BOOLEAN, 1         ; Else mov 1 to BOOLEAN
    
    EX:
        POP BX
        RET
CHECK endp
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 

;+++++++++++++++++++++++++++ LINE METHOD ++++++++++++++++++++++++++++
LINE PROC

   CMP DX, 21                ; Comparing DX with 21 because at row 21 there is our first line
   JE KL                     ; Jump to KL if our comparison is equal
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
   JE KL                         
   CMP DX, 98                     
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
   JNE EF                    ; Else Jump to EF

   KL:
        MOV LINE_NO, 1       ; Moving 1 to LINE_NO 

   EF:
        RET
LINE ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;+++++++++++++++++++++++++ COUNTER METHOD +++++++++++++++++++++++++++
COUNTER PROC

    PUSH CX
    PUSH DX
    PUSH BX

    MOV AH, 2                      ; Subroutine to write character to standard output

    MOV DL, P1_COUNT               ; Moving P1_COUNT to DL
    INT 21h                        ; Interrupt to display character
    MOV DL, P2_COUNT               ; Moving P2_COUNT to DL
    INT 21h                        ; Interrupt to display character
    MOV DL, P3_COUNT               ; Moving P3_COUNT to DL
    INT 21h                        ; Interrupt to display character

    MOV DL, 0                      ; Move Cursor to Column 1
    MOV DH, 0                      ; Move Cursor to Row 1
    MOV AH, 02                     ; Subroutine to change cursor position
    MOV BH, 0                      ; Mov to page 0
    INT 10h                        ; Interrupt to set cursor position

    CMP P3_COUNT, '9'              ; Comparing P3_COUNT with ascii 9
    JE NEX1                        ; Jump to NEX1 if above comparison is equal

    INC  P3_COUNT                  ; Incrementing P3_COUNT
    JMP SEC                        ; Jump to SEC

    NEX1:
        CMP P2_COUNT, '9'          ; Comparing P2_COUNT with ascii 9
        JE NEX2                    ; Jump to NEX2 if above comparison is equal

    MOV P3_COUNT, '0'              ; Comparing P2_COUNT with ascii 0
    INC P2_COUNT                   ; Incrementing P2_COUNT
    JMP SEC                        ; Jump to SEC
    
    NEX2:
        INC P1_COUNT               ; Incrementing P1_COUNT
        MOV P2_COUNT, '0'          ; Moving ascii 0 to P2_COUNT 
        MOV P3_COUNT, '0'          ; Moving ascii 0 to P3_COUNT 

    SEC:
        ADD COUNT_MAX, 1           ; Add 1 to COUNT_MAX
    
    POP BX
    POP DX
    POP CX
    RET
COUNTER ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 

;++++++++++++++++++++++++ CONGRETS METHOD +++++++++++++++++++++++++++
CONGRETS PROC
    PUSH CX

    CALL RESET               ; Call RESET Method
    CALL HEAD                ; Call HEAD Method

    CMP COUNT_MAX, 390       ; Comparing COUNT_MAX to 390 
    JB FIRST                 ; Jump to FIRST if COUNT_MAX is less than 390
    CMP COUNT_MAX, 420       ; Comparing COUNT_MAX to 420
    JB SECOND                ; Jump to SECOND if COUNT_MAX is less than 420
    CMP COUNT_MAX, 450       ; Comparing COUNT_MAX to 450
    JB THIRD                 ; Jump to THIRD if COUNT_MAX is less than 450

    MOV GAME_POINT, '3'      ; Else move 3 to GAME_POINT
    JMP CONTINUE             ; Jump to CONTINUE 

    FIRST:
        MOV GAME_POINT, '9'  ; Moving 9 to GAME_POINT
        JMP CONTINUE         ; Jump to CONTINUE
    SECOND:
        MOV GAME_POINT, '7'  ; Moving 7 to GAME_POINT
        JMP CONTINUE         ; Jump to CONTINUE
    THIRD:
        MOV GAME_POINT, '5'  ; Moving 5 to GAME_POINT


    PUSH CX
    PUSH DX                  
    MOV CX, GAME_POINT       ; Moving GAME_POINT to CX
    MOV DX, TOTAL_POINT      ; Moving TOTAL_POINT to DX
    MOV GAME_POINT, DX       ; Moving TOTAL_POINT from DX to GAME_POINT
    MOV TOTAL_POINT, CX      ; Moving GAME_POINT from CX to TOTAL_POINT
    POP DX
    POP CX


    CONTINUE:
        MOV AX, 0B817H       ; To give offset to text on screen 
        LEA SI, GREETINGS    ; Move offset of variable in SI
        MOV CX, 32           ; Initialize counter with 16
        CALL DISP            ; Call DISP Method
        MOV AX, 0B81DH                    
        LEA SI, GREETINGS+33                
        MOV CX, 32                       
        CALL DISP 
        MOV AX, 0B823H                    
        LEA SI, GREETINGS+66                
        MOV CX, 32                       
        CALL DISP

        MOV AX, 0B833H        ; To give offset to text on screen 
        LEA SI, SCORE_NOTE    ; Move offset of variable in SI
        MOV CX, 20            ; Initialize counter with 14
        CALL DISP             ; Call DISP Method
        ADD COUNT_MAX, 48
        MOV AX, 0B833H                    
        LEA SI, COUNT_MAX               
        MOV CX, 4                       
        CALL DISP

        MOV AX, 0B844H                    
        LEA SI, CONGO_EXIT               
        MOV CX, 32                       
        CALL DISP                        
        MOV AX, 0B84AH                    
        LEA SI, CONGO_EXIT+33                
        MOV CX, 32                       
        CALL DISP 
        MOV AX, 0B850H                    
        LEA SI, CONGO_EXIT+66                
        MOV CX, 32                       
        CALL DISP
        
        MOV AX, 0B860H                    
        LEA SI, CONGO_EXIT+99                
        MOV CX, 18                       
        CALL DISP

        SUB TOTAL_POINT, 48    ; Subtracting 48 from TOTAL_POINT
        MOV CX, TOTAL_POINT    ; Moving TOTAL_POINT to CX
        SUB GAME_POINT , 48    ; Subtracting 48 from GAME_POINT
        ADD GAME_POINT , CX    ; Add GAME_POINT to CX
        PUSH DX
        PUSH BX
        
        MOV AX, GAME_POINT     ; Moving GAME_POINT to AX
        MOV CX, 10             ; Initializing counter with 10
        CWD                    ; Convert Word to Byte
        
        DIV CX                 ; Divide value in AX from CX
        ADD DX, 48             ; Add 48 in DX which has remainder to convert it into ascii number
        PUSH DX                ; Push DX to stack
        CWD                    ; Convert Word to Byte
        
        DIV CX
        ADD DX, 48
        PUSH DX  
        
        MOV BH, 0              ; To point towards current page
        MOV CH, 43             ; To initialize counter
        
        myLoop2: 
            MOV DL, CH         ; To which column to give offset to the cursor
            MOV DH, 17         ; To which row to give offset to the cursor
            MOV AH, 02         ; To change cursor position
            INT 10H            ; Interrupt to enter into graphical mode
        
            MOV AH, 2          ; To write a character to standard output
            POP DX             ; Pop value from stack to DX
            INT 21H            ; Interrup to call to text mode 
            INC CH             ; Increment counter
            CMP CH, 45         ; Comparing counter with 43 
            JNE myLoop2        ; Jump to myLoop if above comparison is not equal
            MOV CH, 0          ; Moving 0 to CH
        
        POP BX
        POP DX
        POP AX

        MOV AX, 0B8A1H       
        LEA SI, PROMPT
        MOV CX, 32 
        CALL DISP
        
        CALL INPUT 
        
    POP BX
    POP DX
    POP CX

    RET
CONGRETS ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
