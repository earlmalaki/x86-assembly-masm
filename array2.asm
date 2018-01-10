; Earl Timothy Malaki
; CMSC 131 Laboratory

TITLE ARRAY2 (.EXE MODEL)
;-----------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;-----------------------------------------
DATASEG SEGMENT PARA 'Data'

	PROMPT0 DB 10,13,'$'
	PROMPT1 DB 10, 13, "STRING 1> ", '$'
	PROMPT2 DB "STRING 2> ", '$'
	PROMPT3 DB "Program terminated successfully!", 0AH, '$'
	NUM_LOC DB 10 DUP (' '), '$'

	POINT STRUC
		X DW ?
		Y DW ?
	POINT ENDS

	; square
	; P1 POINT <1,1>
	; P2 POINT <3,1>
	; P3 POINT <1,3>
	; P4 POINT <3,3>

	; diamond
	; P1 POINT <2,1>
	; P2 POINT <0,3>
	; P3 POINT <4,3>
	; P4 POINT <2,5>

	; tilted square
	P1 POINT <3,1>
	P2 POINT <1,2>
	P3 POINT <4,3>
	P4 POINT <2,4>

	P1_SELECTED_CELLS DW ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?	
	P1_SEL_CEL_FIRST DB ?
	P1_SEL_CEL_LAST ?
	P1_SEL_CEL_MAX DB ?
	P2_SELECTED_CELLS DW ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?

	MAX_SELECTED_CELLS DW 32


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



		EXIT:
		CALL _TERMINATE
_MAIN ENDP
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
_CLEAR_SCREEN PROC NEAR
	
	MOV AX, 0600H 			; fullscreen
	MOV BH, 0BH			;
	MOV CX, 0000H			; from 00,00
	MOV DX, 184FH			; to   80,24
	INT 10H

  RET
_CLEAR_SCREEN ENDP
;--------------------------------------------------
_PRINT_CX PROC NEAR
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

        RET
_PRINT_CX ENDP
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