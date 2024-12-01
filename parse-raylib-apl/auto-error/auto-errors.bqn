json ← •Import "../json.bqn"

fmt←"scopes"‿"functions"
scopes‿functions ← ⊐⟜fmt⊸⊏˝json.Parse •FChars "auto-error.json"

[begin⋄end⋄scopeDoc] ⇐ {
  ⍉>⊐⟜𝕩⊸⊏˝¨scopes
}"begin"‿"end"‿"doc"

[name⋄allow⋄disallow⋄funcDoc] ⇐ {
  ⍉>⊐⟜𝕩⊸⊏˝¨functions
}"name"‿"allowed cases"‿"disallowed cases"‿"doc"
