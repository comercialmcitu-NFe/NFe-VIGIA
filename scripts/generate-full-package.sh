#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="$ROOT_DIR/docs/full-package-copy-paste.md"
FILES=(
README.md package.json docs/architecture.md
supabase/migrations/202602210001_initial_schema.sql
apps/web/package.json apps/web/tsconfig.json apps/web/index.html apps/web/src/main.tsx apps/web/src/App.tsx
apps/api/package.json apps/api/tsconfig.json apps/api/src/main.ts apps/api/src/app.module.ts
apps/api/src/modules/condominiums/condominiums.module.ts apps/api/src/modules/condominiums/condominiums.controller.ts
apps/api/src/modules/rbac/rbac.module.ts apps/api/src/modules/rbac/rbac.controller.ts
apps/api/src/modules/antifraud/antifraud.module.ts apps/api/src/modules/antifraud/antifraud.controller.ts
packages/shared/package.json packages/shared/src/index.ts packages/shared/src/domain/workflow.ts
)
{
 echo '# Pacote completo para copiar/colar e subir'
 echo
 for rel in "${FILES[@]}"; do
  ext="${rel##*.}"; lang="$ext"
  printf '## `%s`\n\n' "$rel"
  printf '```%s\n' "$lang"
  cat "$ROOT_DIR/$rel"
  echo
  echo '```'
  echo
 done
} > "$OUT"
echo "Gerado: $OUT"
