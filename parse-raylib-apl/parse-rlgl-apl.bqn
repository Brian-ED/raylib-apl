#!/usr/bin/env bqn
⟨ToFFI⋄ParseHeader⟩ ← •Import "parseAPL.bqn"
map ← [
  "RL_ZERO"‿"RLGL_VERSION"
  "RLZERO" ‿"RLGLVersionString"
]

file ← •FChars "../lib/rlgl.h"
file ParseHeader˜↩ "RLAPI"
file ToFFI˜↩ map
destination ← "../link/rlgl.apln"
destination •FChars file
•Out destination∾" successfully generated"
