# Restaurante do Atila

Projeto acadêmico desenvolvido para a Atividade IV de Banco de Dados (BCD), com o objetivo de planejar, modelar, normalizar e consultar um banco de dados relacional para o gerenciamento completo de um restaurante.

## Demonstração

Acesse o site da documentação do projeto: [Restaurante — Vercel](https://restaurantedoatila-restaurante.vercel.app/#empresa)

## Objetivos

- Diagnosticar e resolver falhas operacionais causadas pela falta de um SGBD relacional.
- Modelar um banco de dados relacional completo para o restaurante (clientes, atendimentos, cardápio, estoque e pedidos).
- Implementar tabelas com chaves primárias (PK) e chaves estrangeiras (FK) para garantir integridade referencial.
- Aplicar conceitos de normalização de dados (1FN, 2FN, 3FN e 4FN).
- Desenvolver 15 consultas SQL contextualizadas para relatórios operacionais e financeiros.
- Documentar o projeto e disponibilizar a apresentação em uma interface web responsiva.

## Tecnologias utilizadas

- **MySQL / MySQL Workbench** — criação, modelagem e gerenciamento do banco de dados.
- **SQL (DDL, DML e DQL)** — definição da estrutura, povoamento e consultas analíticas.
- **HTML5** — estruturação da página web de documentação.
- **CSS3** — estilização visual, layout responsivo e design moderno.
- **Git e GitHub** — versionamento de código e armazenamento do repositório.
- **Vercel** — hospedagem da documentação do projeto na nuvem.

## Modelo do banco de dados

O banco de dados `restaurante_atila` é composto por 5 tabelas relacionais principais:

| Tabela | Descrição |
|---|---|
| `clientes` | Armazena o cadastro dos clientes (nome, CPF e telefone). |
| `atendimentos` | Registra a sessão/mesa ocupada pelo cliente e o horário de chegada. |
| `cardapio` | Armazena o catálogo de pratos, bebidas, sobremesas, categorias e preços de venda. |
| `estoque` | Controla os ingredientes e insumos disponíveis na cozinha e suas quantidades. |
| `pedidos` | Registra os pratos solicitados por atendimento, quantidades e o `status_prato`. |

### Relacionamentos

- **Clientes → Atendimentos (1:N):** um cliente pode realizar vários atendimentos (visitas) ao restaurante.
- **Atendimentos → Pedidos (1:N):** uma mesa/atendimento pode conter vários pedidos ao longo do consumo.
- **Cardápio → Pedidos (1:N):** um prato do cardápio pode estar associado a múltiplos registros de pedidos.

As relações são mantidas por chaves estrangeiras (`FOREIGN KEY`), garantindo a integridade dos dados e o histórico financeiro.

## Normalização

O projeto aplica as Formas Normais de banco de dados para garantir a consistência e eficiência:

- **1FN — Primeira Forma Normal:** eliminação de grupos repetitivos e garantia de atributos atômicos (ex: telefones e dados indivisíveis).
- **2FN — Segunda Forma Normal:** garantia de dependência funcional total em relação à chave primária simples (`AUTO_INCREMENT`).
- **3FN — Terceira Forma Normal:** eliminação de dependências transitivas entre atributos não-chave (ex: cliente associado via atendimento e não direto no pedido).
- **4FN — Quarta Forma Normal:** isolamento de dependências multivaloradas independentes em tabelas associativas (ex: relação prato vs. ingredientes).

## Consultas SQL (15 Consultas Analíticas)

O projeto contempla 15 consultas SQL contextualizadas para a gestão do restaurante, utilizando:

- Filtros e ordenação com `WHERE`, `LIKE`, `IN`, `BETWEEN` e `ORDER BY`.
- Cruzamento de dados entre tabelas usando `INNER JOIN` simples e múltiplos.
- Agrupamento e agregação com `GROUP BY`, `HAVING`, `COUNT`, `SUM` e `AVG`.
- Limitação de resultados (`LIMIT`) para relatórios operacionais em tempo real.

## Estrutura do projeto

```text
Restaurante-do-Atila/
├── index.html       # Página web da documentação do projeto
├── style.css        # Estilização visual e responsividade
├── script.sql       # Script SQL completo (DDL, DML e 15 Consultas DQL)
└── README.md        # Documentação do repositório
