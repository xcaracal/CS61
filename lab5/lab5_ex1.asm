;=================================================
; Name: Steven Hoang
; Email: Shoan031@ucr.edu
; 
; Lab: lab 5, ex 1
; Lab section: 24
; TA: David Feng
; 
;=================================================
;=================================================
;Main:
;	Prints out first 10 powers of 2
;=================================================
.ORIG x3000
;INSTRUCTIONS

LD R1, VALUE
LD R2, CURR_PTR
LD R0, STOP

	LOOP
	STR R1,R2,#0 ;Store into R2
	ADD R2,R2,#1 ;Next mem loc
	ADD R1,R1,R1 ;ADD VALUE WITH VALUE WHICH REFLECTS HOW 2^n WORKS
	ADD R3,R1,R0 ;Checks if it ran 10 times 
	BRnp LOOP ;Checks if it hit 2^10 
	
LD R1, CURR_PTR
LD R2, PRINT_STOP
LD R6, TWO_COMP_3200_PTR
PRINT_LOOP
		LDR R5,R1,#0 ;Loads number from R1 ADDRESS to R0
		ADD R3,R5,#0 ;USES THIS TO CHECK ITEMS LATER
		JSRR R6
		ADD R1,R1,#1 ;INCREMENT TO NEXT ADDRESS
		ADD R3,R3,R2 ;will stop once number gets to 512
BRnp PRINT_LOOP
HALT
;_____________________________________
;DATA
;_____________________________________
VALUE 		.FILL x1 ;Technically the power???
CURR_PTR 	.FILL ARRAY
STOP		.FILL #-1024 ;Tells me when to stop.
PRINT_STOP	.FILL #-512  ;Stop for print
TWO_COMP_3200_PTR .FILL x3200
NUM .FILL #2
	;REMOTE DATA
	.ORIG x4000
	ARRAY .BLKW #10
;===================================================
;Subroutine: TWO_COMP_3200
;Input(R0): VALUE CONVERTED AND PRINTED IN BINARY
;POSTCONDITIONS: USES 2COMP and LEFT SHIFT TO PRINT OUT BINARY REPRESENTATION OF NUM IN R1
;RETURN VALUE: NO RETURN JUST PRINTS IT
;===================================================
.ORIG x3200	
ST R0, BACKUP_R0_3200
ST R2, BACKUP_R2_3200
ST R3, BACKUP_R3_3200
ST R5, BACKUP_R5_3200
ST R7, BACKUP_R7_3200

;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
LD R2, BIT_COUNTER							;COUNTS THE 16 NUMBERS
LD R3, BIT_SECTION_COUNTER					;COUNTS EACH SECTION (4 per 4 SECTIONS)


SUB_LOOP
		IF
		ADD R5,R5,#0						;CHECK NUMBER(NEGATIVE = 1 or POSITIVE/ZERO = 0)
		BRn OUT_ONE
		BRzp OUT_ZERO
	
			OUT_ONE
			LEA R0,ONE_BIT
			PUTS							;PRINT FROM ADDRESS LOADED INTO R0
			ADD R5,R5,#0					;JUST TO SKIP THE ZERO LOOP
			BRn NEXT_STEP
			
			OUT_ZERO
			LEA R0,ZERO_BIT						
			PUTS							;PRINT FROM THE ZERO LOADED INTO R0
	
	NEXT_STEP					
	ADD R5,R5,R5							;ADDING 2COMPS together (LEFT SHIFTS THE NUMBERS TILL THE 16BINARY IS ALL 0)
	ADD R2,R2,#-1							;DECREMENT COUNTERS
	ADD R3,R3,#-1
	
		IF2
		ADD R2,R2,#0						;MAKE SURE TO NOT PUT IT IF IT HAS REACHED 16 
		BRz SKIP_SPACE
		ADD R3,R3,#0						;IF SECTION HAS REACHED 4 NUMS ADD A SPACE...NO SPACE OTHERWISE 
		BRz INSERT_SPACE					
		BRp SKIP_SPACE
		
		INSERT_SPACE
		LEA R0,SPACE
		PUTS								;INSERT SPACE AND OUTPUT
		LD R3, BIT_SECTION_COUNTER			;RESETS SECTION COUNTER
		END_IF
		
		SKIP_SPACE
		END_IF2
		ADD R2,R2,#0						;ONCE YOU HAVE 16 NUMBERS STOP
		BRp SUB_LOOP
END_LOOP

LEA	R0,NEW_LINE
PUTS

LD R0,BACKUP_R0_3200
LD R2,BACKUP_R2_3200
LD R3,BACKUP_R3_3200
LD R5,BACKUP_R5_3200
LD R7,BACKUP_R7_3200

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
BACKUP_R0_3200			.BLKW #1
BACKUP_R2_3200			.BLKW #1
BACKUP_R3_3200			.BLKW #1
BACKUP_R5_3200			.BLKW #1
BACKUP_R7_3200			.BLKW #1
;===================================================
;				END SUB_ROUTINE
;===================================================

.END
