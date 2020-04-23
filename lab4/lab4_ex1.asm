;=================================================
; Name: Steven Hoang
; Email: Shoan031@ucr.edu
; 
; Lab: lab 4, ex 1
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
	


HALT
;_____________________________________
;DATA
;_____________________________________
VALUE 		.FILL #0
CURR_PTR 	.FILL ARRAY
	;REMOTE DATA
	.ORIG x4000
	ARRAY .BLKW #10

.END
