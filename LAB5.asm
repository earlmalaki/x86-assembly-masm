; Earl Timothy Malaki
; CMSC 131 Laboratory
; Lab 5 - Procedure

TITLE PROCEDURE (.EXE MODEL)
;--------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;--------------------------------------
DATASEG SEGMENT PARA 'Data'
	MSG1 DB "> Enter initial of first name: ", '$'
	MSG2 DB "> Enter initial of middle name: ", '$'
	MSG3 DB "> Enter initial of last name: ", '$'

	NEWLINE DB 0AH, 0DH, '$'

	HOLDER DB ?, '$'

	OUTMSG1 DB "Initial of your first name is "
	INPUT1 DB ?
	OUTMSG2 DB ", middle name is "
	INPUT2 DB ?
	OUTMSG3 DB " and last name is "
	INPUT3 DB ?
	OUTMSG4 DB "!", '$'

DATASEG ENDS
;--------------------------------------
CODESEG SEGMENT PARA 'Code'
	ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG

START:
	MOV AX, DATASEG
	MOV DS, AX
	
	; MAIN PROCEDURE
	;--------------------------------------
	MAIN PROC FAR
		
		;------ INPUT 1 -------
		LEA DX, MSG1		; transfer MSG1 from memory to register
		PUSH DX				; push DX contents to stack, to be used later as parameter
		CALL GET_INPUT		; getInput(MSG1)

		; INPUT1 = HOLDER
		MOV AL, HOLDER		; transfer memory value 'HOLDER' to register 'AX'
		MOV INPUT1, AL		; transfer 'AL' to 'INPUT1' memory
		
		;------ INPUT 2 -------
		LEA DX, MSG2
		PUSH DX
		CALL GET_INPUT

		MOV AL, HOLDER
		MOV INPUT2, AL
		
		;------ INPUT 3 -------
		LEA DX, MSG3
		PUSH DX
		CALL GET_INPUT

		MOV AL, HOLDER
		MOV INPUT3, AL

		;------ DISPLAY OUTPUT -------
		LEA DX, INPUT1		; transfer INPUT1 from memory to register
		PUSH DX				; push DX contents to stack, to be used later as parameter

		LEA DX, INPUT2
		PUSH DX

		LEA DX, INPUT3
		PUSH DX

		CALL DISPLAY 		; display(input1, input2, input3)

		; END PROCESSING
		MOV AH, 4CH
		INT 21H
	MAIN ENDP
	;--------------------------------------
	
	; SUB ROUTINES

	;--------------------------------------
	GET_INPUT PROC NEAR
		PUSH BP			; save the original BP value to stack 
		MOV BP, SP		; use stack pointer as the base pointer

		MOV AX, [BP+4]	; get passed parameter (one pushed before procedure call)

		; print message
		MOV DX, AX
		MOV AH, 09H
		INT 21H

		; usual ask for char input
		MOV AH, 10H
		INT 16H
		MOV HOLDER, AL

		; display char input
		LEA DX, HOLDER
		MOV AH, 09H
		INT 21H

		; display new line (for format purposes)
		LEA DX, NEWLINE
		MOV AH, 09H
		INT 21H		

		MOV SP, BP		; reset BP back to SP
		POP BP			; get back original value of BP
		RET 2			; return and pop off 2 bytes to set SP back to 0000
	GET_INPUT ENDP
	;--------------------------------------
	
	;--------------------------------------
	DISPLAY PROC NEAR
		PUSH BP
		MOV BP, SP

		; usual printing
		LEA DX, OUTMSG1
		MOV AH, 09H
		INT 21H
		
		MOV SP, BP
		POP BP
		RET 2

	DISPLAY ENDP
	;--------------------------------------

CODESEG ENDS
END START