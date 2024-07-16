⟨HeaderToFFI⟩ ← •Import "parseAPL.bqn"
file ← •FChars "raylib.h"
file HeaderToFFI˜↩ "RLAPI"
destination ← "../link/raylib.apln"
destination •FChars file
•Out destination∾" successfully generated"