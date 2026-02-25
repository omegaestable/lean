# Lean 4 Tactic Cheat Sheet

A quick reference for the most common tactics. Keep this open while proving!

---

## Core Tactics

### Introducing and Using Hypotheses

| Tactic | Goal Before | Effect |
|--------|------------|--------|
| `intro h` | `⊢ P → Q` | Adds `h : P` to context, goal becomes `Q` |
| `intro x` | `⊢ ∀ x, P x` | Adds `x` to context, goal becomes `P x` |
| `exact h` | `⊢ P` (with `h : P`) | Closes the goal |
| `assumption` | `⊢ P` (with `h : P`) | Like `exact` but finds `h` automatically |

### Backward Reasoning

| Tactic | Goal Before | Effect |
|--------|------------|--------|
| `apply h` | `⊢ Q` (with `h : P → Q`) | Goal becomes `P` |
| `apply h` | `⊢ Q` (with `h : P₁ → P₂ → Q`) | Creates two goals: `P₁` and `P₂` |
| `refine ⟨?_, ?_⟩` | `⊢ P ∧ Q` | Creates goals for each `?_` |

### Splitting Goals

| Tactic | Goal Before | Effect |
|--------|------------|--------|
| `constructor` | `⊢ P ∧ Q` | Two goals: `⊢ P` and `⊢ Q` |
| `constructor` | `⊢ P ↔ Q` | Two goals: `⊢ P → Q` and `⊢ Q → P` |
| `left` | `⊢ P ∨ Q` | Goal becomes `⊢ P` |
| `right` | `⊢ P ∨ Q` | Goal becomes `⊢ Q` |
| `use t` | `⊢ ∃ x, P x` | Goal becomes `⊢ P t` |

### Destructuring Hypotheses

| Tactic | Hypothesis | Effect |
|--------|-----------|--------|
| `obtain ⟨hp, hq⟩ := h` | `h : P ∧ Q` | Splits into `hp : P` and `hq : Q` |
| `obtain ⟨x, hx⟩ := h` | `h : ∃ x, P x` | Gets witness `x` and proof `hx : P x` |
| `cases h with \| inl hp => ... \| inr hq => ...` | `h : P ∨ Q` | Case split |
| `rcases h with ⟨a, b, c⟩` | `h : P ∧ Q ∧ R` | Recursive destructuring |

### Rewriting

| Tactic | Effect |
|--------|--------|
| `rw [h]` | If `h : a = b`, replaces `a` with `b` in goal |
| `rw [← h]` | If `h : a = b`, replaces `b` with `a` in goal |
| `rw [h] at h2` | Rewrite in hypothesis `h2` instead of goal |
| `rw [h1, h2, h3]` | Chain multiple rewrites |
| `simp [h1, h2]` | Simplify using `h1`, `h2`, and simp lemmas |
| `simp only [h]` | Simplify using ONLY the specified lemmas |
| `simp at h` | Simplify a hypothesis |

---

## Power Tactics (Automation)

| Tactic | Solves |
|--------|--------|
| `rfl` | `a = a` (definitional equality) |
| `omega` | Linear arithmetic: `Nat`, `Int` equations/inequalities |
| `ring` | Polynomial ring identities |
| `norm_num` | Numerical computations |
| `decide` | Decidable propositions (finite checks) |
| `simp` | Simplification with lemma database |
| `aesop` | General automated proof search |
| `tauto` | Propositional tautologies |
| `linarith` | Linear arithmetic with hypotheses |
| `positivity` | Proving `0 ≤ x` or `0 < x` |
| `nlinarith` | Nonlinear arithmetic (squares, products) |
| `norm_cast` | Move between `Nat`, `Int`, `Rat`, `Real` coercions |
| `push_cast` | Push coercions inward |
| `field_simp` | Clear denominators in field expressions |
| `polyrith` | Polynomial arithmetic (needs network) |
| `gcongr` | "Generalized congruence" for inequalities |

---

## Proof Structure

| Tactic | Effect |
|--------|--------|
| `have h : P := proof` | Introduce intermediate fact |
| `suffices h : P from proof` | "It suffices to show P" |
| `show P` | Change goal display (must be definitionally equal) |
| `change P` | Change goal (must be definitionally equal) |
| `exfalso` | Change goal to `False` |
| `by_contra h` | Assume `¬(goal)`, derive `False` |
| `push_neg` | Push negation through quantifiers |

### Induction

```lean
induction n with
| zero => ...          -- base case
| succ k ih => ...     -- inductive step, ih is the hypothesis
```

### Calc Blocks

```lean
calc a = b := by ...
  _ = c := by ...
  _ ≤ d := by ...      -- can mix = and ≤ and <
```

---

## Searching for Lemmas

| Command | What it does |
|---------|-------------|
| `exact?` | "What lemma closes this goal?" |
| `apply?` | "What lemma can I apply here?" |
| `rw?` | "What can I rewrite with?" |
| `simp?` | "What lemmas did simp use?" (shows the call) |
| `#check lemma_name` | Look up a specific lemma |

---

## Common Mathlib Lemma Naming Patterns

Mathlib follows consistent naming conventions:

```
Nat.add_comm       -- a + b = b + a
Nat.add_assoc      -- (a + b) + c = a + (b + c)
Nat.mul_comm       -- a * b = b * a
Nat.zero_add       -- 0 + a = a
Nat.add_zero       -- a + 0 = a
List.length_append -- (xs ++ ys).length = xs.length + ys.length
abs_add            -- |a + b| ≤ |a| + |b|
sq_nonneg          -- 0 ≤ a ^ 2
```

**Pattern**: `[namespace].[operation]_[property]` or `[property]_[operation]`

---

## Unicode Input (VS Code)

| Type | Get | Meaning |
|------|-----|---------|
| `\to` or `\r` | → | function/implication |
| `\and` | ∧ | logical and |
| `\or` | ∨ | logical or |
| `\not` or `\neg` | ¬ | negation |
| `\iff` | ↔ | if and only if |
| `\all` or `\forall` | ∀ | for all |
| `\ex` or `\exists` | ∃ | there exists |
| `\in` | ∈ | element of |
| `\sub` or `\subset` | ⊂ | subset |
| `\le` | ≤ | less or equal |
| `\ge` | ≥ | greater or equal |
| `\ne` | ≠ | not equal |
| `\N` or `\nat` | ℕ | natural numbers |
| `\Z` | ℤ | integers |
| `\Q` | ℚ | rationals |
| `\R` | ℝ | reals |
| `\C` | ℂ | complex numbers |
| `\lam` or `\fun` | λ | lambda |
| `\ang` | ⟨ ⟩ | angle brackets |
| `\inv` | ⁻¹ | inverse |
| `\inf` | ∞ | infinity |
| `\sum` | ∑ | summation |
| `\prod` | ∏ | product |
| `\int` | ∫ | integral |
| `\x` | × | product type |
| `\top` | ⊤ | top |
| `\bot` | ⊥ | bottom |
| `\a` | α | alpha |
| `\b` | β | beta |
| `\e` or `\eps` | ε | epsilon |
| `\d` or `\del` | δ | delta |

**Tip:** In VS Code with the lean4 extension, type `\` followed by the abbreviation and press space to convert.
