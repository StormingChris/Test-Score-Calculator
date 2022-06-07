; TEST SCORE CALCULATOR
; CIS 11
; PURPOSE:	To recieve 5 test score values and return highest, lowest and avg value in grade letter
; Input: 	5 numerical values (0 - 100)
; Output:	Highest, lowest, and average test score as A, B, C, D, or F
; Authors:	Marlon Jimenez, David Gonzalez, Christopher Diaz

////////// TEST SCORE CALCULATOR \\\\\\\\\\

.ORIG x3000

LEA R0, PROMPT
PUTS
GETC			; get input
OUT			; print input to console

;///////USER INPUTS USING POINTERS////////

AND R0, R0, #0		; CLEAR R0
ADD R0, A, #0		; PUT VALUE IN A
STR R0, R5, #0		; STORE IN i

ADD R0, R5, #0		; R0 = R5 + 0 (ADDR OF I)
STR R0, R5, #-1		; STORE IN POINTER

LDR R0, R5, #-1		; R0 = PTR
LDR R1, R0, #0		; LOAD CONTENTS *PTR
ADD R1, R1, #1		; ADD ONE
STR R1, R0, #0		; STORE RESULT WHERE R0 POINTS

LEA R0, PROMPT
PUTS
GETC
OUT

AND R0, R0, #0		; CLEAR R0
ADD R0, B, #0		; PUT VALUE IN B
STR R0, R5, #0		; STORE IN i
;
ADD R0, R5, #0		; R0 = R5 + 0 (ADDR OF I)
STR R0, R5, #-1		; STORE IN POINTER

LDR R0, R5, #-1		; R0 = PTR
LDR R1, R0, #0		; LOAD CONTENTS *PTR
ADD R1, R1, #1		; ADD ONE
STR R1, R0, #0		; STORE RESULT WHERE R0 POINTS

LEA R0, PROMPT
PUTS
GETC
OUT

AND R0, R0, #0		; CLEAR R0
ADD R0, C, #0		; PUT VALUE IN C
STR R0, R5, #0		; STORE IN i

ADD R0, R5, #0		; R0 = R5 + 0 (ADDR OF I)
STR R0, R5, #-1		; STORE IN POINTER
	
LDR R0, R5, #-1		; R0 = PTR
LDR R1, R0, #0		; LOAD CONTENTS *PTR
ADD R1, R1, #1		; ADD ONE
STR R1, R0, #0		; STORE RESULT WHERE R0 POINTS

LEA R0, PROMPT
PUTS
GETC
OUT

AND R0, R0, #0		; CLEAR R0
ADD R0, D, #0		; PUT VALUE IN D 
STR R0, R5, #0		; STORE IN i

ADD R0, R5, #0		; R0 = R5 + 0 (ADDR OF I)
STR R0, R5, #-1		; STORE IN POINTER

LDR R0, R5, #-1		; R0 = PTR
LDR R1, R0, #0		; LOAD CONTENTS *PTR
ADD R1, R1, #1		; ADD ONE
STR R1, R0, #0		; STORE RESULT WHERE R0 POINTS

LEA R0, PROMPT
PUTS
GETC
OUT

AND R0, R0, #0		; CLEAR R0
ADD R0, F,  #0		; PUT VALUE IN F
STR R0, R5, #0		; STORE IN i

ADD R0, R5, #0		; R0 = R5 + 0 (ADDR OF I)
STR R0, R5, #-1		; STORE IN POINTER

LDR R0, R5, #-1		; R0 = PTR
LDR R1, R0, #0		; LOAD CONTENTS *PTR
ADD R1, R1, #1		; ADD ONE
STR R1, R0, #0		; STORE RESULT WHERE R0 POINTS

JSR COMPARE 		; compare function

HALT

COMPARE
        AND R3, R3, X0      ; CLEAR R3
        NOT R2, R2          ; 1S COMPLEMENT
        ADD R2, R2, X1      ; 2S COMPLEMENT
        ADD R3, R1, R2      ; SUBTRACT 1ST INPUT WITH 2ND INPUT
        BRn NEG             ; WHEN NEGATIVE
            ADD R3, R3, X0  ; COPY RESULT TO R3
        BRp POS             ; WHEN POSITIVE
            ADD R3, R3, X0  ; COPY RESULT TO R3
        BRz EQ
            AND R5, R5, X0  ; CLEAR R5
            ADD R5, R5, R1  ; ADD 1ST INPUT TO R5
        RET
    NEG LEA R0, N           ; TRIGGERS WHEN R3 IS NEGATIVE
        PUT
        RET
    POS LEA R0, P           ; TRIGGERS WHEN R3 IS POSITIVE
        PUTS 
        RET
    EQ LEA R0, E	    ; TRIGGERS WHEN R3 IS ZERO
	PUTS
	RET


;add test scores to get sum
			; CLEAR R6?
ADD R6, R2, R1		; TSCORE1 + TSCORE2 = SUM1				
AND R0, R0, #0		; CLEAR R0
ADD R0, R3, R6		; TSCORE 3 + SUM1 = SUM2
AND R1, R1, #0		; CLEAR R1
ADD R1, R4, R0		;TSCORE 4 + SUM2 = SUM3
AND R0, R0, #0		; CLEAR R0	
ADD R0, R5, R1		; TSCORE5 + SUM3 = SUM
AND R5, R5, #0		; CLEAR R5
ADD R5, R0, #0		; R5 = SUM
AND R6, R6, #0		; CLEAR R6
ADD R6, #5		; R6 = 5
;/////Savereg/////

ST R5, SAVEREG5		; SAVE R5
ST R6, SAVEREG6		; Save R6

				

JSR DIV
QUIT2	NOT R3, R3	;IN NEGATIVE AFTER THEY MULTIPLY
	ADD R3, R3, #1

	LD R5, SaveReg5	;RESTORE R5
	LD R6, SaveReg6	;RESTORE R6
	RET		;BACK TO CALLING PROGRAM



;//////DIVISION SUBROUTINE//////
DIV				; X/Y -> SUM/5
	AND R5, R5, #0		; CLEAR R5
	ADD R5, R1, #0		;X INTO R3
	ADD R4, R6, #0		;Y INTO R4
	NOT R4, R4		;INVERT
	ADD R4, R4, #1		;2S COMPLEMENT
	ADD R0, R3, R4		;SUBTRACT X BY Y
	BRn QUIT2		;CHECKS IF Y>X
LOOP	ADD R5, R5, #1		;COUNTER
	ADD R3, R3, R4		;SUBTRACT X BY Y
	BRp LOOP3		;IF POS GO BACK TO LOOP3
	BRz QUIT3		;IF 0 GO TO QUIT3
	ADD R3, R3, R6		;IF NEG ADD THE RESULT + Y
	ADD R5, R5, #-1		;IF NEG ADD THE COUNTER + 1
	BR QUIT3
QUIT3	RET			;BACK TO CALLING PROGRAM



PUSH		ADD R6, R6, #-1
	STR R0, R6, #0
	RET
POP		LDR R0, R6, #0
	ADD R6, R6, #1
	RET
ISEMPTY	LD R0, EMPTY
	ADD R0, R6, R0
	BRz IS
	ADD R0, R0, #0
		RET
IS		AND R0, R0, #0
	ADD R6, R6, #1
	RET
EMPTY	.FILL xC000




ERROR
		LEA R0, ERMS		; LOAD ERMS WHEN INPUT IS INVALID
		PUTS			; SHOW "INVALID INPUT"
		HALT			; IF INPUT IS WRONG, STOP PROGRAM

PROMPT	.STRINGZ  "Please enter test score (0-100):    "
LOWS		.STRINGZ  "The lowest score is:                       "
HIGHS		.STRINGZ  "The highest score is:                      "
AVGS		.STRINGZ  "The average from all the scores is:"


;//////////Conditional statements to determine grade\\\\\\\\\\

; //////pass HIGH through conditionals\\\\\\
; If score >= 90 branch     
LD R0, HIGH   			; load value ‘HIGH’
LD R1, NEG_NINETY   		; load -90
ADD R0, R0, R1   		; add -90 to HIGH
BRn LESS_THAN_A 		; If negative, not >=90
				; else continue
BRp				; if positive
LD R3, LTTR			; Load first element of array
PUTS 				; empty and output to console "A"

LESS_THAN_A			; unfinished branch logic
; if value >=80 and <=89
LD R1, NEG_EIGHTY		; load -80
ADD R1, R1, R0
BRzp				; if result is zero or positive (>=) proceed
LD R2, NEG_EIGHTYNINE		; load -89
BRnz				; if result is negative or zero (<=), conditions met
LD R3, LTTR 			; Load array
ADD R3, R3, #1			; +1 to arrive at second element, letter "B"
PUTS				; outputs "B"

LESS_THAN_B			; unfinished branch logic
	
; if value >= 70 and <=79
LD R1, NEG_SEVENTY		; load -70
ADD 
BRzp				; if result is zero or positive (>=) proceed
LD R2, NEG_SEVENTYNINE 		; load -79
BRnz				; if result is negative or zero (<=), conditions met
LD R3, LTTR 			; Load array
ADD R3, R3, #2			; +2 to arrive at second element, letter "C"
PUTS				; outputs "C"

LESS_THAN_C			; unfinished branch logic

; if value >=60 and <=69
LD R1, NEG_SIXTY		; load -60
ADD …
BRzp				; if result is zero or positive (>=) proceed
LD R2, NEG_SIXTYNINE		; load -69
BRnz				; if result is negative or zero (<=), conditions met
LD R3, LTTR 			; Load array
ADD R3, R3, #3			; +3 to arrive at second element, letter "D"
PUTS				; outputs "D"

LESS_THAN_D		

; if value <=59 branch	
LD R0, HIGH			; load value HIGH
LD R1, NEG_FIFTYNINE 		; load -59
ADD R0, R0, R1			; add -59 to HIGH
BRn F_OR_BELOW			; if result neg, branch 
LD R3, LTTR 			; 
ADD R3, R3, 5			; increment to element 5, Letter "F"
PUTS				; empty Register, output to console letter "F"

;//////////  pass LOW through conditionals \\\\\\\\\\
; If score >= 90 branch     
LD R0, LOW	  		; load value ‘LOW’
LD R1, NEG_NINETY   		; load -90
ADD R0, R0, R1   		; add -90 to LOW
BRn LESS_THAN_A 		; If negative, not >=90
				; else continue
BRp				; if positive
LD R3, LTTR			; Load first element of array
PUTS 				; empty and output to console "A"

LESS_THAN_A
; if value >=80 and <=89
LD R1, NEG_EIGHTY		; load -80
ADD R1, R1, R0
BRzp				; if result is zero or positive (>=) proceed
LD R2, NEG_EIGHTYNINE		; load -89
BRnz				; if result is negative or zero (<=), conditions met
LD R3, LTTR 			; Load array
ADD R3, R3, #1			; +1 to arrive at second element, letter "B"
PUTS				; outputs "B"

LESS_THAN_B			; unfinished branch logic
	
; if value >= 70 and <=79
LD R1, NEG_SEVENTY		; load -70
ADD …
BRzp				; if result is zero or positive (>=) proceed
LD R2, NEG_SEVENTYNINE 		; load -79
BRnz				; if result is negative or zero (<=), conditions met
LD R3, LTTR 			; Load array
ADD R3, R3, #2			; +2 to arrive at second element, letter "C"
PUTS				; outputs "C"

LESS_THAN_C			; unfinished branch logic

; if value >=60 and <=69
LD R1, NEG_SIXTY		; load -60
ADD …
BRzp				; if result is zero or positive (>=) proceed
LD R2, NEG_SIXTYNINE		; load -69
BRnz				; if result is negative or zero (<=), conditions met
LD R3, LTTR 			; Load array
ADD R3, R3, #3			; +3 to arrive at second element, letter "D"
PUTS				; outputs "D"

LESS_THAN_D			; unfinished branch logic

; if value <=59 branch	
LD R0, LOW			; load value HIGH
LD R1, NEG_FIFTYNINE 		; load -59
ADD R0, R0, R1			; add -59 to HIGH
BRn F_OR_BELOW			; if result neg, branch 
LD R3, LTTR 			; 
ADD R3, R3, 5			; increment to element 5, Letter "F"
PUTS				; empty Register, output to console letter "F"

/////////  pass AVG through conditionals \\\\\\\\\\

; If score >= 90 branch     
LD R0, AVG  			; load value ‘AVG’
LD R1, NEG_NINETY   		; load -90
ADD R0, R0, R1   		; add -90 to AVG
BRn LESS_THAN_A 		; If negative, not >=90
				; else continue
BRp				; if positive
LD R3, LTTR			; Load first element of array
PUTS 				; empty and output to console "A"

LESS_THAN_A
; if value >=80 and <=89
LD R1, NEG_EIGHTY		; load -80
ADD R1, R1, R0
BRzp				; if result is zero or positive (>=) proceed
LD R2, NEG_EIGHTYNINE		; load -89
BRnz				; if result is negative or zero (<=), conditions met
LD R3, LTTR 			; Load array
ADD R3, R3, #1			; +1 to arrive at second element, letter "B"
PUTS				; outputs "B"

LESS_THAN_B		
	
; if value >= 70 and <=79
LD R1, NEG_SEVENTY		; load -70
ADD 
BRzp				; if result is zero or positive (>=) proceed
LD R2, NEG_SEVENTYNINE 		; load -79
BRnz				; if result is negative or zero (<=), conditions met
LD R3, LTTR 			; Load array
ADD R3, R3, #2			; +2 to arrive at second element, letter "C"
PUTS				; outputs "C"

LESS_THAN_C		

; if value >=60 and <=69
LD R1, NEG_SIXTY		; load -60
ADD
BRzp				; if result is zero or positive (>=) proceed
LD R2, NEG_SIXTYNINE		; load -69
BRnz				; if result is negative or zero (<=), conditions met
LD R3, LTTR 			; Load array
ADD R3, R3, #3			; +3 to arrive at second element, letter "D"
PUTS				; outputs "D"

LESS_THAN_D	

; if value <=59 branch	
LD R0, HIGH			; load value HIGH
LD R1, NEG_FIFTYNINE 		; load -59
ADD R0, R0, R1			; add -59 to HIGH
BRn F_OR_BELOW			; if result neg, branch 
LD R3, LTTR 			; 
ADD R3, R3, 5			; increment to element 5, Letter "F"
PUTS				; empty Register, output to console letter "F"





;////////// Labels used to test inputs against \\\\\\\\\\
;The negative numbers are added to a value to determine if positive
;if neg result when added, then condition (grade letter) not met

NEG_FIFTYNINE 	.FILL #-59	; -59, needed to determine branching
NEG_SIXTY	.FILL #-60	; -60
NEG_SIXTYNINE	.FILL #-69	; -69
NEG_SEVENTY	.FILL #-70	; -70
NEG_SEVENTYNINE	.FILL #-79	; -79
NEG_EIGHTY	.FILL #-80	; -80
NEG_EIGHTYNINE	.FILL #-89	; -89
NEG_NINETY 	.FILL #-90	; -90  

;////////// Array for each letter grade \\\\\\\\\\
LTTR		.STRINGZ "A"			
		.STRINGZ "B"
		.STRINGZ "C"
		.STRINGZ "D"
		.STRINGZ "F"


A		.FILL x3120		; Value storage for 5 values
B		.FILL x3121
C		.FILL x3122
D		.FILL x3123
E		.FILL x3124
SAVEREG5	.FILL x0			
SAVEREG6	.FILL x0
HIGH		.FILL x3125		; storage for Highest Value
LOW		.FILL x3126		; Storage for Lowest Value
AVG 		.FILL x3127		; storage for AVG

ERMS	.STRINGZ "INVALID INPUT"	;invalid input error message

.END