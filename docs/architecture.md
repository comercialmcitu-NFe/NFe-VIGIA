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
