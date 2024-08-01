#!/usr/bin/env bqn
⟨HeaderToFFI⟩ ← •Import "parseAPL.bqn"
file ← •FChars "../lib/raylib.h"
file HeaderToFFI˜↩ "RLAPI"
destination ← "../link/raylib.apln"
destination •FChars file
•Out destination∾" successfully generated"