TITLE ASM1 (EXE)
;---------------------------------------------
STACKSEG SEGMENT PARA 'Stack'
  DW 12 DUP ('AB')
  DW 13 DUP ('CD')
STACKSEG ENDS
;---------------------------------------------
DATASEG SEGMENT PARA 'Data'
  MESSAGE1 DB "LEARNING ASSEMBLY PROGRAMMING IS FUN AND JUST FUN!!!"
  MESSAGE2 DB 0AH, 0DH, "I LOVE PROGRAMMING, ESPECIALLY ASSEMBLY PROGRAMMING!!!$"
DATASEG ENDS
;---------------------------------------------
CODESEG SEGMENT PARA 'Code'
  ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG
START:
  MOV AX, DATASEG
  MOV DS, AX
  LEA DX, MESSAGE1
  MOV AH, 9
  INT 21H
  LEA DX, MESSAGE2
  MOV AH, 9
  INT 21H
  MOV AH, 4CH
  INT 21H
CODESEG ENDS
END START