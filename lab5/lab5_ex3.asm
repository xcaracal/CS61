;=================================================
; Name: Steven Hoang
; Email: Shoan031@ucr.edu
; 
; Lab: lab 5, ex 2
; Lab section: 24
; TA: David Feng
; 
;=================================================
.ORIG x3000
;Instructions
LEA R0,PROMPT			;OUTPUT PROMPT
PUTS

LEA R0,NEWLINE			;OUTPUT NEWLINE
PUTS

LD R6,BIN_TO_DEC_3200	;CALLS BINARY TO DEC STORED IN R2
JSRR R6

LEA R0,NEWLINE			;OUTPUT NEWLINE
PUTS

LD R6,TWO_COMP_3400		;PRINT BINARY OUT FROM DECIMAL STORED IN R2
JSRR R6

HALT
;Data
BIN_TO_DEC_3200 .FILL	x3200
TWO_COMP_3400	.FILL	x3400
PROMPT			.STRINGZ "ENTER 16 (1 or 0) WITH A 'b' IN FRONT:"
NEWLINE			.STRINGZ "\n"
;===================================================
;Subroutine: BIN_TO_DEC_3200
;Input(R0): 
;POSTCONDITIONS:USES LEFT SHIFTING AND TWO COMP TO MOVE 1 AND ZEROS INTO THE RIGHT PLACE
;RETURN VALUE: DECIMAL VALUE STORED INTO R2
;===================================================
.ORIG x3200

;Instructions
ST R7, BACKUP_R7_3200
LD R1,COUNTER

CHECKB
	GETC				;IF NOT 'b' PRINT ERROR AND REPEAT TILL YOU GET IT
	LD R4,b_CHECKER
	ADD R3,R4,R0
	BRnp NOTB
	BRz IS_B

NOTB
	LEA R0,b_ERROR		;ERROR LOOP IF NOT 'b'
	PUTS

	LEA R0,SUB_NEWLINE
	PUTS

	GETC			
	LD R4,b_CHECKER
	ADD R3,R4,R0
	BRnp NOTB
	BRz IS_B

IS_B					;PRINT OUT B
	OUT

START_LOOP
	GETC
	LD R4,SPACE_CHECK
	ADD R3,R4,R0
	BRz START_LOOP
	ADD R2,R2,R2		;SHIFT LEFT
	
	IF
		LD R4,ASCII_ZERO	;IF CURR IS 1 then ADD 1 TO R2 DECREMENT OTHERWISE
		ADD R3,R0,R4
		BRz SKIP
		LD R4,ASCII_ONE
		ADD R3,R0,R4
		BRz COMP
		BRnp BIN_ERROR		;IF NOT 1 OR 0 THEN GO TO ERROR LOOP
	
	BIN_ERROR
		LEA R0,SUB_NEWLINE
		PUTS
	
		LEA R0,BIN_ERROR_OUT ;PRINT ERROR
		PUTS
		
		LEA R0,SUB_NEWLINE
		PUTS
		
		GETC
		LD R4,SPACE_CHECK
		ADD R3,R4,R0
		BRz START_LOOP
		ADD R2,R2,R2		;SHIFT LEFT
	
	IF2
		LD R4,ASCII_ZERO	;IF CURR IS 1 then ADD 1 TO R2 INCREMENT OTHERWISE
		ADD R3,R0,R4
		BRz SKIP
		LD R4,ASCII_ONE
		ADD R3,R0,R4
		BRz COMP
		BRnp BIN_ERROR
	
	COMP
		ADD R2,R2,#1
	
	SKIP
		OUT
		ADD R1,R1,#-1
		BRp START_LOOP

LD R7, BACKUP_R7_3200
RET
;Data
BACKUP_R7_3200			.BLKW #1
ASCII_ZERO		.FILL	#-48
ASCII_ONE		.FILL	#-49
COUNTER			.FILL	#16
b_CHECKER		.FILL	#-98
b_ERROR			.STRINGZ "NOT 'b', PLS ENTER 'b' FOLLOWED BY 16(0 or 1):"
SUB_NEWLINE		.STRINGZ "\n"
SPACE_CHECK		.FILL	#-32
BIN_ERROR_OUT	.STRINGZ "PLS ENTER A 0 OR 1:"
;===================================================
;				END SUB_ROUTINE
;===================================================

;===================================================
;Subroutine: TWO_COMP_3400
;Input(R2): VALUE CONVERTED AND PRINTED IN BINARY
;POSTCONDITIONS: USES 2COMP and LEFT SHIFT TO PRINT OUT BINARY REPRESENTATION OF NUM IN R1
;RETURN VALUE: NO RETURN JUST PRINTS IT
;===================================================
.ORIG x3400	
ST R0, BACKUP_R0_3400
ST R2, BACKUP_R2_3400
ST R3, BACKUP_R3_3400
ST R5, BACKUP_R5_3400
ST R7, BACKUP_R7_3400

;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
LD R5, BIT_COUNTER							;COUNTS THE 16 NUMBERS
LD R3, BIT_SECTION_COUNTER					;COUNTS EACH SECTION (4 per 4 SECTIONS)


SUB_LOOP
		SUB_IF
			ADD R2,R2,#0						;CHECK NUMBER(NEGATIVE = 1 or POSITIVE/ZERO = 0)
			BRn OUT_ONE
			BRzp OUT_ZERO
	
			OUT_ONE
				LEA R0,ONE_BIT
				PUTS							;PRINT FROM ADDRESS LOADED INTO R0
				ADD R2,R2,#0					;JUST TO SKIP THE ZERO LOOP
				BRn NEXT_STEP
			
			OUT_ZERO
				LEA R0,ZERO_BIT						
				PUTS							;PRINT FROM THE ZERO LOADED INTO R0
	
	NEXT_STEP					
		ADD R2,R2,R2							;ADDING 2COMPS together (LEFT SHIFTS THE NUMBERS TILL THE 16BINARY IS ALL 0)
		ADD R5,R5,#-1							;DECREMENT COUNTERS
		ADD R3,R3,#-1
	
		SUB_IF2
			ADD R5,R5,#0						;MAKE SURE TO NOT PUT IT IF IT HAS REACHED 16 
			BRz SKIP_SPACE
			ADD R3,R3,#0						;IF SECTION HAS REACHED 4 NUMS ADD A SPACE...NO SPACE OTHERWISE 
			BRz INSERT_SPACE					
			BRp SKIP_SPACE
		
		INSERT_SPACE
			LEA R0,SPACE
			PUTS								;INSERT SPACE AND OUTPUT
			LD R3, BIT_SECTION_COUNTER			;RESETS SECTION COUNTER
			END_SUB_IF
		
		SKIP_SPACE
			END_SUB_IF2
			ADD R5,R5,#0						;ONCE YOU HAVE 16 NUMBERS STOP
			BRp SUB_LOOP
END_LOOP

LEA	R0,NEW_LINE
PUTS

LD R0,BACKUP_R0_3400
LD R2,BACKUP_R2_3400
LD R3,BACKUP_R3_3400
LD R5,BACKUP_R5_3400
LD R7,BACKUP_R7_3400

RET
;---------------	
;Data
;---------------
BIT_SECTION_COUNTER		.FILL #4
BIT_COUNTER				.FILL #16
NEW_LINE				.STRINGZ "\n"
SPACE					.STRINGZ " "
ZERO_BIT				.STRINGZ "0"
ONE_BIT					.STRINGZ "1"
BACKUP_R0_3400			.BLKW #1
BACKUP_R2_3400			.BLKW #1
BACKUP_R3_3400			.BLKW #1
BACKUP_R5_3400			.BLKW #1
BACKUP_R7_3400			.BLKW #1
;===================================================
;				END SUB_ROUTINE
;===================================================
.END
