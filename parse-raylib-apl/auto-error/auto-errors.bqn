replic‿[
  s2LinesExtended⋄s1LinesExtended
  names⋄argNames⋄outType⋄argTypes
] ← •args

json ← •Import "../json.bqn"
out←⟨⟩

fmt←"scopes"‿"functions"
scopes‿functions ← ⊐⟜fmt⊸⊏˝json.Parse •FChars "auto-error.json"

[begin⋄end⋄scopeDoc] ⇐ {
  ⍉>⊐⟜𝕩⊸⊏˝¨scopes
}"begin"‿"end"‿"doc"

[name⋄allow⋄disallow⋄funcDoc] ⇐ {⍋∘⊏⊸(⊏⎉1)𝕩} {
  ⍉>⊐⟜𝕩⊸⊏˝¨functions
}"name"‿"allowed cases"‿"disallowed cases"‿"doc"

# Define Assert. Needed for erroring
out ∾↩<"Assert ← {⍺←'assertion failure' ⋄ 0∊⍵:⍺ ⎕SIGNAL 8 ⋄ shy←0}"

# Defining scope status variables
@∘{𝕊⟨b⟩:
  out∾↩<"scope"∾b∾" ← 0"
}˘⍉[begin]

# Spacing to seperate variable definitions section from tradfns definition
out∾↩""‿""

# When the first argument is a pointer, it's usually a reference as return value.
# Useful since if first arg is a pointer, the function has a return value.
returnViaRef ← '*'={⊢´⊑𝕩∾<" "}¨argTypes

# Adding tradfns with assertions
@∘{𝕊⟨n,aw,daw,an,r,retPtrF⟩:
  arg ← 1↓∾' '∾¨an # TODO arg names here can be simplified
  out∾↩<'∇'∾"r←"⊸∾⍟r n∾(' '⊸∾"("∾⁼∾⟜")"⁼)⍟(×∘≠∧∧´∘≠⟜' ') ('('∾∾⟜')')⍟(×≠) arg
  out∾↩<"    '"∾n∾" errored' Assert ∨/"∾"1"⍟("()"⊸≡)"("∾")"∾˜3↓∾{") ("∾3↓∾" ∧ scope"⊸∾¨𝕩}¨aw
  out∾↩<"    '"∾n∾" errored' Assert ∧/"∾"⍬"⍟("()"⊸≡)"("∾")"∾˜3↓∾{") ("∾3↓∾" ∨ scope"⊸∾¨𝕩}¨daw
  {𝕊:out∾↩<"    scope"∾𝕩∾" ← 1"}∘⊑⍟(×≠) n⊸≡¨    ⊸/begin
  {𝕊:out∾↩<"    scope"∾𝕩∾" ← 0"}∘⊑⍟(×≠) n⊸≡¨∘end⊸/begin
  out∾↩"∇"⋈˜"    "∾"r←"⊸∾⍟r(n∾"RAYLIB")∾",⊂"⊸∾⍟(×∘≠∧∧´∘≠⟜' ') ('('∾∾⟜')')⍟(×≠) ("⍬"∾' '⊸∾⍟(×≠))⍟retPtrF arg

}˘⍉ [
  ∾⟜"RetPtr"¨⌾((»s2LinesExtended)⊸/)∾⟜"Ref"¨⌾((»s1LinesExtended)⊸/) replic/name
  replic/allow
  replic/disallow
  argNames
  returnViaRef∨"void"⊸≢¨outtype
  »s2LinesExtended
]

out∾˜↩":Namespace replacements"‿""
out∾↩""‿":EndNamespace"

"../replacements.apln" •FLines out
