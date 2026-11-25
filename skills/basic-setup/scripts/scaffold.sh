#!/usr/bin/env bash
# Usage: scaffold.sh --plan|--apply [--lang go|none] [--containers compose|k8s|none] <project folder>
# Adds missing files and folders. Never changes an existing one.
set -euo pipefail

mode="" lang="go" containers="compose" target=""
while [ $# -gt 0 ]; do
  case "$1" in
    --plan|--apply) mode="${1#--}" ;;
    --lang) lang="${2:-}"; shift ;;
    --containers) containers="${2:-}"; shift ;;
    -*) echo "unknown option: $1" >&2; exit 2 ;;
    *) target="$1" ;;
  esac
  shift
done
[ -n "$mode" ] && [ -n "$target" ] || { echo "usage: scaffold.sh --plan|--apply [--lang go|none] [--containers compose|k8s|none] <folder>" >&2; exit 2; }
case "$lang" in go|none) ;; *) echo "--lang must be go or none" >&2; exit 2 ;; esac
case "$containers" in compose|k8s|none) ;; *) echo "--containers must be compose, k8s or none" >&2; exit 2 ;; esac
[ -d "$target" ] || { echo "no such folder: $target" >&2; exit 2; }

templates="$(cd "$(dirname "${BASH_SOURCE[0]}")/../templates" && pwd)"
cd "$target"
project="$(basename "$PWD")"
project_esc="$(printf '%s' "$project" | sed 's/[&/\\]/\\&/g')"
module="$(printf '%s' "$project" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9._-]+/-/g; s/^[-._]+//; s/[-._]+$//')"
[ -n "$module" ] || module="app"
slug="$(printf '%s' "$module" | sed -E 's/[^a-z0-9]+/-/g; s/^-+//' | cut -c1-50 | sed -E 's/-+$//')"
[ -n "$slug" ] || slug="app"
testcmd="[test command]"
[ "$lang" = go ] && testcmd="go test ./..."
testcmd_esc="$(printf '%s' "$testcmd" | sed 's/[&/\\]/\\&/g')"
gover="$(go env GOVERSION 2>/dev/null | sed -nE 's/^go([0-9]+\.[0-9]+).*/\1/p' || true)"
[ -n "$gover" ] || gover="1.26"

exists() { [ -e "$1" ] || [ -L "$1" ]; }

put() { # put <destination> <template or empty>
  if exists "$1"; then echo "KEEP    $1"; return; fi
  echo "CREATE  $1"
  [ "$mode" = apply ] || return 0
  mkdir -p "$(dirname "$1")"
  if [ -z "${2:-}" ]; then : > "$1"; return; fi
  sed -e "s/{{PROJECT}}/$project_esc/g" -e "s/{{MODULE}}/$module/g" -e "s/{{GOVERSION}}/$gover/g" -e "s/{{SLUG}}/$slug/g" -e "s/{{TESTCMD}}/$testcmd_esc/g" "$templates/$2" > "$1"
}

known=" README.md CLAUDE.md DESIGN.md GLOSSARY.md .gitignore .env .env.example .secrets .claude .git core helpers assets data tests main.go go.mod go.sum .gitattributes Dockerfile .dockerignore compose.yaml compose.yml docker-compose.yml docker-compose.yaml k8s LICENSE .DS_Store "
for f in * .[!.]*; do
  exists "$f" || continue
  # docs/ is allowed only for the issue tracker setup in docs/agents
  if [ "$f" = docs ] && [ "$(ls -A docs)" = agents ]; then continue; fi
  case "$known" in *" $f "*) ;; *) echo "EXTRA   $f" ;; esac
done

for f in README CLAUDE DESIGN GLOSSARY; do put "$f.md" "base/$f.md"; done
put .gitignore base/gitignore
put .gitattributes base/gitattributes
put .env.example base/env.example
put .claude/settings.json base/settings.json
for d in core helpers assets tests data/import data/export data/docs data/db; do
  if [ -d "$d" ]; then
    if [ -n "$(ls -A "$d")" ]; then echo "KEEP    $d/"; else put "$d/.gitkeep" ""; fi
  elif exists "$d"; then echo "WARN    $d exists but is not a folder"
  else put "$d/.gitkeep" ""; fi
done
if [ "$lang" = go ]; then put go.mod go/go.mod; put main.go go/main.go; fi
if [ "$containers" != none ]; then
  compose=compose.yaml
  for f in compose.yml docker-compose.yaml docker-compose.yml; do
    if exists "$f" && ! exists compose.yaml; then compose="$f"; fi
  done
  put "$compose" containers/compose.yaml
  put .dockerignore containers/dockerignore
  if [ "$lang" = go ]; then put Dockerfile containers/Dockerfile.go; fi
  if [ "$containers" = k8s ]; then put k8s/app.yaml containers/k8s.yaml; fi
fi

if [ -d .git ] || git rev-parse --git-dir >/dev/null 2>&1; then echo "KEEP    git repository"
else
  echo "CREATE  git repository"
  if [ "$mode" = apply ]; then git init -q; fi
fi

umask 077
put .env ""
put .secrets ""

# Existing files are kept, so check that they still protect secrets.
if [ "$mode" = apply ]; then
  for f in .env .secrets; do
    if git ls-files --error-unmatch "$f" >/dev/null 2>&1; then echo "WARN    $f is already tracked by git"
    elif ! git check-ignore -q "$f"; then echo "WARN    $f is not ignored by the existing .gitignore"; fi
  done
  git check-ignore -q data/db/probe.db || echo "WARN    data contents are not ignored by the existing .gitignore"
  if [ "$containers" != none ]; then
    for f in .env .secrets; do
      grep -qxF "$f" .dockerignore || echo "WARN    .dockerignore does not exclude $f, so it could end up in the image"
    done
  fi
  grep -q 'Read(./.secrets)' .claude/settings.json && grep -q 'Read(./.env)' .claude/settings.json \
    || echo "WARN    .claude/settings.json does not block reading .env and .secrets"
fi
