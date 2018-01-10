; Earl Timothy Malaki
; CMSC 131 Laboratory
; Long Exam 2 Practical

TITLE PRACTICAL NUMBER 2 (.EXE MODEL)
;--------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;--------------------------------------
DATASEG SEGMENT PARA 'Data'
	
	PROMPT0 DB 10,13,'$'
	PROMPT1 DB "Enter string: $"
	PROMPT2 DB 10,13, "Enter search: $"
	PROMPT3 DB 10,13, "Found at location ", '$'
	PROMPT4 DB 10,13, "Not found", '$'

	INPUT_STR DB 20 DUP(?)

	SOURCE_STR DB 20 DUP('$')
	TARGET_STR DB 20 DUP('$')

	INPUT_LEN DW ?
	SOURCE_LEN DW ?
	TARGET_LEN DW ?
	FIRSTOCC DW ?

	NUM_LOC DB 10 DUP('$')
	
	EQUALITY_FLAG DB 'Y'
	TARGET_INDEXONE DB ?

	CHER DB 10,13,"CHERET$"

DATASEG ENDS
;--------------------------------------
CODESEG SEGMENT PARA 'Code'
	ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG

	START:
		MAIN PROC FAR
			MOV AX, DATASEG 				; initialize program
			MOV DS, AX
			MOV ES, AX

			CALL _SET_SCREEN
			;-------
			LEA DX, PROMPT1 				; prompt for source string
			PUSH DX
			CALL _DISP_PROMPT

			LEA SI, INPUT_STR
			CALL _SCAN_STRING 				; scan source string input
			MOV INPUT_LEN, AX
			MOV SOURCE_LEN, AX


			LEA DX, SOURCE_STR				; load SOURCE_STR address
			PUSH DX							; pass as parameter
			CALL _COPY_STRING				; copy INPUT_STR to SOURCE_STR

			CALL _RESET_VARIABLES

			LEA DX, PROMPT2 				; prompt for source string
			PUSH DX
			CALL _DISP_PROMPT

			LEA SI, INPUT_STR
			CALL _SCAN_STRING 				; scan source string input
			MOV INPUT_LEN, AX
			MOV TARGET_LEN, AX

			LEA DX, TARGET_STR				; load SOURCE_STR address
			PUSH DX							; pass as parameter
			CALL _COPY_STRING				; copy INPUT_STR to SOURCE_STR
			
			;-------

			MOV FIRSTOCC, 9999
			CALL _SEARCH
			
			CMP FIRSTOCC, 9999 				; -1 is 999 for now. invalid location
			JE NOT_FOUND

			FOUND:
				MOV AH, 09H
				LEA DX, PROMPT3
				INT 21H

				CALL _PRINT_CX				; print integer value of CX

				JMP EXIT

			NOT_FOUND:
				MOV AH, 09H
				LEA DX, PROMPT4
				INT 21H

				JMP EXIT

		MAIN ENDP
	EXIT:
		CALL _TERMINATE
;-----------------------------------------
_DISP_PROMPT PROC NEAR
	PUSH BP					; save the original BP value to stack 
	MOV BP, SP				; use stack pointer as the base pointer

	MOV AH, 09H
	MOV DX, [BP+4]			; get passed parameter (one pushed before procedure call)
	INT 21H

	MOV SP, BP		; reset BP back to SP
	POP BP			; get back original value of BP
	RET 2			; return and pop off 2 bytes to set SP back to 0000
_DISP_PROMPT ENDP
;-----------------------------------------
_SCAN_STRING PROC NEAR
	MOV CX, SI 		            ; cx == buffer start address
	
    READ:
    	MOV AH, 01H				; read a char, store in AL
        INT 21H
        CMP AL, 13				; is it [enter]?
        JE DONE                 ; if yes, entering char is done
        
	    MOV [SI], AL		; good input, move char to [SI] (STRING)
	    INC SI              ; increment index
        
	    JMP READ            ; loop

    DONE:
    	MOV AL, '$'				
        mov [si], AL            ; add delimiter. terminate string
        mov ax, si              ; ax -> buffer end address
        sub ax, cx              ; ax = si - cx

    RET_INPUT:
    	RET

_SCAN_STRING ENDP
;--------------------------------------------------
_SEARCH PROC NEAR
	
	LEA SI, SOURCE_STR 			; load source and target strings
	LEA DI, TARGET_STR
	
	MOV DL, [DI] 				; store target str's first letter
	MOV TARGET_INDEXONE, DL

	MOV CX, 0 					; init cx to 0

	WHILE1:
		MOV AH, [SI] 			; load letters to AX registers
		MOV AL, [DI] 			; AH for source, AL for target

		CMP AH, '$'				; while SI is not end of source yet, do iterate
		JE EXIT_SEARCH 			; else if end is reached, exit loop

		WHILE2:
		; while SI is not equal to start of target AND SI is not end of source
			MOV AH, [SI]

			CMP AH, TARGET_INDEXONE
			JE BREAK_WHILE2
			CMP AH, '$'
			JE BREAK_WHILE2

			INC SI
			INC CX
			JMP WHILE2

		BREAK_WHILE2:

		CMP AH, '$'
		JE S_NOT_FOUND
		
		MOV FIRSTOCC, 0000
		MOV FIRSTOCC, CX

		WHILE3:
			MOV AH, [SI]
			MOV AL, [DI]

			CMP AH, AL
			JNE BREAK_WHILE3
			CMP AH, '$'
			JE BREAK_WHILE3
			CMP AL, '$'
			JE BREAK_WHILE3

			INC SI
			INC DI

			JMP WHILE3

		BREAK_WHILE3:

		CMP AL, '$'
		JE EXIT_SEARCH

		CMP AH, '$'
		JE S_NOT_FOUND

		PUSH CX
		LEA SI, SOURCE_STR
		MOV CX, FIRSTOCC
		INC CX
		SI_INPLACE:
			INC SI
			LOOP SI_INPLACE
		POP CX
		INC CX

		LEA DI, TARGET_STR

		JMP WHILE1

	S_NOT_FOUND:
	 	MOV FIRSTOCC, 9999 		; not found

	EXIT_SEARCH:
		RET
_SEARCH ENDP
;--------------------------------------------------
_PRINT_CX PROC NEAR

    LEA SI, NUM_LOC+9 		; set space for num characters. 10 chars of space

    INC CX
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

        RET

_PRINT_CX ENDP
;--------------------------------------------------
_COPY_STRING PROC NEAR
	PUSH BP
	MOV BP, SP
								; copy INPUT_STR to SOURCE or TARGET STRING
	CLD             			; clear direction flag (left to right)
	MOV CX, INPUT_LEN        		; initialize counter
	MOV DI, [BP+4]  			; initialize destination address
	LEA SI, INPUT_STR  			; initialize source address
	REP MOVSB

	MOV SP, BP
	POP BP
	RET 2
_COPY_STRING ENDP
;-----------------------------------------
_RESET_VARIABLES PROC NEAR

									; reset INPUT_STR variable
	MOV CX, 20 						; set counter to 20
	MOV SI, 0000 					; set index to 0000
	B10:
		MOV INPUT_STR[SI], '?' 		; overwrite data with
		INC SI 						; increment index
		LOOP B10 					; loop


	MOV INPUT_LEN, 0000

	RET
_RESET_VARIABLES ENDP
;--------------------------------------------------
_PRNT_STR PROC NEAR
	
	LEA SI, SOURCE_STR
	MOV CX, SOURCE_LEN
	PR10:
		MOV AL, [SI] 		; load char at SI to AL

		MOV AH, 02H 		; fxn code for printing char
		MOV DL, AL 			; load char to DL
		MOV DH, 00 			; clear higher byte
		INT 21H

		INC SI
		LOOP PR10 			; loop times the number of chars

	MOV AH, 09H
	LEA DX, PROMPT0
	INT 21H

	LEA SI, TARGET_STR
	MOV CX, TARGET_LEN
	PR20:
		MOV AL, [SI] 		; load char at SI to AL

		MOV AH, 02H 		; fxn code for printing char
		MOV DL, AL 			; load char to DL
		MOV DH, 00 			; clear higher byte
		INT 21H

		INC SI
		LOOP PR20 			; loop times the number of chars

	RET
_PRNT_STR ENDP
;--------------------------------------------------
_SET_SCREEN PROC NEAR
	MOV	AH, 02H		; request set cursor, use DX's values
	MOV BX, 00H
	MOV DX, 0000
	INT	10H

	MOV AH, 09H
	LEA DX, PROMPT0
	INT 21H

	MOV AX, 0600H		; fullscreen
	MOV BH, 07H		; SET COLOR BEFORE CALLING
	MOV CX, 0000H
	MOV DX, 184FH
	INT 10H
	
	RET
_SET_SCREEN ENDP
;--------------------------------------------------
_TERMINATE PROC
	MOV AH, 4CH		; System.exit(0)
	INT 21H
_TERMINATE ENDP

CODESEG ENDS
END START







