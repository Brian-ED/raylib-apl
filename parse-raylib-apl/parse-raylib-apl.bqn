#!/usr/bin/env bqn
⟨HeaderToFFI⟩ ← •Import "parseAPL.bqn"
file ← •FChars "../lib/raylib.h"
file HeaderToFFI˜↩ "RLAPI"
file ∾˜↩ ":Namespace raylib"∾@+10
file ∾ ↩ ":EndNamespace"∾˜@+10
destination ← "../link/raylib.apln"
destination •FChars file
•Out destination∾" successfully generated"