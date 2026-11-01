Dicionário de dados 

# Dicionário de Dados — Loja de Cupcakes Gourmet

## Tabela: usuario
| Coluna | Tipo | Restrições | Descrição |
|--------|------|------------|-----------|
| id | SERIAL | PK | Identificador único |
| nome | VARCHAR(120) | NOT NULL | Nome completo |
| email | VARCHAR(120) | UNIQUE, NOT NULL | Login do usuário |
| senha_hash | VARCHAR(255) | NOT NULL | Hash bcrypt da senha |
| telefone | VARCHAR(20) | — | Telefone de contato |
| tipo_usuario | tipo_usuario_enum | NOT NULL | CLIENTE ou ADMINISTRADOR |
| data_cadastro | TIMESTAMP | NOT NULL, default now() | Data de cadastro |

## Tabela: cliente
| Coluna | Tipo | Restrições | Descrição |
|--------|------|------------|-----------|
| id_usuario | INT | PK, FK → usuario(id) | Referência ao usuário |
| cpf | CHAR(11) | UNIQUE, NOT NULL | CPF sem pontuação |
| logradouro | VARCHAR(150) | — | Rua/avenida |
| numero | VARCHAR(10) | — | Número |
| complemento | VARCHAR(80) | — | Complemento |
| bairro | VARCHAR(80) | — | Bairro |
| cidade | VARCHAR(80) | — | Cidade |
| uf | CHAR(2) | — | Estado (UF) |
| cep | CHAR(8) | — | CEP sem hífen |

## Tabela: administrador
| Coluna | Tipo | Restrições | Descrição |
|--------|------|------------|-----------|
| id_usuario | INT | PK, FK → usuario(id) | Referência ao usuário |
| matricula | VARCHAR(20) | UNIQUE, NOT NULL | Matrícula interna do admin |

## Tabela: categoria
| Coluna | Tipo | Restrições | Descrição |
|--------|------|------------|-----------|
| id | SERIAL | PK | Identificador único |
| nome | VARCHAR(60) | UNIQUE, NOT NULL | Nome da categoria |
| ativa | BOOLEAN | NOT NULL, default TRUE | Indica se está visível |

## Tabela: produto
| Coluna | Tipo | Restrições | Descrição |
|--------|------|------------|-----------|
| id | SERIAL | PK | Identificador único |
| nome | VARCHAR(120) | NOT NULL | Nome do produto |
| descricao | TEXT | — | Descrição detalhada |
| preco | NUMERIC(10,2) | NOT NULL, CHECK >= 0 | Preço unitário |
| disponivel | BOOLEAN | NOT NULL, default TRUE | Se está à venda |
| imagem_url | VARCHAR(255) | — | URL da imagem |
| id_categoria | INT | NOT NULL, FK → categoria(id) | Categoria do produto |

## Tabela: pedido
| Coluna | Tipo | Restrições | Descrição |
|--------|------|------------|-----------|
| id | SERIAL | PK | Identificador único |
| id_cliente | INT | NOT NULL, FK → cliente(id_usuario) | Cliente que fez o pedido |
| data_pedido | TIMESTAMP | NOT NULL, default now() | Data/hora do pedido |
| status | status_pedido_enum | NOT NULL | Status atual |
| valor_total | NUMERIC(10,2) | NOT NULL, CHECK >= 0 | Total do pedido |
| forma_pagamento | VARCHAR(30) | — | CARTAO_CREDITO, PIX, etc. |
| status_pagamento | VARCHAR(30) | — | APROVADO, RECUSADO, PENDENTE |

## Tabela: item_pedido
| Coluna | Tipo | Restrições | Descrição |
|--------|------|------------|-----------|
| id | SERIAL | PK | Identificador único |
| id_pedido | INT | NOT NULL, FK → pedido(id) | Pedido ao qual pertence |
| id_produto | INT | NOT NULL, FK → produto(id) | Produto incluído |
| quantidade | INT | NOT NULL, CHECK > 0 | Quantidade |
| preco_unitario | NUMERIC(10,2) | NOT NULL, CHECK >= 0 | Preço no momento da compra |
| subtotal | NUMERIC(10,2) | GENERATED ALWAYS AS (quantidade * preco_unitario) STORED | Subtotal calculado |