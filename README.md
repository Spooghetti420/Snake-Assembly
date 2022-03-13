# Snake Assembly
This project is the classic, unmistakable game of "Snake", faithfully ported to what is effecively ARM assembly, with some extensions tacked on. It has only the most basic features to reduce all bloat and keep the game lightweight and enjoyable.

## Running
Any more and there is a good chance that the game would become interolably slow much too quickly.
I worked diligently to create a vaguely enjoyable rendition of Snake that also runs in the browser!
In order to run the program in its intended environment, go to [https://peterhigginson.co.uk/AQA](), either pressing "Load" and selecting the assembly source file, or copy-pasting the contents into the assembler.
NOTE: It is *highly* recommended that you hit the "OPTIONS" dropdown and select `def fast` before beginning the game with the "Run" button.
As a further suggestion, you should also additionally hit the `>>` symbol to increase the rate all the way up to 24.9. The game will wait for your first input, so you do not need to worry about hitting into a wall while cranking up the speed. 

## Minimal versions
(Note: these are not yet implemented, or I've forgotten to remove this notice...)

The purpose of the minimal versions of the game is to keep the game, ultimately, playable.
As you may notice playing the full, stable version of the game, the virtualiser is not intended for this kind of
program, I would imagine, and thus fastidiously animates all frames of execution of each instruction,
updating memory addresses visually as it goes, and at the end of the day, simply wastes far too much time processing these.
There will be two minimal source files also attached; one will lack any kind of input validation, so if you press a key that is
not valid, the snake will halt in place and slowly compress into a single tile (don't worry, it will grow back upon re-movement).
The second will "feature" the same lacks as the first one, but will also not bother with the collision check either.
This constitutes a reasonable component of the lag that larger snake sizes induce. It is part of the fundamental problem that
updating the snake as it increases in size is ultimately an O(n) process, so we waste more and more time doing this as the snake
grows. As this is fundamental to the gameplay, this is not something that can be circumvented, but I wanted to make a release that
fundamentally does feature "a snake", and one which can grow, but that relies on the user's honesty as to when they have lost, instead
leveraging the reduced bloat to gain a little bit of FPS.

