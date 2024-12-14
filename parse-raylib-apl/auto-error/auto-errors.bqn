replic‿[
  s2LinesExtended⋄s1LinesExtended
  names⋄argNames⋄outType
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

# Adding tradfns with assertions
@∘{𝕊⟨n,aw,daw,an,r⟩:
  arg ← ('('∾')'⊸«)⍟(×≠)∾' '∾¨an # TODO arg names here can be simplified
  out∾↩<'∇'∾("r←")⊸∾⍟r n∾(' '⊸∾·"("⊸∾⁼∾⟜")"⁼)⍟(×∘≠∧∧´∘≠⟜' ')  arg      # This 1 here is temporary, a "catch all" for the incomplete auto-error txt file.
  out∾↩⋈"    '"∾n∾" errored' Assert ∨/"∾"1"⍟("()"⊸≡)"("⊸∾∾⟜")" 3↓∾") ("⊸∾¨{3↓∾" ∧ scope"⊸∾¨𝕩}¨aw
  out∾↩⋈"    '"∾n∾" errored' Assert ∧/"∾"⍬"⍟("()"⊸≡)"("⊸∾∾⟜")" 3↓∾") ("⊸∾¨{3↓∾" ∨ scope"⊸∾¨𝕩}¨daw
  {𝕊:
    out∾↩<"    scope"∾(⊑𝕩)∾" ← 1"
  }⍟(×≠)n⊸≡¨⊸/begin
  {𝕊:
    out∾↩<"    scope"∾(⊑𝕩)∾" ← 0"
  }⍟(×≠)(n⊸≡¨end)⊸/begin
  out∾↩<"    "∾("r←")⊸∾⍟r("RAYLIB"∾˜n)∾  ",⊂"⊸∾⍟(×∘≠∧∧´∘≠⟜' ')arg

  out∾↩<"∇"

  # Last time i was attempting to add retptr and raylib suffixes to extend auto-warnings to all functions in raylib-apl
}˘⍉ (∾⟜"RetPtr"¨⌾((»s2LinesExtended)⊸/)∾⟜"Ref"¨⌾((»s1LinesExtended)⊸/))⌾⊏ [replic/name,replic/allow,replic/disallow,argNames,"void"⊸≢¨outtype]

out∾˜↩":Namespace replacements"‿""
out∾↩""‿":EndNamespace"

"../replacements.apln" •FLines out
