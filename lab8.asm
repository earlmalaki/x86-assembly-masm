; Earl Timothy Malaki
; CMSC 131 Laboratory
; Lab 8 - FILE HANDLING

TITLE LAB8 FILE HANDLING (.EXE MODEL)
;-----------------------------------------
STACKSEG SEGMENT PARA 'Stack'
STACKSEG ENDS
;-----------------------------------------
DATASEG SEGMENT PARA 'Data'

	PROMPT0 DB 10,13,'$'
	PROMPT3 DB 10,10,13,"Program terminated successfully!", 0AH, '$'
	PROMPT4 DB 10,10,13,"New content successfully written to 'new.txt'!$"

	PATHFILENAME_IN  DB 'file.txt', 00H
  	FILEHANDLE_IN    DW ?

  	PATHFILENAME_OUT  DB 'new.txt', 00H
  	FILEHANDLE_OUT    DW ?

  	RECORD_STR    DB 1000 DUP('$')  ;length = original length of record + 1 (for $)
  	RECORD_STR2   DB 1000 DUP('$')  ;length = original length of record + 1 (for $)
  	RECORD_LEN DW ?

  	ERROR1_STR    DB 'Error in opening file.$'
  	ERROR2_STR    DB 'Error reading from file.$'
  	ERROR3_STR    DB 'No record read from file.$'

  	ERROR1_W    DB 'Error in creating file.$'
  	ERROR2_W    DB 'Error writing in file.$'
  	ERROR3_W    DB 'Record not written properly.$'

  	ORIG_STR DB 10,13,'Original contents of file.',10,13,'$'
  	MODIF_STR DB 10,13,'Modified contents of file.',10,13,'$'

  	DOTS_STR DB '...$'

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

		CALL _READ_FILE				; read contents of file

		LEA DX, ORIG_STR
		PUSH DX
		CALL _DISP_PROMPT

			  						;display record
		LEA DX, RECORD_STR
		MOV AH, 09
		INT 21H

		;CALL _LOADING				; show loading before displaying modified contents

		CALL _MODIFY_INPUT

		LEA DX, PROMPT0
		PUSH DX
		CALL _DISP_PROMPT

		LEA DX, MODIF_STR
		PUSH DX
		CALL _DISP_PROMPT

									;display record2
		LEA DX, RECORD_STR2
		MOV AH, 09
		INT 21H

		CALL _WRITE_FILE

									; exit program
		CALL _TERMINATE
_MAIN ENDP
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
_LOADING PROC NEAR
	PUSH BP					; save the original BP value to stack 
	MOV BP, SP				; use stack pointer as the base pointer

	MOV CX, 03

	I10:
		MOV AH, 09H
		LEA DX, DOTS_STR
		INT 21H

		CALL _DELAY

		LOOP I10

	E10:
		MOV SP, BP		; reset BP back to SP
		POP BP			; get back original value of BP
		RET 2			; return and pop off 2 bytes to set SP back to 0000
_LOADING ENDP
;-----------------------------------------
_READ_FILE PROC NEAR
	
							;open file
	  MOV AH, 3DH           ;requst open file
	  MOV AL, 00            ;00 - read only | 01 - write only | 10 - read/write
	  LEA DX, PATHFILENAME_IN
	  INT 21H
	  JC DISP_ERROR1_R		; error opening file. file not found
	  MOV FILEHANDLE_IN, AX

	  ;read file
	  MOV AH, 3FH           ;request read record
	  MOV BX, FILEHANDLE_IN    ;file handle
	  MOV CX, 1000            ;record length
	  LEA DX, RECORD_STR    ;address of input area
	  INT 21H
	  JC DISP_ERROR2_R		; error reading file
	  CMP AX, 00            ;zero bytes read?
	  JE DISP_ERROR3_R		; file is empty
	  MOV RECORD_LEN, AX	; store input lenght

	  ;						;display record
	  ;LEA DX, RECORD_STR
	  ;MOV AH, 09
	  ;INT 21H

	  ;close file handle
	  MOV AH, 3EH           ;request close file
	  MOV BX, FILEHANDLE_IN    ;file handle
	  INT 21H

	  JMP EXIT_READ


	DISP_ERROR1_R:
	  LEA DX, ERROR1_STR
	  MOV AH, 09
	  INT 21H

	  JMP EXIT_READ


	DISP_ERROR2_R:
	  LEA DX, ERROR2_STR
	  MOV AH, 09
	  INT 21H

	  JMP EXIT_READ


	DISP_ERROR3_R:
	  LEA DX, ERROR3_STR
	  MOV AH, 09
	  INT 21H


	  EXIT_READ:
	  	RET
_READ_FILE ENDP
;-----------------------------------------
_RESET_VARIABLES PROC NEAR

					
	RET
_RESET_VARIABLES ENDP
;-----------------------------------------
_DELAY PROC	NEAR
			mov bp, 4 ;lower value faster
			mov si, 4 ;lower value faster
		delay2:
			dec bp
			nop
			jnz delay2
			dec si
			cmp si,0
			jnz delay2
			RET
_DELAY ENDP
;-----------------------------------------
_CLEAR_SCREEN PROC NEAR
	
	MOV AX, 0600H 			; fullscreen
	MOV BH, 0BH				;
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
_MODIFY_INPUT PROC NEAR

	LEA SI, RECORD_STR 			; set SI to starting letter of STRing 1
	LEA DI, RECORD_STR2			; set SI to starting letter of STRing 2
	
	MOV CX, RECORD_LEN
	L10:
		MOV AL, [SI]			; get char at SI's address

		CMP AL, 48				; check if '0'
		JL SPEC_CHAR
		CMP AL, 57 				; check if '9'
		JG CHECK_LET_BIG

		IS_NUMBER:
			MOV [DI], AL 		; copy number to string2
			JMP BREAK
		
		SPEC_CHAR:
			CMP AL, 36 			; if '$'
			JE IS_DELI
			CMP AL, 10 			; chech if AL is NewLine
			JE IS_NEWLINE

			MOV AL, ' ' 		; load [space] char to register
			MOV [DI], AL		; store converted (special char to [space])
			JMP BREAK

		IS_NEWLINE: 			; if newline, replace with two [space] '  '
			MOV [DI], '  '	
			INC DI 				; di + 1 to accomodate 1 additional char
			ADD RECORD_LEN, 1 	; rec_len + 1 to accomodate 1 additional char
			JMP BREAK

		IS_DELI: 				; if '$', stop copying			
			MOV AL, '$'
			MOV [DI], AL
			CALL _DELI_IN_RECORD
			RET

		CHECK_LET_BIG:
			CMP AL, 65			; check if 'A'
			JL SPEC_CHAR
			CMP AL, 90			; check if 'Z'
			JG CHECK_LET_SMALL

			IS_BIG_LET:
				ADD AL, 32 		; convert BIG to small
				MOV [DI], AL	; store converted to result string
				JMP BREAK

		CHECK_LET_SMALL:
			CMP AL, 97 			; check if 'a'
			JL SPEC_CHAR
			CMP AL, 122 		; check if 'z'
			JG SPEC_CHAR

			IS_SMALL_LET:
				SUB AL, 32 		; convert small to BIG
				MOV [DI], AL	; store converted to result string
				JMP BREAK

		BREAK:
			INC SI
			INC DI
			LOOP L10

	RET
_MODIFY_INPUT ENDP
;--------------------------------------------------
_DELI_IN_RECORD PROC NEAR
	DIR10:
		MOV AL, ' '
		MOV [DI], AL
		INC DI
		LOOP DIR10
	RET
_DELI_IN_RECORD ENDP
;--------------------------------------------------
_WRITE_FILE PROC NEAR
	
								;create file
	  MOV AH, 3CH          		;request create file
	  MOV CX, 00            	;normal attribute
	  LEA DX, PATHFILENAME_OUT  ;load path and file name
	  INT 21H
	  JC DISP_ERROR1_W     	;if there's error in creating file, carry flag = 1, otherwise 0
	  MOV FILEHANDLE_OUT, AX

	  						;write file
	  MOV AH, 40H           ;request write record
	  MOV BX, FILEHANDLE_OUT    ;file handle
	  MOV CX, RECORD_LEN            ;record length
	  LEA DX, RECORD_STR2    ;address of output area
	  INT 21H
	  JC DISP_ERROR2_W     ;if carry flag = 1, there's error in writing (nothing is written)
	  CMP AX, RECORD_LEN
	  JNE DISP_ERROR3_W

	  ;close file handle
	  MOV AH, 3EH           ;request close file
	  MOV BX, FILEHANDLE_OUT    ;file handle
	  INT 21H

	  JMP EXIT_WRITE

	DISP_ERROR1_W:
	  LEA DX, ERROR1_W
	  MOV AH, 09
	  INT 21H

	  JMP EXIT_WRITE

	DISP_ERROR2_W:
	  LEA DX, ERROR2_W
	  MOV AH, 09
	  INT 21H

	  JMP EXIT_WRITE

	DISP_ERROR3_W:
	  LEA DX, ERROR3_W
	  MOV AH, 09
	  INT 21H

	EXIT_WRITE:
		LEA DX, PROMPT4
		PUSH DX
		CALL _DISP_PROMPT
		
	  	RET
_WRITE_FILE ENDP
;-----------------------------------------
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