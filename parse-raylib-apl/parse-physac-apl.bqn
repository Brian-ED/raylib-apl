#!/usr/bin/env bqn
⟨ParseHeader
GetFiles
FFISetup
ToFFI
MakeReplacement⟩ ← •Import "parseAPL.bqn"

libName ← "physac"
libPrefix ← "PHYSACDEF"

⟨ header ⋄ autoErrorJson ⋄ replacementFilename
  replacement ⋄ linkOutput
⟩ ← GetFiles libName

header {𝕩/˜¬∨`𝕩≠⊸↑𝕨⍷𝕩}˜↩ "/***********************************************************************************
*
*   PHYSAC IMPLEMENTATION
*
************************************************************************************/
"
·‿·‿·‿·‿·‿functions ← headerTree ← libPrefix ParseHeader header
replacement •FLines libName‿autoErrorJson MakeReplacement ⍉(⍋⊏˘)⊸⊏(↕0‿5)∾´functions

linkOutput •FChars libName‿replacementFilename FFISetup [
  "PhysicsShapeType"‿"PhysicsBody"
  "i"               ‿"ptr"
] ToFFI headerTree
•Out linkOutput∾" successfully generated"
