
section .text
org 100h

main:
  mov ah, 9
  mov dx, nazwa 
  int 21h 

  mov dx, nowa_linia 
  int 21h 

  mov ax, 4C00h
  int 21h

section .data
  prompt db  "Moje imie i nazwisko to: $\"
  nazwa db 80, 65, 87, 69, 76, 32, 83, 85, 67, 72, 84, 65, 13, 10, '$' ;32 to znaj spacji
  nowa_linia db 80, 65, 87, 69, 76, 13, 10, 83, 85, 67, 72, 84, 65, '$' ;13 10 to znaki nowej lini
