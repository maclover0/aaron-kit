# {{PROJECT}}

- `DESIGN.md` is the live design: read it before planning, and update its progress and decisions when they change.
- `GLOSSARY.md` defines terms and where files belong: read it before naming things or adding files.
- Record decisions in the `DESIGN.md` log, one line each. It takes the place of `docs/adr/`.
- Keep both sections of `GLOSSARY.md`, "Language" and "Files and folders", when editing it.
- `core` may use `helpers`; `helpers` stays independent of `core`.
- Keep modules small and separable so scope can grow.
- Treat `.env` and `.secrets` as off limits. Variable names go in `.env.example`.

## Commands

[Build, run and test commands, including how to test one package.]
