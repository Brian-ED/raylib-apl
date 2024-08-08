#!/usr/bin/dyalogscript
dir ← ⊃1⎕NPARTS''
rl ← 0⎕Fix dir,'../link/raylib.apln'
rl.Start '../libtemp-c-raylib.so' ⍝ TODO make it to init


white ← 4⍴255
black ← ¯4↑255
gray ← 150 150 150 255
red ← 255 0 0 255
_←rl.SetTraceLogLevel ,rl.TraceLogLevel.LOG_WARNING
_←rl.InitWindow 800 800 'Hello!!!'
_←rl.SetTargetFPS 60
_←rl.DisableCursor

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

model _ ← rl.LoadModelRetPtr (,⊂(⊂16⍴0),12⍴0) 'OBJ/RubberDuck_LOD0.obj'
position ← 0 0 0

⍝ ⎕NA somehow doesn't need padding at {F4 F4 F4}. Using {F4 F4 F4 U1 U1 U1 U1} makes the model dissapear.
⎕NA rl.pathToBinary,'|DrawModel {{F4 F4 F4 F4 F4 F4 F4 F4 F4 F4 F4 F4 F4 F4 F4 F4} I4 I4 P P P I4 U1 U1 U1 U1 P P} {F4 F4 F4} F4 {U1 U1 U1 U1 U1 U1 U1 U1}'

:While ~rl.WindowShouldClose
  camera ← rl.UpdateCamera ((,⊂camera) rl.CameraMode.CAMERA_THIRD_PERSON)
  rl.BeginDrawing
    rl.ClearBackground ,⊂8↑255 255 255 255
    rl.DrawFPS 40 40
    rl.BeginMode3D ,⊂,⊂camera
      DrawModel (model position 1 (8↑white))
      rl.DrawGrid 200 10
    rl.EndMode3D
  rl.EndDrawing
:EndWhile

_←rl.UnloadModel ,⊂model
_←rl.CloseWindow
