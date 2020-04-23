;=================================================
; Name: Steven Hoang
; Email: Shoan031@ucr.edu
; 
; Lab: lab 4, ex 2
; Lab section: 24
; TA: David Feng
; 
;=================================================
.ORIG x3000
;_____________________________________
;INSTRUCTIONS
;_____________________________________
;USE R1 as the value to put in the array at loc in R2
LD R1, VALUE
LD R2, CURR_PTR
	
	LOOP
	STR R1,R2,#0 ;Store into R2
	ADD R2,R2,#1 ;Next mem loc
	ADD R1,R1,#1 ;Next val
	ADD R3,R1,#-10 ;Checks if it ran 10 times 
	BRnp LOOP ; 
	
LD R0,CURR_PTR ;R0 is start of array
LDR R2,R0,#6   ;Load (address of array + 6) into R2 

;RESTART PROCESS TO PRINT OUT WHILE CONVERTING ASCII
;NOTE: would use R2 as mem loc tracker but idk if we still need it to hold the seventh item in the array...:/
LD R1, CURR_PTR
LD R4, ASCII_NUM

PRINT_LOOP
		LDR R0,R1,#0 ;Loads number from R1 ADDRESS to R0
		ADD R3,R0,#0 ;USES THIS TO CHECK ITEMS LATER
		ADD R0,R0,R4 ;ASCII CONVERSION
		OUT
		ADD R1,R1,#1 ;INCREMENT TO NEXT ADDRESS
		ADD R3,R3,#-9 ;will stop once number gets to 9
BRnp PRINT_LOOP

HALT
;_____________________________________
;DATA
;_____________________________________
VALUE 		.FILL #0
CURR_PTR 	.FILL ARRAY
ASCII_NUM	.FILL #48 ;THATS HOW FAR IT IS IN ASCII
	;REMOTE DATA
	.ORIG x4000
	ARRAY .BLKW #10

.END
