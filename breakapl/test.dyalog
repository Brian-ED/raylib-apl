⍝⎕NA '/mnt/0AD47A53D47A414D/Users/brian/Persinal/Scripts/APL/raylib-apl/breakapl/zig-out/lib/libbreakapl.so|sayFloat I4 I4 F4 F4 {U1 U1 U1 U1 U4} U8'
⍝ sayFloat 1 2 3 4 (5 6 7 8 9) 10
⍝ ⎕NA '/mnt/0AD47A53D47A414D/Users/brian/Persinal/Scripts/APL/raylib-apl/breakapl/zig-out/lib/libbreakapl.so|sayI8 I1 I1 I1 I1 I1 {U8 {U8 U4 U4} U1 U4 U2 U1}'
⍝ sayI8 1 2 3 4 5 (6 (7 8 0) 9 0 0 0)
⍝ ⎕←0
⍝ ⎕NA '/mnt/0AD47A53D47A414D/Users/brian/Persinal/Scripts/APL/raylib-apl/breakapl/zig-out/lib/libbreakapl.so|pad {U1 U4 U2 U1 U8}'
⍝ pad ,⊂(1 0 0 0 2)
⍝ ⎕←0
⍝ ⎕NA 'U4 /mnt/0AD47A53D47A414D/Users/brian/Persinal/Scripts/APL/raylib-apl/breakapl/zig-out/lib/libbreakapl.so|ret'
⍝ ⎕←ret
⍝ ⎕←''

⍝ Not useful tests
⍝⎕NA 'P libmain.so|strs >0C1'
⍝p ← ⊃strs ,⊂104 101 108 108 111 0 0 0
⍝⎕NA 'U1 libmain.so|indexStr P U4'
⍝⎕← indexStr¨ p,¨ ¯1+⍳6


⍝⎕NA 'zig-out/lib/libbreakapl.so|func2 {F8 U1}'
⍝func2 ,⊂1 2
⍝⎕NA 'zig-out/lib/libbreakapl.so|func2 {F8 U1 U1 U1 U1 U1 U1 U1 U1}'
⍝func2 ,⊂1 2 0 0 0 0 0 0 0

os ← ⎕←'-64'~⍨⊃#⎕WG'APLVersion'
:if os≡'Linux'
  ⎕SH 'zig build'
  lib ← 'zig-out/lib/libbreakapl.so'
:ElseIf os≡'Windows'
  ⎕CMD 'zig build'
  lib ← 'zig-out/bin/breakapl.dll'
:EndIf


⎕NA lib,'|func2 {F8 U1}'
func2 ,⊂1 2
⎕←⊃⎕NGET 'junk_file.txt'

⎕NA lib,'|func2 {F8 U1 U1 U1 U1 U1 U1 U1 U1}'
func2 ,⊂1 2 0 0 0 0 0 0 0
⎕←⊃⎕NGET 'junk_file.txt'

⎕NA lib,'|func2 {F8 U1 U1 U1 U1 U1 U1 U1 U1}'
FuncCoveredUp ← {func2 ,⊂(⊃⍵),7⍴0}
FuncCoveredUp ,⊂1 2
⎕←⊃⎕NGET 'junk_file.txt'

⎕NA lib,'|setFirstChar =C1[]'
⎕ ← setFirstChar ,⊂'hii'

⎕NA 'P ',lib,'|alloc U4'
⎕NA lib,'|free P'
⎕NA lib,'|setIndex P U4 U1'
⎕NA 'U1 ',lib,'|seeIndex P U4'
MakeArr ← {
  ptr ← alloc 1+≢⍵
  _←setIndex¨ ⍵,¨⍨ptr,¨¯1+⍳≢⍵
  _←setIndex ptr (≢⍵) 0
  ptr
}
SeeArr ← {seeIndex¨ ⍺,¨¯1+⍵}
ptr ← MakeArr 5 4 3 8
⎕←ptr SeeArr ⍳4
free ptr

⎕NA lib,'|structTestWindows {U1 U1 U1 U1 U1 U1 U1 U1}'
structTestWindows ,⊂150 150 150 150 0 0 0 0
⎕←⊃⎕NGET 'junk_file.txt'
⍝ main.color{ .r = 160, .g = 85, .b = 149, .a = 1 }
⍝ main.color{ .r = 0, .g = 86, .b = 149, .a = 1 }

⎕←0
