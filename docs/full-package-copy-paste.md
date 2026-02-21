# Pacote completo para copiar/colar e subir

## `README.md`

```md
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

```

## `package.json`

```json
{
  "name": "nfe-vigia",
  "private": true,
  "version": "0.1.0",
  "workspaces": ["apps/*", "packages/*"],
  "scripts": {
    "dev:web": "npm --workspace @nfe-vigia/web run dev",
    "dev:api": "npm --workspace @nfe-vigia/api run start:dev"
  }
}

```

## `docs/architecture.md`

```md
# Arquitetura Inicial - NFe Vigia SaaS

## Visão macro

- **Frontend (React + TS)**: painel responsivo.
- **Backend (NestJS)**: API REST modular.
- **Supabase**: Auth, Postgres e Storage.

## Multi-tenant

Todos os registros de domínio incluem `condominium_id`.

## Workflow antifraude inicial

1. Chamado
2. Ordem de Serviço
3. Aprovação

```

## `supabase/migrations/202602210001_initial_schema.sql`

```sql
create extension if not exists "pgcrypto";

create table if not exists public.condominiums (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  created_at timestamptz not null default now()
);

create table if not exists public.tickets (
  id uuid primary key default gen_random_uuid(),
  condominium_id uuid not null references public.condominiums(id),
  title text not null,
  status text not null default 'OPEN',
  created_at timestamptz not null default now()
);

```

## `apps/web/package.json`

```json
{
  "name": "@nfe-vigia/web",
  "version": "0.1.0",
  "private": true,
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build"
  },
  "dependencies": {
    "react": "^18.3.1",
    "react-dom": "^18.3.1"
  },
  "devDependencies": {
    "typescript": "^5.6.3",
    "vite": "^5.4.8"
  }
}

```

## `apps/web/tsconfig.json`

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "moduleResolution": "Bundler",
    "jsx": "react-jsx",
    "strict": true
  },
  "include": ["src"]
}

```

## `apps/web/index.html`

```html
<!doctype html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>NFe Vigia</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
  </body>
</html>

```

## `apps/web/src/main.tsx`

```tsx
import React from 'react';
import ReactDOM from 'react-dom/client';
import { App } from './App';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);

```

## `apps/web/src/App.tsx`

```tsx
export function App() {
  return (
    <main style={{ fontFamily: 'Arial, sans-serif', padding: 24 }}>
      <h1>NFe Vigia SaaS</h1>
      <p>Bootstrap inicial: Chamado → OS → Aprovação</p>
    </main>
  );
}

```

## `apps/api/package.json`

```json
{
  "name": "@nfe-vigia/api",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "start:dev": "nest start --watch",
    "build": "nest build"
  },
  "dependencies": {
    "@nestjs/common": "^10.4.4",
    "@nestjs/core": "^10.4.4",
    "reflect-metadata": "^0.2.2",
    "rxjs": "^7.8.1"
  },
  "devDependencies": {
    "@nestjs/cli": "^10.4.5",
    "typescript": "^5.6.3"
  }
}

```

## `apps/api/tsconfig.json`

```json
{
  "compilerOptions": {
    "module": "CommonJS",
    "target": "ES2021",
    "strict": true,
    "experimentalDecorators": true,
    "emitDecoratorMetadata": true,
    "outDir": "dist"
  },
  "include": ["src"]
}

```

## `apps/api/src/main.ts`

```ts
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.setGlobalPrefix('api');
  await app.listen(3000);
}

bootstrap();

```

## `apps/api/src/app.module.ts`

```ts
import { Module } from '@nestjs/common';
import { CondominiumsModule } from './modules/condominiums/condominiums.module';
import { RbacModule } from './modules/rbac/rbac.module';
import { AntifraudModule } from './modules/antifraud/antifraud.module';

@Module({
  imports: [CondominiumsModule, RbacModule, AntifraudModule]
})
export class AppModule {}

```

## `apps/api/src/modules/condominiums/condominiums.module.ts`

```ts
import { Module } from '@nestjs/common';
import { CondominiumsController } from './condominiums.controller';

@Module({
  controllers: [CondominiumsController]
})
export class CondominiumsModule {}

```

## `apps/api/src/modules/condominiums/condominiums.controller.ts`

```ts
import { Controller, Get } from '@nestjs/common';

@Controller('condominiums')
export class CondominiumsController {
  @Get('health')
  health() {
    return { module: 'condominiums', ok: true };
  }
}

```

## `apps/api/src/modules/rbac/rbac.module.ts`

```ts
import { Module } from '@nestjs/common';
import { RbacController } from './rbac.controller';

@Module({
  controllers: [RbacController]
})
export class RbacModule {}

```

## `apps/api/src/modules/rbac/rbac.controller.ts`

```ts
import { Controller, Get } from '@nestjs/common';

@Controller('rbac')
export class RbacController {
  @Get('matrix')
  matrix() {
    return { module: 'rbac', roles: ['ADMIN', 'GESTOR', 'OPERADOR', 'APROVADOR'] };
  }
}

```

## `apps/api/src/modules/antifraud/antifraud.module.ts`

```ts
import { Module } from '@nestjs/common';
import { AntifraudController } from './antifraud.controller';

@Module({
  controllers: [AntifraudController]
})
export class AntifraudModule {}

```

## `apps/api/src/modules/antifraud/antifraud.controller.ts`

```ts
import { Controller, Get } from '@nestjs/common';

@Controller('antifraud')
export class AntifraudController {
  @Get('workflow')
  workflow() {
    return { steps: ['CHAMADO', 'OS', 'APROVACAO'] };
  }
}

```

## `packages/shared/package.json`

```json
{
  "name": "@nfe-vigia/shared",
  "version": "0.1.0",
  "private": true,
  "main": "src/index.ts"
}

```

## `packages/shared/src/index.ts`

```ts
export * from './domain/workflow';

```

## `packages/shared/src/domain/workflow.ts`

```ts
export type TicketStatus = 'OPEN' | 'IN_REVIEW' | 'CONVERTED_TO_OS' | 'CLOSED';
export type WorkOrderStatus = 'DRAFT' | 'SUBMITTED' | 'APPROVED' | 'REJECTED' | 'EXECUTING' | 'DONE';
export type ApprovalStatus = 'PENDING' | 'APPROVED' | 'REJECTED';

```

