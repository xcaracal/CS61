;=================================================
; Name: Steven Hoang
; Email:  Shoan031@ucr.edu
; 
; Lab: lab 1, ex 1
; Lab section: 24
; TA: David Feng
; 
;=================================================
.orig x3000
	;----------------
	;Instructions
	;----------------
	AND R1,R1,x0  ;R1<= #0
	LD R2,DEC_12 ;R2<= #12
	LD R3,DEC_6  ;R3<= #6
	
	DO_WHILE_LOOP
		ADD R1,R1,R2 ;R1<=R1+R2
		ADD R3,R3,#-1;R3<=R3-#1
		BRp DO_WHILE_LOOP ;if(R3>0) go back to do while loop
	END_DO_WHILE_LOOP
	
	HALT ;HALT Program exit() 
	
	;----------------
	;Local Data
	;----------------
	DEC_0		.FILL #0 ;put #0 here in mem
	DEC_12      .FILL #12;#12 in mem here
	DEC_6       .FILL #6 ;#6 in mem here
	
.end
