-- ===========================================
-- EXTENSÃO PARA GERAR UUIDs
-- ===========================================
create extension if not exists "pgcrypto";

-- ===========================================
-- TABELA: usuários
-- ===========================================
create table usuarios (
    id_usuario uuid primary key default gen_random_uuid(),
    nome varchar(100) not null,
    email varchar(100) unique not null,
    senha text not null,
    idade int,
    tipo_usuario varchar(50), -- ex: aluno, professor, admin
    genero varchar(20),
    data_cadastro timestamp default now()
);

-- ===========================================
-- TABELA: horários_aula
-- ===========================================
create table horarios_aula (
    id_horario uuid primary key default gen_random_uuid(),
    id_usuario uuid references usuarios(id_usuario) on delete cascade,
    dia_semana varchar(20) check (dia_semana in ('segunda','terça','quarta','quinta','sexta')),
    horario_inicio time not null,
    horario_fim time not null,
    materia varchar(100),
    professor varchar(100)
);

-- ===========================================
-- TABELA: alimentação
-- ===========================================
create table alimentacao (
    id_alimentacao uuid primary key default gen_random_uuid(),
    id_usuario uuid references usuarios(id_usuario) on delete cascade,
    data date not null,
    refeicao varchar(20) check (refeicao in ('café da manhã', 'almoço', 'janta')),
    descricao text,
    calorias int
);

-- ===========================================
-- TABELA: pagamentos
-- ===========================================
create table pagamentos (
    id_pagamento uuid primary key default gen_random_uuid(),
    id_usuario uuid references usuarios(id_usuario) on delete cascade,
    curso_comprado varchar(100),
    valor numeric(10,2),
    metodo varchar(20) check (metodo in ('cartão','pix','boleto')),
    status varchar(20) check (status in ('pago','pendente'))
);

-- ===========================================
-- TABELA: feedback
-- ===========================================
create table feedback (
    id_feedback uuid primary key default gen_random_uuid(),
    id_usuario uuid references usuarios(id_usuario) on delete cascade,
    horario_acesso varchar(20) check (horario_acesso in ('manhã','tarde','noite')),
    progresso_medio numeric(5,2),
    gosto text
);

-- ===========================================
-- TABELA: treinos
-- ===========================================
create table treinos (
    id_treino uuid primary key default gen_random_uuid(),
    id_usuario uuid references usuarios(id_usuario) on delete cascade,
    tipo_treino varchar(100),
    duracao_min int,
    data_treino date,
    calorias_gastas int
);

-- ===========================================
-- TABELA: meses
-- ===========================================
create table meses (
    id_mes uuid primary key default gen_random_uuid(),
    id_usuario uuid references usuarios(id_usuario) on delete cascade,
    data_inicio date,
    duracao_dias int
);

-- ===========================================
-- RLS (Row Level Security)
-- ===========================================
-- Habilita RLS em todas as tabelas
alter table usuarios enable row level security;
alter table horarios_aula enable row level security;
alter table alimentacao enable row level security;
alter table pagamentos enable row level security;
alter table feedback enable row level security;
alter table treinos enable row level security;
alter table meses enable row level security;

-- ===========================================
-- POLÍTICAS BÁSICAS DE ACESSO POR USUÁRIO
-- ===========================================
-- Exemplo de política: cada usuário só pode ver/editar seus próprios dados
-- (para funcionar com Supabase Auth, o id do usuário autenticado deve ser igual ao id_usuario)

-- Usuários só podem ver seus próprios dados
create policy "Usuário pode ver seus próprios dados"
on usuarios
for select
using (auth.uid() = id_usuario);

-- Usuários só podem editar seus próprios dados
create policy "Usuário pode editar seus próprios dados"
on usuarios
for update
using (auth.uid() = id_usuario);

-- Políticas padrão para tabelas relacionadas
-- Cada registro pertence ao usuário autenticado

create policy "Apenas o dono pode acessar"
on horarios_aula
for all
using (auth.uid() = id_usuario);

create policy "Apenas o dono pode acessar"
on alimentacao
for all
using (auth.uid() = id_usuario);

create policy "Apenas o dono pode acessar"
on pagamentos
for all
using (auth.uid() = id_usuario);

create policy "Apenas o dono pode acessar"
on feedback
for all
using (auth.uid() = id_usuario);

create policy "Apenas o dono pode acessar"
on treinos
for all
using (auth.uid() = id_usuario);

create policy "Apenas o dono pode acessar"
on meses
for all
using (auth.uid() = id_usuario);
