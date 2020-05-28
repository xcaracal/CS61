;=================================================
; Name: Steven Hoang
; Email: shoan031@ucr.edu
; 
; Lab: lab 9, ex 3
; Lab section: 24
; TA: David Feng
; 
;=================================================

; test harness
					.orig x3000
					
;-------FIRST NUM

LD R4,BASE
LD R5,MAX
LD R6,TOS				 
				 
LEA R0,PROMPT1
PUTS

GETC
OUT

LD R7,ASCII
ADD R0,R0,R7

LD R7,SUB_STACK_PUSH
JSRR R7

LEA R0,NEWLINE
PUTS
;-------SECOND NUM

LEA R0,PROMPT2
PUTS

GETC
OUT

LD R7,ASCII
ADD R0,R0,R7

LD R7,SUB_STACK_PUSH
JSRR R7

LEA R0,NEWLINE
PUTS
;-------OPERATION
			
LEA R0,PROMPT3
PUTS

GETC
OUT

;-------MULTI
LD R7,SUB_RPN_MULTIPLY
JSRR R7

LEA R0,NEWLINE
PUTS 

LEA R0,PRODUCT
PUTS

LD R7,SUB_STACK_POP		;load multiplied num to R0
JSRR R7

ADD R1,R0,#0			;move it to R1 since im lazy
LD R7,SUB_PRINT_DECIMAL
JSRR R7

LEA R0,NEWLINE
PUTS

					halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
PROMPT1				.STRINGZ "INPUT FIRST NUMBER TO MULTIPLY:\n"
MULTI				.STRINGZ " * "
PROMPT2				.STRINGZ "INPUT SECOND NUMBER TO MULTIPLY:\n"
PROMPT3				.STRINGZ "WHAT OPERATION:\n"
NEWLINE				.STRINGZ "\n"
PRODUCT				.STRINGZ "PRODUCT: "
ASCII				.FILL #-48
BASE				.FILL xA000
MAX					.FILL xA005
TOS					.FILL xA000
SUB_STACK_PUSH		.FILL x3200
SUB_STACK_POP		.FILL x3400
SUB_RPN_MULTIPLY	.FILL x3600
SUB_PRINT_DECIMAL	.FILL x4800



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

;------------------------------------------------------------------------------------------
; Subroutine: SUB_RPN_MULTIPLY
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped off the top two values of the stack,
;		    multiplied them together, and pushed the resulting value back
;		    onto the stack.
; Return Value: R6 ← updated TOS address
;------------------------------------------------------------------------------------------
					.orig x3600
ST R7,BACKUP_R7_3600
ST R1,BACKUP_R1_3600
ST R2,BACKUP_R2_3600
ST R3,BACKUP_R3_3600
				 
LD R7,SUB_STACK_POP_3600
JSRR R7

AND R1,R1,#0					;LOAD FIRST NUM TO R1
ADD R1,R1,R0

LD R7,SUB_STACK_POP_3600
JSRR R7		

AND R2,R2,#0					;SECOND NUMTO R2
ADD R2,R2,R0 

LD R7,SUB_MULTI					;MULTI AND STORE IN R3
JSRR R7

AND R0,R0,#0					;MOVE R0<-R3
ADD R0,R0,R3

LD R7,SUB_STACK_PUSH_3600		;PUSH
JSRR R7
				 
LD R7,BACKUP_R7_3600
LD R1,BACKUP_R1_3600
LD R2,BACKUP_R2_3600
LD R3,BACKUP_R3_3600
					ret
;-----------------------------------------------------------------------------------------------
; SUB_RPN_MULTIPLY local data
BACKUP_R7_3600				.BLKW #1
BACKUP_R1_3600				.BLKW #1
BACKUP_R2_3600				.BLKW #1
BACKUP_R3_3600				.BLKW #1
SUB_STACK_PUSH_3600		.FILL x3200
SUB_STACK_POP_3600		.FILL x3400
SUB_MULTI				.FILL x3800


;===============================================================================================



; SUB_MULTIPLY
.ORIG x3800
ST R7,BACKUP_R7_3800
ST R2,BACKUP_R2_3800

AND R3,R3,#0

CONT_ADD						;ADD TO BY OTHER NUMBERS MOUNT
ADD R3,R3,R1
ADD R2,R2,#-1
BRnp CONT_ADD
BRz END_3800

END_3800

LD R2,BACKUP_R2_3800
LD R7,BACKUP_R7_3800
RET
;local data
BACKUP_R7_3800				.BLKW #1
BACKUP_R2_3800				.BLKW #1
		

; SUB_PRINT_DECIMAL		Only needs to be able to print 1 or 2 digit numbers. 
;						You can use your lab 7 s/r.
.ORIG x4800
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
ST R1,BACKUP_R1_4800
ST R4,BACKUP_R4_4800
ST R5,BACKUP_R5_4800
ST R7,BACKUP_R7_4800

LD R4,Two
LD R6,SUB_SUB_OUTPUT_PLACE
JSRR R6

LD R4,One
LD R6,LAST_OUTPUT
JSRR R6

LD R1,BACKUP_R1_4800
LD R4,BACKUP_R4_4800
LD R5,BACKUP_R5_4800
LD R7,BACKUP_R7_4800

RET
;data
BACKUP_R1_4800		.BLKW #1
BACKUP_R4_4800		.BLKW #1
BACKUP_R5_4800		.BLKW #1
BACKUP_R7_4800		.BLKW #1
SUB_SUB_OUTPUT_PLACE .FILL x5400
LAST_OUTPUT			 .FILL x5600
Two					.FILL #-10
One					.FILL #-1
NEGATIVE 	 		.FILL #45
;=================================================
;				END 3400
;=================================================

;=================================================
;Subroutine:SUB_SUB_OUTPUT_PLACE
;Parameter():takes in the numbers to printout the number
;Postcondition:Fill A number into R2
;Return Value(NA):
;=================================================
.ORIG x5400
;instructions
ST R7,BACKUP_R7_5400
ST R2,BACKUP_R2_5400
ST R3,BACKUP_R3_5400

AND R3,R3,#0
ADD R2,R1,R4
BRn DO_ZERO
BRzp FIND_NUM_PLACE


FIND_NUM_PLACE
	ADD R2,R1,#0
	LOOP
	ADD R2,R2,R4
	BRnp SKIP_THIS
	
	ADD R3,R3,#1
	AND R1,R1,#0
	
	SKIP_THIS
	ADD R3,R3,#1
	ADD R2,R2,#0
	BRz OUTPUT
	BRzp LOOP
	
OUTPUT
	LD R0,IS_LAST_PLACE
	ADD R0,R4,R5
	BRz SKIP
	ADD R5,R5,#1
	
	ADD R3,R3,#-1
	
	SKIP
		LD R0,ASCII_5400
		ADD R0,R3,R0
		OUT
		
		NOT R2,R2
		ADD R2,R2,#1
		ADD R2,R2,R4
		NOT R2,R2
		ADD R2,R2,#1
		ADD R1,R1,#0
		BRz SKIP_HERE
		ADD R1,R2,#0
		SKIP_HERE
		BRnzp FINAL
	
DO_ZERO
	ADD R5,R5,#0
	BRnz FINAL
	LD R0,ASCII_5400
	OUT
	
FINAL

LD R7,BACKUP_R7_5400
LD R2,BACKUP_R2_5400
LD R3,BACKUP_R3_5400

RET
;data
BACKUP_R7_5400		.BLKW #1
BACKUP_R2_5400		.BLKW #1
BACKUP_R3_5400		.BLKW #1
ASCII_5400				.FILL #48
IS_LAST_PLACE		.FILL #1
;=================================================
;				END 3400
;=================================================
;=================================================
;Subroutine:LAST_OUTPUT
;Parameter():takes in the numbers to printout the number
;Postcondition:Fill A number into R2 (DIFFERENCE IS DOESNT DECREMENT)
;Return Value(NA):
;=================================================
.ORIG x5600
;instructions
ST R7,BACKUP_R7_5600
ST R2,BACKUP_R2_5600
ST R3,BACKUP_R3_5600

AND R3,R3,#0
ADD R2,R1,R4
BRn DO_ZERO_5600
BRzp FIND_NUM_PLACE_5600


FIND_NUM_PLACE_5600
	ADD R2,R1,#0
	LOOP_5600
	ADD R2,R2,R4
	BRzp SKIP_THIS_2
	
	ADD R3,R3,#-1
	
	SKIP_THIS_2
	ADD R3,R3,#1
	ADD R2,R2,#0
	BRz OUTPUT_5600
	BRzp LOOP_5600
	
OUTPUT_5600
		ADD R5,R5,#1
		LD R0,ASCII_5600
		ADD R0,R3,R0
		OUT
		
		NOT R2,R2
		ADD R2,R2,#1
		ADD R2,R2,R4
		NOT R2,R2
		ADD R2,R2,#1
		ADD R1,R2,#0
		BRnzp FINAL_5600
	
DO_ZERO_5600
	LD R0,ASCII_5600
	OUT
	
FINAL_5600

LD R7,BACKUP_R7_5600
LD R2,BACKUP_R2_5600
LD R3,BACKUP_R3_5600

RET
;data
BACKUP_R7_5600		.BLKW #1
BACKUP_R2_5600		.BLKW #1
BACKUP_R3_5600		.BLKW #1
ASCII_5600				.FILL #48
;=================================================
;				END 5600
;=================================================
;--------------------------------
;Data for subroutine print number
;--------------------------------

