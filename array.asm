; Earl Timothy Malaki
; CMSC 131 Laboratory
; Long Exam 2 Practical 2

TITLE ARRAY (.EXE MODEL)
;--------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;--------------------------------------
DATASEG SEGMENT PARA 'Data'

	HELLOW DB "HELLO WORLD", 10,13,'$'

	BTNS_HOLDER		DW 2
					DW 3,4,5,6
					DW 7,8,9,9
	BTN_HOLDER 		DW ?

	NUM_LOC DB 10 DUP ('$')

DATASEG ENDS
;--------------------------------------
CODESEG SEGMENT PARA 'Code'
	ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG

START:
	MAIN PROC FAR
		MOV AX, DATASEG
		MOV DS, AX

		;LEA SI, BTNS_HOLDER 			; 
		;MOV AX, [SI] 					; load SI's value to AX for multiplication
		;MOV BX, 4 						; set multiplier to 4
		;MUL BX 							; multiply to get the needed number of iterations
		;MOV CX, AX 						; store correct iterations to cx. EX: 2 btns * 4 coords = 8 iterations needed

		;INC SI 							; increment SI to get to the first coord of the first btn

		;LOOPER:
		;	PUSH CX
		;	PUSH SI
		;	MOV CX, [SI]
		;	CALL _PRINT_CX
		;	POP SI
		;	POP CX
;
;			MOV AH, 09H
;			LEA DX, HELLOW
;			INT 21H
;
;			INC SI
;			INC SI
;			LOOP LOOPER

		LEA DX, BTNS_HOLDER
		MOV BTN_HOLDER, DX


		LEA SI, BTNS_HOLDER
		MOV CX, [SI]
		PUSH CX
			PUSH SI
			;MOV CX, BX
			CALL _PRINT_CX
			POP SI
			POP CX
		LOOPER1:

			MOV BX, [SI]
			INC SI
			INC SI

			PUSH CX
			PUSH SI
			MOV CX, BX
			CALL _PRINT_CX
			POP SI
			POP CX

			MOV BX, [SI]
			INC SI
			INC SI

			PUSH CX
			PUSH SI
			MOV CX, BX
			CALL _PRINT_CX
			POP SI
			POP CX

			MOV BX, [SI]
			INC SI
			INC SI

			PUSH CX
			PUSH SI
			MOV CX, BX
			CALL _PRINT_CX
			POP SI
			POP CX


			MOV BX, [SI]
			INC SI
			INC SI

			PUSH CX
			PUSH SI
			MOV CX, BX
			CALL _PRINT_CX
			POP SI
			POP CX

			MOV AH, 09H
			LEA DX, HELLOW
			INT 21H

			LOOP LOOPER1

		CALL _TERMINATE
	MAIN ENDP
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