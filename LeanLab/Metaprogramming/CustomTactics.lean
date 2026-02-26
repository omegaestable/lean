import Lean
import Lean.Elab.Tactic
import Mathlib.Tactic

/-!
# Phase 3A — Custom Tactics and Metaprogramming

This is where Lean goes from being a proof assistant to being a
*programmable proof assistant*. Everything you've used so far — `simp`,
`ring`, `omega` — was built using the same APIs you'll learn here.

Don't be intimidated! You'll start with tiny tactics (5 lines) and
gradually build up intuition. By the end, you'll understand how AI tools
like LeanDojo interact with Lean under the hood.

## Why metaprogramming matters
Metaprogramming is how you EXTEND Lean itself. This is critical for:

1. **AI integration**: AI theorem provers interact with Lean through the
   same APIs available to metaprograms (goals, tactics, proof states)
2. **Proof automation**: Write tactics that automate repetitive proof patterns
3. **Domain-specific tools**: Build specialized automation for your research area
4. **LeanDojo/Pantograph**: These tools are built on Lean's metaprogramming APIs

## Learning objectives
After this file you will be able to:
  1. Understand the `TacticM` monad and proof states
  2. Write a simple custom tactic using `elab`
  3. Read and inspect goals and hypotheses
  4. Combine existing tactics into new ones
  5. Understand how AI tools use the same APIs

## What you'll learn
- The `TacticM` monad (the monad tactics run in)
- Reading and manipulating proof goals
- Writing custom tactics
- Macros and syntax extensions
- How this connects to AI/Lean toolchains
-/

open Lean Elab Tactic Meta

-- ============================================================
-- SECTION 1: Understanding the Tactic Monad
-- ============================================================

-- 💡 DON'T PANIC about the word "monad." For our purposes,
-- `TacticM` just means "a computation that can read and modify
-- the current proof state." Think of it as a context where you
-- can ask "what's the current goal?" and "what hypotheses do I have?"

/-!
## The mental model

When you write `by intro h; exact h`, Lean processes this as:
1. Create an initial proof state with the goal
2. Run `intro h` — this transforms the proof state
3. Run `exact h` — this transforms the proof state again
4. If no goals remain, the proof is complete

Each tactic is a function in the `TacticM` monad:
  `TacticM Unit`

The monad gives you access to:
- `getMainGoal` — the current goal (an `MVarId`)
- `getGoals` / `setGoals` — all remaining goals
- `getMainTarget` — the type of the current goal
- `getLocalDecls` — hypotheses in the current context
-/

-- ============================================================
-- SECTION 2: Your first custom tactic
-- ============================================================

-- Let's start small. The pattern for defining a new tactic is:
--    elab "tactic_name" : tactic => do
--      ... code in TacticM ...
--
-- The `elab` command says "when Lean sees `tactic_name` in a proof,
-- run this code."  Let's make one that just SHOWS the current goal.

-- A tactic that just logs the current goal to the info view
elab "show_goal" : tactic => do
  let goal ← getMainGoal
  let goalType ← goal.getType
  logInfo m!"Current goal: {goalType}"

-- Try it:
example : 1 + 1 = 2 := by
  show_goal    -- will display "Current goal: 1 + 1 = 2"
  rfl

-- A tactic that counts hypotheses
elab "count_hyps" : tactic => do
  let ctx ← getLCtx
  let count := ctx.decls.toList.filterMap id |>.length
  logInfo m!"You have {count} hypotheses in context"

example (h1 : True) (h2 : 1 = 1) : True := by
  count_hyps   -- "You have 2 hypotheses in context"
  exact h1

-- ============================================================
-- SECTION 3: A more useful custom tactic
-- ============================================================

-- A tactic that tries `rfl`, then `simp`, then `omega`
-- (a "kitchen sink" approach — try common closers)
elab "auto_close" : tactic => do
  let goal ← getMainGoal
  -- Try rfl
  try
    goal.refl
    return
  catch _ => pure ()
  -- Try simp
  try
    evalTactic (← `(tactic| simp))
    return
  catch _ => pure ()
  -- Try omega
  try
    evalTactic (← `(tactic| omega))
    return
  catch _ => pure ()
  throwError "auto_close: none of rfl, simp, omega worked"

-- Test it:
example : 1 + 1 = 2 := by auto_close
example (n : Nat) : n + 0 = n := by auto_close
example (n : Nat) : n < n + 1 := by auto_close

-- ============================================================
-- SECTION 4: Macros and syntax extensions
-- ============================================================

-- Macros are simpler than full tactics — they're syntax transformations

-- A macro that expands to a common proof pattern
macro "by_obvious" : tactic =>
  `(tactic| first | rfl | simp | omega | norm_num | decide | trivial)

example : 2 + 3 = 5 := by by_obvious
example : ¬(3 = 4) := by by_obvious
example (n : Nat) : n ≤ n := by by_obvious

-- A macro for "prove by contradiction using omega"
macro "omega_contra" : tactic =>
  `(tactic| (by_contra h; push_neg at h; omega))

-- ============================================================
-- SECTION 5: Working with expressions (Expr)
-- ============================================================

/-!
## Lean's internal representation

💡 Think of `Expr` as Lean's "machine language for math."
Every definition, theorem, type, and proof is stored as an `Expr`.
When you write `2 + 3`, Lean converts it to something like
`Expr.app (Expr.app (Expr.const `HAdd.hAdd ...) 2) 3`.

The main constructors:
- `Expr.const` — named constants like `Nat.add`
- `Expr.app` — function application
- `Expr.lam` — lambda abstraction
- `Expr.forallE` — dependent function type (∀)
- `Expr.mvar` — metavariable (unknown/goal)
- `Expr.lit` — literals (numbers, strings)

Understanding `Expr` is essential for:
- Extracting proof data for AI training (LeanDojo does this)
- Building custom proof search strategies
- Analyzing proof structure programmatically
-/

-- Inspect expressions with #check and metaprogramming
#check @Expr.const
#check @Expr.app

-- A command that decomposes an expression and shows its structure
elab "#inspect " t:term : command => do
  let e ← Elab.Command.liftTermElabM do
    let e ← Term.elabTerm t none
    Term.synthesizeSyntheticMVarsNoPostponing
    return e
  logInfo m!"Expression: {e}"
  logInfo m!"Type: {← Elab.Command.liftTermElabM (inferType e)}"

-- ============================================================
-- SECTION 6: Connection to AI/Lean toolchains
-- ============================================================

/-!
## How AI theorem provers use these APIs

### LeanDojo
LeanDojo uses Lean's metaprogramming APIs to:
1. Extract proof states (goals + hypotheses) at each tactic step
2. Build a dataset of (state, tactic, next_state) triples
3. Train models to predict tactics given proof states
4. Verify AI-generated proofs by replaying tactics

### Pantograph / PyPantograph
Pantograph provides a REPL interface to Lean's proof engine:
1. Send a theorem statement → get initial proof state
2. Send a tactic → get new proof state(s)
3. Repeat until no goals remain
4. AI models interact with this API to search for proofs

### The key insight
Everything a human does in VS Code tactic mode, an AI model can
do programmatically through these same APIs. Custom tactics you write
can be used by both humans and AI agents.

### Data extraction for training
The proof state at each step contains:
- Goal type (what needs to be proved)
- Local context (available hypotheses)
- Available lemmas (from imports)
This becomes the INPUT to an AI model.
The tactic that was applied becomes the LABEL.
-/

-- ============================================================
-- TRY IT YOURSELF
-- ============================================================

-- 1. Write a tactic that prints all hypothesis names and types
-- elab "list_hyps" : tactic => do
--   sorry

-- 2. Write a macro `prove_eq` that tries `ring` first, then `omega`, then `norm_num`
-- macro "prove_eq" : tactic => ...

-- 3. (Advanced) Write a tactic that automatically applies all hypotheses
--    of the form `h : a = b` as rewrites
-- elab "rw_all" : tactic => do
--   sorry
