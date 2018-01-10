; Llorada, Edison
; Malaki, Earl Timothy
; CMSC 131
; Final Project
; SQRD

TITLE SQRD (.EXE MODEL)
;--------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;--------------------------------------
DATASEG SEGMENT PARA 'Data'

	; ------------------------------------------------------------------------------------------------------------
	; MAIN SCREEN UI
	; Button border coords:
	; HOR = 26 <-> 51
    ; VER = 16 <-> 18 | 21 <-> 23

	MAIN_SCREEN_UI 		DB "                                                                                "
						DB "                                                                                "
    					DB "                   _________________  __________ ________                       "
						DB "                  /   _____/\_____  \ \______   \\______ \                      "
						DB "                  \_____  \  /  / \  \ |       _/ |    |  \                     "
						DB "                  /        \/   \_/.  \|    |   \ |    `   \                    "
						DB "                 /_______  /\_____\ \_/|____|_  //_______  /                    "
						DB "                         \/        \__>       \/         \/                     "
    					DB "                                                                                "
    					DB "                                                                                "
    					DB "                         .-------------------------.                            "
    					DB "                         |        NEW GAME         |                            "
    					DB "                         '-------------------------'                            "
    					DB "                                                                                "
    					DB "                         .-------------------------.                            "
    					DB "                         |       HOW TO PLAY       |                            "
    					DB "                         '-------------------------'                            "
    					DB "                                                                                "
    					DB "                         .-------------------------.                            "
    					DB "                         |          EXIT           |                            "
    					DB "                         '-------------------------'                            "
    					DB "                                                                                "
    					DB "                                                                                "
    					DB "                                                                                ", '$'

   	; coordinates for button borders
   	; to check click boundary
   	; Format:
   	; 	- dec position with respect to screen size (80,25)
   	; 	-	 	up, down, left, right
   	; 	- ex:	16, 18, 26, 51

    BTN_NEWGAME		DW 10,12,26,50
    BTN_HOWTO		DW 14,16,26,50
    BTN_QUIT		DW 18,20,26,50
    ; ------------------------------------------------------------------------------------------------------------    

    ; ------------------------------------------------------------------------------------------------------------
    ; HOW TO SCREEN UI
	; Button border coords:
	; HOR = 1AH <-> 33H
    ; VER = 16H <-> 17H

	HOWTO_SCREEN_UI 	DB "                                                                                "
						DB "                                                                                "
    					DB "                   _________________  __________ ________                       "
						DB "                  /   _____/\_____  \ \______   \\______ \                      "
						DB "                  \_____  \  /  / \  \ |       _/ |    |  \                     "
						DB "                  /        \/   \_/.  \|    |   \ |    `   \                    "
						DB "                 /_______  /\_____\ \_/|____|_  //_______  /                    "
						DB "                         \/        \__>       \/         \/                     "
    					DB "                                                                                "
						DB "                          _________________________                             "
    					DB "                                                                                "
    					DB "                                 HOW TO PLAY                                    "
    					DB "                          _________________________                             "
    					DB "                                                                                "    					
    					DB "                                                                                "
    					DB "      Player 1 and Player 2 will take turns on claiming dots on the grid.       "
    					DB "                   P1's SQRS are Blue and P2's SQRS are Red.                    "
    					DB "                  The first player to claim four dots forming                   "
						DB "                        a square will be hailed winner.                         "
    					DB "                                    SQRD                                        "
    					DB "                                                                                "						
    					DB "                         .-------------------------.                            "
    					DB "                         |      BACK TO MAIN       |                            "
    					DB "                         '-------------------------'                            ", '$'

    BTN_BACKTOMAIN_FROMHOWTO		DW 21,23,26,50
    ; ------------------------------------------------------------------------------------------------------------
	
	
	; ------------------------------------------------------------------------------------------------------------
	; GAMEPLAY SCREEN UI
	GAMEPLAY_SCREEN_UI		DB "                                                                                "
							DB "                   _________________  __________ ________                       "
						    DB "                  /   _____/\_____  \ \______   \\______ \                      "
						    DB "                  \_____  \  /  / \  \ |       _/ |    |  \                     "
						    DB "                  /        \/   \_/.  \|    |   \ |    `   \                    "
						    DB "                 /_______  /\_____\ \_/|____|_  //_______  /                    "
						    DB "                         \/        \__>       \/         \/                     "
						    DB "                                                                                "
						    DB "                                                                                "
    						DB "                        _____________________________                           "
    						DB "                       |    |    |    |    |    |    |                          "
    						DB "                       |____|____|____|____|____|____|                          "
    						DB "                       |    |    |    |    |    |    |                          "
    						DB "   __________  ____    |____|____|____|____|____|____|   ________________       "
    						DB "   \______   \/_   |   |    |    |    |    |    |    |   \______   \___  \      "
    						DB "    |     ___/ |   |   |____|____|____|____|____|____|    |     ___//  __/      "
    						DB "    |    |     |   |   |    |    |    |    |    |    |    |    |   /     \      "
    						DB "    |____|     |___|   |____|____|____|____|____|____|    |____|   \______\     "
    						DB "                       |    |    |    |    |    |    |                          "
    						DB "                       |____|____|____|____|____|____|                          "
    						DB "                       |    |    |    |    |    |    |                          "
    						DB "                       |____|____|____|____|____|____|                          "
    						DB "                                                                                "
    						DB "                         ____________   ____________                            "
    						DB "                        |   RETURN   | |  RESTART!  |                          ", '$'
	
	BTN_GAMESCREEN_RETURN		DW 24,25,25,36    						
	BTN_GAMESCREEN_RESTART		DW 24,25,40,51

	PLAYER_INDICATOR_UI_1					DB "-_-_-_-", '$'
	PLAYER_INDICATOR_UI_2					DB "  \./  ", '$'

	PLAYER_INDICATOR_DEL_1					DB "       ", '$'
	PLAYER_INDICATOR_DEL_2					DB "       ", '$'

	PLAYER_INDICATOR_POS_P1					DW 0B07H, 0C07H
	PLAYER_INDICATOR_POS_P2 				DW 0B3DH, 0C3DH
	; ------------------------------------------------------------------------------------------------------------


    ; ------------------------------------------------------------------------------------------------------------
    GAMEOVER_SCREEN_UI			DB "                                                                                "
    							DB "           ________                      ________                               "
    							DB "          /  _____/_____    _____   ____ \_____  \___  __ ___________           "
    							DB "         /   \  ___\__  \  /     \_/ __ \ /   |   \  \/ // __ \_  __ \          "
    							DB "         \    \_\  \/ __ \|  Y Y  \  ___//    |    \   /\  ___/|  | \/          "
    							DB "          \______  (____  /__|_|  /\___  >_______  /\_/  \___  >__|             "
    							DB "                 \/     \/      \/     \/        \/          \/                 "
    							DB "                                                                                "
    							DB "                                           _  _ ____ _  _ ____                  "
    							DB "                                           |\ | |__| |\/| |___ <>               "
    							DB "                                           | \| |  | |  | |___ <>               "
    							DB "                                                                                "
    							DB "                                            >                                   "
    							DB "                                                                                "
    							DB "                                                                                "
    							DB "                                                                                "
    							DB "                                                                                "
    							DB "                                                                                "
    							DB "                                                                                "
    							DB "                           _________________________                            "
    							DB "                          |   _  _ ____ __ _ _  _   |                           "
    							DB "                          |   |\/| |=== | \| |__|   |                           "
    							DB "                           -------------------------                            "
								DB "                                                                                ", '$'
		

	BTN_TOMENU_FROMGMOV			DW 21,22,27,52
	PLAYER_NAME_POS				DW 0C2EH
	PLAYER_NAME_PREV_POS		DW 102EH
	PLAYER_WON_POS				DW 0800H

	PLAYER_1_WON			DB "            __________  _____  ", 10,13
							DB "            \______   \/_    | ", 10,13
							DB "             |     ___/ |    | ", 10,13
							DB "             |    |     |    | ", 10,13
							DB "             |____|     |____| ", 10,13
							DB "             _ _ _ _ _ _ _ _ _ ", 10,13
							DB "              _ _ _ ____ _  _  ", 10,13
							DB "              | | | |  | |\ |  ", 10,13
							DB "              |_|_| |__| | \|  ", '$'

	PLAYER_2_WON 			DB "            __________________  ", 10,13
							DB "            \______   \_____  \ ", 10,13
							DB "             |     ___//  ____/ ", 10,13
							DB "             |    |   /       \ ", 10,13
							DB "             |____|   \_______ \", 10,13
							DB "             _ _ _ _ _ _ _ _ _\/", 10,13
							DB "              _ _ _ ____ _  _   ", 10,13
							DB "              | | | |  | |\ |   ", 10,13
							DB "              |_|_| |__| | \|   ", '$'
	                  
; ------------------------------------------------------------------------------------------------------------

    MOUSEX				DW 0H
    MOUSEY				DW 0H
    MOUSECLICK 			DW 0H            
    MOUSEPOS 			DW 0H

    CONST_SCREEN_MAINMENU 	DB "MAIN"
    CONST_SCREEN_HOWTO 		DB "HOWT"
    CONST_SCREEN_GAMEPLAY 	DB "GMPL"
    CONST_SCREEN_GAMEOVER	DB "GMOV"
    CURRENT_SCREEN			DB 4 DUP(' ')

    CONST_STATE_PLAYING		DB "PLAY"
    CONST_STATE_OVER		DB "OVER"
	CURRENT_STATE 			DB 4 DUP(' '), '$'

	CONST_PLAYER_0			DW 0
	CONST_PLAYER_1			DW 1
	CONST_PLAYER_2			DW 2
    CURRENT_PLAYER 			DW ?

    CONST_BOOLEAN_TRUE		DW 1
    CONST_BOOLEAN_FALSE		DW 0

    NUM_LOC DB 10 DUP(' '),'$'
    TEMP_NUMBER				DW ?
    BOOLEAN_FLAG_BTN DB 'F'
    CONST_NEWLINE 			DB 10,13,'$'

    ; cell represents a grid entry by a player
    CELL STRUC
    	X 			DW ?
    	Y 			DW ?
    	TOP_LEFT 	DW ?
    	BOT_RIGHT 	DW ?
    	OWNER 		DW ?			; 1 FOR P1, 2 FOR P2
    	CHECKED 	DW ?			; 1 FOR YES/TRUE, 0 FOR NO/FALSE
    CELL ENDS

    ; initialize cell by
    ;CELL <2,3,0,0>
	;POINT_A CELL <3,0>
	;MOV [CELL_A.X], 3

	; INITIALIZE GRID
	; ------------------------------------------------------------------------------------------------------------
	; CELL <X,Y,TOP_LEFT,BOT_RIGHT,OWNER(1 p1 OR 2 p2 OR 0 no owner), CHECKED (1 YES OR 0 NO)>
	CELL_0_0		CELL <0,0,0A18H,0B1BH,0,0>
	CELL_1_0		CELL <1,0,0A1DH,0B20H,0,0>
	CELL_2_0		CELL <2,0,0A22H,0B25H,0,0>
	CELL_3_0		CELL <3,0,0A27H,0B2AH,0,0>
	CELL_4_0		CELL <4,0,0A2CH,0B2FH,0,0>
	CELL_5_0		CELL <5,0,0A31H,0B34H,0,0>

	CELL_0_1		CELL <0,1,0C18H,0D1BH,0,0>
	CELL_1_1		CELL <1,1,0C1DH,0D20H,0,0>
	CELL_2_1		CELL <2,1,0C22H,0D25H,0,0>
	CELL_3_1		CELL <3,1,0C27H,0D2AH,0,0>
	CELL_4_1		CELL <4,1,0C2CH,0D2FH,0,0>
	CELL_5_1		CELL <5,1,0C31H,0D34H,0,0>

	CELL_0_2		CELL <0,2,0E18H,0F1BH,0,0>
	CELL_1_2		CELL <1,2,0E1DH,0F20H,0,0>
	CELL_2_2		CELL <2,2,0E22H,0F25H,0,0>
	CELL_3_2		CELL <3,2,0E27H,0F2AH,0,0>
	CELL_4_2		CELL <4,2,0E2CH,0F2FH,0,0>
	CELL_5_2		CELL <5,2,0E31H,0F34H,0,0>

	CELL_0_3		CELL <0,3,1018H,111BH,0,0>
	CELL_1_3		CELL <1,3,101DH,1120H,0,0>
	CELL_2_3		CELL <2,3,1022H,1125H,0,0>
	CELL_3_3		CELL <3,3,1027H,112AH,0,0>
	CELL_4_3		CELL <4,3,102CH,112FH,0,0>
	CELL_5_3		CELL <5,3,1031H,1134H,0,0>

	CELL_0_4		CELL <0,4,1218H,131BH,0,0>
	CELL_1_4		CELL <1,4,121DH,1320H,0,0>
	CELL_2_4		CELL <2,4,1222H,1325H,0,0>
	CELL_3_4		CELL <3,4,1227H,132AH,0,0>
	CELL_4_4		CELL <4,4,122CH,132FH,0,0>
	CELL_5_4		CELL <5,4,1231H,1334H,0,0>

	CELL_0_5		CELL <0,5,1418H,151BH,0,0>
	CELL_1_5		CELL <1,5,141DH,1520H,0,0>
	CELL_2_5		CELL <2,5,1422H,1525H,0,0>
	CELL_3_5		CELL <3,5,1427H,152AH,0,0>
	CELL_4_5		CELL <4,5,142CH,152FH,0,0>
	CELL_5_5		CELL <5,5,1431H,1534H,0,0>
	; ------------------------------------------------------------------------------------------------------------

	; ------------------------------------------------------------------------------------------------------------
	; grid click bounds
	BTN_0_0		DW 10, 11, 24, 27
	BTN_1_0		DW 10, 11, 29, 32
	BTN_2_0		DW 10, 11, 34, 37
	BTN_3_0		DW 10, 11, 39, 42
	BTN_4_0		DW 10, 11, 44, 47
	BTN_5_0		DW 10, 11, 49, 52

	BTN_0_1		DW 12, 13, 24, 27
	BTN_1_1		DW 12, 13, 29, 32
	BTN_2_1		DW 12, 13, 34, 37
	BTN_3_1		DW 12, 13, 39, 42
	BTN_4_1		DW 12, 13, 44, 47
	BTN_5_1		DW 12, 13, 49, 52

	BTN_0_2		DW 14, 15, 24, 27
	BTN_1_2		DW 14, 15, 29, 32
	BTN_2_2		DW 14, 15, 34, 37
	BTN_3_2		DW 14, 15, 39, 42
	BTN_4_2		DW 14, 15, 44, 47
	BTN_5_2		DW 14, 15, 49, 52

	BTN_0_3		DW 16, 17, 24, 27
	BTN_1_3		DW 16, 17, 29, 32
	BTN_2_3		DW 16, 17, 34, 37
	BTN_3_3		DW 16, 17, 39, 42
	BTN_4_3		DW 16, 17, 44, 47
	BTN_5_3		DW 16, 17, 49, 52

	BTN_0_4		DW 18, 19, 24, 27
	BTN_1_4		DW 18, 19, 29, 32
	BTN_2_4		DW 18, 19, 34, 37
	BTN_3_4		DW 18, 19, 39, 42
	BTN_4_4		DW 18, 19, 44, 47
	BTN_5_4		DW 18, 19, 49, 52

	BTN_0_5		DW 20, 21, 24, 27
	BTN_1_5		DW 20, 21, 29, 32
	BTN_2_5		DW 20, 21, 34, 37
	BTN_3_5		DW 20, 21, 39, 42
	BTN_4_5		DW 20, 21, 44, 47
	BTN_5_5		DW 20, 21, 49, 52
	; ------------------------------------------------------------------------------------------------------------					

    BLOCK 	DB 177,177,177,177, '$'

    INDEX_I DW 0
    INDEX_J DW 0
    INDEX_K DW 0
    INDEX_TEMP DW 0

    BOOLEAN_NEIGH_RIGHT DB 'F'
    BOOLEAN_NEIGH_BOT DB 'F'
    BOOLEAN_NEIGH_DIAG DB 'F'
    BOOLEAN_FLAG_NORMAL_SQUARE DB 'F'
    BOOLEAN_FLAG_DIAMOND_SQUARE DB 'F'
    ROW_OF_CELLS DD ?,?,?,?,?,?
    DISTANCE DW ?

    BOOLEAN_GAME_WON DB 'F'
    SCORE DB ?
    PLAYER_NAME				DB 31 DUP (' '), '$'
    PLAYER_NAME_PREVIOUS	DB 31 DUP (' '), '$'

    PLAYER_PREV_WINNER		DB "Previous Winner: ", '$'
    

    PATHFILENAME  DB 'hscore.txt', 00H
    FILEHANDLE_R    DW ?
    FILEHANDLE_W    DW ?
    ERROR1_STR_R    DB 'Error in opening file.$'
  	ERROR2_STR_R    DB 'Error reading from file.$'
  	ERROR3_STR_R    DB 'No record read from file.$'

  	ERROR1_STR_W    DB 'Error in creating file.$'
  ERROR2_STR_W    DB 'Error writing in file.$'
  ERROR3_STR_W    DB 'Record not written properly.$'

    CHER db "cheret $"
    CHAR db "charat $"

DATASEG ENDS
; ------------------------------------------------------------------------------------------------------------
CODESEG SEGMENT PARA 'Code'
	ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG

START:
	MAIN PROC FAR
		MOV AX, DATASEG 				; initialize
		MOV DS, AX
		MOV ES, AX

		CALL _DRAW_MAIN_SCREEN 			; draw main screen UI

		CALL _HIDE_CURSOR
		CALL _RESET_MOUSE

		CALL _SHOW_CURSOR

		MAIN_LOOP:
			CALL _GET_MOUSE_STAT

			CMP MOUSECLICK, 1H 			; check if left click
			JNE CONT_ML 				; if false, nothing happens
			CALL _ASSESS_CLICK	 		; if true, check what was clicked

			LEA DX, CONST_STATE_PLAYING
			CMP CURRENT_STATE, DL
			JNE CONT_ML
			MOV DX, CONST_PLAYER_1
			CMP CURRENT_PLAYER, DX
			JE DRAW_P1_GRAPHICS
			MOV DX, CONST_PLAYER_2
			CMP CURRENT_PLAYER, DX
			JE DRAW_P2_GRAPHICS
			JMP CONT_ML

			DRAW_P1_GRAPHICS:
				PUSH [PLAYER_INDICATOR_POS_P1+0]
				PUSH [PLAYER_INDICATOR_POS_P1+2]
				CALL _PRINT_INDICATOR
				PUSH [PLAYER_INDICATOR_POS_P2+0]
				PUSH [PLAYER_INDICATOR_POS_P2+2]
				CALL _ERASE_INDICATOR
				JMP CONT_ML

			DRAW_P2_GRAPHICS:
				PUSH [PLAYER_INDICATOR_POS_P2+0]
				PUSH [PLAYER_INDICATOR_POS_P2+2]
				CALL _PRINT_INDICATOR
				PUSH [PLAYER_INDICATOR_POS_P1+0]
				PUSH [PLAYER_INDICATOR_POS_P1+2]
				CALL _ERASE_INDICATOR
				JMP CONT_ML

			CONT_ML:
				CALL _DELAY
				JMP MAIN_LOOP

	    JMP EXIT_MAIN
	MAIN ENDP

EXIT_MAIN:
	CALL _TERMINATE
; ---------------------------------------------
_GET_MOUSE_STAT PROC NEAR
	MOV  AX, 3H 				; fxn code for get mouse pos(cx,dx) and btn status(bx)
	INT  33H 					; int code for mouse access
	MOV  mouseClick, BX 		; store btn clicked 

	PUSH DX 					; keep safe DX's value. it will be affected by DIVision fxn

	MOV AX, CX 					; divide CX (x pos) by 8 to get text mode reso
	MOV BL, 8
	DIV BL
	MOV AH, 00H
	MOV MOUSEX, AX 				; store correct x pos

	POP DX 						; refresh DX's orig value

	MOV AX, DX 					; divide DX (y pos) by 8 to get text mode reso
	MOV BL, 8
	DIV BL
	MOV AH, 00H
	MOV MOUSEY, AX 				; store correct y pos

	; MOUSEX & MOUSEY now has correct (80x25)-based coordinates

	; MOV DH, 00
	; MOV DL, 00
	; CALL _SET_CURSOR
	; MOV CX, MOUSEX
	; CALL _PRINT_CX

	; MOV AH, 02H
	; MOV DL, ','
	; INT 21H
	; MOV CX, MOUSEY
	; CALL _PRINT_CX
		  
	RET
_GET_MOUSE_STAT ENDP
;--------------------------------------
_RESET_MOUSE PROC NEAR
    push ax
    mov ax, 0
    int 33h
    pop ax
    ret
_RESET_MOUSE ENDP
;--------------------------------------
_SHOW_CURSOR PROC NEAR
    push ax
    mov ax, 1
    int 33h
    pop ax
    ret
_SHOW_CURSOR ENDP
;--------------------------------------
_HIDE_CURSOR PROC NEAR
    push ax
    mov ax, 2
    int 33h
    pop ax
    ret
_HIDE_CURSOR ENDP
;--------------------------------------
_DRAW_MAIN_SCREEN PROC NEAR
	CALL _HIDE_CURSOR

	MOV BH, 07H 					; light gray on black
	CALL _CLEAR_SCREEN

	MOV DX, 0000H
	CALL _SET_CURSOR

	MOV AH, 09H
	LEA DX, MAIN_SCREEN_UI
	INT 21H

	LEA DX, CONST_SCREEN_MAINMENU 	; set current screen flag to main menu constant
	MOV CURRENT_SCREEN, DL

	LEA DX, CONST_STATE_OVER
	MOV CURRENT_STATE, DL			; set curr state to not playing/over

	CALL _SHOW_CURSOR
	RET
_DRAW_MAIN_SCREEN ENDP
;--------------------------------------
_DRAW_HOWTO_SCREEN PROC NEAR
	CALL _HIDE_CURSOR

	MOV BH, 07H 					; light gray on black
	CALL _CLEAR_SCREEN

	MOV DX, 0000H
	CALL _SET_CURSOR

	MOV AH, 09H
	LEA DX, HOWTO_SCREEN_UI
	INT 21H

	LEA DX, CONST_SCREEN_HOWTO 		; set current screen flag to how to constant
	MOV CURRENT_SCREEN, DL

	LEA DX, CONST_STATE_OVER
	MOV CURRENT_STATE, DL			; set curr state to not playing/over

	CALL _SHOW_CURSOR
	RET
_DRAW_HOWTO_SCREEN ENDP
;--------------------------------------
_DRAW_GAMEPLAY_SCREEN PROC NEAR
	CALL _HIDE_CURSOR

	MOV BH, 07H 					; light gray on black
	CALL _CLEAR_SCREEN

	MOV AX, 0600H					; fullscreen
	MOV BH, 0BH						; light cyan on black
	MOV CX, 0B02H
	MOV DX, 1316H
	INT 10H

	MOV AX, 0600H			
	MOV BH, 0CH						; light red on black
	MOV CX, 0B38H
	MOV DX, 134CH
	INT 10H

	MOV DX, 0000H
	CALL _SET_CURSOR

	MOV AH, 09H
	LEA DX, GAMEPLAY_SCREEN_UI
	INT 21H

	LEA DX, CONST_SCREEN_GAMEPLAY 			; set current screen to GameScreen
	MOV CURRENT_SCREEN, DL

	LEA DX, CONST_STATE_PLAYING 			; set current state to Playing
	MOV CURRENT_STATE, DL

	MOV DX, CONST_PLAYER_1
	MOV CURRENT_PLAYER, DX

	CALL _RESET_GAME_VARIABLES
	CALL _SHOW_CURSOR

	RET
_DRAW_GAMEPLAY_SCREEN ENDP
;--------------------------------------
_DRAW_GAMEOVER_SCREEN PROC NEAR
	CALL _HIDE_CURSOR

	MOV BH, 07H 					; light gray on black
	CALL _CLEAR_SCREEN

	MOV DX, 0000H
	CALL _SET_CURSOR

	MOV AH, 09H 					; draw base UI
	LEA DX, GAMEOVER_SCREEN_UI
	INT 21H

	; draw winner player icon
	MOV BX, CONST_PLAYER_1
	CMP CURRENT_PLAYER, BX
	JNE P2_WON
	MOV DX, PLAYER_WON_POS
	CALL _SET_CURSOR
	MOV AH, 09H
	LEA DX, PLAYER_1_WON
	INT 21H
	JMP DONE
	P2_WON:
	MOV DX, PLAYER_WON_POS
	CALL _SET_CURSOR
	MOV AH, 09H
	LEA DX, PLAYER_2_WON
	INT 21H

	DONE:

	; dispaly previous winner
	CALL _FILE_READ

	MOV DX, PLAYER_NAME_PREV_POS
	CALL _SET_CURSOR

	LEA DX, PLAYER_PREV_WINNER
	MOV AH, 09H
	INT 21H

	LEA DX, PLAYER_NAME_PREVIOUS
	MOV AH, 09H
	INT 21H

	CALL _SHOW_CURSOR

	; ask new winner's name
	MOV DX, PLAYER_NAME_POS
	CALL _SET_CURSOR

	MOV AH, 3FH
	LEA DX, PLAYER_NAME
	INT 21H

	CALL _FILE_WRITE

	LEA DX, CONST_SCREEN_GAMEOVER 	; set current screen flag to game over constant
	MOV CURRENT_SCREEN, DL

	LEA DX, CONST_STATE_OVER
	MOV CURRENT_STATE, DL			; set curr state to not playing/over

	MOV DX, CONST_PLAYER_0
	MOV CURRENT_PLAYER, DX

	CALL _DRAW_MAIN_SCREEN
	RET
_DRAW_GAMEOVER_SCREEN ENDP
;--------------------------------------
_CLEAR_SCREEN PROC NEAR
	; turn-off blinking attribute
    MOV     AX, 1003h       
    MOV     BL, 00
    INT     10h

    ; BH -> BG-FG
	MOV AX, 0600H		; fullscreen
	; MOV BH, XXXX		; BH is set before calling for reusability
	MOV CX, 0000H
	MOV DX, 184FH
	INT 10H

 	RET
_CLEAR_SCREEN ENDP
;--------------------------------------------------
_PRINT_INDICATOR PROC NEAR
	PUSH BP
	MOV BP, SP

	; draw graphic arrow
	MOV DX, [BP+6]
	CALL _SET_CURSOR
	LEA DX, PLAYER_INDICATOR_UI_1
	MOV AH, 09H
	INT 21H

	MOV DX, [BP+4]
	CALL _SET_CURSOR
	LEA DX, PLAYER_INDICATOR_UI_2
	MOV AH, 09H
	INT 21H

	MOV SP, BP
	POP BP
	RET 2
_PRINT_INDICATOR ENDP
;--------------------------------------------------
_ERASE_INDICATOR PROC NEAR
	PUSH BP
	MOV BP, SP

	; draw graphic arrow
	MOV DX, [BP+6]
	CALL _SET_CURSOR
	LEA DX, PLAYER_INDICATOR_DEL_1
	MOV AH, 09H
	INT 21H

	MOV DX, [BP+4]
	CALL _SET_CURSOR
	LEA DX, PLAYER_INDICATOR_DEL_2
	MOV AH, 09H
	INT 21H

	MOV SP, BP
	POP BP
	RET 2
_ERASE_INDICATOR ENDP
;--------------------------------------------------
_SET_CURSOR PROC	NEAR
	MOV	AH, 02H		; request set cursor, use DX's values
	MOV BX, 00H
	;MOV DX, XXX 	; DX is set before calling for reusability
	INT	10H

	RET
_SET_CURSOR ENDP
;--------------------------------------------------
_ASSESS_CLICK PROC NEAR

	LEA DX, CONST_SCREEN_MAINMENU
	CMP CURRENT_SCREEN, DL
	JE AC_MAINMENU

	LEA DX, CONST_SCREEN_HOWTO
	CMP CURRENT_SCREEN, DL
	JE AC_HOWTO

	LEA DX, CONST_SCREEN_GAMEPLAY
	CMP CURRENT_SCREEN, DL
	JE AC_GAMEPLAY

	LEA DX, CONST_SCREEN_GAMEOVER
	CMP CURRENT_SCREEN, DL
	JE AC_GAMEOVER

	JMP EXIT_AC
	
	AC_MAINMENU:
		LEA SI, BTN_NEWGAME
		CALL _CHECK_BUTTON_PRESS
		CMP BOOLEAN_FLAG_BTN, 'T' 			; if True that button press was new game button
		JE AC_PRESSED_NEWGAME

		LEA SI, BTN_HOWTO
		CALL _CHECK_BUTTON_PRESS
		CMP BOOLEAN_FLAG_BTN, 'T' 			; if True that button press was how to button
		JE AC_PRESSED_HOWTO		

		LEA SI, BTN_QUIT
		CALL _CHECK_BUTTON_PRESS
		CMP BOOLEAN_FLAG_BTN, 'T' 			; if True that button press was how to button
		JE AC_PRESSED_QUIT

		JMP EXIT_AC

		AC_PRESSED_NEWGAME:
			CALL _DRAW_GAMEPLAY_SCREEN
			JMP EXIT_AC

		AC_PRESSED_HOWTO:
			CALL _DRAW_HOWTO_SCREEN
			JMP EXIT_AC

		AC_PRESSED_QUIT:
			CALL _TERMINATE

	AC_HOWTO:
		LEA SI, BTN_BACKTOMAIN_FROMHOWTO
		CALL _CHECK_BUTTON_PRESS
		CMP BOOLEAN_FLAG_BTN, 'T'
		JNE EXIT_AC

		AC_PRESSED_BACKTOMAIN_FHT:
			CALL _DRAW_MAIN_SCREEN
			JMP EXIT_AC

	AC_GAMEOVER:
		LEA SI, BTN_TOMENU_FROMGMOV
		CALL _CHECK_BUTTON_PRESS
		CMP BOOLEAN_FLAG_BTN, 'T'
		JNE EXIT_AC
		CALL _DRAW_MAIN_SCREEN
		JMP EXIT_AC

	AC_GAMEPLAY:
		LEA SI, BTN_GAMESCREEN_RETURN
		CALL _CHECK_BUTTON_PRESS
		CMP BOOLEAN_FLAG_BTN, 'T'
		JE AC_GAMESCREEN_PRESSED_RETURN

		LEA SI, BTN_GAMESCREEN_RESTART
		CALL _CHECK_BUTTON_PRESS
		CMP BOOLEAN_FLAG_BTN, 'T'
		JE AC_GAMESCREEN_PRESSED_RESTART

		CALL _CHECK_BUTTON_PRESS_GRID

		JMP EXIT_AC

		AC_GAMESCREEN_PRESSED_RETURN:
			CALL _DRAW_MAIN_SCREEN
			JMP EXIT_AC

		AC_GAMESCREEN_PRESSED_RESTART:
			CALL _DRAW_GAMEPLAY_SCREEN
			JMP EXIT_AC

	EXIT_AC:
		MOV BOOLEAN_FLAG_BTN, 'F'
		RET
_ASSESS_CLICK ENDP
;--------------------------------------------------
_CHECK_BUTTON_PRESS PROC NEAR
		MOV BOOLEAN_FLAG_BTN, 'F'

		MOV AX, [SI] 			; UP
		INC SI
		INC SI
		MOV BX, [SI] 			; DOWN
		INC SI
		INC SI
		MOV CX, [SI] 			; LEFT
		INC SI
		INC SI
		MOV DX, [SI] 			; RIGHT
		INC SI
		INC SI
			
		CHECKBOUNDS:
			CMP MOUSEX, CX
			JL EXIT_CBP
			CMP MOUSEX, DX
			JG EXIT_CBP
			CMP MOUSEY, AX
			JL EXIT_CBP
			CMP MOUSEY, BX
			JG EXIT_CBP

			MOV BOOLEAN_FLAG_BTN, 'T'

	EXIT_CBP:
		RET
_CHECK_BUTTON_PRESS ENDP
;--------------------------------------------------
_PRINT_CX PROC NEAR
	PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    LEA SI, NUM_LOC+9 		; set space for num characters. 10 chars of space
    

    ;INC CX
    MOV AX, CX           	; load value of CX to AX
    MOV BX, 10         		; set divisor to 10

	PC10:
        MOV DX, 0           ; clear DX; DX is where remainder is put after MUL
        DIV BX              ; AX:DX = AX/BX
        ADD DX, 48          ; add 48 to get ASCII char of number
        DEC SI              ; dec pointer index
        MOV [SI], DL
        CMP AX, 0            
        JZ EXIT_PC          ; if AX is 0, convertion has completed
        JMP PC10            ; else continue

	EXIT_PC:
        MOV AH, 09H            ; print string
        MOV DX, SI
        INT 21H

		LEA SI, NUM_LOC
        MOV CX, 10
        RESET_NUM_LOC:
        	MOV SI, ' '
        	INC SI
        	LOOP RESET_NUM_LOC

    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
_PRINT_CX ENDP
;-------------------------------------------
_DELAY PROC	NEAR
	MOV BP, 3 				; lower value faster
	MOV SI, 3 				; lower value faster
	DELAY10:
		DEC BP
		NOP
		JNZ DELAY10
		DEC SI
		CMP SI,0
		JNZ DELAY10
		RET
_DELAY ENDP
;--------------------------------------------------
_TERMINATE PROC
	MOV AH, 4CH		; System.exit(0)
	INT 21H
_TERMINATE ENDP
;--------------------------------------------------
_CHECK_BUTTON_PRESS_GRID PROC NEAR
		LEA SI, BTN_0_0
		CALL _CHECK_BUTTON_PRESS
		CMP BOOLEAN_FLAG_BTN, 'T'
		JNE CHECK_BTN_1_0
		LEA DI, CELL_0_0
		CALL _CLICK_CELL
		JMP EXIT_CBPG

		CHECK_BTN_1_0:
			LEA SI, BTN_1_0
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_2_0
			LEA DI, CELL_1_0
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_2_0:
			LEA SI, BTN_2_0
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_3_0
			LEA DI, CELL_2_0
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_3_0:
			LEA SI, BTN_3_0
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_4_0
			LEA DI, CELL_3_0
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_4_0:
			LEA SI, BTN_4_0
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_5_0
			LEA DI, CELL_4_0
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_5_0:
			LEA SI, BTN_5_0
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_0_1
			LEA DI, CELL_5_0
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_0_1:
			LEA SI, BTN_0_1
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_1_1
			LEA DI, CELL_0_1
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_1_1:
			LEA SI, BTN_1_1
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_2_1
			LEA DI, CELL_1_1
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_2_1:
			LEA SI, BTN_2_1
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_3_1
			LEA DI, CELL_2_1
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_3_1:
			LEA SI, BTN_3_1
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_4_1
			LEA DI, CELL_3_1
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_4_1:
			LEA SI, BTN_4_1
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_5_1
			LEA DI, CELL_4_1
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_5_1:
			LEA SI, BTN_5_1
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_0_2
			LEA DI, CELL_5_1
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_0_2:
			LEA SI, BTN_0_2
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_1_2
			LEA DI, CELL_0_2
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_1_2:
			LEA SI, BTN_1_2
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_2_2
			LEA DI, CELL_1_2
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_2_2:
			LEA SI, BTN_2_2
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_3_2
			LEA DI, CELL_2_2
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_3_2:
			LEA SI, BTN_3_2
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_4_2
			LEA DI, CELL_3_2
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_4_2:
			LEA SI, BTN_4_2
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_5_2
			LEA DI, CELL_4_2
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_5_2:
			LEA SI, BTN_5_2
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_0_3
			LEA DI, CELL_5_2
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_0_3:
			LEA SI, BTN_0_3
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_1_3
			LEA DI, CELL_0_3
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_1_3:
			LEA SI, BTN_1_3
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_2_3
			LEA DI, CELL_1_3
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_2_3:
			LEA SI, BTN_2_3
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_3_3
			LEA DI, CELL_2_3
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_3_3:
			LEA SI, BTN_3_3
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_4_3
			LEA DI, CELL_3_3
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_4_3:
			LEA SI, BTN_4_3
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_5_3
			LEA DI, CELL_4_3
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_5_3:
			LEA SI, BTN_5_3
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_0_4
			LEA DI, CELL_5_3
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_0_4:
			LEA SI, BTN_0_4
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_1_4
			LEA DI, CELL_0_4
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_1_4:
			LEA SI, BTN_1_4
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_2_4
			LEA DI, CELL_1_4
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_2_4:
			LEA SI, BTN_2_4
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_3_4
			LEA DI, CELL_2_4
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_3_4:
			LEA SI, BTN_3_4
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_4_4
			LEA DI, CELL_3_4
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_4_4:
			LEA SI, BTN_4_4
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_5_4
			LEA DI, CELL_4_4
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_5_4:
			LEA SI, BTN_5_4
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_0_5
			LEA DI, CELL_5_4
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_0_5:
			LEA SI, BTN_0_5
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_1_5
			LEA DI, CELL_0_5
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_1_5:
			LEA SI, BTN_1_5
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_2_5
			LEA DI, CELL_1_5
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_2_5:
			LEA SI, BTN_2_5
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_3_5
			LEA DI, CELL_2_5
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_3_5:
			LEA SI, BTN_3_5
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_4_5
			LEA DI, CELL_3_5
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_4_5:
			LEA SI, BTN_4_5
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE CHECK_BTN_5_5
			LEA DI, CELL_4_5
			CALL _CLICK_CELL
			JMP EXIT_CBPG

		CHECK_BTN_5_5:
			LEA SI, BTN_5_5
			CALL _CHECK_BUTTON_PRESS
			CMP BOOLEAN_FLAG_BTN, 'T'
			JNE EXIT_CBPG
			LEA DI, CELL_5_5
			CALL _CLICK_CELL
			JMP EXIT_CBPG

	EXIT_CBPG:
		RET
_CHECK_BUTTON_PRESS_GRID ENDP
;--------------------------------------------------
_CLICK_CELL PROC NEAR
	; draw clicked based on player
	; use 
	DEC SCORE
	MOV BOOLEAN_GAME_WON, 'F'

	MOV DX, CONST_PLAYER_0 			; check if cell hasn't been clicked yet
	CMP [DI+8], DX
	JNE EXIT_CLICK_CELL

	MOV DX, CURRENT_PLAYER 			; set clicked cell's owner to current player
	MOV [DI+8], DX

	CALL _PRINT_CELL 				; print block graphics on grid

	; check if a square has been formed
	CALL _CHECK_NORMAL_SQUARE
	CMP BOOLEAN_FLAG_NORMAL_SQUARE, 'T'
	JE SQUARE_MADE
	
	; update current player
	; update cell with owner player
	MOV DX, CONST_PLAYER_1
	CMP CURRENT_PLAYER, DX
	JE SET_TO_P2 					; if P1 is curr, change to P2
	MOV DX, CONST_PLAYER_2
	CMP CURRENT_PLAYER, DX
	JE SET_TO_P1 					; if P2 is curr, change to P1

	SET_TO_P1: 						; else if P2 is curr, set to P1
		MOV DX, CONST_PLAYER_1 		; change curr player from p2 to p1
		MOV CURRENT_PLAYER, DX
		JMP EXIT_CLICK_CELL

	SET_TO_P2:
		MOV DX, CONST_PLAYER_2 		; change curr player from p1 to p2
		MOV CURRENT_PLAYER, DX
		JMP EXIT_CLICK_CELL

	SQUARE_MADE:
		MOV BOOLEAN_GAME_WON, 'T'
		CALL _DRAW_GAMEOVER_SCREEN

	EXIT_CLICK_CELL:
		RET
_CLICK_CELL ENDP
;--------------------------------------------------
_PRINT_CELL PROC NEAR
	; check current player to set color of box accordingly
	; blue for P1, red for P2
	MOV BX, CONST_PLAYER_1
	CMP CURRENT_PLAYER, BX
	JE PB_PLAYER1
	MOV BX, CONST_PLAYER_2
	CMP CURRENT_PLAYER, BX
	JE PB_PLAYER2

	PB_PLAYER1:
		MOV BH, 0BH			; light cyan on black
		JMP CONT_PB
	PB_PLAYER2:
		MOV BH, 0CH			; light red on dark grey
		JMP CONT_PB

	CONT_PB:
		CALL _HIDE_CURSOR
		; set color
		MOV AX, 0600H			; fullscreen	
		;MOV BX, XXXXH			; already set beforehand. color.
		MOV CX, [DI+4]			; top left
		MOV DX, [DI+6]			; bot right
		INT 10H
		
		; draw blocks
		MOV DX, [DI+4] 			; CELL<X,Y,0000,0000,?,?> note: indexing is ->0-2-4-6-8-10
		CALL _SET_CURSOR
		LEA DX, BLOCK
		MOV AH, 09H
		INT 21H

		MOV DX, [DI+6]
		SUB DL, 3 				; subtract 3 units to the left
		CALL _SET_CURSOR
		LEA DX, BLOCK
		MOV AH, 09H
		INT 21H

		CALL _SHOW_CURSOR

	RET
_PRINT_CELL ENDP
;--------------------------------------------------
_RESET_GAME_VARIABLES PROC NEAR
	MOV SCORE, 20 						; max score of 20 per game. minus 1 per move

	MOV BOOLEAN_FLAG_NORMAL_SQUARE, 'F'
	MOV BOOLEAN_FLAG_DIAMOND_SQUARE, 'F'
	MOV BOOLEAN_GAME_WON, 'F'

	MOV [CELL_0_0.X], 0
	MOV [CELL_0_0.Y], 0
	MOV [CELL_0_0.TOP_LEFT], 0A18H
	MOV [CELL_0_0.BOT_RIGHT], 0B1BH
	MOV [CELL_0_0.OWNER], 0
	MOV [CELL_0_0.CHECKED], 0

	MOV [CELL_1_0.X], 1
	MOV [CELL_1_0.Y], 0
	MOV [CELL_1_0.TOP_LEFT], 0A1DH
	MOV [CELL_1_0.BOT_RIGHT], 0B20H
	MOV [CELL_1_0.OWNER], 0
	MOV [CELL_1_0.CHECKED], 0

	MOV [CELL_2_0.X], 2
	MOV [CELL_2_0.Y], 0
	MOV [CELL_2_0.TOP_LEFT], 0A22H
	MOV [CELL_2_0.BOT_RIGHT], 0B25H
	MOV [CELL_2_0.OWNER], 0
	MOV [CELL_2_0.CHECKED], 0	

	MOV [CELL_3_0.X], 3
	MOV [CELL_3_0.Y], 0
	MOV [CELL_3_0.TOP_LEFT], 0A27H
	MOV [CELL_3_0.BOT_RIGHT], 0B2AH
	MOV [CELL_3_0.OWNER], 0
	MOV [CELL_3_0.CHECKED], 0	

	MOV [CELL_4_0.X], 4
	MOV [CELL_4_0.Y], 0
	MOV [CELL_4_0.TOP_LEFT], 0A2CH
	MOV [CELL_4_0.BOT_RIGHT], 0B2FH
	MOV [CELL_4_0.OWNER], 0
	MOV [CELL_4_0.CHECKED], 0	

	MOV [CELL_5_0.X], 5
	MOV [CELL_5_0.Y], 0
	MOV [CELL_5_0.TOP_LEFT], 0A31H
	MOV [CELL_5_0.BOT_RIGHT], 0B34H
	MOV [CELL_5_0.OWNER], 0
	MOV [CELL_5_0.CHECKED], 0

	; ----

	MOV [CELL_0_1.X], 0
	MOV [CELL_0_1.Y], 1
	MOV [CELL_0_1.TOP_LEFT], 0C18H
	MOV [CELL_0_1.BOT_RIGHT], 0D1BH
	MOV [CELL_0_1.OWNER], 0
	MOV [CELL_0_1.CHECKED], 0

	MOV [CELL_1_1.X], 1
	MOV [CELL_1_1.Y], 1
	MOV [CELL_1_1.TOP_LEFT], 0C1DH
	MOV [CELL_1_1.BOT_RIGHT], 0D20H
	MOV [CELL_1_1.OWNER], 0
	MOV [CELL_1_1.CHECKED], 0

	MOV [CELL_2_1.X], 2
	MOV [CELL_2_1.Y], 1
	MOV [CELL_2_1.TOP_LEFT], 0C22H
	MOV [CELL_2_1.BOT_RIGHT], 0D25H
	MOV [CELL_2_1.OWNER], 0
	MOV [CELL_2_1.CHECKED], 0	

	MOV [CELL_3_1.X], 3
	MOV [CELL_3_1.Y], 1
	MOV [CELL_3_1.TOP_LEFT], 0C27H
	MOV [CELL_3_1.BOT_RIGHT], 0D2AH
	MOV [CELL_3_1.OWNER], 0
	MOV [CELL_3_1.CHECKED], 0	

	MOV [CELL_4_1.X], 4
	MOV [CELL_4_1.Y], 1
	MOV [CELL_4_1.TOP_LEFT], 0C2CH
	MOV [CELL_4_1.BOT_RIGHT], 0D2FH
	MOV [CELL_4_1.OWNER], 0
	MOV [CELL_4_1.CHECKED], 0	

	MOV [CELL_5_1.X], 5
	MOV [CELL_5_1.Y], 1
	MOV [CELL_5_1.TOP_LEFT], 0C31H
	MOV [CELL_5_1.BOT_RIGHT], 0D34H
	MOV [CELL_5_1.OWNER], 0
	MOV [CELL_5_1.CHECKED], 0

	; ----

	MOV [CELL_0_2.X], 0
	MOV [CELL_0_2.Y], 2
	MOV [CELL_0_2.TOP_LEFT], 0E18H
	MOV [CELL_0_2.BOT_RIGHT], 0F1BH
	MOV [CELL_0_2.OWNER], 0
	MOV [CELL_0_2.CHECKED], 0

	MOV [CELL_1_2.X], 1
	MOV [CELL_1_2.Y], 2
	MOV [CELL_1_2.TOP_LEFT], 0E1DH
	MOV [CELL_1_2.BOT_RIGHT], 0F20H
	MOV [CELL_1_2.OWNER], 0
	MOV [CELL_1_2.CHECKED], 0

	MOV [CELL_2_2.X], 2
	MOV [CELL_2_2.Y], 2
	MOV [CELL_2_2.TOP_LEFT], 0E22H
	MOV [CELL_2_2.BOT_RIGHT], 0F25H
	MOV [CELL_2_2.OWNER], 0
	MOV [CELL_2_2.CHECKED], 0	

	MOV [CELL_3_2.X], 3
	MOV [CELL_3_2.Y], 2
	MOV [CELL_3_2.TOP_LEFT], 0E27H
	MOV [CELL_3_2.BOT_RIGHT], 0F2AH
	MOV [CELL_3_2.OWNER], 0
	MOV [CELL_3_2.CHECKED], 0	

	MOV [CELL_4_2.X], 4
	MOV [CELL_4_2.Y], 2
	MOV [CELL_4_2.TOP_LEFT], 0E2CH
	MOV [CELL_4_2.BOT_RIGHT], 0F2FH
	MOV [CELL_4_2.OWNER], 0
	MOV [CELL_4_2.CHECKED], 0	

	MOV [CELL_5_2.X], 5
	MOV [CELL_5_2.Y], 2
	MOV [CELL_5_2.TOP_LEFT], 0E31H
	MOV [CELL_5_2.BOT_RIGHT], 0F34H
	MOV [CELL_5_2.OWNER], 0
	MOV [CELL_5_2.CHECKED], 0

	; ----

	MOV [CELL_0_3.X], 0
	MOV [CELL_0_3.Y], 3
	MOV [CELL_0_3.TOP_LEFT], 1018H
	MOV [CELL_0_3.BOT_RIGHT], 111BH
	MOV [CELL_0_3.OWNER], 0
	MOV [CELL_0_3.CHECKED], 0

	MOV [CELL_1_3.X], 1
	MOV [CELL_1_3.Y], 3
	MOV [CELL_1_3.TOP_LEFT], 101DH
	MOV [CELL_1_3.BOT_RIGHT], 1120H
	MOV [CELL_1_3.OWNER], 0
	MOV [CELL_1_3.CHECKED], 0

	MOV [CELL_2_3.X], 2
	MOV [CELL_2_3.Y], 3
	MOV [CELL_2_3.TOP_LEFT], 1022H
	MOV [CELL_2_3.BOT_RIGHT], 1125H
	MOV [CELL_2_3.OWNER], 0
	MOV [CELL_2_3.CHECKED], 0	

	MOV [CELL_3_3.X], 3
	MOV [CELL_3_3.Y], 3
	MOV [CELL_3_3.TOP_LEFT], 1027H
	MOV [CELL_3_3.BOT_RIGHT], 112AH
	MOV [CELL_3_3.OWNER], 0
	MOV [CELL_3_3.CHECKED], 0	

	MOV [CELL_4_3.X], 4
	MOV [CELL_4_3.Y], 3
	MOV [CELL_4_3.TOP_LEFT], 102CH
	MOV [CELL_4_3.BOT_RIGHT], 112FH
	MOV [CELL_4_3.OWNER], 0
	MOV [CELL_4_3.CHECKED], 0	

	MOV [CELL_5_3.X], 5
	MOV [CELL_5_3.Y], 3
	MOV [CELL_5_3.TOP_LEFT], 1031H
	MOV [CELL_5_3.BOT_RIGHT], 1134H
	MOV [CELL_5_3.OWNER], 0
	MOV [CELL_5_3.CHECKED], 0

	; ----

	MOV [CELL_0_4.X], 0
	MOV [CELL_0_4.Y], 4
	MOV [CELL_0_4.TOP_LEFT], 1218H
	MOV [CELL_0_4.BOT_RIGHT], 131BH
	MOV [CELL_0_4.OWNER], 0
	MOV [CELL_0_4.CHECKED], 0

	MOV [CELL_1_4.X], 1
	MOV [CELL_1_4.Y], 4
	MOV [CELL_1_4.TOP_LEFT], 121DH
	MOV [CELL_1_4.BOT_RIGHT], 1320H
	MOV [CELL_1_4.OWNER], 0
	MOV [CELL_1_4.CHECKED], 0

	MOV [CELL_2_4.X], 2
	MOV [CELL_2_4.Y], 4
	MOV [CELL_2_4.TOP_LEFT], 1222H
	MOV [CELL_2_4.BOT_RIGHT], 1325H
	MOV [CELL_2_4.OWNER], 0
	MOV [CELL_2_4.CHECKED], 0	

	MOV [CELL_3_4.X], 3
	MOV [CELL_3_4.Y], 4
	MOV [CELL_3_4.TOP_LEFT], 1227H
	MOV [CELL_3_4.BOT_RIGHT], 132AH
	MOV [CELL_3_4.OWNER], 0
	MOV [CELL_3_4.CHECKED], 0	

	MOV [CELL_4_4.X], 4
	MOV [CELL_4_4.Y], 4
	MOV [CELL_4_4.TOP_LEFT], 122CH
	MOV [CELL_4_4.BOT_RIGHT], 132FH
	MOV [CELL_4_4.OWNER], 0
	MOV [CELL_4_4.CHECKED], 0	

	MOV [CELL_5_4.X], 5
	MOV [CELL_5_4.Y], 4
	MOV [CELL_5_4.TOP_LEFT], 1231H
	MOV [CELL_5_4.BOT_RIGHT], 1334H
	MOV [CELL_5_4.OWNER], 0
	MOV [CELL_5_4.CHECKED], 0

	; ----

	MOV [CELL_0_5.X], 0
	MOV [CELL_0_5.Y], 5
	MOV [CELL_0_5.TOP_LEFT], 1418H
	MOV [CELL_0_5.BOT_RIGHT], 151BH
	MOV [CELL_0_5.OWNER], 0
	MOV [CELL_0_5.CHECKED], 0

	MOV [CELL_1_5.X], 1
	MOV [CELL_1_5.Y], 5
	MOV [CELL_1_5.TOP_LEFT], 141DH
	MOV [CELL_1_5.BOT_RIGHT], 1520H
	MOV [CELL_1_5.OWNER], 0
	MOV [CELL_1_5.CHECKED], 0

	MOV [CELL_2_5.X], 2
	MOV [CELL_2_5.Y], 5
	MOV [CELL_2_5.TOP_LEFT], 1422H
	MOV [CELL_2_5.BOT_RIGHT], 1525H
	MOV [CELL_2_5.OWNER], 0
	MOV [CELL_2_5.CHECKED], 0	

	MOV [CELL_3_5.X], 3
	MOV [CELL_3_5.Y], 5
	MOV [CELL_3_5.TOP_LEFT], 1427H
	MOV [CELL_3_5.BOT_RIGHT], 152AH
	MOV [CELL_3_5.OWNER], 0
	MOV [CELL_3_5.CHECKED], 0	

	MOV [CELL_4_5.X], 4
	MOV [CELL_4_5.Y], 5
	MOV [CELL_4_5.TOP_LEFT], 142CH
	MOV [CELL_4_5.BOT_RIGHT], 152FH
	MOV [CELL_4_5.OWNER], 0
	MOV [CELL_4_5.CHECKED], 0	

	MOV [CELL_5_5.X], 5
	MOV [CELL_5_5.Y], 5
	MOV [CELL_5_5.TOP_LEFT], 1431H
	MOV [CELL_5_5.BOT_RIGHT], 1534H
	MOV [CELL_5_5.OWNER], 0
	MOV [CELL_5_5.CHECKED], 0

	RET
_RESET_GAME_VARIABLES ENDP
;--------------------------------------------------
_CHECK_NORMAL_SQUARE PROC NEAR
	MOV BOOLEAN_FLAG_NORMAL_SQUARE, 'F'

	MOV INDEX_I, 0
	MOV INDEX_K, 0

	PUSH SI
	LEA SI, CELL_0_0 					; load cell[0][0] at SI. need to traverse all cells, hence need index reg
	ROW_LOOP:
		CMP INDEX_I, 6
		JE BREAK_ROW_LOOP

		MOV INDEX_J, 0
		COL_LOOP:
			CMP INDEX_J, 6
			JE BREAK_COL_LOOP

			MOV BX, INDEX_K 			; load indexer
			MOV DX, CURRENT_PLAYER 		
			CMP [SI+BX+8], DX 			; check if cell[j][i] is owned by current player
			JNE CONT_COL_LOOP			; pass if Not equal. only do action if curr player owns cell
			CALL _CHECK_NEIGH_RIGHT		; check if cell has same owner neighbor
			CMP BOOLEAN_NEIGH_RIGHT, 'T'
			JNE CONT_COL_LOOP

			CALL _CHECK_NEIGH_BOT
			CMP BOOLEAN_NEIGH_BOT, 'T'
			JNE CONT_COL_LOOP

			CALL _CHECK_NEIGH_DIAG
			CMP BOOLEAN_NEIGH_DIAG, 'T'
			JNE CONT_COL_LOOP

			MOV BOOLEAN_FLAG_NORMAL_SQUARE, 'T'
			LEA DX, CONST_STATE_OVER
			MOV CURRENT_STATE, DL
			JMP BREAK_ROW_LOOP

			CONT_COL_LOOP:
			INC INDEX_J
			ADD INDEX_K, 12
			LOOP COL_LOOP

			BREAK_COL_LOOP:
			INC INDEX_I
		LOOP ROW_LOOP

	BREAK_ROW_LOOP:
	POP SI
	RET
_CHECK_NORMAL_SQUARE ENDP
;--------------------------------------------------
_CHECK_NEIGH_RIGHT PROC NEAR
	MOV BOOLEAN_NEIGH_RIGHT, 'F'
	MOV INDEX_TEMP, 0000
	MOV DX, INDEX_K
	MOV INDEX_TEMP, DX 			; set temp index to index of selected cell

	CNR_LOOP1:
		MOV BX, INDEX_TEMP
		MOV DX, 5
		CMP [SI+BX+0], DX
		JE EXIT_CNR

		ADD INDEX_TEMP, 12

		MOV BX, INDEX_TEMP 			; get address of child cell
		MOV DX, CURRENT_PLAYER 		; load current player
		CMP [SI+BX+8], DX			; if (ChildCell.Owner == curr player)
		JNE CONT_CNRL1 				; if not equal continue loop 
		
		; if equal, get distance
		MOV AX, [SI+BX+0] 			; get X coord of child cell
		MOV BX, INDEX_K 			; get address of parent cell
		SUB AX, [SI+BX+0] 			; AX = Child.X - Parent.X
		MOV DISTANCE, AX			; store 
		MOV BOOLEAN_NEIGH_RIGHT, 'T'
		
		CONT_CNRL1:
		JMP CNR_LOOP1
	
	EXIT_CNR:
	RET
_CHECK_NEIGH_RIGHT ENDP
;--------------------------------------------------
_CHECK_NEIGH_BOT PROC NEAR
	MOV BOOLEAN_NEIGH_BOT, 'F'

	; Goal: get DISTANCE * 12
	MOV AX, DISTANCE 			; load operand
	MOV BL, 72 					; load multiplier. 72 to proceed to next row
	MUL BL 						; AX = DISTANCE * 72
	MOV BX, INDEX_K
	ADD AX, BX
	MOV INDEX_TEMP, AX

	MOV DX, 432 				; max index grid (SE corner)
	CMP INDEX_TEMP, DX
	JE EXIT_CNB 				; exit proc if bottom index went out bounds

	LEA SI, CELL_0_0
	MOV BX, INDEX_TEMP 			; load address of Cell south of parent cell
	MOV DX, CURRENT_PLAYER 		; load curr player

	CMP [SI+BX+8], DX 			; if (cell south of parent cell is owned by same player)
	JNE EXIT_CNB 				; no neighbor bottom
	MOV BOOLEAN_NEIGH_BOT, 'T'

	EXIT_CNB:
	RET
_CHECK_NEIGH_BOT ENDP
;--------------------------------------------------
_CHECK_NEIGH_DIAG PROC NEAR
	MOV BOOLEAN_NEIGH_DIAG, 'F'

	; Goal: get DISTANCE * 72
	MOV AX, DISTANCE 			; load operand
	MOV BL, 72 					; load multiplier. 72 to proceed to next row
	MUL BL 						; AX = DISTANCE * 72
	MOV BX, INDEX_K
	ADD AX, BX
	MOV INDEX_TEMP, AX

	MOV AX, DISTANCE 			; get cell diagonal(SE) from parent cell
	MOV BL, 12 					; 
	MUL BL
	ADD AX, INDEX_TEMP
	MOV INDEX_TEMP, AX

	MOV DX, 432 				; max index grid (SE corner)
	CMP INDEX_TEMP, DX
	JE EXIT_CND 				; exit proc if bottom index went out bounds

	LEA SI, CELL_0_0
	MOV BX, INDEX_TEMP 			; load address of Cell SE of parent cell
	MOV DX, CURRENT_PLAYER 		; load curr player

	; MOV CX, [SI+BX+0]
	; CALL _PRINT_CX

	; MOV CX, [SI+BX+2]
	; CALL _PRINT_CX

	; MOV CX, [SI+BX+8]
	; CALL _PRINT_CX

	; LEA DX, CHER
	; MOV AH, 09
	; INT 21H

	CMP [SI+BX+8], DX 			; if (cell SE of parent cell is owned by same player)
	JNE EXIT_CND 				; no neighbor bottom
	MOV BOOLEAN_NEIGH_DIAG, 'T'

	EXIT_CND:
	RET
_CHECK_NEIGH_DIAG ENDP
;--------------------------------------------------
_FILE_WRITE PROC NEAR
	;create file
  MOV AH, 3CH           ;request create file
  MOV CX, 00            ;normal attribute
  LEA DX, PATHFILENAME  ;load path and file name
  INT 21H
  JC DISPLAY_ERROR1_W     ;if there's error in creating file, carry flag = 1, otherwise 0
  MOV FILEHANDLE_W, AX

  ;write file
  MOV AH, 40H           ;request write record
  MOV BX, FILEHANDLE_W    ;file handle
  MOV CX, 30            ;record length
  LEA DX, PLAYER_NAME    ;address of output area
  INT 21H
  JC DISPLAY_ERROR2_W     ;if carry flag = 1, there's error in writing (nothing is written)
  CMP AX, 30            ;after writing, set AX to size of chars nga na write
  JNE DISPLAY_ERROR3_W

  ;close file handle
  MOV AH, 3EH           ;request close file
  MOV BX, FILEHANDLE_W    ;file handle
  INT 21H

  JMP EXIT_W

DISPLAY_ERROR1_W:
  LEA DX, ERROR1_STR_W
  MOV AH, 09
  INT 21H

  JMP EXIT_W

DISPLAY_ERROR2_W:
  LEA DX, ERROR2_STR_W
  MOV AH, 09
  INT 21H

  JMP EXIT_W

DISPLAY_ERROR3_W:
  LEA DX, ERROR3_STR_W
  MOV AH, 09
  INT 21H

  EXIT_W:
  RET
_FILE_WRITE ENDP
;--------------------------------------------------
_FILE_READ PROC NEAR
	;open file
  MOV AH, 3DH           ;requst open file
  MOV AL, 00            ;read only; 01 (write only); 10 (read/write)
  LEA DX, PATHFILENAME
  INT 21H
  JC DISPLAY_ERROR1
  MOV FILEHANDLE_R, AX

  ;read file
  MOV AH, 3FH           ;request read record
  MOV BX, FILEHANDLE_R    ;file handle
  MOV CX, 30            ;record length
  LEA DX, PLAYER_NAME_PREVIOUS    ;address of input area
  INT 21H
  JC DISPLAY_ERROR2
  CMP AX, 00            ;zero bytes read?
  JE DISPLAY_ERROR3

  ;close file handle
  MOV AH, 3EH           ;request close file
  MOV BX, FILEHANDLE_R    ;file handle
  INT 21H

  JMP EXIT_R

DISPLAY_ERROR1:
  LEA DX, ERROR1_STR_R
  MOV AH, 09
  INT 21H

  JMP EXIT_R

DISPLAY_ERROR2:
  LEA DX, ERROR2_STR_R
  MOV AH, 09
  INT 21H

  JMP EXIT_R

DISPLAY_ERROR3:
  ; LEA DX, ERROR3_STR_R
  ; MOV AH, 09
  ; INT 21H

EXIT_R:
  RET
_FILE_READ ENDP
;--------------------------------------------------
CODESEG ENDS
END START

















