Sprint01
┌─────────────┬──────────────────────────────────────────┬─────────────────┬────────────────────────┐
│ Entidade    │ Atributos                                │ Chave Primária  │ Chave Estrangeira      │
│             │                                          │ (PK)            │ (FK)                   │
├─────────────┼──────────────────────────────────────────┼─────────────────┼────────────────────────┤
│ Cliente     │ id_cliente, nome, email, telefone        │ id_cliente      │ -                      │
├─────────────┼──────────────────────────────────────────┼─────────────────┼────────────────────────┤
│ Pedido      │ id_pedido, data_pedido, valor_total,     │ id_pedido       │ id_cliente             │
│             │ id_cliente                               │                 │                        │
├─────────────┼──────────────────────────────────────────┼─────────────────┼────────────────────────┤
│ Produto     │ id_produto, nome, preco, estoque         │ id_produto      │ -                      │
├─────────────┼──────────────────────────────────────────┼─────────────────┼────────────────────────┤
│ Item_Pedido │ id_item, id_pedido, id_produto,          │ id_item         │ id_pedido, id_produto  │
│             │ quantidade, preco_unitario               │                 │                        │
└─────────────┴──────────────────────────────────────────┴─────────────────┴────────────────────────┘


Sprint02

┌───────────────┬───────┬────────────────────────────────────────────────────────────────────────┐
│ Entidade      │ Tipo  │ Principais atributos                                                   │
├───────────────┼───────┼────────────────────────────────────────────────────────────────────────┤
│ Cliente       │ Forte │ id_cliente (PK), nome, CPF, telefone                                   │
├───────────────┼───────┼────────────────────────────────────────────────────────────────────────┤
│ Veiculo       │ Forte │ id_veiculo (PK), placa, modelo, cor, id_cliente (FK)                   │
├───────────────┼───────┼────────────────────────────────────────────────────────────────────────┤
│ Vaga          │ Forte │ id_vaga (PK), numero, tipo, status                                     │
├───────────────┼───────┼────────────────────────────────────────────────────────────────────────┤
│ Estacionamento│ Forte │ id_estacionamento (PK), nome, endereco                                 │
├───────────────┼───────┼────────────────────────────────────────────────────────────────────────┤
│ Movimentacao  │ Forte │ id_movimentacao (PK), entrada, saida, valor, id_veiculo (FK),          │
│               │       │ id_vaga (FK)                                                           │
├───────────────┼───────┼────────────────────────────────────────────────────────────────────────┤
│ Pagamento     │ Forte │ id_pagamento (PK), data, valor, forma_pagamento, id_movimentacao (FK)  │
└───────────────┴───────┴────────────────────────────────────────────────────────────────────────┘


————————————————————————————————————————
CREATE DATABASE estacionamento;
========================================= -- TABELA: CLIENTE -- ========================================= 
CREATE TABLE Cliente (
id_cliente INT AUTO_INCREMENT,
nome VARCHAR(100) NOT NULL,
cpf VARCHAR(14) NOT NULL UNIQUE,
telefone VARCHAR(20), 
PRIMARY KEY (id_cliente) ); 
-- ========================================= -- TABELA: VEICULO -- ========================================= 
CREATE TABLE Veiculo (
id_veiculo INT AUTO_INCREMENT, 
placa VARCHAR(10) NOT NULL UNIQUE, 
modelo VARCHAR(50) NOT NULL, 
cor VARCHAR(30), id_cliente INT NOT NULL, 
PRIMARY KEY (id_veiculo), 
FOREIGN KEY (id_cliente) 
REFERENCES Cliente(id_cliente) ); 
-- ========================================= -- TABELA: ESTACIONAMENTO -- ========================================= 
CREATE TABLE Estacionamento (
id_estacionamento INT AUTO_INCREMENT,
nome VARCHAR(100) NOT NULL, 
endereco VARCHAR(200) NOT NULL,
PRIMARY KEY (id_estacionamento) ); 
-- ========================================= -- TABELA: VAGA -- ========================================= 
CREATE TABLE Vaga (
id_vaga INT AUTO_INCREMENT,
numero INT NOT NULL, 
tipo VARCHAR(30) NOT NULL, 
status VARCHAR(20) NOT NULL, 
id_estacionamento INT NOT NULL,
PRIMARY KEY (id_vaga), 
FOREIGN KEY (id_estacionamento) 
REFERENCES Estacionamento(id_estacionamento), 
UNIQUE (numero, id_estacionamento) ); 
-- ========================================= -- TABELA: MOVIMENTACAO -- ========================================= 
CREATE TABLE Movimentacao ( 
id_movimentacao 
INT AUTO_INCREMENT, 
data_entrada DATETIME NOT NULL,
data_saida DATETIME,
valor DECIMAL(10,2), 
id_veiculo INT NOT NULL, 
id_vaga INT NOT NULL,
PRIMARY KEY (id_movimentacao), 
FOREIGN KEY (id_veiculo) 
REFERENCES Veiculo(id_veiculo), 
FOREIGN KEY (id_vaga) 
REFERENCES Vaga(id_vaga) ); 
-- ========================================= -- TABELA: PAGAMENTO -- ========================================= 
CREATE TABLE Pagamento ( id_pagamento INT AUTO_INCREMENT, 
data_pagamento DATETIME NOT NULL, 
valor DECIMAL(10,2) NOT NULL,
forma_pagamento VARCHAR(30) NOT NULL, 
id_movimentacao INT NOT NULL UNIQUE, 
PRIMARY KEY (id_pagamento),
FOREIGN KEY (id_movimentacao) 
REFERENCES Movimentacao(id_movimentacao) );


Sprint03

┌─────────────┬───────────────┬─────────────────┬────────────────────────────────┐
│ Tabela      │ Coluna        │ Tipo de Dados   │ Restrições / Atributos         │
├─────────────┼───────────────┼─────────────────┼────────────────────────────────┤
│ Cliente     │ id_cliente    │ INT             │ PK, AUTO_INCREMENT             │
│             │ nome          │ VARCHAR(100)    │ NOT NULL                       │
│             │ email         │ VARCHAR(150)    │ NOT NULL, UNIQUE               │
│             │ telefone      │ VARCHAR(20)     │ NOT NULL                       │
├─────────────┼───────────────┼─────────────────┼────────────────────────────────┤
│ Pedido      │ id_pedido     │ INT             │ PK, AUTO_INCREMENT             │
│             │ data_pedido   │ DATE            │ NOT NULL, DEFAULT CURRENT_DATE │
│             │ valor_total   │ DECIMAL(10,2)   │ NOT NULL, CHECK                │
│             │ id_cliente    │ INT             │ FK, NOT NULL                   │
├─────────────┼───────────────┼─────────────────┼────────────────────────────────┤
│ Produto     │ id_produto    │ INT             │ PK, AUTO_INCREMENT             │
│             │ nome          │ VARCHAR(100)    │ NOT NULL                       │
│             │ preco         │ DECIMAL(10,2)   │ NOT NULL, CHECK                │
│             │ estoque       │ INT             │ NOT NULL, CHECK                │
├─────────────┼───────────────┼─────────────────┼────────────────────────────────┤
│ Item_Pedido │ id_item       │ INT             │ PK, AUTO_INCREMENT             │
│             │ id_pedido     │ INT             │ FK, NOT NULL                   │
│             │ id_produto    │ INT             │ FK, NOT NULL                   │
│             │ quantidade    │ INT             │ NOT NULL, CHECK                │
└─────────────┴───────────────┴─────────────────┴────────────────────────────────┘


———————————————————————————————————————-
CREATE DATABASE loja;

USE loja;

CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    telefone VARCHAR(20) NOT NULL
);

CREATE TABLE Produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL DEFAULT 0,

    CHECK (preco > 0),
    CHECK (estoque >= 0)
);

CREATE TABLE Pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    data_pedido DATE NOT NULL DEFAULT (CURRENT_DATE),
    valor_total DECIMAL(10,2) NOT NULL,
    id_cliente INT NOT NULL,

    CHECK (valor_total >= 0),

    CONSTRAINT fk_pedido_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente)
);

CREATE TABLE Item_Pedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,

    CHECK (quantidade > 0),
    CHECK (preco_unitario > 0),

    CONSTRAINT fk_item_pedido
        FOREIGN KEY (id_pedido)
        REFERENCES Pedido(id_pedido),

    CONSTRAINT fk_item_produto
        FOREIGN KEY (id_produto)
        REFERENCES Produto(id_produto),

    CONSTRAINT uk_pedido_produto
        UNIQUE (id_pedido, id_produto)
);

————————————————————————————————————————
USE loja;

-- CLIENTES
INSERT INTO Cliente (nome, email, telefone)
VALUES
('João Silva', 'joao@email.com', '98999990001'),
('Maria Santos', 'maria@email.com', '98999990002'),
('Pedro Oliveira', 'pedro@email.com', '98999990003');


-- PRODUTOS
INSERT INTO Produto (nome, preco, estoque)
VALUES
('Teclado Mecânico', 250.00, 15),
('Mouse Gamer', 150.00, 20),
('Headset Gamer', 300.00, 10);


-- PEDIDOS
INSERT INTO Pedido (data_pedido, valor_total, id_cliente)
VALUES
('2026-09-20', 400.00, 1),
('2026-09-21', 300.00, 2),
('2026-09-22', 450.00, 3);
————————————————————————————————————————

SELECT
    p.id_pedido,
    p.data_pedido,
    c.nome AS cliente,
    c.email,
    p.valor_total
FROM Pedido p
INNER JOIN Cliente c
    ON p.id_cliente = c.id_cliente;


————————————————————————————————————————

SELECT
    p.id_pedido,
    c.nome AS cliente,
    pr.nome AS produto,
    ip.quantidade,
    ip.preco_unitario
FROM Item_Pedido ip
INNER JOIN Pedido p
    ON ip.id_pedido = p.id_pedido
INNER JOIN Cliente c
    ON p.id_cliente = c.id_cliente
INNER JOIN Produto pr
    ON ip.id_produto = pr.id_produto;
———————————————————————————————————————-
## Normalização até a 3ª Forma Normal (3FN)

O banco de dados foi desenvolvido seguindo as regras de normalização até a Terceira Forma Normal (3FN), com o objetivo de reduzir a redundância dos dados e evitar problemas de inserção, atualização e exclusão.

### Primeira Forma Normal (1FN)

Na 1FN, todos os atributos devem possuir valores atômicos, ou seja, cada campo deve armazenar apenas um valor.

No modelo desenvolvido, os dados foram separados em tabelas de acordo com suas características. Por exemplo, os produtos de um pedido não são armazenados em uma única coluna contendo vários produtos. Eles são registrados individualmente na tabela `Item_Pedido`.

Dessa forma, cada campo possui apenas um valor e não existem grupos de valores repetidos.

### Segunda Forma Normal (2FN)

Na 2FN, além de estar na 1FN, todos os atributos não-chave devem depender completamente da chave primária.

O relacionamento entre `Pedido` e `Produto` é do tipo N:N. Para resolver esse relacionamento, foi criada a tabela `Item_Pedido`.

A tabela `Item_Pedido` possui informações como `quantidade` e `preco_unitario`, que dependem do item relacionado ao pedido e ao produto.

Além disso, informações próprias do cliente permanecem na tabela `Cliente`, enquanto informações próprias do produto permanecem na tabela `Produto`.

Isso evita dependências parciais e a repetição de informações.

### Terceira Forma Normal (3FN)

Na 3FN, além de estar na 2FN, os atributos não-chave não podem depender de outros atributos não-chave.

No modelo desenvolvido, os dados foram separados de forma que cada informação dependa diretamente da chave primária de sua própria tabela.

Na tabela `Cliente`, por exemplo, `nome`, `email` e `telefone` dependem diretamente de `id_cliente`.

Na tabela `Produto`, `nome`, `preco` e `estoque` dependem diretamente de `id_produto`.

Na tabela `Pedido`, `data_pedido`, `valor_total` e `id_cliente` dependem diretamente de `id_pedido`.

Na tabela `Item_Pedido`, `id_pedido`, `id_produto`, `quantidade` e `preco_unitario` dependem diretamente de `id_item`.

Assim, não existem dependências transitivas entre atributos não-chave.

### Conclusão

O modelo foi estruturado até a 3FN, separando os dados em entidades relacionadas e eliminando redundâncias, dependências parciais e dependências transitivas.

A utilização da tabela `Item_Pedido` permite representar corretamente o relacionamento N:N entre `Pedido` e `Produto`, mantendo a estrutura do banco organizada e evitando a duplicação desnecessária de informações.


Sprint04

-- =====================================================
-- TABELA: CLIENTE
-- =====================================================

CREATE TABLE IF NOT EXISTS cliente (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    telefone VARCHAR(20) NOT NULL
);

-- =====================================================
-- TABELA: PRODUTO
-- =====================================================

CREATE TABLE IF NOT EXISTS produto (
    id_produto SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco NUMERIC(10,2) NOT NULL
        CHECK (preco >= 0),
    estoque INTEGER NOT NULL
        CHECK (estoque >= 0)
);

-- =====================================================
-- TABELA: PEDIDO
-- =====================================================

CREATE TABLE IF NOT EXISTS pedido (
    id_pedido SERIAL PRIMARY KEY,
    data_pedido DATE NOT NULL DEFAULT CURRENT_DATE,
    valor_total NUMERIC(10,2) NOT NULL
        CHECK (valor_total >= 0),
    id_cliente INTEGER NOT NULL,

    CONSTRAINT fk_pedido_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- =====================================================
-- TABELA: ITEM_PEDIDO
-- =====================================================

CREATE TABLE IF NOT EXISTS item_pedido (
    id_item SERIAL PRIMARY KEY,
    id_pedido INTEGER NOT NULL,
    id_produto INTEGER NOT NULL,
    quantidade INTEGER NOT NULL
        CHECK (quantidade > 0),
    preco_unitario NUMERIC(10,2) NOT NULL
        CHECK (preco_unitario >= 0),

    CONSTRAINT fk_item_pedido
        FOREIGN KEY (id_pedido)
        REFERENCES pedido(id_pedido)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_item_produto
        FOREIGN KEY (id_produto)
        REFERENCES produto(id_produto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);




SET search_path TO loja, public;

-- 1. Busca de pedidos por cliente
CREATE INDEX IF NOT EXISTS idx_pedido_id_cliente
ON pedido (id_cliente);

-- 2. Consulta dos pedidos por data
CREATE INDEX IF NOT EXISTS idx_pedido_data
ON pedido (data_pedido);

-- 3. Busca dos itens de um pedido
CREATE INDEX IF NOT EXISTS idx_item_pedido_id_pedido
ON item_pedido (id_pedido);

-- 4. Busca dos pedidos que contêm determinado produto
CREATE INDEX IF NOT EXISTS idx_item_pedido_id_produto
ON item_pedido (id_produto);

-- 5. Busca de produtos pelo nome
CREATE INDEX IF NOT EXISTS idx_produto_nome
ON produto (nome);



SET search_path TO loja, public;

-- =====================================================
-- TRANSACAO 1: CADASTRO COMPLETO DE UM PEDIDO
-- =====================================================

BEGIN;

-- 1. Cadastrar cliente e capturar seu ID
INSERT INTO cliente (nome, email, telefone)
VALUES (
    'Ana Silva',
    'ana.silva@example.com',
    '(98) 99999-1111'
)
RETURNING id_cliente
\gset cli_

-- 2. Cadastrar produto e capturar seu ID
INSERT INTO produto (nome, preco, estoque)
VALUES ('Teclado Mecanico', 150.00, 20)
RETURNING id_produto
\gset prod_

-- 3. Criar pedido usando o ID do cliente
INSERT INTO pedido (data_pedido, valor_total, id_cliente)
VALUES (
    CURRENT_DATE,
    300.00,
    :cli_id_cliente
)
RETURNING id_pedido
\gset ped_

-- 4. Inserir item usando os IDs capturados
INSERT INTO item_pedido (
    id_pedido,
    id_produto,
    quantidade,
    preco_unitario
)
VALUES (
    :ped_id_pedido,
    :prod_id_produto,
    2,
    150.00
);

-- Confirma todas as insercoes
COMMIT;


-- =====================================================
-- TRANSACAO 2: SAVEPOINT E ROLLBACK PARCIAL
-- =====================================================

BEGIN;

-- 1. Cadastrar outro cliente
INSERT INTO cliente (nome, email, telefone)
VALUES (
    'Carlos Souza',
    'carlos.souza@example.com',
    '(98) 99999-2222'
)
RETURNING id_cliente
\gset cli2_

-- 2. Cadastrar outro produto
INSERT INTO produto (nome, preco, estoque)
VALUES ('Mouse Gamer', 100.00, 15)
RETURNING id_produto
\gset prod2_

-- 3. Criar o pedido
INSERT INTO pedido (data_pedido, valor_total, id_cliente)
VALUES (
    CURRENT_DATE,
    100.00,
    :cli2_id_cliente
)
RETURNING id_pedido
\gset ped2_

-- 4. Criar ponto de salvamento
SAVEPOINT antes_dos_itens;

-- 5. Inserir item temporariamente
INSERT INTO item_pedido (
    id_pedido,
    id_produto,
    quantidade,
    preco_unitario
)
VALUES (
    :ped2_id_pedido,
    :prod2_id_produto,
    1,
    100.00
);

-- Desfaz somente as operacoes posteriores ao SAVEPOINT
ROLLBACK TO SAVEPOINT antes_dos_itens;

-- 6. Inserir novamente o item corretamente
INSERT INTO item_pedido (
    id_pedido,
    id_produto,
    quantidade,
    preco_unitario
)
VALUES (
    :ped2_id_pedido,
    :prod2_id_produto,
    1,
    100.00
);



Sprint05

create database Sistema_Express;

-- ---------------------------------------------------------
-- 1. Table_Bebidas - catálogo de produtos (bebidas)
-- ---------------------------------------------------------
CREATE TABLE Table_Bebidas (
    id_bebida       SERIAL PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    categoria       VARCHAR(50)  NOT NULL,   -- Ex: Refrigerante, Cerveja, Água, Suco, Energético
    marca           VARCHAR(50),
    embalagem       VARCHAR(30),             -- Ex: Lata, Garrafa PET, Garrafa de Vidro, Fardo
    volume_ml       INT,                     -- Ex: 350, 600, 1000, 2000
    estoque_atual   INT NOT NULL DEFAULT 0,
    estoque_minimo  INT NOT NULL DEFAULT 0,
    ativo           BOOLEAN NOT NULL DEFAULT TRUE,
    data_cadastro   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------------------------------------
-- 2. Table_Clientes - cadastro de clientes
-- ---------------------------------------------------------
CREATE TABLE Table_Clientes (
    id_cliente      SERIAL PRIMARY KEY,
    nome            VARCHAR(150) NOT NULL,
    tipo_pessoa     VARCHAR(10) NOT NULL DEFAULT 'Fisica'
                        CHECK (tipo_pessoa IN ('Fisica', 'Juridica')),
    cpf_cnpj        VARCHAR(20) NOT NULL UNIQUE,
    telefone        VARCHAR(20),
    email           VARCHAR(100),
    endereco        VARCHAR(150),
    numero          VARCHAR(10),
    bairro          VARCHAR(80),
    cidade          VARCHAR(80),
    estado          CHAR(2),
    cep             VARCHAR(10),
    ativo           BOOLEAN NOT NULL DEFAULT TRUE,
    data_cadastro   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------------------------------------
-- 3. Table_Valor - tabela de preços das bebidas
-- ---------------------------------------------------------
CREATE TABLE Table_Valor (
    id_valor             SERIAL PRIMARY KEY,
    id_bebida            INT NOT NULL,
    preco_custo          DECIMAL(10,2) NOT NULL,
    preco_venda          DECIMAL(10,2) NOT NULL,
    data_vigencia_inicio DATE NOT NULL,
    data_vigencia_fim    DATE,
    ativo                BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_valor_bebida FOREIGN KEY (id_bebida)
        REFERENCES Table_Bebidas(id_bebida)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- 4. Table_Comercio - pedidos / vendas
-- ---------------------------------------------------------
CREATE TABLE Table_Comercio (
    id_pedido       SERIAL PRIMARY KEY,
    id_cliente      INT NOT NULL,
    id_bebida       INT NOT NULL,
    id_valor        INT NOT NULL,     -- preço aplicado no momento da venda
    quantidade      INT NOT NULL,
    valor_total     DECIMAL(10,2) NOT NULL,
    forma_pagamento VARCHAR(30),      -- Ex: Dinheiro, Pix, Cartao, Boleto
    status_entrega  VARCHAR(30) NOT NULL DEFAULT 'Pendente', -- Pendente, Em rota, Entregue, Cancelado
    data_pedido     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_entrega    TIMESTAMP,
    CONSTRAINT fk_comercio_cliente FOREIGN KEY (id_cliente)
        REFERENCES Table_Clientes(id_cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_comercio_bebida FOREIGN KEY (id_bebida)
        REFERENCES Table_Bebidas(id_bebida)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_comercio_valor FOREIGN KEY (id_valor)
        REFERENCES Table_Valor(id_valor)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

)


Sprint06

Backups


#!/bin/bash

# =========================================================
# SCRIPT DE BACKUP DO BANCO DE DADOS POSTGRESQL
# Projeto: Sistema de Comércio de Bebidas
# Arquivo: 08_backup.sh
# =========================================================

# Configurações do banco
DB_NAME="bebidas"
DB_USER="postgres"
DB_HOST="localhost"
DB_PORT="5432"

# Diretório onde os backups serão armazenados
BACKUP_DIR="/var/backups/postgresql/bebidas"

# Retenção dos backups
RETENTION_DAYS=30

# Data e hora para identificar o backup
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# Nome do arquivo de backup
BACKUP_FILE="$BACKUP_DIR/backup_${DB_NAME}_${DATE}.dump"

# =========================================================
# CRIAÇÃO DO DIRETÓRIO
# =========================================================

mkdir -p "$BACKUP_DIR"

if [ $? -ne 0 ]; then
    echo "ERRO: Não foi possível criar o diretório de backup."
    exit 1
fi

# =========================================================
# INÍCIO DO BACKUP
# =========================================================

echo "=============================================="
echo "INICIANDO BACKUP DO BANCO DE DADOS"
echo "=============================================="
echo "Banco: $DB_NAME"
echo "Data: $(date)"
echo "Arquivo: $BACKUP_FILE"
echo ""

# =========================================================
# EXECUÇÃO DO PG_DUMP
# -Fc = formato customizado
# -b  = incluir objetos grandes (blobs)
# -v  = modo detalhado
# =========================================================

pg_dump \
    -h "$DB_HOST" \
    -p "$DB_PORT" \
    -U "$DB_USER" \
    -Fc \
    -b \
    -v \
    -f "$BACKUP_FILE" \
    "$DB_NAME"

# =========================================================
# TRATAMENTO DE ERROS
# =========================================================

if [ $? -ne 0 ]; then
    echo ""
    echo "ERRO: O backup não foi realizado."

    # Remove arquivo incompleto, caso tenha sido criado
    rm -f "$BACKUP_FILE"

    exit 1
fi

# Verifica se o arquivo realmente existe
if [ ! -f "$BACKUP_FILE" ]; then
    echo ""
    echo "ERRO: O arquivo de backup não foi encontrado."
    exit 1
fi

echo ""
echo "Backup realizado com sucesso!"
echo "Arquivo: $BACKUP_FILE"

# =========================================================
# LIMPEZA DE BACKUPS ANTIGOS
# Retenção: 30 dias
# =========================================================

echo ""
echo "Removendo backups com mais de $RETENTION_DAYS dias..."

find "$BACKUP_DIR" \
    -type f \
    -name "backup_${DB_NAME}_*.dump" \
    -mtime +$RETENTION_DAYS \
    -delete

if [ $? -eq 0 ]; then
    echo "Limpeza concluída."
else
    echo "AVISO: Não foi possível concluir a limpeza dos backups antigos."
fi

# =========================================================
# FINALIZAÇÃO
# =========================================================

echo ""
echo "=============================================="
echo "BACKUP FINALIZADO COM SUCESSO"
echo "=============================================="

exit 0















