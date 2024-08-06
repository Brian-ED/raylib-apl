#!/usr/bin/env bqn
⟨HeaderToFFI⟩ ← •Import "parseAPL.bqn"
file ← •FChars "../lib/raymath.h"
file HeaderToFFI˜↩ "RMAPI"
file ∾˜↩ ":Namespace raymath"∾@+10
file ∾ ↩ ":EndNamespace"∾˜@+10
destination ← "../link/raymath.apln"
destination •FChars file
•Out destination∾" successfully generated"
