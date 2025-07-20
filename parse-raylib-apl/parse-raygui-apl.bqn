#!/usr/bin/env bqn
⟨HeaderToFFI⟩ ← •Import "parseAPL.bqn"
file ← •FChars "include/raygui.h"
file {𝕩/˜¬∨`𝕩≠⊸↑𝕨⍷𝕩}˜↩ "/***********************************************************************************
*
*   RAYGUI IMPLEMENTATION
*
************************************************************************************/
"
file HeaderToFFI˜↩ "RAYGUIAPI"
file ∾˜↩ ":Namespace raygui"∾@+10
file ∾↩ ":EndNamespace"∾˜@+10
file ∾↩ @+10
destination ← "../link/raygui.apln"
destination •FChars  file
•Out destination∾" successfully generated"
