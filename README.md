# Snake Assembly
This project is the classic, unmistakable game of "Snake", faithfully ported to Peter Higginson's assembly simulator, allowing you to play it in the browser. It has only the most basic features to reduce all bloat and keep the game lightweight and enjoyable.

## Running
In order to run the program in its intended environment, go to [https://peterhigginson.co.uk/AQA](https://peterhigginson.co.uk/AQA), either pressing "Load" and selecting the assembly source file, or copy-pasting the contents into the assembler.

It is *highly* recommended that you hit the "OPTIONS" dropdown and select `def fast` before beginning the game with the "Run" button.
As a further suggestion, you should also hit the `>>` button to increase the rate all the way up to 24.9. The game will wait for your first input, so you do not need to worry about hitting into a wall while cranking up the speed. 

## Minified version

### Reading off your score
The minified version relies on the fact that the snake will attempt to render at an invalid address when it runs off the edge,
so the program will simply crash if you wander off the side. (This, incidentally, is the only way to lose…)
Your score is stored in the register R5, so you can use that at the end of the game to see your score.
Do be aware, as it is possible that the registers flow over their intended boundaries, so if you see a "65536" as your score, try the ones around it!

### Why?
The purpose of the minimal version of the game is to speed up the game to easen the gameplay at the later stages.
As you may notice playing the full, stable version of the game, the virtualiser is not intended for this kind of
program, and thus fastidiously animates all frames of execution of each instruction,
updating memory addresses visually as it goes, expending much time on updating the machine and playing its animations.
The minified version (see: `snake.min.asm`) is significantly reduced in size, lacking hit detection (be honest with yourself :P),
a proper game over screen, or input validation. These trade-offs reduce the program's memory and processing footprints,
albeit at the cost of the game's functionality. Hopefully, if you are having trouble with the game in its fully-fledged form
due to lag, this version will be more palatable and to your liking.
Unfortunately, I am faced with the fundamental problem that updating the snake as it increases in size is ultimately an O(n) process, since each cell depends on the one above it to update its position. 
Thusly, as far as I know, there is no way to circumvent spending increasing amounts of time doing this as the snake grows.