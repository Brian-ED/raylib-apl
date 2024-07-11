⟨HeaderToFFI,SetPath⟩ ← •Import "parseAPL.bqn"
"output-raylib.apln" •FChars "C:\Users\brian\Persinal\Scripts\C\raylib\src\raylib.dll" SetPath "RLAPI" HeaderToFFI •FChars "raylib.h"
•Out "output-raylib.apln successfully generated"