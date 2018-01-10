; Earl Timothy Malaki
; CMSC 131 Laboratory
; Long Exam 2 Practical

TITLE PRACTICAL NUMBER 1(.EXE MODEL)
;--------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;--------------------------------------
DATASEG SEGMENT PARA 'Data'
	
	PROMPT0 DB "Enter N: ", '$'

	INPUT DB 3 DUP (?)
	INPUT_LEN DW ?
	N DW ?

	CHAR DB '$'
	SPACE DB ' ', '$'
	NEWLINE DB 10,13,'$'

DATASEG ENDS
;--------------------------------------
CODESEG SEGMENT PARA 'Code'
	ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG

	START:
		MAIN PROC FAR
			MOV AX, DATASEG
			MOV DS, AX

		CALL _MAIN_LOOP

		JMP EXIT
		MAIN ENDP

	EXIT:
		CALL _TERMINATE
;--------------------------------------------------
_MAIN_LOOP PROC NEAR
	
	ITERATE:

		MOV AH, 09H
		LEA DX, PROMPT0
		INT 21H

		CALL _SCAN_STRING 			; get input
		MOV INPUT_LEN, AX 			; store input length

		CALL _TO_INTEGER 			; convert input number string to integer

		CALL _PRINT_CHARS 			; print final output

		MOV AH, 09H 				; print newline
		LEA DX, NEWLINE
		INT 21H

		BREAK:
			JMP ITERATE

_MAIN_LOOP ENDP
;--------------------------------------------------
_SCAN_STRING PROC NEAR
	LEA SI, INPUT
	MOV CX, SI 		            ; cx == buffer start address
	
    READ:
    	MOV AH, 01H				; read a char, store in AL
        INT 21H
        CMP AL, 13				; is it [enter]?
        JE DONE                 ; if yes, entering char is done
        CMP AL, 27				; is it [esc]?
        JE QUIT 				; if yes, QUIT
        
        MOV [SI], AL		; good input, move char to [SI] (STRING)
	    INC SI              ; increment index

		JMP READ            ; loop

    DONE:
    	MOV AL, '$'				
        mov [si], AL            ; add delimiter. terminate string
        mov ax, si              ; ax -> buffer end address
        sub ax, cx              ; ax = si - cx

        RET

    QUIT:
    	CALL _TERMINATE

_SCAN_STRING ENDP
;--------------------------------------------------
_TO_INTEGER PROC NEAR
	LEA SI, INPUT

	XOR AX, AX  		; AX 0 so far, AX holds result
	;MOV AX, 0001

	L10:
		MOV CL, [SI] 	; get char in [SI]
		INC SI 

		CMP CL, '$'
		JE DONE_CONV
		CMP CL, '0'		; check if char is valid (numbers)
		JB DONE_CONV
		CMP CL, '9'
		JA DONE_CONV

		SUB CL, '0' 	; convert char to number
		;IMUL AX, 10 	; multiply curr result by 10 to get place
		MOV BL, 10
		MUL BL
		ADD AL, CL 		; add in curr digit

		JMP L10

	DONE_CONV:
		MOV AH, 00
		MOV N, AX
		RET

_TO_INTEGER ENDP
;--------------------------------------------------
_PRINT_CHARS PROC NEAR

	MOV BX, 0
	MOV CX, N 				; set counter to N

	PC10:
		CMP CX, 0
		JE DONE_PRINT

		CMP BX, 5 			; if 5th char, print space
		JE PRINT_SPACE
		CMP BX, 11 			; if 10th char, print newline
		JE PRINT_NEWLINE

		MOV AH, 02H 		; print $
		MOV DL, '$'
		INT 21H

		DEC CX
		INC BX

		JMP BREAK_PR

		PRINT_SPACE:			
			MOV AH, 09H
			LEA DX, SPACE 		; load [space] to DX
			INT 21H

			INC BX
			JMP BREAK_PR

		PRINT_NEWLINE:
			MOV AH, 09H
			LEA DX, NEWLINE 		; load [space] to DX
			INT 21H

			MOV BX, 0
			JMP BREAK_PR

		BREAK_PR:
			JMP PC10

	DONE_PRINT:
		MOV AH, 09H
		LEA DX, NEWLINE
		INT 21H

		RET
_PRINT_CHARS ENDP
;--------------------------------------------------
_DELAY PROC	NEAR
	mov bp, 2 ;lower value faster
	mov si, 2 ;lower value faster
	
	delay2:
		dec bp
		nop
		jnz delay2
		dec si
		cmp si,0
		jnz delay2
		RET
_DELAY ENDP
;--------------------------------------
_CLEAR_SCREEN PROC NEAR
	; BLACK
	MOV AX, 0600H		; fullscreen
	MOV BH, 0FH			; colors
	MOV CX, 0000H
	MOV DX, 184FH
	INT 10H

	; LIGHT CYAN
	MOV AX, 0600H
	MOV BH, 0B0H
	MOV CX, 0101H
	MOV DX, 174EH
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
_TERMINATE PROC
	MOV AH, 4CH		; System.exit(0)
	INT 21H
_TERMINATE ENDP

CODESEG ENDS
END START