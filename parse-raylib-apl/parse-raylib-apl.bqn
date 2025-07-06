#!/usr/bin/env bqn
⟨ParseHeader,ToFFI,HeaderToFFI⟩ ← •Import "parseAPL.bqn"
file ← •FChars "../include/raylib.h"
file ParseHeader˜↩ "RLAPI"

defines‿structs‿aliases‿enums‿callbacks‿functions←file
funcName‿returnTypes ← <˘⍉>{funcName‿description‿retType‿argTypes‿args: funcName‿retType}¨functions

[names⋄comment⋄outType⋄argNames⋄argTypes] ←  ⍉funcName⍋⊸⊏>functions

[
  names
  argNames
  outType
  argTypes
] •Import "auto-error/auto-errors.bqn"

file ToFFI↩

file ∾⟜("AfterDefaultDefinitions mode"∾@+10)⌾(∾⟜"∇"⁼)↩
file ∾˜↩ ":Namespace raylib"∾@+10
file ∾ ↩ ":EndNamespace"∾˜@+10
file ∾↩ @+10
destination ← "../link/raylib.apln"
destination •FChars file
•Out destination∾" successfully generated"
