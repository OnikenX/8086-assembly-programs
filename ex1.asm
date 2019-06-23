;OnikenX

;This code is under the GPL v3.0 license, a copy of the license will come with this program if not go to 
; https://www.gnu.org/licenses/gpl-z3.0.en.html

;This program takes a set of numbers in a Vector1 and tells 
;how many are divisible by the vector2 and gives those results
;in the Vector3. There is the need to insert the number of dividends
;and divisors in the respective variables




.8086
.model small
.stack 2048

dseg segment para public 'data'
 ;variables

 dividends db 6
 divisors  db 6
 Vector1   db 15,16,9,12,8,25
 Vector2   db 1,4,2,5,3,6
 Vector3   db 6 dup (0); replace 6 with the number of dividends
 ;end of viriables
dseg ends

cseg segment para public 'code'
 assume cs:cseg, ds:dseg, ss:stack
 Main proc
 mov ax, dseg
 mov ds, ax
 ;codigo
 
 xor si,si
 xor dx,dx
 xor di, di

;the calculation hapens here
calc:
  xor ax, ax
  xor bx, bx  
  ;for a division it will divide the dividend wich is dx:ax in case of the divisor is 16bits, ax if it is 8 bits
  mov al, Vector1[si]
  mov bl, Vector2[di]
  ;the div instruction will recieve as argument the divisor only
  div bl; the division will put the quotient in ax in case of 16bits divisor, al in case of 8bits divisor
  cmp ah, 0; the rest of the division stays in ah if the divider is 8bits, if it is 16bits the rest will be in dx
  je incnum
  jmp continue

;this function increments the number in the Vector3
incnum:
  
  mov bl, Vector3[si]
  inc bl
  mov Vector3[si],bl
  

continue:
 xor bx, bx
 mov bl, dividends
 sub bl, 1
 cmp di, bx
 je change
 inc di
 jmp calc


change:
 xor bx, bx
 mov bl, divisores
 sub bl, 1
 cmp si, bx
 je end
 inc si
 xor di,di
 jmp calc
end:
 ;fim do codiogo
 mov ah,4CH
 int 21H
Main endp

cseg ends
end main
