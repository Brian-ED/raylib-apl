#!/usr/bin/env bqn
⟨HeaderToFFI⟩ ← •Import "parseAPL.bqn"
file ← •FChars "../lib/raymath.h"
file HeaderToFFI˜↩ "RMAPI"
destination ← "../link/raymath.apln"
destination •FChars file
•Out destination∾" successfully generated"
