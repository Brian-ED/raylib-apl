#!/usr/bin/dyalogscript
dir ← ⊃1⎕NPARTS''
⎕Fix dir,'../link/raylib.apln'
raylib.Start '../libtemp-c-raylib.so'

⍝ sizes of the shapes
rec←60 ⋄ cir←400

⍝ positions of the squares
distFromMiddle ← 170
outerRecs ← distFromMiddle×¯1+2×↑,¯1+⍳(2 2)

white ← 4⍴255
black ← ¯4↑255
gray ← 150 150 150 255
red ← 255 0 0 255
_←raylib.InitWindow 800 800 'Hello!!!'
_←raylib.SetTargetFPS 60

raylib.SetTraceLogLevel raylib.traceLogLevel.lOG_NONE

:While ~raylib.WindowShouldClose

    ⍝ mouse pos floored
    pos ← raylib.GetMousePositionRetPtr ,⊂,⊂0 0

    _←raylib.BeginDrawing
        _←raylib.ClearBackground ,⊂black,0 0 0 0
        _←raylib.DrawFPS 40 40
        _←raylib.DrawEllipse (red,0 0 0 0),∘⊂⍨pos,(200 200)
        _←{_←raylib.DrawRectangle (white,0 0 0 0),∘⊂⍨(rec rec),⍨⍵+pos-rec÷2}⍤¯1⊢ outerRecs
        ⍝ color, shape,         positions
        ⍝ this drawing function is being used to draw on a black canvas
    _←raylib.EndDrawing
:EndWhile
_←raylib.CloseWindow
