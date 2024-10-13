
# raylib-apl
raylib-apl is a library made to write cross-platform graphical applications using the Dyalog APL programming language.

Breaking changes to any feature in raylib-apl should be expected for now, as this library is very young and experimental. Read further on under "Warning".

# Documentation
raylib-apl currently only supports windows. This is due to a bug in `⎕NA` that makes functions taking structs as arguments error.

# Getting started
Current examples expect a `libraylib.so` file to be in the raylib-apl directory, downloadable [here](https://github.com/raysan5/raylib/releases/tag/5.0). Make sure you download raylib version `5.0`, and to specifically take out the `libraylib.so` from the `lib` folder. You may delete the rest.

### Importing raylib
run the following:
`rl ← 0 ⎕FIX (⊃1⎕NPARTS''),'../parse-raylib-apl/setup.apln'`

To import all names in raylib to current scope, run the following:
`⎕THIS ⎕NS 0 ⎕FIX (⊃1⎕NPARTS''),'../parse-raylib-apl/setup.apln'`

After importing raylib, Give `rl.Init` left argument of 1 to not modify raylib at all. 0 as left argument to Init runs default changes. If no left argument given, default to 1.
```
rl.Init 'path to binary.so'
```

# Warning
Breaking changes to any feature in raylib-apl should be expected for now, as this library is very young and experimental. You will crash Dyalog a lot. If you experience code 999, there was likely a "segfault"/error in raylib. These are usually due to using functions in the wrong contexts, like drawing a box before `rl.BeginDrawing`, or loading an image before opening the window.


## Using Link: (UNFINISHED DOCUMENTATION)
Then [\]Link](https://dyalog.github.io/link/4.0/API/) to the examples directory and run the examples as functions.

## Using dyalogscript: (UNFINISHED DOCUMENTATION)

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
