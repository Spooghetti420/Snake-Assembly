// Run at: https://peterhigginson.co.uk/AQA
// The snake body is stored from the final memory address backwards, i.e. head = 199, cell 1 = 198, etc.
// Each value of the "body" is an integer which represents the x-position in the top 16 bits and the y-position in the bottom 16.

// Place the head at address 199
mov r12, #0x00000000
str r12, 199


// Draw the food and cell initially
str r12, 256
ldr r9, food_position // r9 holds the position of the food
ldr r1, food_color
str r1, 656

// Throughout the rest of the program, r12 is used to store the tail of the snake
// r5 stores the score in this version
mov r5, #0

// Back of the snake (front is always 199)
mov r11, #199

input:
    inp r0, 4 // read a character (keyboard codes: https://keycode.info/)

update_snake:
    // Store the position of the tail so it can be deleted from the screen afterwards.
    ldr r12, [r11]
    
    // Begin the loop from the back of the snake.
    mov r10, r11

snake_body_loop:

    // Each cell must decide what its next x and y must be — for body cells, the next higher cell in the snake; for the head, a function of its current position.
    cmp r10, #199
    beq head_update

    // Body cells must "become" the next cell in front of them
    ldr r8, [r10 + 1]
    str r8, [r10]

    add r10, r10, #1
    b snake_body_loop

head_update:
    ldr r8, 199

update_x:
    cmp r0, #37
    beq left
    cmp r0, #39
    beq right

    b update_y

    left:
        sub r8, r8, #0x00010000
        b store
    right:
        add r8, r8, #0x00010000
        b store

update_y:
    cmp r0, #38
    beq up
    cmp r0, #40
    beq down
    b store
    
    up:
        sub r8, r8, #0x00000001
        b store
    down:
        add r8, r8, #0x00000001
        b store

store:
    str r8, [r10]

draw_head:
    cmp r8, r9
    bne draw_body

eat_food:
    add r5, r5, #1
    
    // Randomly select new position for the food
    inp r2, 8
    ldr r4, rng_mask // Bit mask to extract coordinates in the valid range from the random bytes input
    and r9, r2, r4
    
    // Add the current final cell in the tail to the memory location before it
    sub r6, r11, #1
    str r12, [r6]

    // Push the back of the snake back by 1
    sub r11, r11, #1

    ldr r1, food_color
    mov r8, r9
    b draw_immediate

draw_body:
    mov r1, #0

draw:
    ldr r8, [r10]
draw_immediate: // If immediate mode is signalled like this, it is assumed r8 already contains the coordinates to draw to.

    lsr r7, r8, #16 // x

    lsl r6, r8, #16 // y
    lsr r6, r6, #16

    lsl r4, r6, #5 // Multiply y by 32
    add r4, r4, r7

    add r4, r4, #256

    str r1, [r4] // Draw color at correct pixel.

    ldr r3, white
    cmp r1, r3
    beq input // After the clear operation completes, return to the game loop.

    ldr r3, food_color
    cmp r1, r3
    beq draw_body

clear:
    // Clear the tail
    mov r8, r12
    
    cmp r8, r9 // If food is eaten, then do not clear the tail
    beq input

    ldr r1, white
    b draw_immediate

// Start food at the center. All future positions are random, though.
food_position:
    DAT 0x0010000C

// F
white:
    DAT 0xFFFFFFFF

// Like a red apple :D
food_color:
    DAT 0x00FF0000

// This is a binary number (used as an AND mask) which extracts only
// numbers in the range [0, 31] in the upper 2 bytes and [0, 23] in the lower 2.
// (The computer's RNG gives a word, i.e. 4 bytes, with randomized bits, so needs to be constrained for the food's new position.)
rng_mask:
    DAT 0x001e0017