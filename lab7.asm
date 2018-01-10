; Earl Timothy Malaki
; CMSC 131 Laboratory
; Lab 7 - PALINDROME

TITLE LAB7 PALINDROME (.EXE MODEL)
;-----------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;-----------------------------------------
DATASEG SEGMENT PARA 'Data'

	PROMPT0 DB 10,13,'$'
	PROMPT1 DB 10, 13, "STRING 1> ", '$'
	PROMPT2 DB "STRING 2> ", '$'
	PROMPT3 DB "Program terminated successfully!", 0AH, '$'

	PALI_YES1 DB "It's just '", '$'
	PALI_YES2 DB "'!", 0AH, '$'
	PALI_BOTH DB "You got 2 palindromes!", 0AH, '$'
	PALI_NONE DB "Finals is coming!", 0AH, '$'

	STRING DB 31 DUP (?)
	STRING1 DB 31 DUP ('$')
	STRING2 DB 31 DUP ('$')
	STR_LEN DW ?
	STR_LEN_DIV2 DW ?
	FLAG_PALI DB 'N'

	STR1_PALI DB 'N'		; flag for palindrome-ness of STRING1 and STRING2
	STR2_PALI DB 'N'

DATASEG ENDS
;-----------------------------------------
CODESEG SEGMENT PARA 'Code'
	ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG
START:
_MAIN PROC FAR
									; initialize program
		MOV AX, DATASEG
		MOV DS, AX
		MOV ES, AX
		
		CALL _CLEAR_SCREEN			; clear screen and set color to cyan-on-black

		MOV DX, 0000H				; set cursor to top of screen
		CALL _SET_CURSOR

									; enter main loop
		CALL _ITERATE

									; exit program
		CALL _TERMINATE
_MAIN ENDP
;-----------------------------------------
_ITERATE PROC NEAR

	PART1:
		CALL _RESET_VARIABLES

		LEA DX, PROMPT1				; load prompt1
		PUSH DX						; pass as parameter
		CALL DISP_PROMPT			; ask for 1st input string

		LEA SI, STRING				; set starting buffer address
		CALL _SCAN_STRING			; ask input
		MOV STR_LEN, AX 			; mov AX (len of input)

		LEA DX, STRING1				; load STRING1 address
		PUSH DX						; pass as parameter
		CALL _COPY_STRING			; copy STRING to STRING1

		CALL _CHECK_PALINDROME		; check palindromeness of STRING1 (at var STRING)

		CMP FLAG_PALI, 'Y'			; if flag is yes, set STR1_PALI flag to YES
		JNE PART2					; if not, skip to part 2

		MOV STR1_PALI, 'Y' 			; set to YES

	PART2:
		CALL _RESET_VARIABLES

		LEA DX, PROMPT2				; load prompt2
		PUSH DX						; pass as parameter
		CALL DISP_PROMPT			; ask for 2ND input string

		LEA SI, STRING				; set starting buffer address
		CALL _SCAN_STRING			; ask input
		MOV STR_LEN, AX 			; mov AX (len of input)
		
		LEA DX, STRING2				; load STRING2 address
		PUSH DX						; pass as parameter
		CALL _COPY_STRING			; copy STRING to STRING2

		CALL _CHECK_PALINDROME		; check palindromeness of STRING2 (at var STRING)

		CMP FLAG_PALI, 'Y'			; if flag is yes, set STR2_PALI flag to YES
		JNE DONEBOTH 				; if not, checking is done

		MOV STR2_PALI, 'Y' 			; set to yes


	DONEBOTH:
		CMP STR1_PALI, 'Y'			; is STRING1 a palindrome?
		JNE STR1_NOTPALI			; if not, check STRING2

		CMP STR2_PALI, 'Y'			; is STRING2 a palindrome?
		JE BOTH_PALI				; if yes, both inputs are palindrome

									; if not, only STRING2 is palindrome
		LEA DX, STRING1
		PUSH DX
		CALL _DISP_ITS_JUST
		JMP RESTART

		STR1_NOTPALI:
			CMP STR2_PALI, 'Y'		; is STRING2 a palindrome?
			JNE BOTH_NOTPALI		; if not, then you got 2 non-palindrome strings

									; if yes, then it's just STRING2
			LEA DX, STRING2
			PUSH DX
			CALL _DISP_ITS_JUST
			JMP RESTART

		BOTH_NOTPALI:				; both inputs NOT palindrome
			MOV AH, 09H				; display finals is coming
			LEA DX, PALI_NONE
			INT 21H
			JMP RESTART

		BOTH_PALI:					; both inputs ARE palindrome
			MOV AH, 09H				; display youve got 2 palindromes
			LEA DX, PALI_BOTH
			INT 21H			

	RESTART:
		CALL _RESET_VARIABLES2

		CALL _ITERATE

_ITERATE ENDP
;-----------------------------------------
_DISP_ITS_JUST PROC NEAR
	PUSH BP					; save the original BP value to stack 
	MOV BP, SP				; use stack pointer as the base pointer

	MOV AH, 09H
	LEA DX, PALI_YES1
	INT 21H

	MOV AH, 09H
	MOV DX, [BP+4]			; get passed parameter (one pushed before procedure call)
	INT 21H

	MOV AH, 09H
	LEA DX, PALI_YES2
	INT 21H

	MOV SP, BP		; reset BP back to SP
	POP BP			; get back original value of BP
	RET 2			; return and pop off 2 bytes to set SP back to 0000
_DISP_ITS_JUST ENDP
;-----------------------------------------
DISP_PROMPT PROC NEAR
	PUSH BP					; save the original BP value to stack 
	MOV BP, SP				; use stack pointer as the base pointer

	MOV AH, 09H
	MOV DX, [BP+4]			; get passed parameter (one pushed before procedure call)
	INT 21H

	MOV SP, BP		; reset BP back to SP
	POP BP			; get back original value of BP
	RET 2			; return and pop off 2 bytes to set SP back to 0000
DISP_PROMPT ENDP
;-----------------------------------------
_SCAN_STRING PROC NEAR
	; before calling proc, do:
	; STRINGVAR DB 31 DUP (?)		; initialize
	; LEA SI, STRINGVAR				; set starting buffer address

	MOV CX, SI 		            ; cx == buffer start address
    READ:
    	MOV AH, 01H				; read a char, store in AL
        INT 21H
        CMP AL, 13				; is it [enter]?
        JE DONE                 ; if yes, entering char is done
        CMP AL, 32				; is it [space]?
        JE PASS 				; if yes, ignore
        CMP AL, 97				; is it a small letter?
        JL BIG					; if yes, make it big
        SUB AL, 32				; subtract 32 to get ASCII for caps

        BIG:
	        MOV [SI], AL		; good input, move char to [SI] (STRING)
	        INC SI              ; increment index    
        PASS:
	        JMP READ            ; loop
    DONE:
    	MOV AL, '$'				
        mov [si], AL            ; add delimiter. terminate string
        mov ax, si              ; ax -> buffer end address
        sub ax, cx              ; ax = si - cx

        CMP AX, 1				; is it a one char input?
        JE CHECKIF_QUIT
        RET
    QUIT:
    	CALL _TERMINATE
    CHECKIF_QUIT:    	
    	CMP STRING[0], 'Q'		; is it 'Q' for quit?
    	JE QUIT
    	RET

_SCAN_STRING ENDP
;-----------------------------------------
_CHECK_PALINDROME PROC NEAR
	
							; STR_LEN_DIV2 = STR_LEN / 2
	MOV AX, STR_LEN			; set dividend to STR_LEN
	MOV BL, 2 				; set divisor to 2
	DIV BL 					; AX = AX / BL
	MOV AH, 00H 			; clear out remainder
	MOV STR_LEN_DIV2, AX 	; store STR_LEN / 2
	
	LEA SI, STRING	 		; set Start Index to start of STRING
	LEA AX, STRING			; store string to AX
	MOV CX, STR_LEN        	; set string size to CX
	ADD AX, CX				; add the length to AX to point to end of String
	MOV DI, AX				; set enD Index to end of string (in AX)
	DEC DI

	MOV CX, STR_LEN_DIV2
	ITERATE:
	    MOV AL, [SI]
	    MOV AH, [DI]
	    CMP AL, AH
	    JNE CHECKER_OUT

	    INC SI
	    DEC DI

	    LOOP ITERATE

	PALINDROME:
		MOV FLAG_PALI, 'Y'		; set palindrome flag to YES

	JMP CHECKER_OUT
	
    CHECKER_OUT:
		RET
_CHECK_PALINDROME ENDP
;-----------------------------------------
_RESET_VARIABLES PROC NEAR

									; reset STRING variable
	MOV CX, 31 						; set counter to 31
	MOV SI, 0000 					; set index to 0000
	B10:
		MOV STRING[SI], '?' 		; overwrite data with
		INC SI 						; increment index
		LOOP B10 					; loop


	MOV STR_LEN, 0000
	MOV STR_LEN_DIV2, 0000

	MOV FLAG_PALI, 'N'

	RET
_RESET_VARIABLES ENDP
;-----------------------------------------
_RESET_VARIABLES2 PROC NEAR

	MOV STR1_PALI, 'N'
	MOV STR2_PALI, 'N'

									; reset STRING1 variable
	MOV CX, 31 						; set counter to 31
	MOV SI, 0000 					; set index to 0000
	B20:
		MOV STRING1[SI], '$' 		; overwrite data with
		INC SI 						; increment index
		LOOP B20 					; loop

									; reset STRING2 variable
	MOV CX, 31 						; set counter to 31
	MOV SI, 0000 					; set index to 0000
	B30:
		MOV STRING2[SI], '$' 		; overwrite data with
		INC SI 						; increment index
		LOOP B30 					; loop

	RET
_RESET_VARIABLES2 ENDP
;-----------------------------------------
_COPY_STRING PROC NEAR
	PUSH BP
	MOV BP, SP
								; copy STRING to STRING1 or STRING2
	CLD             			; clear direction flag (left to right)
	MOV CX, STR_LEN        		; initialize counter
	MOV DI, [BP+4]  			; initialize destination address
	LEA SI, STRING  			; initialize source address
	REP MOVSB

	MOV SP, BP
	POP BP
	RET 2
_COPY_STRING ENDP
;-----------------------------------------
_CLEAR_SCREEN PROC NEAR
	
	MOV AX, 0600H 			; fullscreen
	MOV BH, 0BH			;
	MOV CX, 0000H			; from 00,00
	MOV DX, 184FH			; to   80,24
	INT 10H

  RET
_CLEAR_SCREEN ENDP
;--------------------------------------------------
_SET_CURSOR PROC	NEAR
	MOV	AH, 02H		; request set cursor, use DX's values
	MOV	BH, 00		; page number
	INT	10H

	RET
_SET_CURSOR ENDP
;--------------------------------------------------
_TERMINATE PROC NEAR
	MOV AH, 09H
	LEA DX, PROMPT3
	INT 21H

	MOV AH, 4CH		; System.exit(0)
	INT 21H
_TERMINATE ENDP
;-----------------------------------------
CODESEG ENDS
END START