section .text
org 100h
start:
  ;#################MNOZENIE###################
  ; operacja mnozenia
  mov ah, 9
  mov dx, mnozenie
  int 21h

  ; Pobranie pierwszej liczby
  mov dx, wpisz_pierwsza
  call pobierz_znak
  mov byte [mnoz1], al

  ; Pobranie drugiej liczby
  mov dx, wpisz_druga
  call pobierz_znak
  mov byte [mnoz2], al

  mov al, [mnoz1]
  mov bl, [mnoz2]
  mul bl
  ; komorka rejestru al przechowuje wynik mnozenia
  cmp al, [prog]
  jg wieksze_od_progu ; skok, gdy flaga znaku wyzerowana
  jl mniejsze_od_progu ; skok, gdy flaga znaku ustawiona
  jz rowne_prog ; skok, gdy flaga zera ustawiona

  wieksze_od_progu:
    mov dx, wieksze
    jmp wypisz
  mniejsze_od_progu:
    mov dx, mniejsze
    jmp wypisz
  rowne_prog:
    mov dx, rowne
  wypisz:
    mov ah, 9
    int 21h
    mov ax, 4C00h
    int 21h

pobierz_znak:
  mov ah, 9
  int 21h
  mov ah, 1
  int 21h
  sub al, '0' ; Zmiana Znaku ASCII na liczbę
  mov ah, 9
  mov dx, nowa_linia
  int 21h
  ret


section .data
  nowa_linia db 13,10,"$"
  mnozenie db "Mnozenie",13,10,"$"
  wpisz_pierwsza db "Wpisz pierwsza liczbe",10,30,"$"
  wpisz_druga db "Wpisz druga liczbe",10,30,"$"
  mnoz1 db 5
  mnoz2 db 5
  mniejsze db "Wynik jest mniejszy od uslatonego progu$"
  wieksze db "Wynik jest wiekszy od ustalonego progu$"
  rowne db "Wynik jest rowny ustalonemu progowi$"
  prog db 25