
ToFFI‿ParseHeader ← •Import "parseAPL.bqn"
file ← •FChars "include/physac.h"
file {𝕩/˜¬∨`𝕩≠⊸↑𝕨⍷𝕩}˜↩ "/***********************************************************************************
*
*   PHYSAC IMPLEMENTATION
*
************************************************************************************/
"
file ParseHeader˜↩ "PHYSACDEF"
file ToFFI˜↩ [
  "PhysicsShapeType"‿"PhysicsBody"
  "i"               ‿"ptr"
]
file ∾˜↩ ":Namespace physac"∾@+10
file ∾↩ ":EndNamespace"∾˜@+10
file ∾↩ @+10
destination ← "../link/physac.apln"
destination •FChars  file
•Out destination∾" successfully generated"
