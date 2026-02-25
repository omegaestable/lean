import Lake
open Lake DSL

package LeanLab where
  leanOptions := #[
    ⟨`autoImplicit, false⟩
  ]

@[default_target]
lean_lib LeanLab where
  srcDir := "LeanLab"

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "master"

-- Uncomment to add LeanCopilot (AI-assisted tactic suggestions):
-- require LeanCopilot from git
--   "https://github.com/lean-dojo/LeanCopilot" @ "main"
