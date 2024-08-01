#!/usr/bin/env bqn
⟨HeaderToFFI⟩ ← •Import "parseAPL.bqn"
file ← •FChars "../lib/raygui.h"
file {𝕩/˜¬∨`𝕩≠⊸↑𝕨⍷𝕩}˜↩ "RAYGUI IMPLEMENTATION"
file HeaderToFFI˜↩ "RAYGUIAPI"
destination ← "../link/raygui.apln"
destination •FChars  file
•Out destination∾" successfully generated"