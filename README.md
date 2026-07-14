# 🛒 E-Commerce Data Infrastructure & Analytics with MySQL & Docker

[![SQL](<https://img.shields.io/badge/SQL-MySQL%208.0-blue.svg>)](https://www.mysql.com/)
[![Docker](https://img.shields.io/badge/Docker-Container-blue.svg)](https://www.docker.com/)
[![Git](<https://img.shields.io/badge/Git-Version%20Control-orange.svg>)](https://git-scm.com/)
[![Linkedin](https://img.shields.io/badge/linkedin-blue.svg)](https://www.linkedin.com/in/douglasfariasil/)
[![GitHub](<https://img.shields.io/badge/GitHub%20-blue.svg>)](https://github.com/douglasfariasil)

Este projeto simula o ambiente de engenharia e análise de dados de um e-commerce real de grande porte. Ele utiliza o **Docker** para subir uma instância isolada do **MySQL 8.0**, estruturando e populando um banco de dados com **mais de 200 mil registros reais** baseados no dataset público da Olist (maior integradora de marketplaces do Brasil).

O objetivo principal é demonstrar competência em modelagem de dados, conteinerização de infraestrutura de banco de dados, otimização de cargas massivas (`ETL`) e extração de insights de negócios por meio de SQL avançado.

---

## 🏗️ Arquitetura e Estrutura do Projeto

O repositório está organizado seguindo as melhores práticas de desenvolvimento do mercado:

```text
📂 projeto-ecommerce-sql/
├── 📂 config/
│   ├── init.sql          # Script DDL de criação automatizada das tabelas
│   ├── olist_customers_dataset.csv
│   └── olist_order_items_dataset.csv
├── 📂 queries/
│   ├── insights_vendas.sql    # Queries focadas em métricas de faturamento
│   └── relatorio_gerencial.sql # Queries focadas em dados demográficos e KPIs
├── 📄 .gitignore         # Configurado para ignorar dados locais de volume do Docker
├── 📄 docker-compose.yml # Orquestração do container do banco de dados
└── 📄 README.md          # Documentação do projeto

🛠️ Tecnologias e Conceitos Utilizados
Banco de Dados: MySQL 8.0 (Modelagem Relacional, Índices, Agregações).

Infraestrutura: Docker & Docker Compose (Isolamento de ambiente, persistência de volumes e mapeamento de portas locais).

Engenharia de Dados (Ingestão): Otimização de performance com LOAD DATA INFILE, desativação temporária de checagem de chaves (FOREIGN_KEY_CHECKS = 0) para cargas massivas de alta performance.

Automação (Python): Uso do gerenciador de pacotes uv, biblioteca Pandas para manipulação de dados, OpenPyXL para relatórios em Excel e ReportLab para geração de PDFs corporativos.

Versionamento: Git seguindo boas práticas de commits.


🚀 Como Executar o Projeto Localmente

Pré-requisitos:
	Docker e Docker Compose instalados na máquina.

	Git instalado.

Passo a Passo:
	Clonar o repositório:


Bash

git clone https://github.com/douglasfariasil/projeto-ecommerce-sql.git
cd projeto-ecommerce-sql

Subir a infraestrutura com um único comando:

Bash

docker compose up -d

Nota: Se a porta 3306 do seu sistema local já estiver ocupada, certifique-se de ajustar o mapeamento de portas no docker-compose.yml para uma porta alternativa (como 3307).

	Carga de Dados Real:
	Os dados em massa são carregados utilizando comandos otimizados de ingestão direto no prompt do MySQL no container:

Bash

docker exec -it ecommerce-mysql mysql -u root -p

📊 Insights Extraídos e Consultas Reais
1. Distribuição de Clientes por Região
Uma consulta analítica processando quase 100.000 clientes reais revelou a concentração demográfica das vendas:

	São Paulo (SP): Concentra aproximadamente 41.98% de toda a base de clientes ativos.

	Rio de Janeiro (RJ) & Minas Gerais (MG): Seguem como os principais polos secundários com cerca de ~12% e ~11% respectivamente.

2. KPIs Consolidados do E-Commerce
Processamento de mais de 112.000 linhas de itens de pedidos para cálculo ágil de indicadores de performance financeira (faturamento acumulado, ticket médio por item e despesa logística com fretes).

📊 Pipeline de BI e Geração Automatizada de Relatórios (Python)
Para integrar a infraestrutura de dados com as ferramentas de negócios (Excel, Power BI e relatórios executivos), o projeto conta com um script de automação em Python (gerar_relatorios.py).

O script conecta-se de forma segura ao banco MySQL rodando no Docker, extrai as análises analíticas utilizando a biblioteca Pandas e distribui os dados automaticamente na pasta exports/ nos seguintes formatos:

	.csv (Dados Brutos): Pronto para ingestão automatizada no Power BI para criação de dashboards de monitoramento.

	.xlsx (Planilha Excel): Estruturado de forma profissional para análises avançadas de negócios, tabelas dinâmicas e fórmulas (XLOOKUP).

	.pdf (Executive Report): Um relatório analítico altamente formatado e estilizado para tomadores de decisão (C-Level).

Como executar o gerador de relatórios:

Bash

# Com o ambiente virtual ativo:
uv run gerar_relatorios.py

👨‍💻 Autor

Desenvolvido por Douglas Faria

Meu LinkedIn

Meu GitHub

* [Meu LinkedIn](https://www.linkedin.com/in/douglasfaria-dev/)
* [Meu GitHub](https://github.com/douglasfariasil)
```
