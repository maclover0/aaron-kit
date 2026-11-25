---
name: design-steps
description: Turn a raw idea into a written plan in DESIGN.md, ready for grilling. Use when the user floats an idea for an app or feature, says they have some data and could show something with it, or brings a data source or visual that the project's plan does not cover.
---

# Design steps

Take an idea to a plan in `DESIGN.md`. Grilling stress-tests the plan afterwards, so this skill gets one round of questions and parks the rest as open questions.

If `DESIGN.md` already holds a plan, read it and follow [Adding to a plan](#adding-to-a-plan) instead of the steps.

## 1. Draft

Draft all seven parts from what the user has said. Look up facts yourself: sample the data files, read the API's documentation. Mark anything else you would have to invent with `?`.

1. **Idea**: one sentence, with who it is for and the problem it solves.
2. **Data and visuals**: every data source and every visual the user has mentioned, then the obvious neighbours, marked as suggestions: up to two sources that would join to these (and the key they would need), and up to two visuals this data already supports. Surfacing them now is what keeps them from arriving mid-build. An idea without data lists its inputs and outputs here instead.
   - Each source: where it comes from, access (cost, key, licence), format and size, how often it changes, known gaps, what is sensitive, and its **grain** (what one row stands for).
   - Each visual: the question it answers, the sources and fields it needs, and the grain it needs.
   - Each pair of sources that a visual combines: the key that joins them.
3. **Done**: what the user can see or do that proves it works.
4. **Smallest useful version**: the fewest sources and visuals that still answer the main question. Take each one away in turn; whatever can go without losing that answer goes to Not yet. One source and one visual is the usual result.
5. **Scope edges**: **Not yet** (wanted, later) and **Out of scope** (decided against).
6. **Shape**: the modules, the language and the containers (by the Stack rules in `../resourcing/SKILL.md`), plus constraints, risks and unknowns. Each source gets its own module that turns raw data into a shared form; each visual reads only the shared form. Then run the **growth test**: for every Not yet item, name the modules that change when it is added. More than one new module and one line to register it means the shape needs rework, or the cost goes in the risks.
7. **Build steps**: in order, each with its expense label from `resourcing`. The first is a tracer bullet: one real source through to one rough visual, choosing the riskiest source, running in its container.

The draft is done when every source feeds a visual, every visual has its sources, every Not yet item has its growth test, and every gap is marked `?`.

## 2. Ask once

Show the draft briefly: the idea, the data and visuals tables, the smallest useful version and Not yet. Then ask, five questions at most: first which suggestions the user wants (now, not yet, or drop), then the `?` marks whose answers would change the smallest useful version or the shape. Number them, recommend an answer to each, and word them so "yes" accepts it. Wait for the answers.

## 3. Write

Write the plan to `DESIGN.md`. If there is none, start from `../basic-setup/templates/base/DESIGN.md`, replacing `{{PROJECT}}`. If it is still bracketed prompts, replace those and keep its sections.

- Build steps go in Progress with status "not started".
- Choices the user made go in Decisions, one brief line each.
- Every remaining `?` goes in Open questions.

Done when no bracketed prompt and no `?` is left outside Open questions. Tell the user what is in the plan in a few lines and offer grilling, starting from Open questions. In a folder without the standard structure, also offer basic-setup. Code waits until the user has settled the plan.

## Adding to a plan

For a new source, visual or feature in a project that already has a plan:

1. Write its row in Data and visuals, as in part 2.
2. Run the growth test on it.
3. Recommend **now** or **not yet** in one line, with its expense label and which unfinished step it would delay. The default is not yet: now means Done cannot be met without it.
4. After the user chooses, put it in Progress or Not yet, and log the choice in Decisions.

The unfinished steps keep their order unless the user changes it.
