⟨HeaderToFFI,SetPath⟩ ← •Import "parseAPL.bqn"
file ← •FChars "raylib.h"
file HeaderToFFI˜↩ "RLAPI"
file SetPath˜↩ "../libraylib.so.5.0.0"⍟("linux"≡•platform.os)"../raylib.dll"
"output-raylib.apln" •FChars file
•Out "output-raylib.apln successfully generated"