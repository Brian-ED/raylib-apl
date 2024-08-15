#!cd $dir && /usr/bin/dyalogscript $fileName
dir ← ⊃1⎕NPARTS''
rl ← 0⎕Fix dir,'../link/raylib.apln'
rl.Init '../libtemp-c-raylib.so'

rl.InitWindow 800 800 'Hello!!!'
rl.DisableCursor

camera ← (50 50 50) (0 10 0) (0 1 0) 45 rl.CameraProjection.CAMERA_PERSPECTIVE 0 0 0 0
⍝ Define the camera to look into our 3d world
⍝ Camera position
⍝ Camera looking at point
⍝ Camera up vector (rotation towards target)
⍝ Camera field-of-view Y
⍝ Camera mode type

model _ ← rl.LoadModelRetPtr ⍬ 'OBJ/RubberDuck_LOD0.obj'
⍝ Matrix transform     ⍝ Local transform matrix
⍝ int meshCount        ⍝ Number of meshes
⍝ int materialCount    ⍝ Number of materials
⍝ Mesh *meshes         ⍝ Meshes array
⍝ Material *materials  ⍝ Materials array
⍝ int *meshMaterial    ⍝ Mesh material number
⍝ int boneCount        ⍝ Number of bones
⍝ BoneInfo *bones      ⍝ Bones information (skeleton)
⍝ Transform *bindPose  ⍝ Bones base transformation (pose)

⍝ For every frame till user closes the window
:While ~rl.WindowShouldClose
  ⍝ Look for keystrokes from user, move the camera
  camera ← rl.UpdateCamera ((,⊂camera) rl.CameraMode.CAMERA_THIRD_PERSON)

  ⍝ Preparing another buffer to draw the new frame, with white background
  rl.BeginDrawing
    rl.ClearBackground ,⊂8↑rl.color.white

    ⍝ Draws FPS at x=40 y=40
    rl.DrawFPS 40 40

    ⍝ Draw 3d stuff relative to the camera
    rl.BeginMode3D ,⊂,⊂camera

      ⍝ draws grid
      rl.DrawGrid 20 10

      ⍝ Draw the duck model at position
      position ← 0 0 0  ⋄  scale ← 1
      rl.DrawModel (model position scale (8↑rl.color.white))

    ⍝ Stop drawing 3d
    rl.EndMode3D

  ⍝ wait till next frame is needed, then switch to this new buffer we've drawn
  rl.EndDrawing
:EndWhile

⍝ Unloading model, freeing it's memory.
rl.UnloadModel ,⊂model
rl.CloseWindow
