[
  names⋄argNames⋄outType⋄argTypes
] ← •args

json ← •Import "../../imports/c-header-to-bqn-ffi/json.bqn"
out←⟨⟩

fmt←"scopes"‿"functions"
scopes‿functions ← ⊐⟜fmt⊸⊏˝json.Parse •FChars "auto-error.json"

[begin⋄end⋄nested⋄scopeDoc] ⇐ {
  ⍉>⊐⟜𝕩⊸⊏˝¨scopes
}"begin"‿"end"‿"nested"‿"doc"
nested ⊐˜↩ "false"⋈○<"true" # Turn json booleans into binary

[name⋄allow⋄disallow⋄funcDoc] ⇐ {⍋∘⊏⊸(⊏⎉1)𝕩} {
  ⍉>⊐⟜𝕩⊸⊏˝¨functions
}"name"‿"allowed cases"‿"disallowed cases"‿"doc"

# Define Assert. Needed for erroring
out ∾↩<"Assert ← {⍺←'assertion failure' ⋄ 0∊⍵:⍺ ⎕SIGNAL 8 ⋄ shy←0}"

# Defining scope status variables
@∘{𝕊⟨b⟩:
  out∾↩<"scope"∾b∾" ← 0"
}˘⍉[begin]

# Spacing to separate variable definitions section from Tradfns definition
out∾↩""‿""

# When the first argument is a pointer, it's usually a reference as return value.
# Useful since if first arg is a pointer, the function has a return value.
returnViaRef ← '*'={⊢´⊑𝕩∾<" "}¨argTypes

# Adding Tradfns with assertions
@∘{𝕊⟨n,aw,daw,an,r⟩:
  arg ← "_"⍟(0=≠)1↓∾' '∾¨an
  out∾↩<'∇'∾"r←"⊸∾⍟r n∾(' '⊸∾"("∾⁼∾⟜")"⁼)⍟(×∘≠∧∧´∘≠⟜' ') ('('∾∾⟜')')⍟(×≠) arg
  {𝕊:out∾↩<"    '"∾n∾" errored' Assert ∨/"∾𝕩}⍟(¬"()"⊸≡) "("∾")"∾˜3↓∾{") ("∾3↓∾" ∧ scope"⊸∾¨𝕩}¨aw
  {𝕊:out∾↩<"    '"∾n∾" errored' Assert ∧/"∾𝕩}⍟(¬"()"⊸≡) "("∾")"∾˜3↓∾{") ("∾3↓∾" ∨ scope"⊸∾¨𝕩}¨daw
  {𝕊:out∾↩<"    '"∾n∾" errored' Assert ~scope"∾⊑1⊑𝕩⋄!1≡≠1⊑𝕩}⍟(¬∧´∘⊑)(n⊸≡¨begin)⊸/¨nested‿begin
  {𝕊:out∾↩<"    scope"∾𝕩∾" ← 1"}∘⊑⍟(×≠) begin/˜n⊸≡¨begin
  {𝕊:out∾↩<"    scope"∾𝕩∾" ← 0"}∘⊑⍟(×≠) begin/˜n⊸≡¨end
  out∾↩"∇"⋈˜"    "∾(r⊑"_←"‿"r←")∾ (n∾"RAYLIB")∾ (¬×∘≠∧∧´∘≠⟜' ')◶⟨' '⊸∾⋄'('∾∾⟜')'⟩ arg

}˘⍉ [
  name
  allow
  disallow
  argNames
  returnViaRef∨"void"⊸≢¨outtype
]

out∾˜↩":Namespace replacements"‿""
out∾↩""‿":EndNamespace"

"../../link/replacements.apln.hide" •FLines out
