;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Steven Hoang
; Email: shoan031@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 24
; TA: David Feng
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
LD R2, BIT_COUNTER							;COUNTS THE 16 NUMBERS
LD R3, BIT_SECTION_COUNTER					;COUNTS EACH SECTION (4 per 4 SECTIONS)

LOOP
		IF
		ADD R1,R1,#0						;CHECK NUMBER(NEGATIVE = 1 or POSITIVE/ZERO = 0)
		BRn OUT_ONE
		BRzp OUT_ZERO
	
			OUT_ONE
			LEA R0,ONE_BIT
			PUTS							;PRINT FROM ADDRESS LOADED INTO R0
			ADD R1,R1,#0					;JUST TO SKIP THE ZERO LOOP
			BRn NEXT_STEP
			
			OUT_ZERO
			LEA R0,ZERO_BIT						
			PUTS							;PRINT FROM THE ZERO LOADED INTO R0
	
	NEXT_STEP					
	ADD R1,R1,R1							;ADDING 2COMPS together 
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
		BRp LOOP
END_LOOP

LEA	R0,NEW_LINE
PUTS
		
HALT
;---------------	
;Data
;---------------
Value_ptr	.FILL xB270	; The address where value to be displayed is stored
BIT_SECTION_COUNTER		.FILL #4
BIT_COUNTER				.FILL #16
NEW_LINE				.STRINGZ "\n"
SPACE					.STRINGZ " "
ZERO_BIT				.STRINGZ "0"
ONE_BIT					.STRINGZ "1"

.ORIG xB270					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
