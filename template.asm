;OnikenX

;This code is under the GPL v3.0 license, a copy of the license will come with this program if not go to 
; https://www.gnu.org/licenses/gpl-z3.0.en.html





.8086
.model small
.stack 2048

dseg segment para public 'data'
 ;variables

 ;end of variables
dseg ends

cseg segment para public 'code'
 assume cs:cseg, ds:dseg, ss:stack
 Main proc
 mov ax, dseg
 mov ds, ax
 ;code

end:
 ;end of code
 mov ah,4CH
 int 21H
Main endp

cseg ends
end main
