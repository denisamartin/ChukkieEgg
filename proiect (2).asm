.386
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern malloc: proc
extern memset: proc

includelib canvas.lib
extern BeginDrawing: proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
;aici declaram date
;--------------------------------------------------------


;DENUMIRE JOC :  CHUKIE EGG
; NUME - PRENUME:  MARTIN MARIA DENISA
; GRUPA: 10


;--------------------------------------------------------

;DESCRIERE PROIECT: 
; omuletul are 3 vieti, daca este prins de rata, acesta pierde cate una; cand ajunge la 0, se scrie pe ecran "GAME OVER";
; punctajul difera in functie de timpul gasirii: la inceput primeste 100, dupa 75, dupa 50 si in cele din urma 25;
; dupa ce omuletul a strans toate ouale apare pe ecran "YOU WIN"

;--------------------------------------------------------------------------------------------------------------------

window_title DB "CHUCKIE EGG",0
area_width EQU 721
area_height EQU 340
area DD 0
i db 17
j db 4
xom equ 40
yom equ 310
linie_chenar_x EQU 541
linie_chenar_y EQU 0
omulet equ 3
linie_chenarsus_x EQU 0
linie_chenarsus_y EQU 53

buton_sus_x EQU 611
buton_sus_y EQU 220
size_buton EQU 40
vieti db 3
x EQU 0
y EQU 0
 
x0 equ 1
y0 equ 55

counter DD 0 ; numara evenimentele de tip timer

arg1 EQU 8
arg2 EQU 12
arg3 EQU 16
arg4 EQU 20

symbol_width EQU 10
symbol_height EQU 20
my_symbol_width EQU 15
my_symbol_height EQU 15
inceputjos_x EQU 1
inceputjos_y EQU 325
etaj2_y EQU 207
counter_rate db 2

mapa  		DB 2 DUP(0), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4 DUP(0)
nr_coloane EQU $-mapa
			DB 2 DUP(0), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4 DUP(0)
			DB 2 DUP(0), 0, 0, 0, 0, 0, 0, 0, 4, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4 DUP(0) 
			DB 2 DUP(0), 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 4 DUP(0)
			DB 2 DUP(0), 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4 DUP(0)
			DB 2 DUP(0), 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4 DUP(0)
			DB 2 DUP(0), 0, 0, 0, 0, 0, 0, 4, 0, 0, 2, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4 DUP(0)
			DB 2 DUP(0), 0, 0, 0, 1, 1, 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 4 DUP(0)
			DB 2 DUP(0), 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 4 DUP(0)
			DB 2 DUP(0), 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 4, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 4 DUP(0)
			DB 2 DUP(0), 0, 0, 0, 0, 0, 4, 0, 0, 0, 2, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4 DUP(0)
			DB 2 DUP(0), 0, 0, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4 DUP(0)
			DB 2 DUP(0), 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4 DUP(0)
			DB 2 DUP(0), 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4 DUP(0)
			DB 2 DUP(0), 0, 0, 0, 4, 0, 0, 0, 0, 0, 2, 0, 0, 0, 4, 0, 2, 0, 0, 0, 0, 2, 0, 0, 4, 0, 0, 0, 0, 0, 0, 4 DUP(0)
			DB 2 DUP(0), 0, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4 DUP(0)
			DB 2 DUP(0), 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4 DUP(0)
			DB 2 DUP(0), 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4 DUP(0)
			DB 2 DUP(1), 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4 DUP(1)
nr_linii EQU ($-mapa)/nr_coloane

vector_rate db 5, 28 dup(0)
i_rata db 14
j_rata db 4

i_rata2 db 10
j_rata2 db 5

j_rata3 db 19
i_rata3 db 2
nimic db 0
score dd 0
eggs dd 0

i_ou1 equ 14 
j_ou1 equ 6
include digits.inc
include letters.inc
include simboluri.inc


.code
; procedura make_text afiseaza o litera sau o cifra la coordonatele date
; arg1 - simbolul de afisat (litera sau cifra)
; arg2 - pointer la vectorul de pixeli
; arg3 - pos_x
; arg4 - pos_y

simbol proc
push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	lea esi, simboluri


draw_text:
	mov ebx, my_symbol_width
	mul ebx
	mov ebx, my_symbol_height
	mul ebx
	add esi, eax
	mov ecx, my_symbol_height
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, my_symbol_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, my_symbol_width
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_negru
	cmp byte ptr [esi], 5
	je simbol_pixel_rata
	cmp byte ptr [esi], 4
	je simbol_pixel_ou
	cmp byte ptr [esi], 3
	je simbol_pixel_mov
	cmp byte ptr[esi], 1
	je simbol_pixel_zid
	cmp byte ptr[esi],2
	je simbol_pixel_mov
	mov dword ptr [edi],6B83E3h
	jmp simbol_pixel_next
simbol_pixel_negru:
	mov dword ptr [edi], 0
	jmp simbol_pixel_next
simbol_pixel_om:
	mov dword ptr [edi], 9E96F2h
	jmp simbol_pixel_next
simbol_pixel_rata:
	mov dword ptr [edi], 0ffcc99h
	jmp simbol_pixel_next
simbol_pixel_ou:
	mov dword ptr [edi], 0F3BD38h
	jmp simbol_pixel_next
simbol_pixel_zid:
	mov dword ptr[edi], 36224Dh
	jmp simbol_pixel_next
simbol_pixel_mov:
	mov dword ptr[edi],993399h
	jmp simbol_pixel_next
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
simbol endp



make_text proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	cmp eax, 'A'
	jl make_digit
	cmp eax, 'Z'
	jg make_digit
	sub eax, 'A'
	lea esi, letters
	jmp draw_text
make_digit:
	cmp eax, '0'
	jl make_space
	cmp eax, '9'
	jg make_space
	sub eax, '0'
	lea esi, digits
	jmp draw_text

	

make_space:	
	mov eax, 26 ; de la 0 pana la 25 sunt litere, 26 e space
	lea esi, letters

draw_text:
	mov ebx, symbol_width
	mul ebx
	mov ebx, symbol_height
	mul ebx
	add esi, eax
	mov ecx, symbol_height
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_alb
	mov dword ptr [edi], 993399h
	jmp simbol_pixel_next
simbol_pixel_alb:
	mov dword ptr [edi], 0
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_text endp

; macro-uri:
; un macro ca sa apelam mai usor desenarea simbolului

make_simbol_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call simbol
	add esp, 16
endm

; macro ca sa apelam mai usor desenarea textului
make_text_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call make_text
	add esp, 16
endm

;macro pentru desenarea liniilor orizontale
line_horizontal macro x,y,len, color
	local bucla_linie
	mov eax, y
	mov ebx, area_width
	mul ebx
	add eax, x
	shl eax,2
	add eax,area
	mov ecx,len
	bucla_linie:
	mov dword ptr[eax] ,color
	add eax, 4
	loop bucla_linie
	
	
endm

;macro pentru desenarea liniilor verticale
line_vertical macro x,y,len, color
	local bucla_linie
	mov eax, y
	mov ebx, area_width
	mul ebx
	add eax, x
	shl eax,2
	add eax,area
	mov ecx,len
	bucla_linie:
	mov dword ptr[eax] ,color
	add eax, 4*area_width
	loop bucla_linie
endm


; macro pentru a compara daca s-a dat click in buton
make_move macro x_buton, y_buton, size_buton, final
	mov eax, [ebp+arg1]
	cmp eax, 1
	jne final
	mov eax, [ebp+arg2]
	cmp eax, x_buton
	jl final
	cmp eax, x_buton + size_buton
	jg final
	mov eax,[ebp+arg3]
	cmp eax, y_buton
	jl final
	cmp eax, y_buton +size_buton
	jg final
endm
						
; macro pentru a vedea daca omuletul a fost prins de rata						
conditie_rata macro i_rata, j_rata, final_conditie
	mov al, i
	mov bl, i_rata
	cmp al,bl
	jne final_conditie
	mov al, j 
	mov bl, j_rata
	cmp al,bl
	jne final_conditie
	mov i, 17
	mov j, 4
  endm
  
 ; macro pentru a apela functia simbol
  afisare macro i,j, simbolul_de_desenat 
	mov eax , my_symbol_height
	mul i
	add eax, y0
	push eax
	mov eax, my_symbol_width
	mul j
	add eax, x0
	push eax
	push area
	push simbolul_de_desenat
	call simbol
	add esp, 16
  endm
  
  
; macro pentru a desena un buton
buton macro x,y,len,color
	line_horizontal x,y,len , color
	line_horizontal x,y+len,len , color
	line_vertical x,y,len , color
	line_vertical x+len,y,len , color
endm

;macro pentru a misca rata 
compara_rata macro 
	mov eax,0
	mov al, counter_rate
	mov cl,4
	div cl
	cmp ah,0
endm

; functia de desenare - se apeleaza la fiecare click
; sau la fiecare interval de 200ms in care nu s-a dat click
; arg1 - evt (0 - initializare, 1 - click, 2 - s-a scurs intervalul fara click)
; arg2 - x
; arg3 - y
draw proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1]
	cmp eax, 1
	jz evt_click
	cmp eax, 2
	jz evt_timer ; nu s-a efectuat click pe nimic
	;mai jos e codul care intializeaza fereastra cu pixeli albi
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	push 0
	push area
	call memset
	add esp, 12
	jmp afisare_litere
	
evt_click:
 
	
	
evt_timer:
	; inc counter
	
afisare_litere:


    inc counter
	;afisam valoarea counter-ului curent (zeci de mii, mii ,sute, zeci si unitati)
	mov ebx, 10
	mov eax, counter
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 120, 14
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 110, 14
	;cifra sutelor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 100, 14
	;cifra mii
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 90, 14
	;cifra zeci de mii
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 80, 14
	
	;afisam scorul
	mov ebx, 10
	mov eax, score
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 320, 14
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 310, 14
	;cifra sutelor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 300, 14
	;cifra mii
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 290, 14
	;cifra zeci de mii
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 280, 14
	
	;afisam ouale
	mov ebx, 10
	mov eax, eggs
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 490, 14
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 480, 14
	;cifra sutelor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 470, 14
					
		
	
	; deseam chenarul jocului 
	
	line_vertical linie_chenar_x, linie_chenar_y, area_height,993399h
	line_horizontal linie_chenarsus_x, linie_chenarsus_y, area_width-(area_width-linie_chenar_x),993399h
	line_horizontal 0, 0, area_width-(area_width-linie_chenar_x),993399h
	line_vertical 0,0, area_height, 993399h
  
	; desenam butoanele
	
	buton buton_sus_x, buton_sus_y, size_buton,993399h
	buton buton_sus_x, buton_sus_y+size_buton, size_buton,993399h
	buton buton_sus_x-size_buton, buton_sus_y+size_buton, size_buton,993399h	
	buton buton_sus_x+size_buton, buton_sus_y+size_buton, size_buton,993399h
	buton buton_sus_x+size_buton, buton_sus_y, size_buton,993399h
	buton buton_sus_x-size_buton, buton_sus_y, size_buton,993399h
	
	; punem sagetile in interiorul butoanelor
	make_simbol_macro 6, area, buton_sus_x+15, buton_sus_y+13
	make_simbol_macro 7, area, buton_sus_x-25, buton_sus_y+55
	make_simbol_macro 8, area, buton_sus_x+15, buton_sus_y+55
	make_simbol_macro 9, area, buton_sus_x+55, buton_sus_y+55
	make_simbol_macro 10, area, buton_sus_x+55, buton_sus_y+13
	make_simbol_macro 11, area, buton_sus_x-25, buton_sus_y+13
					
	
	;scriem mesajele
	
	make_text_macro 'S', area, 210, 14
	make_text_macro 'C', area, 220, 14
	make_text_macro 'O', area, 230, 14
	make_text_macro 'R', area, 240, 14
	make_text_macro 'E', area, 250, 14
	
	make_text_macro 'T', area, 30, 14
	make_text_macro 'I', area, 40, 14
	make_text_macro 'M', area, 50, 14
	make_text_macro 'E', area, 60, 14

	make_text_macro 'E', area, 420, 14
	make_text_macro 'G', area, 430, 14
	make_text_macro 'G', area, 440, 14
	make_text_macro 'S', area, 450, 14

		   
    make_text_macro 'C',area, buton_sus_x-25, buton_sus_y-150
	make_text_macro 'H',area, buton_sus_x-15, buton_sus_y-150
	make_text_macro 'U',area, buton_sus_x-5, buton_sus_y-150
	make_text_macro 'C',area, buton_sus_x+5, buton_sus_y-150
	make_text_macro 'K',area, buton_sus_x+15, buton_sus_y-150
	make_text_macro 'I',area, buton_sus_x+25, buton_sus_y-150
	make_text_macro 'E',area, buton_sus_x+35, buton_sus_y-150
		   
		   
	make_text_macro 'E',area, buton_sus_x+45, buton_sus_y-130
	make_text_macro 'G',area, buton_sus_x+55, buton_sus_y-130
	make_text_macro 'G',area, buton_sus_x+65, buton_sus_y-130
		  
		  
		  
		  
	;afisam matricea
	
	; o vom afisa astfel:
	; for i=0;i<nrLinii; i++
	; for j=0; j<nrCol; j++
	; make_symbol mapa[i][j], area, Xij, Yij
	

	mov ecx,0
	primul_for:
	cmp ecx , nr_linii
	je sfarsit
	mov ebx,0
	al_doilea_for:
	; folosim formulele:			    
	
	; y=y0 +i*sh
	mov eax, my_symbol_height
	mul ecx
	add eax,y0
    push eax
	
	; x=x0 +j*sw
	mov eax ,my_symbol_width
	mul ebx
	add eax,x0
	push eax
	
	push area
    	
	mov eax ,nr_coloane
	mul ecx
	add eax, ebx
	push 0
	mov al, mapa[eax]
	mov [esp],al
	call simbol
	add esp, 16
	inc  ebx
	cmp ebx, nr_coloane
	je loopfor
	jmp al_doilea_for
	loopfor:
	inc ecx
	; inc counter_rate
	jmp primul_for
	sfarsit:
					  		  
				  
    ; afisam ratele
	cmp counter_rate, 20
	jne cnt
	mov counter_rate, 4
	cnt:
	inc counter_rate
    
	; rata de sus:	
	
	afisare i_rata3, j_rata3, 5
	compara_rata
	jne  comparare_rata_sus
	inc j_rata3
	comparare_rata_sus:
	cmp j_rata3, 30
	jne rata2
	mov j_rata3, 19
	
	
	;rata de la mijloc:
	rata2:
	afisare i_rata2,j_rata2, 5 
	compara_rata
	jne comparare3
    inc j_rata2
	comparare:
	cmp j_rata2, 16
	jne comparare1
	dec i_rata2
	comparare1:
    cmp j_rata2, 20
	jne comparare2 
	dec i_rata2
	comparare2:
	cmp j_rata2, 24
	jne comparare3
	dec i_rata2
	comparare3:
	cmp j_rata2, 30
	jne final_rata
	mov j_rata2 ,5
	mov i_rata2, 10
	jne final_rata
	; mov j_rata, 21
	final_rata:
					
		
			
	;miscam omuletul				
					
	sus:
	make_move buton_sus_x, buton_sus_y, size_buton, dreapta
	dec i
	jmp om
					
	dreapta:
	make_move buton_sus_x+ size_buton, buton_sus_y+size_buton, size_buton, stanga
	inc j
	jmp om
	
	stanga:
	make_move  buton_sus_x-size_buton , buton_sus_y+size_buton, size_buton, jos
	dec j
	jmp om
	
	jos:
	make_move buton_sus_x, buton_sus_y+size_buton, size_buton, salt_dreapta
	;testam daca dedesubt are pamant, daca are nu poate merge in jos
	mov eax, 1
	mov ebx,0
	mov edx,0
	mov ecx,0
	add al,i
	mov dl, nr_coloane
	mul dl
	mov bl, j
	mov al, mapa[eax][ebx]
	cmp al, 1
	je salt_dreapta
	inc i
	jmp om
					
	salt_dreapta:
	make_move buton_sus_x+size_buton, buton_sus_y, size_buton, salt_stanga
	add j,2
	dec i 
	jmp om
					
	salt_stanga:
	make_move buton_sus_x-size_buton, buton_sus_y, size_buton, final_miscare
	dec j
	dec j
	dec i
	jmp om
	final_miscare:
					
	;afisam omuletul
	
	
	om:
	afisare  i,j, omulet 
	
	; conditie rate: daca omuletul este prins, revine la prima pozitie si pierde o viata				
							
	conditie_rata  i_rata2, j_rata2, final_conditie2
	dec vieti
	final_conditie2:
	conditie_rata i_rata3, j_rata3, final_conditie3
	dec vieti
	final_conditie3:
	cmp vieti,3
	jne doua_vieti
	make_simbol_macro  13 , area, 605, 150
	make_simbol_macro  13, area, 623, 150
	make_simbol_macro  13, area, 641, 150
	doua_vieti:
	cmp vieti,2
	jne o_viata
	make_simbol_macro  0 , area, 605, 150
	make_simbol_macro  13, area, 623, 150
	make_simbol_macro  13, area, 641, 150
	jmp conditie_om
	o_viata:
	cmp vieti,1
	jne game_over
	make_simbol_macro  0 , area, 605, 150
	make_simbol_macro  0, area, 623, 150
	make_simbol_macro  13, area, 641, 150
	jmp conditie_om
	game_over:
	cmp vieti,0
	jne conditie_om
	make_simbol_macro  0 , area, 605, 150
	make_simbol_macro  0, area, 623, 150
	make_simbol_macro  0, area, 641, 150
	make_text_macro 'G', area, 200,200
	make_text_macro 'A', area, 211,200
	make_text_macro 'M', area, 221,200
	make_text_macro 'E', area, 233,200
	make_text_macro 'O', area, 255,200
	make_text_macro 'V', area, 266,200
	make_text_macro 'E', area, 277,200
	make_text_macro 'R', area, 288,200
	
	; conditie miscare: daca sub om este 0(nimic) atunci acesta va cadea
	conditie_om:
	mov eax, 1
    mov ebx,0
	mov edx,0
	mov ecx,0
	add al,i
	mov dl, nr_coloane
	mul dl
	mov bl, j
	mov al, mapa[eax][ebx]
	cmp al,0
	jne conditie_ou
	inc i
					
	;conditie ou				
					
	conditie_ou:
	; verificam daca am ajuns la ou:
	
	mov eax, 0
	mov ebx,0
	mov edx,0
	mov ecx,0
	mov al,i
	mov dl, nr_coloane
	mul dl
	mov bl, j
	mov cl, mapa[eax][ebx]
	cmp cl, 4
	jne final_ou
    
	
	; daca am ajuns il numaram
	add eggs,1	
	mov  mapa[eax][ebx],0
	; si calculam scorul in functie de timpul gasirii
	cmp counter, 100
	jg scor_mai_mic
	add score, 100
	jmp final_ou
	
	scor_mai_mic:
	cmp counter, 400
	jg scor_mai_mic2
	add score, 75
	jmp final_ou
	scor_mai_mic2:
	cmp counter, 1000
	jg scor_mai_mic3
	add counter, 50
	jmp final_ou
	scor_mai_mic3:
	add counter, 25
	final_ou:
    cmp eggs, 10
    jne final_draw
	make_text_macro 'Y', area, 200,200
	make_text_macro 'O', area, 211,200
	make_text_macro 'U', area, 222,200
	make_text_macro 'W', area, 244,200
	make_text_macro 'I', area, 255,200
	make_text_macro 'N', area, 266,200
	make_simbol_macro 14, area,280,203		
				
	
final_draw:
	popa
	mov esp, ebp
	pop ebp
	ret
draw endp

start:
	;alocam memorie pentru zona de desenat
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	call malloc
	add esp, 4
	mov area, eax
	;apelam functia de desenare a ferestrei
	; typedef void (*DrawFunc)(int evt, int x, int y);
	; void __cdecl BeginDrawing(const char *title, int width, int height, unsigned int *area, DrawFunc draw);
	push offset draw
	push area
	push area_height
	push area_width
	push offset window_title
	call BeginDrawing
	add esp, 20
	
	;terminarea programului
	push 0
	call exit
end start