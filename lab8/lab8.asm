;=================================================
; Name: Steven Hoang
; Email: shoan031@ucr.edu
; 
; Lab: lab 8, ex 1 & 2
; Lab section: 24
; TA: David Feng
; 
;=================================================

; test harness
					.orig x3000
				 
			LD R6,SUB_PRINT_OPCODE_TABLE 
			JSRR R6
				 
			LEA R0,NEWLINE
			PUTS
				 
			LD R6,SUB_FIND_OPCODE
			JSRR R6
				 
					halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
NEWLINE						.STRINGZ "\n"
SUB_FIND_OPCODE				.FILL	x3600
SUB_PRINT_OPCODE_TABLE		.FILL	x3200
ARR_NUM						.FILL	x4000
ARR_						.FILL	x4100
;===============================================================================================


; subroutines:
;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE_TABLE
; Parameters: None
; Postcondition: The subroutine has printed out a list of every LC3 instruction
;				 and corresponding opcode in the following format:
;					ADD = 0001
;					AND = 0101
;					BR = 0000
;					…
; Return Value: None
;-----------------------------------------------------------------------------------------------
					.orig x3200
					
					ST R0,BACKUP_R0_3200
					ST R1,BACKUP_R1_3200
					ST R3,BACKUP_R3_3200
					ST R4,BACKUP_R4_3200
					ST R7,BACKUP_R7_3200
					
					LD R1,instructions_po_ptr
					LD R4,opcodes_po_ptr
					
					START_3200
					
					PRINT_WORD_3200
						LDR R0,R1,#0			;LOAD LETTERS
						OUT
						ADD R1,R1,#1			;NEXT SPACE
						LDR R0,R1,#0
						BRnp PRINT_WORD_3200	;AS LONG AS NOT ZERO KEEP PRINTING
					
					PRINT_NUM_3200
						LD R0, SPACE_3200
						OUT
						LD R0, EQUAL_3200
						OUT
						LD R0, SPACE_3200
						OUT
						
						LDR R2,R4,#0				;LOAD OPCODE NUMBER INTO R2 FROM LOC AT R4
						LD R6, SUB_PRINT_OPCODE		;ASSN 3 DECIMAL TO BINARY
						JSRR R6
						ADD R4,R4,#1				;INCRE
						
					CHECK_DONE
						ADD R1,R1,#1				 ;INCRE TO NEXT WORD IN WORD ARR
						LDR R0,R1,#0				
						LD R3,SENTINEL_3200
						ADD R0,R0,R3				;CHECK IS END WHICH IS -1
						BRnp START_3200				;IF NOT RESTART PROCESS
						BRz END_3200
						
					END_3200
						LD R0,BACKUP_R0_3200
						LD R1,BACKUP_R1_3200
						LD R3,BACKUP_R3_3200
						LD R4,BACKUP_R4_3200
						LD R7,BACKUP_R7_3200
					ret
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODE_TABLE local data
BACKUP_R0_3200		.BLKW #1
BACKUP_R1_3200		.BLKW #1
BACKUP_R3_3200		.BLKW #1
BACKUP_R4_3200		.BLKW #1
BACKUP_R7_3200		.BLKW #1
SENTINEL_3200		.FILL #1	
SPACE_3200			.STRINGZ " "
EQUAL_3200			.STRINGZ "="
NEWLINE_3200		.STRINGZ "\n"
SUB_PRINT_OPCODE	.FILL x3400
opcodes_po_ptr		.fill x4000				; local pointer to remote table of opcodes
instructions_po_ptr	.fill x4100				; local pointer to remote table of instructions


;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE
; Parameters: R2 containing a 4-bit op-code in the 4 LSBs of the register
; Postcondition: The subroutine has printed out just the 4 bits as 4 ascii 1s and 0s
;				 The output is NOT newline terminated.
; Return Value: None
;-----------------------------------------------------------------------------------------------
					.orig x3400
		ST R0,BACKUP_R0_3400
		ST R1,BACKUP_R1_3400
		ST R2,BACKUP_R2_3400
		ST R3,BACKUP_R3_3400
		ST R7,BACKUP_R7_3400
		
LD R1,INCR_COUNTER
	KEEP_GOING
	ADD R2,R2,R2
	ADD R1,R1,#-1
	BRp KEEP_GOING
	BRz STOP

STOP

LD R1, BIT_COUNTER							;COUNTS THE 16 NUMBERS
LD R3, BIT_SECTION_COUNTER					;COUNTS EACH SECTION (4 per 4 SECTIONS)

LOOP
		IF
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
		ADD R1,R1,#-1							;DECREMENT COUNTERS
		ADD R3,R3,#-1
	
		IF2
			ADD R1,R1,#0						;MAKE SURE TO NOT PUT IT IF IT HAS REACHED 16 
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
			ADD R1,R1,#0						;ONCE YOU HAVE 16 NUMBERS STOP
			BRp LOOP
END_LOOP

LEA	R0,NEW_LINE
PUTS
		
		LD R0,BACKUP_R0_3400
		LD R1,BACKUP_R1_3400
		LD R2,BACKUP_R2_3400
		LD R3,BACKUP_R3_3400
		LD R7,BACKUP_R7_3400
					ret
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODE local data
BACKUP_R0_3400			.BLKW #1
BACKUP_R1_3400			.BLKW #1
BACKUP_R2_3400			.BLKW #1
BACKUP_R3_3400			.BLKW #1
BACKUP_R7_3400			.BLKW #1
Value_ptr	.FILL xB270	; The address where value to be displayed is stored
INCR_COUNTER			.FILL #12
BIT_SECTION_COUNTER		.FILL #4
BIT_COUNTER				.FILL #4
NEW_LINE				.STRINGZ "\n"
SPACE					.STRINGZ " "
ZERO_BIT				.STRINGZ "0"
ONE_BIT					.STRINGZ "1"

.ORIG xB270					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.


;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_FIND_OPCODE
; Parameters: None
; Postcondition: The subroutine has invoked the SUB_GET_STRING subroutine and stored a string
; 				as local data; it has searched the AL instruction list for that string, and reported
;				either the instruction/opcode pair, OR "Invalid instruction"
; Return Value: None
;-----------------------------------------------------------------------------------------------
					.orig x3600
				ST R7,BACKUP_R7_3600
				
				LEA R2,INPUT_ARR
				
				LD R6, SUB_GET_STRING
				JSRR R6
				
				AND R6,R6,#0						;THIS WILL HELP U LATER IN TO FIND OPCODE
				
				LD R1,instructions_fo_ptr
				
				START_3600
					
					FIND_WORD_3600
						LDR R0,R1,#0				;LD CHECK ARR
						LDR R4,R2,#0				;LD INPUT ARR
						NOT R4,R4
						ADD R4,R4,#1
						ADD R5,R4,R0				;CHECK IF SAME LETTER
						BRnp NEXT_WORD
						BRz CONT
						
						NEXT_WORD
							ADD R1,R1,#1			;KEEPS GOINT TO NEXT WORD OR 0
							LDR R0,R1,#0
							BRnp NEXT_WORD
							BRz FIND_WORD_RESET
						
						FIND_WORD_RESET
							LDR R2,R1,#1			;CHECKS IF ANOTHER 0
							BRz NOT_FOUND			;IF SO PRINT ERROR AND END
							LEA R2,INPUT_ARR		;RELOAD R2 WITH WORD TO CHECK AGAIN
							ADD R6,R6,#1			;NEXT WORD = NECT OPCODE
							ADD R1,R1,#1			;ICRE WORD ARR
							BRnzp FIND_WORD_3600	;REPEAT PROCEsS
							
						CONT
							ADD R1,R1,#1			;IF SAME LETTER YOU INCRE
							ADD R2,R2,#1			;INCRE INPUT WORD
							LDR R4,R2,#0			;RELOAD NEXT LETTER BUT IF -1 MEANS YOU FOUND WORD
							BRn DONE_CHECK
							LDR R0,R1,#0		    ;RELOAD WORD ARR(IF NOT ZERO THEN NOT SPECIAL CASE)
							BRnp FIND_WORD_3600
							BRz FIND_WORD_RESET
						
						DONE_CHECK
							LDR R0,R1,#0
							BRnp NEXT_WORD
							BRz DONE
						
						DONE
							GO_BACK					;BRINGS TO BIGINNING OF WORD U JUST FOUND
							ADD R1,R1,#-1
							LDR R0,R1,#0
							BRnp GO_BACK
						
						PRINT_3600					;PRINTS THE WORD OUT
							ADD R1,R1,#1
							LDR R0,R1,#0
							BRz PRINT_NUM_3600		;ONCE AT 0 MEANS WORD PRINTED
							OUT
							BRnp PRINT_3600
						
						PRINT_NUM_3600
							LD R0, SPACE_3600
							OUT
							LD R0, EQUAL_3600
							OUT
							LD R0, SPACE_3600
							OUT
						
						LD R1,opcodes_fo_ptr
						
						FIND_OPCODE_3600
							ADD R1,R1,#1			;INCRE NUM ARR PER WORDS U PASSED WITH R6
							ADD R6,R6,#-1
							BRnp FIND_OPCODE_3600
							BRz PRINT_NUM_CONT_3600
						
						PRINT_NUM_CONT_3600
							LDR R2,R1,#0					;LOAD THE NUMBER
							LD R6,SUB_PRINT_OPCODE_3600		;PRINT NUMBER
							JSRR R6
						
						BRnzp END_3600
						
					NOT_FOUND
						LEA R0,ERROR_MSG					;ERROR MESSAGE
						PUTS
						
						END_3600
				 
				 LD R7,BACKUP_R7_3600
				 
				 
				 ret
;-----------------------------------------------------------------------------------------------
; SUB_FIND_OPCODE local data
BACKUP_R7_3600			.BLKW #1
ERROR_MSG				.STRINGZ "Invalid Instruction"
SPACE_3600				.STRINGZ " "
EQUAL_3600				.STRINGZ "="
INPUT_ARR				.BLKW #20
SUB_GET_STRING			.FILL x3800
SUB_PRINT_OPCODE_3600	.FILL x3400
opcodes_fo_ptr			.fill x4000
instructions_fo_ptr		.fill x4100



;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameters: R2 - the address to which the null-terminated string will be stored.
; Postcondition: The subroutine has prompted the user to enter a short string, terminated 
; 				by [ENTER]. That string has been stored as a null-terminated character array 
; 				at the address in R2
; Return Value: None (the address in R2 does not need to be preserved)
;-----------------------------------------------------------------------------------------------
					.orig x3800
					
				ST R0,BACKUP_R0_3800
				ST R1,BACKUP_R1_3800
				ST R2,BACKUP_R2_3800
				ST R2,BACKUP_R3_3800
				ST R4,BACKUP_R4_3800
				ST R7,BACKUP_R7_3800
					
				LD R1,ENTER_SENTINEL
					
				 LEA R0,MESG_3800
				 PUTS
				 
				 INPUT_LOOP
					 GETC
					 OUT
					 STR R0,R2,#0
					 ADD R3,R0,R1				;CHECKS FOR SENTINEL [ENTER]
					 BRnp INCR
					 BRz  STOP_INPUT
				 
				 INCR
					 ADD R2,R2,#1				;INCRE AND STORE INPUTsimplsim
					 BRnzp INPUT_LOOP
				 
				 STOP_INPUT
					 LD R1,NEG_SENTINAL
					 STR R1,R2,#0
				 
				 LD R0,BACKUP_R0_3800
				 LD R1,BACKUP_R1_3800
				 LD R2,BACKUP_R2_3800
				 LD R2,BACKUP_R3_3800
				 LD R4,BACKUP_R4_3800
				 LD R7,BACKUP_R7_3800
				 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_GET_STRING local data
BACKUP_R0_3800			.BLKW #1
BACKUP_R1_3800			.BLKW #1
BACKUP_R2_3800			.BLKW #1
BACKUP_R3_3800			.BLKW #1
BACKUP_R4_3800			.BLKW #1
BACKUP_R7_3800			.BLKW #1
NEG_SENTINAL			.FILL #-1
ENTER_SENTINEL			.FILL #-10
MESG_3800				.STRINGZ "WHAT DO U WANNA FIND: "
NEWLINE_3800			.STRINGZ "\n"


;===============================================================================================


;-----------------------------------------------------------------------------------------------
; REMOTE DATA
					.ORIG x4000			; list opcodes as numbers from #0 through #15, e.g. .fill #12 or .fill xC
; opcodes
	.FILL #1
	.FILL #5
	.FILL #0
 	.FILL #12
	.FILL #4
	.FILL #4
	.FILL #2
 	.FILL #10
	.FILL #6
	.FILL #14
	.FILL #9
	.FILL #12
	.FILL #8
 	.FILL #3
	.FILL #11
	.FILL #7
	.FILL #15
	.FILL #13

					.ORIG x4100			; list AL instructions as null-terminated character strings, e.g. .stringz "JMP"
								 		; - be sure to follow same order in opcode & instruction arrays!
; instructions	
	ADD_		.STRINGZ "ADD"
	AND_ 		.STRINGZ "AND"
	BR_ 		.STRINGZ "BR"
	JMP_		.STRINGZ "JMP"
	JSR_ 		.STRINGZ "JSR"
	JSRR_		.STRINGZ "JSRR"
	LD_ 		.STRINGZ "LD"
	LDI_		.STRINGZ "LDI"
	LDR_		.STRINGZ "LDR"
	LEA_		.STRINGZ "LEA"
	NOT_		.STRINGZ "NOT"
	RET_		.STRINGZ "RET"
	RTI_		.STRINGZ "RTI"
	ST_			.STRINGZ "ST"
	STI_		.STRINGZ "STI"
	STR_		.STRINGZ "STR"
	TRAP_		.STRINGZ "TRAP"
	RESERVED 	.STRINGZ "RESERVED"
	END			.FILL	#-1
;===============================================================================================
