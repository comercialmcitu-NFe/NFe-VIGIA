# NFe Vigia SaaS (Bootstrap Inicial)

Repositório oficial: https://github.com/comercialmcitu-NFe/NFe-VIGIA.git

Estrutura inicial do projeto para o **Implement NFe Vigia SaaS** com:

- Frontend: React + TypeScript (responsivo)
- Backend: Node.js + NestJS
- Supabase: Auth, Postgres e Storage
- Multi-tenant por condomínio
- RBAC (roles e permissões)
- Workflow antifraude inicial: **Chamado → OS → Aprovação**

## Estrutura

- `apps/web`: frontend React + Vite + TypeScript
- `apps/api`: backend NestJS (estrutura modular inicial)
- `packages/shared`: tipos utilitários compartilháveis
- `supabase/migrations`: migrations SQL iniciais
- `docs`: documentação de arquitetura e domínio
