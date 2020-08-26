[BITS 16] 

org	0x7c00

START:
mov     ax, 0xb800
mov     es, ax
mov     ax, 0
mov		bx, 0
mov     cx, 80*25*2

CLS:
mov		[es:bx], ax
add		bx, 1
loop 	CLS

;텍스트 띄우기
TEXT:
mov     ds, ax	
mov     si, msg	;텍스트 주소
call    PRINT	;텍스트 출력함수
 
      
PRINT:
    pusha				;함수 이전 레지스터값 스택추가
    mov     ax, 0xb800	
    mov     es, ax		;비디오메모리 시작주소
    mov     ah, 0x07	
    mov     di, 0		
    .loop:
        mov     al, [ds:si]		;문자 하나가져옴
        cmp     al, 0			;문자가 0인지 비교
        je      .end			;문자가 0이면 end로 이동
         
        mov     [es:di], ax		;비디오 메모리에 출력
        add     si, 1			;다음 문자로 이동
        add     di, 2			;다음 비디오 메모리로 이동
        jmp     .loop			;반복
.end:
    popa		;스택에 저장된 레지스터 가져옴
    ret			;호출한 장소로 복귀

msg db "Hello, Jaesik Eom's World", 0
