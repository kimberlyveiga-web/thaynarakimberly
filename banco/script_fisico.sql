Script fisco
---

### 📁 NA PASTA `banco`

**2. Arquivo: `script_fisico.sql`**
```sql
-- =====================================================================
-- Projeto: Loja Virtual de Cupcakes Gourmet
-- Disciplina: Engenharia de Software I — Situação-Problema 1
-- Autora: Thaynara Kimberly Lustosa da Veiga (RGM 35614994)
-- SGBD: PostgreSQL 14+
-- =====================================================================

-- Limpeza (ordem reversa de dependência)
DROP TABLE IF EXISTS item_pedido CASCADE;
DROP TABLE IF EXISTS pedido      CASCADE;
DROP TABLE IF EXISTS produto     CASCADE;
DROP TABLE IF EXISTS categoria   CASCADE;
DROP TABLE IF EXISTS administrador CASCADE;
DROP TABLE IF EXISTS cliente     CASCADE;
DROP TABLE IF EXISTS usuario     CASCADE;
DROP TYPE  IF EXISTS status_pedido_enum CASCADE;
DROP TYPE  IF EXISTS tipo_usuario_enum  CASCADE;

-- Tipos enumerados
CREATE TYPE tipo_usuario_enum AS ENUM ('CLIENTE','ADMINISTRADOR');

CREATE TYPE status_pedido_enum AS ENUM (
  'AGUARDANDO_PAGAMENTO',
  'PAGO',
  'EM_PRODUCAO',
  'ENVIADO',
  'ENTREGUE',
  'CANCELADO'
);

-- Tabelas
CREATE TABLE usuario (
  id            SERIAL PRIMARY KEY,
  nome          VARCHAR(120) NOT NULL,
  email         VARCHAR(120) NOT NULL UNIQUE,
  senha_hash    VARCHAR(255) NOT NULL,
  telefone      VARCHAR(20),
  tipo_usuario  tipo_usuario_enum NOT NULL,
  data_cadastro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cliente (
  id_usuario   INT      PRIMARY KEY REFERENCES usuario(id) ON DELETE CASCADE,
  cpf          CHAR(11) NOT NULL UNIQUE,
  logradouro   VARCHAR(150),
  numero       VARCHAR(10),
  complemento  VARCHAR(80),
  bairro       VARCHAR(80),
  cidade       VARCHAR(80),
  uf           CHAR(2),
  cep          CHAR(8)
);

CREATE TABLE administrador (
  id_usuario INT         PRIMARY KEY REFERENCES usuario(id) ON DELETE CASCADE,
  matricula  VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE categoria (
  id    SERIAL PRIMARY KEY,
  nome  VARCHAR(60) NOT NULL UNIQUE,
  ativa BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE produto (
  id           SERIAL PRIMARY KEY,
  nome         VARCHAR(120) NOT NULL,
  descricao    TEXT,
  preco        NUMERIC(10,2) NOT NULL CHECK (preco >= 0),
  disponivel   BOOLEAN NOT NULL DEFAULT TRUE,
  imagem_url   VARCHAR(255),
  id_categoria INT NOT NULL REFERENCES categoria(id) ON DELETE RESTRICT
);

CREATE TABLE pedido (
  id               SERIAL PRIMARY KEY,
  id_cliente       INT NOT NULL REFERENCES cliente(id_usuario) ON DELETE RESTRICT,
  data_pedido      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status           status_pedido_enum NOT NULL DEFAULT 'AGUARDANDO_PAGAMENTO',
  valor_total      NUMERIC(10,2) NOT NULL DEFAULT 0 CHECK (valor_total >= 0),
  forma_pagamento  VARCHAR(30),
  status_pagamento VARCHAR(30)
);

CREATE TABLE item_pedido (
  id             SERIAL PRIMARY KEY,
  id_pedido      INT NOT NULL REFERENCES pedido(id) ON DELETE CASCADE,
  id_produto     INT NOT NULL REFERENCES produto(id) ON DELETE RESTRICT,
  quantidade     INT NOT NULL CHECK (quantidade > 0),
  preco_unitario NUMERIC(10,2) NOT NULL CHECK (preco_unitario >= 0),
  subtotal       NUMERIC(10,2) GENERATED ALWAYS AS (quantidade * preco_unitario) STORED
);

-- Índices auxiliares
CREATE INDEX idx_produto_categoria  ON produto(id_categoria);
CREATE INDEX idx_pedido_cliente     ON pedido(id_cliente);
CREATE INDEX idx_pedido_status      ON pedido(status);
CREATE INDEX idx_item_pedido_pedido ON item_pedido(id_pedido);