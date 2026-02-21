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
