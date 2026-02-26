import Mathlib.Tactic

/-!
# 14 — AI-Assisted Theorem Proving: The Landscape

Everything you've learned so far — Lean syntax, logic, tactics,
Mathlib, metaprogramming — feeds directly into this section.
AI-assisted theorem proving is the reason many people learn Lean,
and this file will show you how all the pieces connect.

Read this file *actively*: place your cursor on the `by` blocks and
watch the Infoview panel. That's exactly what an AI model "sees."

## The big picture
AI-assisted theorem proving is the intersection of:
- **Formal methods** (Lean, Coq, Isabelle)
- **Machine learning** (LLMs, RL, search algorithms)
- **Mathematics** (the subject being formalized)

This file provides an executable overview of the key concepts,
tools, and research directions. It's designed to orient you in
the field and connect your Lean skills to AI applications.

## Key systems (as of 2025)
- **Aristotle** (Harmonic) — IMO gold-medal level, Lean 4 based
- **AlphaProof** (DeepMind) — IMO silver-medal level, Lean 4 based
- **DeepSeek-Prover** (DeepSeek) — strong on miniF2F, open-weight
- **LeanCopilot** (Caltech/LeanDojo) — VS Code integration
- **COPRA / ReProver** — research systems for tactic prediction

## Learning objectives
After this file you will be able to:
  1. Explain how AI models interact with Lean proof states
  2. Describe the (state, tactic, next_state) training data format
  3. Name the major benchmarks and their purposes
  4. Identify the main research directions in AI-assisted proving
  5. Understand the proof search problem formulation

## What this file covers
- How AI interacts with Lean (the proof state API)
- Training data: what it looks like and where it comes from
- Benchmarks: miniF2F, ProofNet, FormL4, FormalMATH
- Research directions aligned with the Aristotle grant
-/

-- ============================================================
-- SECTION 1: The Proof State — What AI "Sees"
-- ============================================================

-- 💡 THIS IS THE MOST IMPORTANT CONCEPT FOR AI+LEAN.
-- Every AI theorem prover works by reading proof states and
-- predicting tactics. If you understand proof states, you
-- understand 90% of how these systems work.

/-!
When you write a tactic proof, at each step there is a **proof state**:

```
case succ
n : Nat
ih : 0 + n = n
⊢ 0 + (n + 1) = n + 1
```

This state has:
1. **Case name**: `succ` (which branch of induction we're in)
2. **Local context**: `n : Nat`, `ih : 0 + n = n` (available hypotheses)
3. **Goal**: `0 + (n + 1) = n + 1` (what we need to prove)

An AI model receives this state as TEXT and predicts the next TACTIC.

The model might predict: `simp [Nat.add_succ, ih]`

If the tactic succeeds, the proof state changes. If all goals are closed,
the proof is complete. If the tactic fails, the model tries another one.

This is fundamentally a SEARCH problem:
- State space: proof states
- Actions: tactics
- Goal: reach a state with no remaining goals
- Search strategy: beam search, MCTS, best-first, etc.
-/

-- Let's see some proof states by working through a proof step-by-step.
-- Put your cursor on each line to see the state in the Infoview.

theorem demo_proof_state (n : Nat) : n + 0 = 0 + n := by
  -- STATE: n : Nat ⊢ n + 0 = 0 + n
  rw [Nat.add_zero]
  -- STATE: n : Nat ⊢ n = 0 + n
  rw [Nat.zero_add]
  -- STATE: (no goals) ✓

-- A more complex example — watch the state evolve:
theorem demo_induction (n : Nat) : 0 + n = n := by
  -- STATE: n : Nat ⊢ 0 + n = n
  induction n with
  | zero =>
    -- STATE: ⊢ 0 + 0 = 0
    rfl
  | succ k ih =>
    -- STATE: k : Nat, ih : 0 + k = k ⊢ 0 + (k + 1) = k + 1
    rw [Nat.add_succ, ih]

-- ============================================================
-- SECTION 2: Training Data Format
-- ============================================================

/-!
## What AI training data looks like

LeanDojo extracts (state, tactic, next_state) triples:

```json
{
  "state_before": "n : Nat ⊢ n + 0 = 0 + n",
  "tactic": "rw [Nat.add_zero]",
  "state_after": "n : Nat ⊢ n = 0 + n"
}
```

A full proof becomes a sequence of such triples.
The model learns: given `state_before`, predict `tactic`.

## Data sources
- **Mathlib**: ~200K+ theorems, millions of tactic steps
- **miniF2F**: 488 competition-style problems (AMC/AIME/IMO)
- **ProofNet**: undergraduate math problems
- **FormL4**: autoformalized problems from textbooks
- **FormalMATH**: curated formal math benchmark

## Premise selection
Beyond tactic prediction, models also need **premise selection**:
given the current goal, which lemmas from the library are relevant?
This is essentially a retrieval problem (like RAG for proofs).
-/

-- ============================================================
-- SECTION 3: The Tools of the Trade
-- ============================================================

/-!
## LeanDojo (lean-dojo/LeanDojo-v2)
**Purpose**: Extract training data from Lean repos, interact programmatically
**Use case**: Building datasets, training models, evaluating provers
**Language**: Python
**Install**: `pip install lean-dojo`

Key capabilities:
- Trace Lean repos to extract proof states and tactics
- Interact with Lean through a Python API
- Train and evaluate tactic prediction models (ReProver)
- Dataset of Mathlib proofs pre-extracted

## PyPantograph (stanford-centaur/PyPantograph)
**Purpose**: Machine-to-machine REPL for Lean 4
**Use case**: Real-time proof interaction for AI agents
**Language**: Python
**Install**: `pip install pantograph`

Key capabilities:
- Start a proof, send tactics, receive new proof states
- Manage multiple proof goals simultaneously
- Validate entire files
- Extract tactic invocation data

## LeanCopilot
**Purpose**: AI-powered VS Code extension for Lean 4
**Use case**: Interactive AI assistance while writing proofs
**Features**: Suggests next tactics, fills in `sorry`s, premise search

## REPL / Lean4Web
**Purpose**: Web-based or command-line Lean 4 interaction
**Use case**: Quick experiments, CI/CD integration, demos
-/

-- ============================================================
-- SECTION 4: Benchmarks deep dive
-- ============================================================

/-!
## miniF2F
- 488 problems from AMC, AIME, IMO, and math courses
- Translated to Lean 4, Isabelle, Metamath, HOL Light
- Standard benchmark for AI theorem provers
- Repo: github.com/openai/miniF2F
- Note: Some translations have known issues (misformalizations)
- Current SOTA: ~60-70% (Aristotle, DeepSeek-Prover-V2)

## ProofNet
- Undergraduate-level math problems
- Covers algebra, analysis, topology
- More diverse than miniF2F but less standardized

## FormL4
- Autoformalized problems using LLMs
- Tests the autoformalization pipeline, not just proving
- Key paper: "Process-Driven Autoformalization in Lean 4"

## FormalMATH
- Curated benchmark for formal mathematics
- Broader than miniF2F, includes more varied problem types
- Recent addition to the benchmark landscape

## PutnamBench
- Problems from the Putnam competition
- Very challenging — tests the frontier of AI proving
-/

-- ============================================================
-- SECTION 5: Autoformalization
-- ============================================================

/-!
## What is autoformalization?
Converting informal mathematical text into formal Lean code.

Example:
  Informal: "For all natural numbers n, n + 0 = n"
  Formal:   `theorem add_zero (n : Nat) : n + 0 = n`

This is HARD because:
1. Natural language is ambiguous
2. Lean requires extreme precision in types
3. Implicit conventions in math (e.g., "let n be a positive integer")
4. Notation differences between informal and formal

## Approaches
1. **Direct LLM translation**: Ask GPT-4/Claude to translate
   - Fast but error-prone, needs verification
2. **RAG-based**: Retrieve similar Mathlib examples, use as context
   - Better accuracy through grounding
3. **Agentic feedback loops** (FORMAL, PSV):
   - Translate → Check with Lean → Fix errors → Repeat
   - State-of-the-art approach
4. **Back-translation verification**:
   - Translate formal → informal and check consistency

## Why it matters for MSI
Autoformalization is the bridge between human mathematics and
formal verification. If we can autoformalize reliably, we can:
- Verify existing mathematical literature
- Enable AI to learn from informal math papers
- Close the loop between informal reasoning and formal proof
-/

-- A simple autoformalization exercise:
-- Can you formalize these informal statements?

-- "The square of any real number is non-negative"
-- theorem sq_nonneg_informal : ... := by sorry

-- "If a divides b and b divides c, then a divides c"
-- theorem dvd_trans_informal : ... := by sorry

-- "There exist infinitely many prime numbers"
-- (This is in Mathlib! Can you find it?)
-- #check Nat.exists_infinite_primes

-- ============================================================
-- SECTION 6: Research directions for the Aristotle grant
-- ============================================================

-- This section maps the research landscape. If you're looking for
-- a project direction or wondering "what's unsolved?", start here.

/-!
## Directions aligned with Harmonic's MSI goals

### 1. Improved proof search
- Better value functions for MCTS/MCGS
- Curriculum learning for proof search
- Test-time training (adapting to the specific problem)

### 2. Autoformalization at scale
- Formalizing textbook chapters automatically
- Handling diagrams and visual reasoning
- Multi-step verification pipelines

### 3. Premise selection / retrieval
- Semantic search over Mathlib
- Learning to select relevant lemmas
- Cross-library transfer

### 4. Benchmark development
- Correcting misformalizations in miniF2F
- Creating domain-specific benchmarks
- Difficulty calibration and progression

### 5. Human-AI collaboration
- Interactive proof interfaces
- AI suggestions that are interpretable
- Mixed-initiative proof development

### 6. Scaling formal mathematics
- Automating Mathlib contributions
- Keeping pace with new mathematics
- Formalizing research-level results
-/

-- ============================================================
-- TRY IT YOURSELF
-- ============================================================

-- 1. Formalize this informal statement and prove it:
--    "For any natural number n, if n is even, then n² is even"
-- (Define "even" as ∃ k, n = 2 * k)

-- 2. Look up how many miniF2F problems are solved in Lean 4:
--    Visit github.com/openai/miniF2F and check the Lean 4 translation

-- 3. Install LeanDojo or PyPantograph (pip install lean-dojo / pantograph)
--    and extract proof states from one of YOUR proofs in this repo
