# Languages other than Go

Keep the standard folders. Show each exception in the preview.

**Rust**: a module or crate named `core` clashes with the built-in `core` library. Propose `src/main.rs` with the logic in `src/app/` in place of root `core/`, and `src/helpers/`. Cargo picks up `/tests` as integration tests. Starting files: `Cargo.toml`, `src/main.rs`.

**Python**: keep the layout, with an `__init__.py` in `core` and `helpers`. Starting files: `main.py` that only starts the app, `pyproject.toml`.

**C++**: keep the layout, with headers beside their sources. Starting files: `main.cpp`, `CMakeLists.txt`.

**Others**: keep the layout until the language's tooling fights it.

Add the language's build output to `.gitignore`.
