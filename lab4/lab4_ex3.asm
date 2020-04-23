;=================================================
; Name: Steven Hoang
; Email: Shoan031@ucr.edu
; 
; Lab: lab 4, ex 3
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
LD R0, STOP

	LOOP
	STR R1,R2,#0 ;Store into R2
	ADD R2,R2,#1 ;Next mem loc
	ADD R1,R1,R1 ;ADD VALUE WITH VALUE WHICH REFLECTS HOW 2^n WORKS
	ADD R3,R1,R0 ;Checks if it ran 10 times 
	BRnp LOOP ;CHecks if it hit 2^10 
	
LD R4,CURR_PTR ;R0 is start of array
LDR R2,R4,#6   ;Load (address of array + 6) into R2 
	


HALT
;_____________________________________
;DATA
;_____________________________________
VALUE 		.FILL x1 ;Technically the power???
CURR_PTR 	.FILL ARRAY
STOP		.FILL #-1024 ;Tells me when to stop.
	;REMOTE DATA
	.ORIG x4000
	ARRAY .BLKW #10

.END
