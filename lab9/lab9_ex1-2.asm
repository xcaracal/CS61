;=================================================
; Name: Steven Hoang
; Email: shoan031@ucr.edu
; 
; Lab: lab 9, ex 1 & 2
; Lab section: 24
; TA: David Feng
; 
;=================================================

; test harness
					.orig x3000
				 
LD R4,BASE
LD R5,MAX
LD R6,TOS
		
AND R0,R0,#0
ADD R0,R0,#1
LD R7, SUB_STACK_PUSH
JSRR R7 

ADD R0,R0,#1
LD R7, SUB_STACK_PUSH
JSRR R7 

ADD R0,R0,#1
LD R7, SUB_STACK_PUSH
JSRR R7 

ADD R0,R0,#1
LD R7, SUB_STACK_PUSH
JSRR R7 

ADD R0,R0,#1
LD R7, SUB_STACK_PUSH
JSRR R7 

;ADD R0,R0,#1
;LD R7, SUB_STACK_PUSH   ;Causes Overflow
;JSRR R7 

LD R7, SUB_STACK_POP
JSRR R7 

LD R7,ASCII
ADD R0,R0,R7
OUT

LD R7, SUB_STACK_POP
JSRR R7 

LD R7,ASCII
ADD R0,R0,R7
OUT

LD R7, SUB_STACK_POP
JSRR R7 

LD R7,ASCII
ADD R0,R0,R7
OUT

LD R7, SUB_STACK_POP
JSRR R7 

LD R7,ASCII
ADD R0,R0,R7
OUT

LD R7, SUB_STACK_POP
JSRR R7 

LD R7,ASCII
ADD R0,R0,R7
OUT

;LD R7, SUB_STACK_POP		;Causes Underflow
;JSRR R7 

				 
					halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
BASE				.FILL xA000
MAX					.FILL xA005
TOS					.FILL xA000
SUB_STACK_PUSH		.FILL x3200
SUB_STACK_POP		.FILL x3400
ASCII 				.FILL #48



;===============================================================================================


; subroutines:

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1). 
;		    If the stack was already full (TOS = MAX), the subroutine has printed an
;		    overflow error message and terminated.
; Return Value: R6 ← updated TOS
;------------------------------------------------------------------------------------------
					.orig x3200
ST R7,BACKUP_R7_3200
				 
NOT R3,R6
ADD R3,R3,#1

ADD R3,R3,R5		;IF MAX-TOS <= 0 Then OVERFLOW
BRnz OVERFLOW
BRp CONT_3200

CONT_3200
		ADD R6,R6,#1	;INCRE
		STR R0,R6,#0	;STORE
		BRnzp END_3200
		
OVERFLOW
		LEA R0,OVERFLOW_MSG
		PUTS

END_3200
				 
LD R7,BACKUP_R7_3200
					ret
;-----------------------------------------------------------------------------------------------
; SUB_STACK_PUSH local data
BACKUP_R7_3200				.BLKW #1
OVERFLOW_MSG				.STRINGZ "OVERFLOW ERROR\n"


;===============================================================================================


;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available                      
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[TOS] off of the stack.
;		    If the stack was already empty (TOS = BASE), the subroutine has printed
;                an underflow error message and terminated.
; Return Value: R0 ← value popped off the stack
;		   R6 ← updated TOS
;------------------------------------------------------------------------------------------
					.orig x3400
ST R7,BACKUP_R7_3400	 
			 
NOT R3,R4
ADD R3,R3,#1

ADD R3,R3,R6		;IF TOS-BASE <= 0, THEN UNDERFLOW
BRnz UNDERFLOW
BRp CONT_3400

CONT_3400
		LDR R0,R6,#0		;LOAD
		ADD R6,R6,#-1		;DECRE
		BRnzp END_3400
		
UNDERFLOW
		LEA R0,UNDERFLOW_MSG
		PUTS

END_3400			 
				 
LD R7,BACKUP_R7_3400	 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_STACK_POP local data
BACKUP_R7_3400				.BLKW #1
UNDERFLOW_MSG				.STRINGZ "UNDERFLOW ERROR\n"


;===============================================================================================

