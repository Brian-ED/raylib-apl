# raylib-apl
raylib-apl is a library made to write cross-platform graphical applications using the Dyalog APL programming language.

## Features
<img align="right" style="width:240px" src="https://github.com/user-attachments/assets/bf969426-7741-4eda-aa03-5c90ee6f87de">

- Input-methods: Keyboard, Mouse, Controler and Touchscreen.
- Graphics: 2D, 3D, Sound, Text, Vector graphics, Images/Textures and shaders.
- Multiple Fonts formats supported (TTF, OTF, Image fonts, AngelCode fonts)
- Multiple texture formats supported, including compressed formats (DXT, ETC, ASTC)
- Full 3D support, including 3D Shapes, Models, Billboards, Heightmaps and more!
- Flexible Materials system, supporting classic maps and PBR maps
- Animated 3D models supported (skeletal bones animation) (IQM, M3D, glTF)
- Shaders support, including model shaders and postprocessing shaders
- Powerful math module for Vector, Matrix and Quaternion operations: raymath
- Audio loading and playing with streaming support (WAV, QOA, OGG, MP3, FLAC, XM, MOD)
- VR stereo rendering support with configurable HMD device parameters

# Warning
Breaking changes to any feature in raylib-apl should be expected for now, as this library is very young and experimental. If you experience code 999, there was likely a "segfault"/error in raylib.

# Documentation
raylib-apl currently only supports Linux. This is due to a bug in `⎕NA` that makes functions taking structs as arguments error.

## Getting started
*Feel free to watch [How to install raylib-apl on Linux](https://youtu.be/XdDAqfMHjwI?si=iEv_RxAfz94cIUQC) on youtube.*

raylib-apl requires a `libtemp-c-raylib.so` file, downloadable [here](https://github.com/Brian-ED/temp-c-raylib/releases/tag/v0.1.0).
The examples expect the file to be located at the `raylib-apl/` directory.

### Importing raylib
To import raylib-apl as a namespace, take the code below and replace `../` with the proper path to raylib-apl:
```apl
rlDir ← '../raylib-apl/link/',⍨⊃1⎕NPARTS''
rl ← 0⎕Fix rlDir,'raylib.apln'
rl.Init rlDir⍬
```
When making a script file like the raylib-apl's examples, I would recommend the `.apls` file extension and adding this line at the top of the script `#!cd $dir && /usr/bin/dyalogscript $fileName`.
You can give `rl.Init` a path as second argument that points to `libraylib.so`.
Use `⍬` to use the default path `raylib-apl/libraylib.so`.

### Using Link:
You may [\]Link](https://dyalog.github.io/link/4.0/API/) to the `raylib-apl/link` folder.
This imports `raylib.apln`, `rlgl.apln`, and `raymath.apln`, each of which are from [raylib](https://github.com/raysan5/raylib). A 2d physics library called [physac](https://github.com/victorfisac/Physac) is also included as `physac.apln`, and a GUI library called [raygui](https://github.com/raysan5/raygui) as `raygui.apln`.

Example using raylib with `]link` is shown below:
```apl
]cd /home/brian/Persinal/Scripts/APL/raylib-apl/link
]link.create # .
raylib.Init '' ⍬

⍝ Your raylib code starts here
_←raylib.InitWindow 800 800 'Hello!!!'
:While ~raylib.WindowShouldClose
    _←raylib.BeginDrawing
        _←raylib.ClearBackground ,⊂8↑raylib.color.gray
    _←raylib.EndDrawing
:EndWhile
_←raylib.CloseWindow
```

## Intro to raylib-apl

#### InitWindow
Developing an application with raylib-apl is very low level. The entirety of raylib-apl is about 200 functions that take in a list of inputs and returns some outputs, and/or change the state of the application. An example of changing the state of the application is the following:
```apl
raylib.InitWindow 400 400 'Title'
```
This function opens a new window, with width=400, height=400, and window title being "Title".
This changes the state of the computer screen of course, but it also changes something very important, it creates a kind of scope.

```apl
# Begin scope where window is open
raylib.InitWindow 400 400 'Title'

  # Inside this scope, I am allowed to use a lot more functions.

# End scope where window is open, meaning closing window
raylib.CloseWindow
```
Inside this scope, you are allowed a lot more. You can use functions like `SetWindowIcon`, `GetScreenWidth`, `GetMonitorCount`, `LoadShader`, `GetMouseRay`, and many more.
#### Scopes in detail
In the current version of raylib-apl, running a function that requires a scope outside that scope can crashe the Dyalog interpreter, or lead to unintended output.
Not closing a scope after starting it may also crash or give unintended output.

There are other functions that start and end scopes, like `StartDrawing` and `EndDrawing`. `StartDrawing` and `EndDrawing` require the `InitWindow` scope. Inside the `StartDrawing` scope you can use functions like `ClearBackground`, which sets the background of the window to a given color. An important note about `EndDrawing` is that it automatically delays to whatever frame-rate you choose, which by default is your monitor refresh rate. As an example, if your monitor has a refresh rate of 60 frames per second, `EndDrawing` will delay a maximum of `÷60`. I say "maximum", because `EndDrawing` delays just enough to keep your `:while` loop running 60 times a second, so if your loop takes `÷60` seconds to run, `EndDrawing` wouldn't delay.

#### First application
Applications made with raylib-apl have a common structure and style. As you can see by the below example, there's a `:while` loop used that draws the frame using `BeginDrawing`, where the frame being drawn is gray because of `ClearBackground` . This example is intentionally very simple, simply drawing a window with a black background.
```apl
rl.InitWindow 800 800 'abc' # Begin InitWindow scope

:While ~rl.WindowShouldClose # Run this loop per frame
  rl.BeginDrawing # Begin a drawing scope to draw the current frame
    rl.ClearBackground ⊂ 8↑ rl.color.gray # Set backrgound to gray
  rl.EndDrawing # End the Drawing scope
:EndWhile

rl.CloseWindow # End InitWindow scope
```
There are two exceptional things to notice in this example, soon to be changed in a future raylib-apl release, the line `ClearBackground ⊂ 8↑ rl.color.gray`. The two things to notice are the `8↑` and `⊂`.
##### Quirk 1: `8↑color`
Because of a low-level bug with the current version of raylib-apl, colors and some other structures given as arguments to functions must be padded by enough 0s. Colors require only 4 numbers to represent it, RGBA values, but the bug causes them to require 8 numbers. The low-level reason for this is that `⎕NA`, which raylib-apl relies upon, doesn't automatically pad the underlying representations of the structures automatically to make them align with C. This bug will hopefully be fixed soon, either by raylib-apl or by Dyalog.
##### Quirk 2: `ClearBackground ⊂`
If a raylib-apl function takes 1 or more arguments, they're expected to be a rank 1 or rank 0 array of arguments. This is why `rl.color.gray` is enclosed before given to `ClearBackground`, since it takes one argument that's a color, not 8 number arguments. This quirk is planned to be replaced, such that a function that takes 1 argument doesn't require the enclosed argument.

#### Now to start
To get a good start into raylib, mess around with the [examples](https://github.com/Brian-ED/raylib-apl/tree/master/examples) and see what you can make!

## Using dyalogscript
All raylib-apl examples support using [dyalogscript](https://help.dyalog.com/19.0/#UserGuide/Installation%20and%20Configuration/Shell%20Scripts.htm?Highlight=dyalogscript), by having the following on the top of every example:
`#!cd $dir && /usr/bin/dyalogscript $fileName`

# ⎕NA problems

Functions that `⎕NA` outputs can't return `F4`, it formats them incorrectly on Linux. Instead, give a struct in a pointer that C modifies.

argument of type `>U8` is ignored, but you still need to give ⎕NA the input type. Solved by just having a wrapper function in APL that passes `⍬`.

### Examples to make
Sound visualization example.
Game of life.
Visualize 3d arrays.

# Parsing `raylib.apln` and others (optional)
The auto-parsing isn't needed since the parser output is premade, though if you still need to parse, install CBQN to run it.

# Credits

### Dyalog Limited
raylib-apl has been financially supported by [Dyalog Limited](https://www.dyalog.com/).
Brian was hired as an intern by [Dyalog Limited](https://www.dyalog.com/) at about 7th of July 2024 to develop raylib-apl, alongside [Asher](https://github.com/asherbhs).
[The Dyalog team](https://www.dyalog.com/meet-team-dyalog.htm) have helped a lot with the development of this library.

### raylib
raylib-APL relies on the [raylib C library](https://github.com/raysan5/raylib/). Lots of thanks to raysan5 and the raylib community for this great library.

### Marshall Lochbaum
The current version of raylib-apl relies on [json.bqn made by Marshall Lochbaum](https://github.com/mlochbaum/bqn-libs/blob/master/json.bqn), more specifically json.bqn.
