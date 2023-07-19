; multi-segment executable file template.
;khaled AbuRubaia

data segment
    text db 160 dup(0)
    counter dw 0
    RM db 1,3,-5,7,-4,2,-2,1,4,2,6,-2,7,3,-5,-1 
    txt db "press any key to continue..$"
    cc db 0
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
    
    
    call read
    call new_line
    
    
    call new_line
    call print
    call press_key
    call shCol
    call shCol
    call new_line
    call print_st
    call new_line
    call new_line
    call print
    
    call press_key
    call shRow
    call new_line
    call print_st
    call new_line
    call new_line
    call print
    
    
    call press_key
    call rotate
    call new_line
    call print_st
    call new_line
    call new_line
    call print
    
    
    call press_key
    call rotateB
    call new_line
    call print_st
    call new_line
    call new_line
    call print
    
    
    call press_key
    call shRowB
    call new_line
    call print_st
    call new_line
    call new_line
    call print
    
    call press_key
    call shColB
    call shColB
    call new_line
    call print_st
    call new_line
    call new_line
    call print 
    
    
    mov ax, 4c00h ; exit to operating system.
    int 21h
    
    press_key proc
         lea dx,txt
         mov ah,9
         int 21h
         mov ah,1
         int 21h
         ret
    rotateB proc
    lea di,text
    mov cx,counter
    rb3:
    push cx
    mov cx,16
    lea si,RM
    rb2:
    push cx
    mov dl,[di]
    mov cl,[si] 
    mov ch,0
    cmp cl,0
    jl negatb
    rol dl,cl
    contb:  
    mov [di],dl
    inc si
    inc di
    pop cx
    loop rb2
    pop cx
    loop rb3
    ret 
    negatb:
    neg cl
    ror dl,cl
    jmp contb
    
    
    shRowB proc
        lea di,text
        mov cx,counter
       pb31: 
        push cx
        mov cx,4
         pb11:
          mov dl,[di+12]
          mov dh,0
          push dx
          mov dl,[di+8]
          push dx
          mov dl,[di+4]
          push dx
          mov dl,[di]
          mov [di+4],dl
          pop dx
          mov [di+8],dl
          pop dx
          mov [di+12],dl
          pop dx
          mov [di],dl
          inc di
          loop pb11
          add di,12
        pop cx
        loop pb31
        ret
    
    shColB proc
        lea di,text
        mov cx,counter
       cb2: 
        push cx
        mov cx,4
         cb1:
          mov dl,[di+3]
          mov dh,0
          push dx
          mov dl,[di+2]
          push dx
          mov dl,[di+1]
          push dx
          mov dl,[di]
          mov [di+1],dl
          pop dx
          mov [di+2],dl
          pop dx
          mov [di+3],dl
          pop dx
          mov [di],dl
          add di,4
          loop cb1
        pop cx
        loop c2
        ret
        
            
    rotate proc
    lea di,text
    mov cx,counter
    r3:
    push cx
    mov cx,16
    lea si,RM
    r2:
    push cx
    mov dl,[di]
    mov cl,[si] 
    mov ch,0
    cmp cl,0
    jl negat
    ror dl,cl
    cont:  
    mov [di],dl
    inc si
    inc di
    pop cx
    loop r2
    pop cx
    loop r3
    ret 
    negat:
    neg cl
    rol dl,cl
    jmp cont
    
    shCol proc
        lea di,text
        mov cx,counter
       c2: 
        push cx
        mov cx,4
         c1:
          mov dl,[di]
          mov dh,0
          push dx
          mov dl,[di+1]
          push dx
          mov dl,[di+2]
          push dx
          mov dl,[di+3]
          mov [di+2],dl
          pop dx
          mov [di+1],dl
          pop dx
          mov [di],dl
          pop dx
          mov [di+3],dl
          add di,4
          loop c1
        pop cx
        loop c2
        ret
    
    shRow proc
        lea di,text
        mov cx,counter
       p31: 
        push cx
        mov cx,4
         p11:
          mov dl,[di]
          mov dh,0
          push dx
          mov dl,[di+4]
          push dx
          mov dl,[di+8]
          push dx
          mov dl,[di+12]
          mov [di+8],dl
          pop dx
          mov [di+4],dl
          pop dx
          mov [di],dl
          pop dx
          mov [di+12],dl
          inc di
          loop p11
          add di,12
        pop cx
        loop p31
        ret
    
    new_line proc 
         mov ah,2
         mov dl,10
         int 21h
         mov dl,13
         int 21h
         ret
    
    read proc
        lea di,text
        mov cx,160
        sub dx,dx
        rr:
        mov ah,1
        int 21h
        cmp al,13
        jz exit
        mov [di],al
        inc di
        inc dx
        loop rr
        exit:
        mov ax,dx
        mov bl,16
        div bl
        cmp ah,0
        je skip
        inc al
        skip:
        mov counter,al
        ret
    
    print_st proc
        lea di,text
        mov cx,counter
       st3: 
        push cx
        mov cx,4
        st2:
         push cx
         mov cx,4
         st1:
          mov dl,[di]
          mov ah,2
          int 21h
          inc di
          loop st1
         pop cx
         loop st2
        pop cx
        loop st3
        ret
       
        
    print proc
        lea di,text
        mov cx,counter
       p3: 
        push cx
        mov cx,4
        p2:
         push cx
         mov cx,4
         p1:
          mov dl,[di]
          mov ah,2
          int 21h
          mov ah,2
          mov dl,32
          int 21h
          inc di
          loop p1
         call new_line
         pop cx
         loop p2
        call new_line
        pop cx
        loop p3
        ret
       
        
              
ends

end start ; set entry point and stop the assembler.
