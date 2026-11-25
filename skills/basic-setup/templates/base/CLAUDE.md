# {{PROJECT}}

- `DESIGN.md` is the live design: read it before planning, and update its progress and decisions when they change.
- `GLOSSARY.md` defines terms and where files belong: read it before naming things or adding files.
- Record decisions in the `DESIGN.md` log, one line each. It takes the place of `docs/adr/`.
- Keep both sections of `GLOSSARY.md`, "Language" and "Files and folders", when editing it.
- `core` may use `helpers`; `helpers` stays independent of `core`.
- Keep modules small and separable so scope can grow.
- Treat `.env` and `.secrets` as off limits to every command. `.claude/settings.json` blocks only the file tools, so this also covers shell reads and anything that prints their values, such as `docker compose config` (use `config --quiet`). Variable names go in `.env.example`.

## Commands

- Run: `docker compose up --build`
- All tests: `docker compose run --rm --build test`
- One package: [for Go, `docker compose run --rm --build test go test ./core/<package>`]
