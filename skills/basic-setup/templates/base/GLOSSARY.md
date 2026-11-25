# Glossary: {{PROJECT}}

## Language

Project terms, one or two sentences each, with words to avoid.

## Files and folders

**README.md**: what the project is and how to run it, for people.

**CLAUDE.md**: commands, firm rules and pointers. Loaded every session, so kept short.

**DESIGN.md**: the live design, progress and decision log.

**GLOSSARY.md**: shared terms, and what each file and folder is for.

**core/**: the main logic of the app.

**helpers/**: handlers and small reused functions, such as cleaning and normalizing. Independent of `core`.

**assets/**: static files such as images, fonts and styles.

**data/import/**: data coming in.

**data/export/**: data going out.

**data/docs/**: documents the app reads or the user supplies.

**data/db/**: databases.

**tests/**: tests that use the app from outside. Tests of private code sit beside that code when the language needs it.

**docs/agents/**: issue tracker setup, only in projects that use a tracker. Other documents go in `data/docs/` or the root markdown files.

**Dockerfile**: how the app's image is built. Its `build` stage also runs the tests.

**compose.yaml**: how the app and its tests run, the same on every operating system.

**.dockerignore**: what stays out of the image, including secrets.

**.gitattributes**: keeps line endings the same on every operating system.

**k8s/**: Kubernetes manifests, only in projects that use Kubernetes.

**.env**: environment variables, some sensitive. Never committed.

**.env.example**: the variable names without values. Committed.

**.secrets**: sensitive values, such as hashes and keys. Never committed.
