/-!
# 04 — Propositional Logic: Proofs as Programs

## The Curry-Howard correspondence in action
| Logic              | Programming        | Lean          |
|--------------------|--------------------|---------------|
| Proposition        | Type               | `Prop`        |
| Proof              | Term/Program       | `term : Prop` |
| Implication P → Q  | Function P → Q     | `fun h => ..` |
| Conjunction P ∧ Q  | Product P × Q      | `⟨hp, hq⟩`   |
| Disjunction P ∨ Q  | Sum P ⊕ Q          | `.inl` / `.inr`|
| True               | Unit               | `trivial`     |
| False              | Empty              | impossible    |

Once you see this table, logic in Lean "clicks".
-/

-- ============================================================
-- SECTION 1: Implication (→) = Functions
-- ============================================================

-- Proving P → Q is the same as writing a function from P to Q.
-- "Given a proof of P, I produce a proof of Q."

-- Term-mode proof: literally a function
theorem imp_self (P : Prop) : P → P :=
  fun hp => hp         -- Given a proof of P, return it

-- Tactic-mode proof: step-by-step
theorem imp_self' (P : Prop) : P → P := by
  intro hp             -- "assume P" — introduces hypothesis `hp : P`
  exact hp             -- "this is our proof" — provides the exact term

-- Transitivity of implication
theorem imp_trans (P Q R : Prop) : (P → Q) → (Q → R) → P → R := by
  intro hpq hqr hp    -- assume all three hypotheses
  apply hqr            -- suffices to show Q (because hqr : Q → R)
  apply hpq            -- suffices to show P (because hpq : P → Q)
  exact hp             -- we have P

-- ============================================================
-- SECTION 2: Conjunction (∧) = Pairs
-- ============================================================

-- To prove P ∧ Q, you need a proof of P AND a proof of Q.
-- It's literally a pair.

theorem and_intro (P Q : Prop) (hp : P) (hq : Q) : P ∧ Q := by
  constructor          -- splits goal into two: ⊢ P and ⊢ Q
  · exact hp           -- prove the first part
  · exact hq           -- prove the second part

-- Alternative: use the anonymous constructor ⟨ ⟩
theorem and_intro' (P Q : Prop) (hp : P) (hq : Q) : P ∧ Q :=
  ⟨hp, hq⟩

-- Extracting from a conjunction
theorem and_left (P Q : Prop) (h : P ∧ Q) : P := by
  obtain ⟨hp, _hq⟩ := h   -- destructure the pair
  exact hp

theorem and_comm (P Q : Prop) : P ∧ Q → Q ∧ P := by
  intro ⟨hp, hq⟩     -- destructure in the intro
  exact ⟨hq, hp⟩     -- rebuild swapped

-- ============================================================
-- SECTION 3: Disjunction (∨) = Either/Or
-- ============================================================

-- To prove P ∨ Q, you need to choose a side and prove it.

theorem or_left (P Q : Prop) (hp : P) : P ∨ Q := by
  left                 -- "I'll prove the left side"
  exact hp

theorem or_right (P Q : Prop) (hq : Q) : P ∨ Q := by
  right                -- "I'll prove the right side"
  exact hq

-- Using a disjunction: case analysis
theorem or_comm (P Q : Prop) : P ∨ Q → Q ∨ P := by
  intro h
  cases h with         -- "consider both cases"
  | inl hp => right; exact hp   -- if we had P, put it on the right
  | inr hq => left; exact hq    -- if we had Q, put it on the left

-- ============================================================
-- SECTION 4: Negation (¬) = leads to contradiction
-- ============================================================

-- ¬P is DEFINED as P → False.
-- "If you give me a proof of P, I can derive a contradiction."

-- #print Not  -- fun (a : Prop) => a → False

theorem not_false : ¬False := by
  intro h              -- assume False
  exact h              -- False proves anything (we're done!)

-- Modus tollens: if P → Q and ¬Q, then ¬P
theorem modus_tollens (P Q : Prop) : (P → Q) → ¬Q → ¬P := by
  intro hpq hnq hp    -- assume all three
  apply hnq            -- suffices to show Q (to contradict ¬Q)
  apply hpq            -- suffices to show P
  exact hp             -- we have P

-- ============================================================
-- SECTION 5: Iff (↔) = logical equivalence
-- ============================================================

-- P ↔ Q means (P → Q) ∧ (Q → P)

theorem iff_self (P : Prop) : P ↔ P := by
  constructor          -- split into → and ←
  · intro hp; exact hp
  · intro hp; exact hp

-- Shorter:
theorem iff_self' (P : Prop) : P ↔ P :=
  ⟨fun hp => hp, fun hp => hp⟩

-- ============================================================
-- TRY IT YOURSELF
-- ============================================================

-- 1. Prove that ∧ is associative
theorem and_assoc (P Q R : Prop) : (P ∧ Q) ∧ R ↔ P ∧ (Q ∧ R) := by
  sorry

-- 2. Prove one of De Morgan's laws
theorem de_morgan (P Q : Prop) : ¬(P ∨ Q) → ¬P ∧ ¬Q := by
  sorry

-- 3. Prove: if P → Q and P → R then P → Q ∧ R
theorem imp_and (P Q R : Prop) : (P → Q) → (P → R) → P → Q ∧ R := by
  sorry
