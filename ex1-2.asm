;OnikenX

;This code is under the GPL v3.0 license, a copy of the license will come with this program if not go to 
; https://www.gnu.org/licenses/gpl-z3.0.en.html





.8086
.model small
.stack 2048

dseg segment para public 'data'
 ;variables
 testing byte "testing this"
 char byte 2000 dup (?)
 frase byte "holLa mEus puTos$"
 pointh word 80*2 ; aponta para o inicio as maiusculas e a parte de cima do ecra
 pointl word 80*13*2

 ;end of variables
dseg ends

cseg segment para public 'code'
 assume cs:cseg, ds:dseg, ss:stack
 Main proc
 mov ax, dseg
 mov ds, ax
 ;code

 ;meter o segemento da memoria de video no es
 mov ax, 0b800h
 mov es, ax


 jmp comeca


 ;fuctions 
clear proc

 push si
 push bx
 push cx
 push ax

 ;clear screen
 xor si, si
 xor bx, bx
 mov ah, ' '
 mov al, 00000100b
 mov cx, 25*80

rec:
 mov es:[bx], ah
 mov es:[bx+1], al
 inc bx
 inc bx
 loop rec

 pop ax
 pop cx
 pop bx 
 pop si
 
 ret

clear endp

printtest proc
 push di
 push bx
 push si


 mov di, 80*2+80*2*13
 mov bl, 0Fh
 xor si, si
 
printar:
 mov bh, testing[si] 
 mov es:[di], bh
 inc di
 inc di
 inc si
 cmp si, 10
 jne printar
  
 pop si
 pop bx
 pop di

 ret
 
 
printtest endp

printf proc
 push di
 push bx
 push si


 mov di, 80*2
 mov bl, 00000010b
 xor si, si
 
printar:
 mov bh, char[si] 
 mov es:[di], bh
 mov es:[di+1], bl
 inc di
 inc di
 inc si
 cmp si, 2000
 jne printar
  
 pop si
 pop bx
 pop di

 ret
 
 
printf endp


comeca:

;copies every single character in the screen to the array char
 xor di, di
 xor si, si
 mov cx, 2000 
copy:
 mov bl, es:[si]
 mov char[di], bl
 inc si
 inc si
 inc di
 loop copy

call clear
  ;comparar e ver o que fica em cima e em baixo
 xor di, di
 mov ah, 'A'
 mov al, 'Z'
 mov bh, 'a'
 mov bl, 'z'
cmploops:
 cmp di, 2000
 je fim
 mov cl, char[di]
 cmp bh, cl
 jae greater
 cmp bl, cl
 jae prtbaixo
 
 

greater:;ve se é maiuscula
 cmp ah, cl
 jae cmploop
 cmp al, cl
 jae prtacima
 jmp cmploop

prtacima: ;printa na parte de cima do texto (para as maiusculas)
 mov si, pointh
 mov es:[si], cl
 inc si
 inc si
 mov pointh, si
 jmp cmploop

prtbaixo: ;printa na parte de baixo do texto (para as minusculas)
 mov si, pointl
 mov es:[si], cl
 inc si
 inc si
 mov pointl, si
 jmp cmploop

cmploop:
 inc di
 jmp cmploops

;end of code
fim:
 mov ah,4CH
 int 21H
Main endp

cseg ends
end main