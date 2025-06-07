#!/usr/bin/env bqn
ToFFI‿ParseHeader ← •Import "parseAPL.bqn"
file ← •FChars "../lib/physac.h"
file {𝕩/˜¬∨`𝕩≠⊸↑𝕨⍷𝕩}˜↩ "PHYSAC IMPLEMENTATION"
file ParseHeader˜↩ "PHYSACDEF"
file ToFFI˜↩ "PhysicsShapeType"≍○⋈"i"
file ∾˜↩ ":Namespace physac"∾@+10
file ∾↩ ":EndNamespace"∾˜@+10
file ∾↩ @+10
destination ← "../link/physac.apln"
destination •FChars  file
•Out destination∾" successfully generated"
