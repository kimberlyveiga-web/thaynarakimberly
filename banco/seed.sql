Sql

-- Categorias
INSERT INTO categoria (nome) VALUES
  ('Cupcakes Clássicos'),
  ('Cupcakes Especiais'),
  ('Cupcakes Veganos');

-- Usuários (senha_hash é placeholder)
INSERT INTO usuario (nome, email, senha_hash, telefone, tipo_usuario) VALUES
  ('Maria Silva', 'maria@email.com',     '$2a$10$PLACEHOLDER_HASH_1', '11987654321', 'CLIENTE'),
  ('Admin Loja',  'admin@cupcakes.com',  '$2a$10$PLACEHOLDER_HASH_2', '11999998888', 'ADMINISTRADOR');

INSERT INTO cliente (id_usuario, cpf, logradouro, numero, bairro, cidade, uf, cep) VALUES
  (1, '12345678901', 'Rua das Flores', '100', 'Centro', 'São Paulo', 'SP', '01001000');

INSERT INTO administrador (id_usuario, matricula) VALUES
  (2, 'ADM001');

-- Produtos
INSERT INTO produto (nome, descricao, preco, disponivel, id_categoria) VALUES
  ('Cupcake Baunilha',        'Massa de baunilha com buttercream',          8.50,  TRUE, 1),
  ('Cupcake Chocolate',       'Massa de chocolate 70% com ganache',          9.00,  TRUE, 1),
  ('Cupcake Red Velvet',      'Massa red velvet com cream cheese',          10.00,  TRUE, 1),
  ('Cupcake Morango',         'Massa branca com recheio de morango',         9.50,  TRUE, 2),
  ('Cupcake Limão Siciliano', 'Massa cítrica com cobertura de limão',       10.50,  TRUE, 2),
  ('Cupcake Vegano de Coco',  'Massa vegana de coco com cobertura de cacau',11.00,  TRUE, 3);

-- Pedido de exemplo
INSERT INTO pedido (id_cliente, status, valor_total, forma_pagamento, status_pagamento) VALUES
  (1, 'PAGO', 26.00, 'CARTAO_CREDITO', 'APROVADO');

INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
  (1, 1, 2, 8.50),
  (1, 2, 1, 9.00);