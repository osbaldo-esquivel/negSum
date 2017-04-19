TITLE Negative Summation(Proj03.asm)

;// Author: Osbaldo Esquivel
;// Date: 24APR2015
;// Description: The user will be able to enter any number of negative numbers and upon
;// entering a positive number, the sum of the negative numbers will be shown to the user.

Include Irvine32.inc

MIN = -101
MAX = 0

.data
intro	BYTE		"                       Negative Summation", 0
intro_1	BYTE		"                               by", 0
intro_2	BYTE		"                        Osbaldo Esquivel", 0
intro_3	BYTE		"================================================================", 0
instr_1	BYTE		"This program will ask you to enter any number of negative values", 0
instr_2	BYTE		"and it will show you their sum. You can stop entering numbers", 0
instr_3	BYTE		"by entering a positive number and pressing <Enter>.", 0
askName	BYTE		"User, please enter your name and press <Enter>: ", 0
hiUser	BYTE		", I hope you are doing well. Let's math!", 0
prompt	BYTE		"Please enter a value from -100 to -1: ", 0
noNeg	BYTE		"You didn't enter a negative value. Bye!", 0
outro	BYTE		"I hope you enjoyed this math demonstration, ", 0
valMsg	BYTE		"Please enter a valid number (-100 to -1). ", 0
sumMsg	BYTE		"The sum of the values is ", 0
avgMsg	BYTE		"The average of the values is ", 0
outro_1	BYTE		".", 0
userName	BYTE		21 DUP(0)
askValue	SDWORD ?
sum		SDWORD	0
accumVal	SDWORD	0
sumAvg	SDWORD	0

.code
main PROC

;// set background color and font color
setColor:
mov	eax, blue + (gray * 16)
call SetTextColor
call	Clrscr

;// introduce the program to the user and display programmer's name
introduction:
mov	edx, OFFSET intro
call WriteString
call Crlf

mov	edx, OFFSET intro_1
call WriteString
call Crlf

mov	edx, OFFSET intro_2
call WriteString
call Crlf

mov	edx, OFFSET intro_3
call	WriteString
call Crlf

;// provide instructions to user
instructions:
mov	edx, OFFSET instr_1
call WriteString
call Crlf

mov edx, OFFSET instr_2
call WriteString
call Crlf

mov	edx, OFFSET instr_3
call WriteString
call Crlf

;// ask user for name and greet user
userInfo:
call Crlf
mov	edx, OFFSET askName
call WriteString
mov	edx, OFFSET userName
mov	ecx, SIZEOF userName
call ReadString
call Crlf

call WriteString
mov	edx, OFFSET hiUser
call WriteString
call Crlf

;// ask user to enter a negative value
userValue:
call Crlf
mov	edx, OFFSET prompt
call WriteString
call ReadInt
mov	askValue, eax
call Crlf

;// check if value entered is negative
isNeg:
cmp askValue, MIN
jle validate
cmp askValue, MAX
jg  checkAccum

;// sum the negative values and increment accumulator
sumNum:
mov eax, sum
mov ebx, askValue
add eax, ebx
mov sum, eax
inc accumVal
jmp userValue

;// if value is positive, check accumulator value
checkAccum:
cmp accumVal, 0
je  specialMsg

;// display sum to user
sumVals:
mov	edx, OFFSET sumMsg
call WriteString
mov	eax, sum
call WriteInt
call Crlf

;// display average of values to user
average:
mov	eax, sum
cdq
mov	ebx, accumVal
idiv ebx
mov	sumAvg, eax
mov	edx, OFFSET avgMsg
call WriteString
mov	eax, sumAvg
call WriteInt
call Crlf
jmp	outroEnd

;// if value is positive and only value, display special message
specialMsg:
mov	edx, OFFSET noNeg
call WriteString
call Crlf
jmp	outroEnd

;// check if value is within range -100 to -1
validate:
mov	edx, OFFSET valMsg
call WriteString
call Crlf
call Crlf
jmp	userValue

;// say goodbye to user
outroEnd:
mov	edx, OFFSET outro
call WriteString
mov	edx, OFFSET userName
call WriteString
mov	edx, OFFSET outro_1
call WriteString
call Crlf

exit
main ENDP
END main
