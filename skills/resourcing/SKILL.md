---
name: resourcing
description: How to spend tokens, choose skills and scale testing. Loads automatically every session.
disable-model-invocation: true
---

# Resourcing

The user's standing preferences. They hold inside other skills too.

## Spending

- Answer short; give detail on request.
- Label each step of a plan or ordered task list with its expense, and split High steps where possible:
  - **Low**: a few files, clear change.
  - **Med**: several files, or some investigation.
  - **High**: broad changes, subagents, or uncertain scope.
- Recommend subagents when they would help, and ask before starting them. A skill the user chose that needs subagents counts as a yes.
- Suggest a fresh session when context is getting out of hand, or when something big interrupts the current work (a major bug, a design change). First save progress, the next step and the new problem to `DESIGN.md`, or to a handoff if the project has none.

## Testing

Rate each change's risk in one line, then test to match. When torn between two levels, take the higher.

- **Low** (docs, wording, styling, isolated cosmetic change): a build check or nothing.
- **Med** (logic inside one package): that package's tests and its direct callers' tests.
- **High** (shared helpers, data formats, database, dependencies, public interfaces, several packages): the full suite.

Keep tests runnable per package so each level is possible.

## Skills by stage

From `mattpocock-skills` unless marked; if it is missing, say so once. Load a skill when its stage arrives. In very light projects use only diagnosing-bugs. "Suggest" skills run only when the user types them, so name the command and the reason.

| Stage | Load | Suggest |
|---|---|---|
| Vague idea, or one outside the plan | design-steps (this plugin), then grilling | `/wayfinder` if too big for one session |
| Look or logic unclear | prototype | |
| Naming, defining terms | domain-modeling | |
| Structuring `core` | codebase-design | `/improve-codebase-architecture` for existing code |
| Plan settled, large build | | `/to-spec`, `/to-tickets`, then `/implement-spec` (High) |
| Writing features | tdd | `/implement` for one spec or ticket |
| Something broken | diagnosing-bugs | |
| Finishing a change of Med or High risk | code-review | |
| Ending a session | | `/handoff` to continue, `/retro` after a rough one |
| User wants to learn | | `/teach`, in its own folder |
