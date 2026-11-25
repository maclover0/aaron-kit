#!/usr/bin/env bash
# Prints the body of the resourcing skill (frontmatter stripped) into session context.
root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
awk 'n >= 2 { print } n < 2 && /^---[[:space:]]*$/ { n++ }' "$root/skills/resourcing/SKILL.md"
