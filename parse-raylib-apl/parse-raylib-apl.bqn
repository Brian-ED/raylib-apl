#!/usr/bin/env bqn
⟨ParseHeader,ToFFI,HeaderToFFI⟩ ← •Import "parseAPL.bqn"
file ← •FChars "../lib/raylib.h"
file ParseHeader˜↩ "RLAPI"

defines‿structs‿aliases‿enums‿callbacks‿functions←file
funcName‿returnTypes ← <˘⍉>{funcName‿description‿retType‿argTypes‿args: funcName‿retType}¨functions

sLines ← 0¨functions
s2Lines ← "void"⊸≢¨funcName⍋⊸⊏returnTypes
!¬∨´s2Lines∧sLines # I don't want the lines to collide

[names⋄comment⋄outType⋄argNames⋄argTypes] ←  ⍉(1+s2Lines∨sLines)/funcName⍋⊸⊏>functions

s1LinesExtended‿s2LinesExtended ← s2Lines{((+´+≠)𝕩+𝕨)↑𝕨⊸{(¬𝕩∊/𝕨)/𝕩+↕≠𝕩}⌾/𝕨+𝕩}{𝔽⋈𝔽˜}sLines

(1+s2Lines∨sLines)‿[
  s2LinesExtended
  s1LinesExtended
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
