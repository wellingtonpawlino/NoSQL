#!/bin/bash

# Repositórios renomeados (sem "nosql-")
declare -A repos=(
  ["mongodb-document"]="MongoDB - Banco baseado em documentos"
  ["redis-keyvalue"]="Redis - Banco chave-valor"
  ["cassandra-columnar"]="Cassandra - Banco orientado a colunas"
  ["neo4j-graph"]="Neo4j - Banco de grafos"
)

for repo in "${!repos[@]}"; do
  echo "🔧 Criando estrutura para $repo..."

  # Criar diretórios
  mkdir -p $repo/scripts
  mkdir -p $repo/notebooks

  # Arquivos iniciais
  touch $repo/scripts/init.py
  touch $repo/scripts/load_data.py
  touch $repo/scripts/query_examples.py
  touch $repo/notebooks/exploracao.ipynb

  # README.md
  cat <<EOF > $repo/README.md
# ${repos[$repo]}

Este repositório demonstra o uso de ${repos[$repo]} com Docker e Python.

## Estrutura

- \`docker-compose.yml\` para subir o banco com Docker
- Scripts em Python para inserção e consulta de dados
- Notebook de exploração

## Como usar

1. Suba o container:
   \`\`\`bash
   docker-compose up -d
   \`\`\`

2. Execute os scripts ou notebooks.

EOF

  # docker-compose.yml base (pode ser customizado depois)
  cat <<EOF > $repo/docker-compose.yml
version: "3.8"
services:
  ${repo%-*}:
    image: ${repo%-*}
    container_name: ${repo%-*}
    ports:
      - "27017:27017"
    volumes:
      - data:/data
volumes:
  data:
EOF

  echo "✅ Estrutura criada: $repo"
done

echo "🎉 Todos os repositórios foram criados com sucesso!"
