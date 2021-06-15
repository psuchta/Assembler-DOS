; nasm -o cw3b.com -f bin cw3b.asm
section .text
  org 100h

start:
  mov ah, 9 ; funkcja wypisujaca ciag znakow na ekran 
  mov dl, naglowek
  int 21h
  xor si, si
  mov dl, '*'

petla:
  mov ah, 7 ; funkcja pobierajaca jeden znak z STDIN
  int 21h
  mov ah, 2 ; funkcja wyswietlajaca pojedynczy znak na ekranie

  cmp al, 13 ; Sprawdz czy wcisnieto enter
  jz wcisniety_enter

  mov [haslo + si], al
  int 21h
  inc si
  cmp si, 15
  jz wcisniety_enter
  jnz petla

krotkie_haslo:
  mov ah, 9
  mov dl, krotki_haslo_msg
  int 21h
  jmp start

wcisniety_enter:
  cmp si, 4
  jl krotkie_haslo

  xor si, si ; wyzerowanie rejestru
  call nowa_linia
  mov ah, 9
  mov dl, wpisz_haslo
  int 21h
  mov dl, '*'

porownaj:
  cmp byte [haslo + si], 0
  jz poprawne_haslo
  mov ah, 7
  int 21h

  cmp [haslo + si], al
  jnz zle_haslo

  mov ah, 2
  int 21h
  inc si 
  cmp si, 15
  jnz porownaj

poprawne_haslo:
  call nowa_linia
  mov dx, haslo_poprawne
  mov ah, 9
  int 21h 
  jmp koniec

zle_haslo:
  mov ah, 2
  call nowa_linia
  mov dx, haslo_niepoprawne
  mov ah, 9
  int 21h 

koniec:
  mov ax, 4c00h 
  int 21h

nowa_linia:
  mov dl, 10
  int 21h
  mov dl, 13
  int 21h
  ret


section .data
  haslo db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; 16 znakow null
  naglowek db 'Ustaw haslo i wcisnij ENTER',13,10,'$'
  krotki_haslo_msg db 13,10,'Haslo powinno skladac sie z conajmniej 4 znakow',13,10,'$'
  wpisz_haslo db 'Wpisz zapamietane haslo:',13,10,'$'
  haslo_poprawne db 'Poprawne haslo',13,10,'$'
  haslo_niepoprawne db 'Niepoprawne haslo!!!',13,10,'$'