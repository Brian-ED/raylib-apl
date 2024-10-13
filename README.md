<img align="left" style="width:124px" src="https://github.com/user-attachments/assets/b89f440b-e804-4c1b-ada9-820826fb8b08">

# raylib-apl
raylib-apl is a library made to write cross-platform graphical applications using the Dyalog APL programming language.

---

The feature-set of raylib-apl is:  
- Input-methods: Keyboard, Mouse, Controler and Touchscreen.  
- Graphics: 2D, 3D, Sound, Text, Vector graphics, Images/Textures and shaders.

# Warning
Breaking changes to any feature in raylib-apl should be expected for now, as this library is very young and experimental. You will crash Dyalog a lot. If you experience code 999, there was likely a "segfault"/error in raylib. These are usually due to using functions in the wrong contexts, like drawing a box before `rl.BeginDrawing`, or loading an image before opening the window.

# Documentation
raylib-apl currently only supports windows. This is due to a bug in `⎕NA` that makes functions taking structs as arguments error.

# Getting started
Current examples expect a `libtemp-c-raylib.so` file to be in the `raylib-apl/` directory, downloadable [here](https://github.com/Brian-ED/temp-c-raylib/releases/tag/v0.1.0).

### Importing raylib
To import raylib-apl as a namespace, run the following:
```apl
rl ← 0⎕Fix (⊃1⎕NPARTS''),'../link/raylib.apln'
rl.Init⍬
```
You can give `rl.Init` a path as argument that points to `libraylib.so`.
Use `⍬` to use the default path `raylib-apl/libraylib.so`.

## Using Link:
You may [\]Link](https://dyalog.github.io/link/4.0/API/) to the `raylib-apl/link` folder.
This imports `raylib.apln`, `rlgl.apln`, and `raymath.apln`, each of which are from [raylib](https://github.com/raysan5/raylib). A 2d physics library called [physac](https://github.com/victorfisac/Physac) is also included as `physac.apln`, and a GUI library called [raygui](https://github.com/raysan5/raygui) as `raygui.apln`.

Example using raylib with `]link` is shown below:
```apl
]cd /mnt/0AD47A53D47A414D/Users/brian/Persinal/Scripts/APL/raylib-apl/link
]link.create # .
raylib.Init⍬

⍝ Your raylib code starts here
_←raylib.InitWindow 800 800 'Hello!!!'
:While ~raylib.WindowShouldClose
    _←raylib.BeginDrawing
        _←raylib.ClearBackground ,⊂8↑raylib.color.gray
    _←raylib.EndDrawing
:EndWhile
_←raylib.CloseWindow
```

## Using dyalogscript
All raylib-apl examples support using [dyalogscript](https://help.dyalog.com/19.0/#UserGuide/Installation%20and%20Configuration/Shell%20Scripts.htm?Highlight=dyalogscript), by having the following on the top of every example:
`#!cd $dir && /usr/bin/dyalogscript $fileName`

# ⎕NA problems

### Solved
`⎕NA` can't return `F4`, it formats them incorrectly on Linux. Instead, give a struct in a pointer that C modifies.

### Unsolved
argument of type `>U8` is ignored, but you still need to give ⎕NA the input type.

# TODO
Use `:require ../parse-raylib-apl/setup.apln` syntax for doing proper imports relative to the file rather than current directory.

Auto pad stuff on APL side.

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
