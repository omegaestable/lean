# Lean Lab

**A structured path from zero Lean knowledge to AI-assisted theorem proving.**

This repository is a hands-on learning environment for Lean 4, designed for mathematicians and programmers who want to master interactive theorem proving and engage with the cutting edge of AI-integrated formal mathematics. The roadmap is aligned with the research themes of the [Harmonic Aristotle program](https://harmonic.fun/news) and the broader goal of Mathematical Superintelligence (MSI).

---

## What is This?

Lean 4 is both a **programming language** and a **proof assistant**. It lets you write executable programs AND machine-checked mathematical proofs. The key insight: **propositions are types, proofs are programs** ([Curry-Howard correspondence](https://en.wikipedia.org/wiki/Curry%E2%80%93Howard_correspondence)).

This repo takes you from "what is Lean?" to "building AI-assisted theorem provers" through 5 structured phases, each with annotated source files, exercises, and references.

---

## Getting Started

### Prerequisites
- A code editor (VS Code recommended)
- Basic programming experience
- Mathematical maturity (undergrad+ level)

### Installation

1. **Install Lean 4** via [elan](https://lean-lang.org/lean4/doc/setup.html):
   ```bash
   # Linux / macOS
   curl https://elan.lean-lang.org/install.sh -sSf | sh

   # Windows: download installer from https://lean-lang.org/lean4/doc/setup.html
   ```

2. **Install VS Code + lean4 extension** (search "lean4" in VS Code extensions)

3. **Build this project**:
   ```bash
   git clone <this-repo-url>
   cd lean
   lake update    # downloads Mathlib (~3 GB first time, be patient)
   lake build     # builds the project
   ```

4. **Open in VS Code** and open any `.lean` file. The **Lean Infoview** panel (right side) shows proof states, types, and errors. **This panel is your most important tool.**

---

## Repository Structure

```
LeanLab/
│
├── Basics/                          ← PHASE 1: Lean Fundamentals
│   ├── HelloWorld.lean                 01 — #check, #eval, your first theorem
│   ├── TypesAndTerms.lean              02 — Types, Prop vs Type, inductive types
│   └── Functions.lean                  03 — Recursion, pattern matching, higher-order
│
├── Logic/                           ← PHASE 1: Proof Skills
│   ├── PropositionalLogic.lean         04 — ∧, ∨, →, ¬, ↔ (Curry-Howard in action)
│   ├── Quantifiers.lean                05 — ∀, ∃, equality, classical logic
│   └── Tactics.lean                    06 — Full tactic reference + practice
│
├── Mathlib/                         ← PHASE 2: Library Mastery
│   ├── SearchAndDiscovery.lean         07 — exact?, apply?, naming conventions, Loogle
│   └── WorkingWithMathlib.lean         08 — Typeclasses, proof engineering, contributing
│
├── Metaprogramming/                 ← PHASE 3: Extending Lean
│   ├── CustomTactics.lean              09 — TacticM monad, custom tactics, Expr type
│   └── MacrosAndDSLs.lean             10 — Macros, syntax extensions, elaboration
│
├── Mathematics/                     ← PHASE 4: Real Formalization
│   ├── NaturalNumbers.lean             11 — Induction, divisibility, modular arithmetic
│   ├── Algebra.lean                    12 — Groups, rings, fields via Mathlib
│   └── Analysis.lean                   13 — Sequences, metric spaces, ε-δ proofs
│
├── AIIntegration/                   ← PHASE 5: AI + Lean
│   ├── Overview.lean                   14 — Landscape, proof states, training data
│   ├── Autoformalization.lean          15 — Informal→formal, pitfalls, pipelines
│   └── ToolsSetup.lean                16 — LeanDojo, Pantograph, LeanCopilot setup
│
├── Exercises/                       ← Progressive Difficulty
│   ├── Level1_Basics.lean              ⭐ Functions and simple proofs
│   ├── Level2_Logic.lean               ⭐⭐ Propositional and predicate logic
│   ├── Level3_Math.lean                ⭐⭐⭐ Algebra, inequalities, induction
│   ├── Level4_Competition.lean         ⭐⭐⭐⭐ AMC/AIME/IMO-style problems
│   └── Level5_Research.lean            ⭐⭐⭐⭐⭐ Research-level formalization
│
└── Sandbox.lean                     ← Your playground
```

---

## Learning Roadmap

### Phase 1 — Foundations (4-6 weeks)
**Goal**: Fluency in Lean 4 syntax, types, and interactive proof.

| Task | File | Skills |
|------|------|--------|
| Learn `#check`, `#eval`, write first theorems | `Basics/HelloWorld.lean` | Basic syntax, `rfl` |
| Understand types, inductive types, Prop vs Type | `Basics/TypesAndTerms.lean` | Type theory |
| Write recursive functions, use higher-order functions | `Basics/Functions.lean` | Functional programming |
| Prove with ∧, ∨, →, ¬, ↔ | `Logic/PropositionalLogic.lean` | Core tactics |
| Work with ∀, ∃, equality, `calc` | `Logic/Quantifiers.lean` | Quantifier reasoning |
| Build your tactic toolbox | `Logic/Tactics.lean` | `simp`, `omega`, `ring`, `aesop` |
| Complete Level 1 + Level 2 exercises | `Exercises/` | Consolidation |

**Parallel activity**: Complete the [Natural Number Game](https://adam.math.hhu.de/#/g/leanprover-community/NNG4) and start [Theorem Proving in Lean 4](https://leanprover.github.io/theorem_proving_in_lean4/).

### Phase 2 — Mathlib & Proof Engineering (6-8 weeks)
**Goal**: Navigate and contribute to Mathlib, the world's largest formalized math library.

| Task | File | Skills |
|------|------|--------|
| Master `exact?`, `apply?`, `rw?`, naming conventions | `Mathlib/SearchAndDiscovery.lean` | Lemma discovery |
| Work with typeclasses, proof patterns, contribution workflow | `Mathlib/WorkingWithMathlib.lean` | Proof engineering |
| Formalize results from a textbook in your area | Your own files | Real formalization |
| Complete Level 3 exercises | `Exercises/Level3_Math.lean` | Applied math in Lean |

**Parallel activity**: Work through [Mathematics in Lean](https://leanprover-community.github.io/mathematics_in_lean/). Explore Tao's [Lean companion to Analysis I](https://github.com/teorth/analysis). Join the [Lean Zulip](https://leanprover.zulipchat.com/).

### Phase 3 — Tactics, Automation & Metaprogramming (6-8 weeks)
**Goal**: Extend Lean with custom tactics, macros, and automation.

| Task | File | Skills |
|------|------|--------|
| Write custom tactics using TacticM | `Metaprogramming/CustomTactics.lean` | Metaprogramming |
| Build macros and syntax extensions | `Metaprogramming/MacrosAndDSLs.lean` | DSL design |
| Understand Expr and the elaboration pipeline | Both files | Internal APIs |

**Parallel activity**: Read the [Lean 4 Metaprogramming Book](https://leanprover-community.github.io/lean4-metaprogramming-book/). Explore [LeanDojo](https://github.com/lean-dojo/LeanDojo-v2) and [PyPantograph](https://github.com/stanford-centaur/PyPantograph) source code.

### Phase 4 — AI-Assisted Theorem Proving (8-12 weeks)
**Goal**: Hands-on experience with AI/Lean tools, autoformalization, and benchmarks.

| Task | File | Skills |
|------|------|--------|
| Understand the AI/Lean landscape and proof states | `AIIntegration/Overview.lean` | Orientation |
| Practice autoformalization, learn pitfalls | `AIIntegration/Autoformalization.lean` | Translation skills |
| Set up LeanDojo, Pantograph, LeanCopilot | `AIIntegration/ToolsSetup.lean` | Tool proficiency |
| Complete Level 4 competition exercises | `Exercises/Level4_Competition.lean` | Benchmark skills |
| Fine-tune a model on Lean proof data (Python) | External | ML engineering |
| Evaluate on miniF2F or FormL4 | External | Research methodology |

**Parallel activity**: Study [Aristotle](https://arxiv.org/abs/2510.01346), [DeepSeek-Prover](https://arxiv.org/abs/2405.14333), and [FORMAL](https://arxiv.org/abs/2505.00629) papers.

### Phase 5 — Research & Portfolio (Ongoing)
**Goal**: Original contributions, collaborations, and Aristotle grant preparation.

| Task | File | Skills |
|------|------|--------|
| Formalize results from your own research | `Exercises/Level5_Research.lean` | Original work |
| Contribute to miniF2F / benchmark correction | External | Community impact |
| Build an autoformalization or proof search tool | External | Research engineering |
| Write a technical report or paper | External | Communication |
| Prepare Aristotle grant application | External | Grant writing |

---

## Key AI/Lean Systems (2025)

| System | Organization | Key Achievement | Lean Version |
|--------|-------------|-----------------|-------------|
| **Aristotle** | Harmonic | IMO gold-medal equivalent | Lean 4 |
| **AlphaProof** | DeepMind | IMO silver-medal equivalent | Lean 4 |
| **DeepSeek-Prover-V2** | DeepSeek | Strong miniF2F performance | Lean 4 |
| **LeanCopilot** | Caltech/LeanDojo | VS Code AI integration | Lean 4 |
| **ReProver** | LeanDojo | Tactic prediction baseline | Lean 4 |

---

## Key Benchmarks

| Benchmark | Source | Size | Focus |
|-----------|--------|------|-------|
| **miniF2F** | OpenAI | 488 problems | AMC/AIME/IMO competition math |
| **ProofNet** | Research | Varies | Undergraduate mathematics |
| **FormL4** | Research | Varies | Autoformalization quality |
| **FormalMATH** | Research | Varies | Broad formal mathematics |
| **PutnamBench** | Research | Varies | Advanced competition math |

---

## Aristotle Grant — Research Directions

The [Harmonic Aristotle program](https://harmonic.fun/news) offers **Principal Investigator Awards** (~$100K) and **Rising Mathematician Awards** for work advancing Mathematical Superintelligence. Key themes:

1. **Autoformalization & Retrieval**: RAG/RAT systems for Lean 4, agentic feedback loops, benchmark curation
2. **Proof Search & RL**: MCTS/MCGS strategies, value models, test-time training
3. **Datasets & Benchmarks**: Correcting misformalizations, creating new benchmarks, evaluation metrics
4. **Model Fine-tuning**: LoRA on Lean proof data, premise selection, local deployment
5. **Human-AI Collaboration**: Mixed-initiative interfaces, interpretable suggestions

---

## Essential Tools

### In Lean (inside proofs)
| Command | Purpose |
|---------|---------|
| `#check expr` | Show type of expression |
| `#eval expr` | Compute expression |
| `#print name` | Show definition |
| `exact?` | Find lemma closing goal |
| `apply?` | Find applicable lemma |
| `rw?` | Find rewrite rule |
| `simp?` | Show simp lemmas used |

### External Search
| Tool | URL | Type |
|------|-----|------|
| **Loogle** | [loogle.lean-lang.org](https://loogle.lean-lang.org/) | Type-based search |
| **Moogle** | [moogle.ai](https://www.moogle.ai/) | Natural language search |
| **Mathlib Docs** | [leanprover-community.github.io/mathlib4_docs](https://leanprover-community.github.io/mathlib4_docs/) | API documentation |

### AI/Lean Tools (Python)
| Tool | Install | Purpose |
|------|---------|---------|
| **LeanDojo-v2** | `pip install lean-dojo` | Data extraction + interaction |
| **PyPantograph** | `pip install pantograph` | Machine-to-machine REPL |
| **LeanCopilot** | Lake dependency | VS Code AI suggestions |

See [REFERENCES.md](REFERENCES.md) for the complete link collection.

---

## Quick Reference: Top Tactics

| Tactic | Solves | Example |
|--------|--------|---------|
| `rfl` | `a = a` | `2 + 2 = 4` |
| `omega` | Linear arithmetic (ℕ, ℤ) | `n + 1 > n` |
| `ring` | Polynomial identities | `(a+b)² = a²+2ab+b²` |
| `simp` | Simplification | `xs ++ [] = xs` |
| `norm_num` | Numerical computation | `2^10 = 1024` |
| `linarith` | Linear arithmetic + hypotheses | `a ≤ b → b ≤ c → a ≤ c` |
| `positivity` | Non-negativity | `a² ≥ 0` |
| `nlinarith` | Nonlinear arithmetic | `(a-b)² ≥ 0` |
| `aesop` | Automated search | Various |
| `tauto` | Propositional tautologies | `P → Q → P` |
| `decide` | Decidable propositions | `¬(3 = 4)` |
| `exact?` | Find a closing lemma | Any goal |

Full reference: [CHEATSHEET.md](CHEATSHEET.md)

---

## FAQ

**Q: Why Lean 4 and not Coq/Isabelle/Agda?**
Lean 4 has the most active mathematical library (Mathlib, 200K+ theorems), the strongest AI tooling ecosystem (LeanDojo, Pantograph, LeanCopilot), and a welcoming community. It's the platform of choice for Aristotle, AlphaProof, and most recent AI/Lean research.

**Q: What's `sorry`?**
A placeholder meaning "trust me." Every `sorry` in this repo is an exercise. Your job is to replace them with real proofs. A file with zero `sorry`s is fully proven.

**Q: How do I find lemmas?**
Use `exact?` / `apply?` / `rw?` inside proofs. Use [Loogle](https://loogle.lean-lang.org/) for type-based search. Use [Moogle](https://www.moogle.ai/) for natural language search.

**Q: I'm stuck on a proof.**
1. Read the Lean Infoview — what's the goal? What hypotheses exist?
2. Try `exact?`, `simp`, `omega`, `ring`, `aesop`
3. Use `#check` to explore relevant lemmas
4. Ask on [Lean Zulip](https://leanprover.zulipchat.com/)

**Q: How do I start with AI/Lean tools?**
See `AIIntegration/ToolsSetup.lean`. Start with `pip install lean-dojo` and extract proof data from your own files.

---

## Community

- [Lean Zulip Chat](https://leanprover.zulipchat.com/) — main community hub, very welcoming
- [Mathlib Initiative](https://mathlib-initiative.org/) — strategic support for the Mathlib ecosystem
- [Lean FRO](https://lean-fro.org/) — Lean Focused Research Organization
- [Harmonic](https://harmonic.fun/) — Aristotle program and AI/Lean research

---

## License

This project is open source. Use it, share it, learn from it, build on it.
