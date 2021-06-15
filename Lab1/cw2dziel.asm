section .text
org 100h
start:
  ;#################DZIELENIE###################
  ; operacja dzielenia
  mov ah, 9
  mov dx, dzielenie
  int 21h
  mov ax, [liczba1]
  mov bl, [liczba2]
  div bl
  ; komorka rejestru al przechowuje wynik dzielenia
  cmp al, [prog] ; porownanie dwoch liczb
  jg wieksze_od_progu ; skok, gdy flaga znaku wyzerowana
  jl mniejsze_od_progu ; skok, gdy flaga znaku ustawiona
  jz rowne_prog ; skok, gdy flaga zera ustawiona

  wieksze_od_progu:
    mov dx, wieksze
    jmp wypisz_prog
  mniejsze_od_progu:
    mov dx, mniejsze
    jmp wypisz_prog
  rowne_prog:
    mov dx, rowne
    jmp wypisz_prog

  liczba_parzysta:
    mov dx, parzysta
    jmp wypisz_parzystosc
  liczba_nieparzysta:
    mov dx, nieparzysta
    jmp wypisz_parzystosc

  wypisz_prog:
    mov ah, 9
    int 21h
    test al, 1 ; testujemy czy najmniej znaczacy bit jest ustawiony
    JNZ liczba_nieparzysta ;najmniej znaczacy bit ustawiony
    JZ  liczba_parzysta ;najmniej znaczacy bit nieustawiony
  wypisz_parzystosc:
    int 21h
    mov ax, 4C00h
    int 21h

section .data
  dzielenie db "Dzielenie",13,10,"$"
  liczba1 dw 100
  liczba2 dw 4
  mniejsze db "Wynik jest mniejszy od uslatonego progu", 13, 10, "$"
  wieksze db "Wynik jest wiekszy od ustalonego progu", 13, 10, "$"
  rowne db "Wynik jest rowny ustalonemu progowi",13, 10, "$"
  parzysta db "Liczba Parzysta$"
  nieparzysta db "Liczba Nieparzysta$"
  prog dw 25