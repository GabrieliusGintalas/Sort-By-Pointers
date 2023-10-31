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
;  File name: input_array.asm
;  File purpose: Get user data and create pointers pointing to those values in the array
;  Language: X86 with Intel syntax.
;  Max page width: 132 columns
;  Assemble: nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm
extern scanf, malloc
global input_array

section .data
    floatFormat db "%lf", 0             ;String format to scanf a double
    

section .bss
    ;Preparing xsave and xrstor
    align 64
    Save resb 832

section .text
    input_array:
        push       rbp                  ;Save a copy of the stack base pointer
        mov        rbp, rsp             ;We do this in order to be 100% compatible with C and C++.
        push       rbx                  ;Back up rbx
        push       rcx                  ;Back up rcx
        push       rdx                  ;Back up rdx
        push       rsi                  ;Back up rsi
        push       rdi                  ;Back up rdi
        push       r8                   ;Back up r8
        push       r9                   ;Back up r9
        push       r10                  ;Back up r10
        push       r11                  ;Back up r11
        push       r12                  ;Back up r12
        push       r13                  ;Back up r13
        push       r14                  ;Back up r14
        push       r15                  ;Back up r15
        pushf                           ;Back up rflags

        ;Set up xsave
        mov rax, 7
        mov rdx, 0
        xsave [Save]

        xor r13, r13                    ;Set r13 to 0 (loop counter)
        mov r14, rdi                    ;Set address of array to r14        
        mov r12, rsi                    ;Set the value of maxSize to r12

    loop_start:
        cmp r13, r12                    ;Check if r13 = maxSize
        jge loop_end                    ;If so, jump to end

        mov rax, 0
        mov rdi, 8                      ;Move 8 bytes (size for double) to rdi as argument to malloc
        call malloc                     ;Allocate memory in heap
        mov r15, rax                    ;No floats will be printed


        mov rax, 0
        mov rdi, floatFormat            ;Prepare to enter a float
        mov rsi, r15                    ;This value will be set to the user input
        call scanf                      ;Scan for user input

        cmp rax, -1                     ;Check if user clicked ctrl-d
        je loop_end                     ;If so, jump to end

        cmp rax, 1                      ;Check if user inputted valid data
        je addToR11

    addVar:
        ; Store the pointer (address of the allocated space) in the array
        mov [r14 + r13*8], r15          ;Store the pointer in the array

        inc r13                         ;Increase loop counter
        jmp loop_start                  ;Jump back to start

    addToR11:
        inc rbx                         ;Increase capacity
        jmp addVar

    loop_end: 
        mov rax, 7
        mov rdx, 0
        xrstor [Save]

        mov rax, rbx

        popf                            ;Restore rflags
        pop        r15                  ;Restore r15
        pop        r14                  ;Restore r14
        pop        r13                  ;Restore r13
        pop        r12                  ;Restore r12
        pop        r11                  ;Restore r11
        pop        r10                  ;Restore r10
        pop        r9                   ;Restore r9
        pop        r8                   ;Restore r8
        pop        rdi                  ;Restore rdi
        pop        rsi                  ;Restore rsi
        pop        rdx                  ;Restore rdx
        pop        rcx                  ;Restore rcx
        pop        rbx                  ;Restore rbx
        pop        rbp                  ;Restore rbp

        ret                             ;End this function
