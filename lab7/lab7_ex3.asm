;=================================================
; Name: Steven Hoang
; Email: shoan031@ucr.edu
; 
; Lab: lab 7, ex 3
; Lab section: 24
; TA: David Feng
; 
;=================================================
.ORIG x3000
;instructions
LD R1,NUMBER
LD R2,COUNTER
LD R5,TAKE_OUT_LEADING

LOOP
ADD R1,R1,#0
BRzp LEFT_SHIFT
BRn ADD_ONE

ADD_ONE
	;XOR R1,R1,R5
	NOT R5,R5
	ADD R5,R5,#1
	
	ADD R1,R1,R5
	
	ADD R1,R1,#1

LEFT_SHIFT
	ADD R1,R1,R1
	ADD R2,R2,#-1
	BRnp LOOP

HALT
;data
NUMBER				.FILL x0FFF
COUNTER				.FILL #14
TAKE_OUT_LEADING	.FILL x8000

.END
