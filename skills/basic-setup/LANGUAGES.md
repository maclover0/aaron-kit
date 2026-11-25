# Languages other than Go

Keep the standard folders. Show each exception in the preview.

**Rust**: a module or crate named `core` clashes with the built-in `core` library. Propose `src/main.rs` with the logic in `src/app/` in place of root `core/`, and `src/helpers/`. Cargo picks up `/tests` as integration tests. Starting files: `Cargo.toml`, `src/main.rs`.

**Python**: keep the layout, with an `__init__.py` in `core` and `helpers`. Starting files: `main.py` that only starts the app, `pyproject.toml`.

**C++**: keep the layout, with headers beside their sources. Starting files: `main.cpp`, `CMakeLists.txt`.

**Others**: keep the layout until the language's tooling fights it.

Add the language's build output to `.gitignore` and `.dockerignore`.

**Containers**: write a `Dockerfile` with a stage named `build` that holds the source and can run the tests, and a small final stage that runs as user 1000 with `/app` as its folder. Use the language's official image at a pinned version. Replace `[test command]` in `compose.yaml`.
