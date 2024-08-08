#!/usr/bin/dyalogscript
dir ← ⊃1⎕NPARTS''
rl ← ⎕Fix dir,'../link/raylib.apln'
rl.Start '../libtemp-c-raylib.so'
raylib.SetTraceLogLevel raylib.TraceLogLevel.LOG_WARNING

gray  ← 8↑150 150 150 255
black ← 8↑  0   0   0 255
red   ← 8↑255   0   0 255
blue  ← 8↑  0   0 255 255
white ← 8↑255 255 255 255
dyalogOrange ← 145 138 190 255
dyalogBlue   ← 255 106  19 255
pixelFormat_uncompressed_r8g8b8a8 ← 7

img ← ,1000 1000⍴100/1000 2⍴256⊥¨⌽¨dyalogBlue dyalogOrange

_←rl.InitWindow 800 800 'def'
rl.SetTargetFPS rl.GetMonitorRefreshRate 0

⍝ ]cd C:\Users\brian\Persinal\Scripts\APL\raylib-apl\examples
⍝ ]create # .
⍝ ]boxing on
⍝ texture ⍬
ptr ← rl.MemAlloc 4×≢img
                       ⍝ 13609856  1000 1000    1 7

tex ← rl.LoadTextureFromImageRetPtr (,⊂0 0 0 0 0 0 0 0 0) (ptr 1000 1000 1 pixelFormat_uncompressed_r8g8b8a8)
rot ← 0

frame ← 0
'Memcpy' ⎕NA rl.pathToBinary,'|memcpy P <U4[] U8'

:While ~rl.WindowShouldClose
    img ⊖⍨← 1
    rot (90|+)← rl.GetMouseWheelMoveRetPtr ,⊂,⊂,0
    mp ← rl.GetMousePositionRetPtr ,⊂,⊂0 0
    rl.BeginDrawing
        rl.ClearBackground ,⊂black
        rl.DrawFPS 10 10
        {rl.DrawTextureEx tex mp ⍵ 0.2 white}¨rot+90×⍳4
        Memcpy (ptr img (4×≢img))
        rl.UpdateTexture (tex ptr)
    rl.EndDrawing
:EndWhile

rl.UnloadTexture ,⊂tex
rl.CloseWindow
