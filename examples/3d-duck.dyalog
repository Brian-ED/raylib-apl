#!/usr/bin/dyalogscript
dir ← ⊃1⎕NPARTS''
rl ← 0⎕Fix dir,'../link/raylib.apln'
rl.Init '../libtemp-c-raylib.so'

white ← 4⍴255
black ← ¯4↑255
gray ← 150 150 150 255
red ← 255 0 0 255
rl.SetTraceLogLevel ,rl.TraceLogLevel.LOG_WARNING
rl.InitWindow 800 800 'Hello!!!'
rl.SetTargetFPS 60
rl.DisableCursor

⍝ Define the camera to look into our 3d world
⍝ Camera position
⍝ Camera looking at point
⍝ Camera up vector (rotation towards target)
⍝ Camera field-of-view Y
⍝ Camera mode type

⍝texture ← rl.LoadTexture "resources/models/obj/castle_diffuse.png"
camera ← (50 50 50) (0 10 0) (0 1 0) 45 rl.CameraProjection.CAMERA_PERSPECTIVE 0 0 0 0

⍝ Model
⍝   Matrix transform;       // Local transform matrix
⍝   int meshCount;          // Number of meshes
⍝   int materialCount;      // Number of materials
⍝   Mesh *meshes;           // Meshes array
⍝   Material *materials;    // Materials array
⍝   int *meshMaterial;      // Mesh material number
⍝   int boneCount;          // Number of bones
⍝   BoneInfo *bones;        // Bones information (skeleton)
⍝   Transform *bindPose;    // Bones base transformation (pose)
model _ ← rl.LoadModelRetPtr ⍬ 'OBJ/RubberDuck_LOD0.obj'
position ← 0 0 0

:While ~rl.WindowShouldClose ⍝ For every frame till user closes the window
  camera ← rl.UpdateCamera ((,⊂camera) rl.CameraMode.CAMERA_THIRD_PERSON) ⍝ Look for keystrokes from user, move the camera
  rl.BeginDrawing ⍝ Preparing another buffer to draw the new frame
    rl.ClearBackground ,⊂8↑255 255 255 255
    rl.DrawFPS 40 40 ⍝ Draws FPS at x=40 y=40

    rl.BeginMode3D ,⊂,⊂camera ⍝ Draw 3d stuff relative to the camera
      rl.DrawModel (model position 1 (8↑white)) ⍝ Draw the duck model at position
      rl.DrawGrid 20 10 ⍝ This draws the grid
    rl.EndMode3D ⍝ Stop drawing 3d

  rl.EndDrawing ⍝ Switch to this new buffer.
:EndWhile

⍝ Unloading model, freeing it's memory.
rl.UnloadModel ,⊂model
rl.CloseWindow
