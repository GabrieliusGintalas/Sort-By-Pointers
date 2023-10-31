;****************************************************************************************************************************
;Program name: "Sort By Pointers".  
;Copyright (C) 2023 Gabrielius Gintalas.                                                                                    *
;                                                                                                                           *
;This file is part of the software program "Sort By Pointers".                                                        *
;Sort By Pointers is free software: you can redistribute it and/or modify it under the terms of the GNU General Public*
;License version 3 as published by the Free Software Foundation.                                                            *
;Basic Float Operations is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the       *
;implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more      *
;details.  A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                  *
;****************************************************************************************************************************

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Gabrielius Gintalas
;  Author email: gabrieliusgintalas@csu.fullerton.edu
;  Author CWID: 885861872
;  Author NASM: NASM version 2.15.05 
;
;Program information
;  Program name: Sort By Pointers
;  Programming languages: Two modules in C++ and three modules in X86
;  Date program began: Oct-3-2023
;  Date of last update: Oct-6-2023
;  Date comments upgraded: Oct-9-2023
;  Due Date: Oct-16-2023
;  Date open source license added: Oct-3-2023
;  Files in this program: director.asm, input_array.asm, main.cpp, output_array.cpp, sort_pointers.asm
;  Status: Finished.
;
;Purpose
;  The purpose of this program is to create a pointer array in which the user inputs up to 8 values and the program creates 
;  an array of pointers that point to those values. The program also prints the values that the user inputted, and it is
;  also responsible for sorting the array and correctly printing the sorted pointed array from least to greatest
;
;This file
;  File name: sort_pointers.asm
;  File purpose: Sort the pointers in the array by pointer values in the array
;  Language: X86 with Intel syntax.
;  Max page width: 132 columns
;  Assemble: nasm -f elf64 -l sort_pointers.lis -o sort_pointers.o sort_pointers.asm
global sort_pointers

segment .data

segment .bss
    ;Preparing xsave and xrstor
    align 64
    Save resb 832

segment .text
    sort_pointers:
        push       rbp              ;Save a copy of the stack base pointer
        mov        rbp, rsp         ;We do this in order to be 100% compatible with C and C++.
        push       rbx              ;Back up rbx
        push       rcx              ;Back up rcx
        push       rdx              ;Back up rdx
        push       rsi              ;Back up rsi
        push       rdi              ;Back up rdi
        push       r8               ;Back up r8
        push       r9               ;Back up r9
        push       r10              ;Back up r10
        push       r11              ;Back up r11
        push       r12              ;Back up r12
        push       r13              ;Back up r13
        push       r14              ;Back up r14
        push       r15              ;Back up r15
        pushf                       ;Back up rflags

        ;Set up xsave
        mov rax, 7
        mov rdx, 0
        xsave [Save]

        xor r12, r12                ;r13 is the main counter - i
        xor r13, r13                ;r11 is the inner counter - j

        mov r14, rdi                ;r14 contains the array - array[]
        mov r15, rsi                ;r15 contains the capacity - array capacity
    outer_loop:
        cmp r12, r15                ;Ensure that the counter doesn't surpass the size - i < size
        jge end_sort

        xor r11, r11                ;Set r11 to 0
        
        ;The following change the condition every loop
        mov r11, r15                ;Set r11 to the capacity of array - r11 = size
        dec r11                     ;Decrement r11 by 1 - r11 -1 
        sub r11, r12                ;Subtract i from r11 - r11 - i
                                    ;In the end we get this r11 = size - i - 1

        xor r13, r13                ;Set r13 to 0 since we will be using this to keep count of the inner loop
    inner_loop:
        cmp r13, r11                ;Checking if r13 < r11
        jge increase_outer_loop     ;If so jump to next element in outer loop

        mov r10, [r14 + r13*8]      ;r10 contains the pointer to the first value - array[j]
        mov r9, [r14 + r13*8 + 8]   ;r9 contains the pointer to the next value - array[j + 1]

        ; Load values from memory before comparing
        movsd xmm0, [r10]           ;Get the physical value of r10 for comparison - *(array[j])
        movsd xmm1, [r9]            ;Get the physical value of r9 for comparison - *(array[j + 1])

        
        ucomisd xmm0, xmm1          ;Compare the two values  
        jb no_swap                  ;If the next value is greater we will not be swapping

        mov [r14 + r13*8], r9       ;Set array[j] to array[j + 1]
        mov [r14 + r13*8 + 8], r10  ;Set array[j + 1] to array[j]

    no_swap:
        inc r13                     ;Increment the counter - j  
        jmp inner_loop              ;Jump to next element in inner loop

    increase_outer_loop:
        inc r12                     ;Increment the counter - i
        jmp outer_loop              ;Jump to next element in outer loop

    end_sort:
        ;Set up xrsor
        mov rax, 7
        mov rdx, 0
        xrstor [Save]

        popf                        ;Restore rflags
        pop        r15              ;Restore r15
        pop        r14              ;Restore r14
        pop        r13              ;Restore r13
        pop        r12              ;Restore r12
        pop        r11              ;Restore r11
        pop        r10              ;Restore r10
        pop        r9               ;Restore r9
        pop        r8               ;Restore r8
        pop        rdi              ;Restore rdi
        pop        rsi              ;Restore rsi
        pop        rdx              ;Restore rdx
        pop        rcx              ;Restore rcx
        pop        rbx              ;Restore rbx
        pop        rbp              ;Restore rbp

        ret