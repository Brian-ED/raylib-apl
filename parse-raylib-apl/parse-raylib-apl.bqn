⟨HeaderToFFI,SetPath⟩ ← •Import "parseAPL.bqn"
"output-raylib.apln" •FChars "../raylib.dll" SetPath "RLAPI" HeaderToFFI •FChars "raylib.h"
•Out "output-raylib.apln successfully generated"