;Working of the water sensor 
;Input: Flame
;Output: Buzzer should ring and the light on the LED must not emit light
	
.include "m328pdef.inc";  contains the definitions specific to the arduino microcontroller

.equ	oVal 	= 71		; using .eq directive to define the outer loop value
.equ	iVal 	= 28168		; using .eq directive to define inner loop value

.cseg ;defining the code segment
.org	0x00

clr	r17					; clearing any previous value in the r17 register
ldi	r16,(1<<PINB0)		; loading 00000001 into mask register
out	DDRB,r16			

CBI DDRC, 1   ; Analog
CBI DDRD, 5   ; Digital


L2:		
SBIC PINC, 1 ; low, SBIC skips when low
rjmp Buzz
rjmp F1


Buzz:	
eor	r17,r16			; toggle PINB0 in led register
out	PORTB,r17			; write led register to PORTB
ldi	r18,oVal			; initialize outer loop count


;delaying loop
;outer loop
outer:	
ldi	r24,LOW(iVal)	; intialize inner loop count in inner loop
ldi	r25,HIGH(iVal)	; intialize inner loop count in inner loop

;inner loop
inner:	
sbiw	r24,1		; decrement the inner loop counters
brne	inner		; branch to iLoop till the inner loop counter is equal to 0

dec	r18				; decrement the outer loop counters
brne	outer		; branch to outer till the outer loop counter is equal to 0

rjmp	L2	

;flame sensor
F1:

SBIC PIND, 5 ; high, SBIC skips when low
rjmp L3
rjmp Buzz


L3:
clr r17
out	PORTB,r17
rjmp L2
	