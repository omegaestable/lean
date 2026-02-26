# References

A curated, verified collection of resources for learning Lean 4 and AI-assisted theorem proving. Organized by phase to match the learning roadmap.

---

## Phase 1: Foundations

### Official Documentation
- [Lean 4 Homepage](https://lean-lang.org/)
- [Lean 4 Setup Guide](https://lean-lang.org/lean4/doc/setup.html) — installation instructions
- [Theorem Proving in Lean 4 (TPIL)](https://leanprover.github.io/theorem_proving_in_lean4/) — **the** foundational book
- [Functional Programming in Lean (FPIL)](https://lean-lang.org/functional_programming_in_lean/) — Lean as a programming language
- [Lean 4 Language Reference](https://lean-lang.org/lean4/doc/) — official manual
- [Lean 4 Dev](https://lean4.dev/) — comprehensive learning platform with 40+ topics

### Interactive Learning
- [Natural Number Game (NNG4)](https://adam.math.hhu.de/#/g/leanprover-community/NNG4) — **start here**, brilliant interactive intro
- [Lean Game Server](https://adam.math.hhu.de/) — more games: Set Theory, Logic, etc.
- [Lean 4 Learning Portal](https://lean-lang.org/learn/) — curated entry point

### Community
- [Lean Zulip Chat](https://leanprover.zulipchat.com/) — the main community hub
- [Lean FRO (Focused Research Organization)](https://lean-fro.org/)
- [Lean 4 GitHub](https://github.com/leanprover/lean4)

---

## Phase 2: Mathlib & Proof Engineering

### Mathlib
- [Mathlib4 Documentation](https://leanprover-community.github.io/mathlib4_docs/) — searchable API docs
- [Mathlib4 GitHub](https://github.com/leanprover-community/mathlib4)
- [Using Mathlib as a dependency](https://github.com/leanprover-community/mathlib4/wiki/Using-mathlib4-as-a-dependency)
- [Mathlib Initiative](https://mathlib-initiative.org/) — strategic support & AI integration
- [Mathlib Contributing Guide](https://leanprover-community.github.io/contribute/)

### Search Tools
- [Loogle](https://loogle.lean-lang.org/) — type-based search for Mathlib
- [Moogle](https://www.moogle.ai/) — natural language search

### Tutorials
- [Mathematics in Lean (MIL)](https://leanprover-community.github.io/mathematics_in_lean/) — structured tutorial
- [Terry Tao's Lean Companion to Analysis I](https://terrytao.wordpress.com/2025/05/31/a-lean-companion-to-analysis-i/) — blog post
- [Tao's Analysis Formalization Repo](https://github.com/teorth/analysis)

### For Mathematicians
- [The Mechanics of Proof](https://hrmacbeth.github.io/math2001/) — Heather Macbeth's course using Lean
- [Formalising Mathematics](https://www.ma.imperial.ac.uk/~buzzard/xena/formalising-mathematics-2024/) — Kevin Buzzard's Imperial College course
- [Xena Project Blog](https://xenaproject.wordpress.com/) — Kevin Buzzard's blog on Lean & math

---

## Phase 3: Metaprogramming

- [Lean 4 Metaprogramming Book](https://leanprover-community.github.io/lean4-metaprogramming-book/) — full guide
- [Chapter 9: Tactics](https://leanprover-community.github.io/lean4-metaprogramming-book/main/09_tactics.html) — TacticM monad reference

---

## Phase 4: AI-Assisted Theorem Proving

### Key Systems
- [Aristotle (Harmonic)](https://harmonic.fun/news) — IMO gold-medal level AI prover
- Aristotle paper: [arXiv 2510.01346](https://arxiv.org/abs/2510.01346)
- DeepSeek-Prover-V1.5: [arXiv 2408.08152](https://arxiv.org/abs/2408.08152)
- AlphaProof (DeepMind): announced at IMO 2024, no public paper yet

### Tools
- [LeanDojo-v2](https://github.com/lean-dojo/LeanDojo-v2) — data extraction & interaction (Python)
- [LeanDojo (original, deprecated)](https://github.com/lean-dojo/LeanDojo)
- [PyPantograph](https://github.com/stanford-centaur/PyPantograph) — machine-to-machine REPL
- [LeanCopilot](https://github.com/lean-dojo/LeanCopilot) — AI-powered VS Code extension

### Benchmarks
- [miniF2F](https://github.com/openai/miniF2F) — 488 competition problems (AMC/AIME/IMO)
- ProofNet: [arXiv 2302.12433](https://arxiv.org/abs/2302.12433)
- FormL4 (Process-Driven Autoformalization): [arXiv 2406.01940](https://arxiv.org/abs/2406.01940)
- FormalMATH: [arXiv 2505.02735](https://arxiv.org/abs/2505.02735)

### Research Papers
- FORMAL (Retrieval-Augmented Autoformalization): [arXiv 2505.00629](https://arxiv.org/abs/2505.00629)
- LeanDojo paper: [arXiv 2306.15626](https://arxiv.org/abs/2306.15626)
- PyPantograph paper: [arXiv 2410.16429](https://arxiv.org/abs/2410.16429)
- Lean Copilot paper: [arXiv 2404.12534](https://arxiv.org/abs/2404.12534)

### Datasets (Hugging Face)
- [LeanDojo Benchmark](https://huggingface.co/datasets/kaiyuy/LeanDojo_Benchmark_4) — pre-traced Mathlib proofs

---

## Phase 5: Research & Grant Preparation

### Harmonic Aristotle Program
- [Harmonic News / Aristotle Grants](https://harmonic.fun/news)
- Principal Investigator Awards: ~$100K for high-impact projects
- Rising Mathematician Awards: support for students

### Research Groups Active in Lean+AI
- **Caltech** — Anima Anandkumar's group (LeanDojo, LeanCopilot, LeanAgent)
- **Stanford** — Clark Barrett's group (Pantograph, PyPantograph)
- **Mathlib Initiative / Lean FRO** — community infrastructure
- **DeepMind** — AlphaProof
- **DeepSeek** — DeepSeek-Prover series
- **Meta FAIR** — formal methods research
- **ByteDance** — InternLM-Math and theorem proving

### Conferences & Venues
- NeurIPS — Mathematical Reasoning and AI workshop
- ICLR — Machine Learning for Theorem Proving workshop
- ITP — Interactive Theorem Proving conference
- CPP — Certified Programs and Proofs

---

## Quick Links

| Resource | URL |
|----------|-----|
| Lean 4 Homepage | https://lean-lang.org/ |
| TPIL (the book) | https://leanprover.github.io/theorem_proving_in_lean4/ |
| Natural Number Game | https://adam.math.hhu.de/#/g/leanprover-community/NNG4 |
| Mathematics in Lean | https://leanprover-community.github.io/mathematics_in_lean/ |
| Mathlib Docs | https://leanprover-community.github.io/mathlib4_docs/ |
| Lean Zulip | https://leanprover.zulipchat.com/ |
| Loogle (search) | https://loogle.lean-lang.org/ |
| LeanDojo-v2 | https://github.com/lean-dojo/LeanDojo-v2 |
| PyPantograph | https://github.com/stanford-centaur/PyPantograph |
| miniF2F | https://github.com/openai/miniF2F |
| Harmonic/Aristotle | https://harmonic.fun/news |
