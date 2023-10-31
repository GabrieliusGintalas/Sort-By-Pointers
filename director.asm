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
;  File name: director.asm
;  File purpose: Print program messages and call every assembly and c++ script, returning the array at the end
;  Language: X86 with Intel syntax.
;  Max page width: 132 columns
;  Assemble: nasm -f elf64 -l director.lis -o director.o director.asm
global director
extern printf, input_array, output_array, sort_pointers

maxSize equ 8                          ;Set maxSize as a constant value of 8

section .data
    whatProgram db "This program will sort all of your doubles", 10, 0
    pleaseEnter db "Please enter floating point numbers seperated by white space. After the last numeric input enter at least one more white space and press ctrl-d.", 10, 0
    thankYou db "Thank you. You entered these numbers:", 10, 0
    endOut db "End of output array.", 10, 0
    dataBeingSorted db "The array is now being sorted without moving any numbers.", 10, 0
    arrayNumbers db "The data in the array are now ordered as follows", 10, 0
    sendBackArray db "The array will be sent back to the caller function.", 10, 0
    stringFormat db "%s", 0

section .bss
    ;Preparing xsave and xrstor
    align 64
    Save resb 832

    array resq maxSize                  ;Initialize array of the maximum size of 8 quadwords

section .text
    director:
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
        
        ;Print what this program will do message
        mov rax, 0
        mov rdi, stringFormat
        mov rsi, whatProgram
        call printf

        ;Print a message prompting user to input values
        mov rax, 0
        mov rdi, stringFormat
        mov rsi, pleaseEnter
        call printf 

        ;Calling the input_array
        mov rax, 0                     
        mov rdi, array                 ;Move array address to rdi
        mov rsi, maxSize               ;Move maxSize address to rsi
        call input_array               ;Call the input function
        
        ;Move the value of the capacity to rbx
        mov rbx, rax
        
        ;Print a message thanking the user for inputting values
        mov rax, 0
        mov rdi, stringFormat
        mov rsi, thankYou
        call printf 

        ;Calling the output_arary
        mov rax, 0
        mov rsi, rbx        ;Move the capacity of the array to rsi
        mov rdi, array      ;Move array address to rdi
        call output_array

        ;Print a message saying the program has reached the end of the output
        mov rax, 0
        mov rdi, stringFormat
        mov rsi, endOut
        call printf 

        mov rax, 0
        mov rdi, stringFormat
        mov rsi, dataBeingSorted
        call printf 

        mov rax, 0
        mov rdi, stringFormat
        mov rsi, arrayNumbers
        call printf 

        mov rax, 0
        mov rdi, array
        mov rsi, rbx
        call sort_pointers

        mov rax, 0
        mov rdi, array
        mov rsi, rbx
        call output_array

        mov qword rax, 0
        mov rdi, stringFormat
        mov rsi, endOut
        call printf 

        mov rax, 0
        mov rdi, stringFormat
        mov rsi, sendBackArray
        call printf

        ;Set up xrstor
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

        mov qword [rdi], rax
        mov rax, array 

        ret                             ;End this function

