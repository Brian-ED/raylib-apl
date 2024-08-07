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
pixelFormat_uncompressed_r8g8b8a8 ← 7

img ← 1000 1000 4⍴100⌿⍤¯1⊢1000 2 4⍴255 106 19 255  145 138 190 255

_←rl.InitWindow 800 800 'def'

⍝ ]cd C:\Users\brian\Persinal\Scripts\APL\raylib-apl\examples
⍝ ]create # .
⍝ ]boxing on
⍝ texture ⍬
ptr ← rl.MemAlloc ×/⍴img
                       ⍝ 13609856  1000 1000    1 7




⎕NA rl.pathToBinary,'|LoadTextureFromImageRetPtr ={U4 I4 I4 I4 I4 U1 U1 U1 U1} {P I4 I4 I4 I4}'
⎕NA rl.pathToBinary,'|UpdateTexture {U4 I4 I4 I4 I4 U1 U1 U1 U1} <U1[]'
⎕NA rl.pathToBinary,'|DrawTextureEx {U4 I4 I4 I4 I4 U1 U1 U1 U1} {F4 F4} F4 F4 {U1 U1 U1 U1 U1 U1 U1 U1}'
⎕NA rl.pathToBinary,'|UnloadTexture {U4 I4 I4 I4 I4 U1 U1 U1 U1}'
tex ← LoadTextureFromImageRetPtr (,⊂0 0 0 0 0 0 0 0 0) (ptr,(2↑⍴img),1 pixelFormat_uncompressed_r8g8b8a8)
rot ← 0
frame ← 0

rl.SetTargetFPS 60
:While ~rl.WindowShouldClose
    frame +← 1
    rot (90|+)← rl.GetMouseWheelMoveRetPtr ,⊂,⊂,0
    mp ← rl.GetMousePositionRetPtr ,⊂,⊂0 0
    rl.BeginDrawing
        rl.ClearBackground ,⊂black
        rl.DrawFPS 10 10
        {DrawTextureEx tex mp ⍵ 0.2 white}¨rot+90×⍳4
        UpdateTexture (tex (,frame⊖⍤2⊢img))
    rl.EndDrawing
:EndWhile

UnloadTexture ,⊂tex
rl.CloseWindow
