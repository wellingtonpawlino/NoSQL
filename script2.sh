#!/bin/bash

# Nomes e descrições dos repositórios
declare -A repos=(
  ["mongodb-document"]="MongoDB - Banco baseado em documentos"
  ["redis-keyvalue"]="Redis - Banco chave-valor"
  ["cassandra-columnar"]="Cassandra - Banco orientado a colunas"
  ["neo4j-graph"]="Neo4j - Banco de grafos"
)

for repo in "${!repos[@]}"; do
  echo "🔧 Criando estrutura para $repo..."

  # Criar pastas
  mkdir -p $repo/scripts
  mkdir -p $repo/notebooks

  # Criar arquivos padrão
  touch $repo/scripts/init.py
  touch $repo/scripts/load_data.py
  touch $repo/scripts/query_examples.py
  touch $repo/notebooks/exploracao.ipynb

  # Criar README.md
  cat <<EOF > $repo/README.md
# ${repos[$repo]}

Este repositório demonstra o uso de ${repos[$repo]} com Docker e Python.

## Estrutura

- \`docker-compose.yml\` para rodar o banco principal
- \`docker-compose.dev.yml\` para ambiente com ferramentas adicionais
- Scripts Python e notebooks de exploração
EOF

  ##### Arquivo: docker-compose.yml #####
  case $repo in
    mongodb-document)
      cat <<EOF > $repo/docker-compose.yml
version: "3.8"
services:
  mongodb:
    image: mongo:7
    container_name: mongodb
    ports:
      - "27017:27017"
    volumes:
      - mongo_data:/data/db
    restart: always

volumes:
  mongo_data:
EOF

      ##### Arquivo: docker-compose.dev.yml #####
      cat <<EOF > $repo/docker-compose.dev.yml
version: "3.8"
services:
  mongo-express:
    image: mongo-express
    ports:
      - "8081:8081"
    environment:
      ME_CONFIG_MONGODB_SERVER: mongodb
    depends_on:
      - mongodb
EOF
      ;;
    redis-keyvalue)
      cat <<EOF > $repo/docker-compose.yml
version: "3.8"
services:
  redis:
    image: redis:7
    container_name: redis
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    restart: always

volumes:
  redis_data:
EOF

      cat <<EOF > $repo/docker-compose.dev.yml
version: "3.8"
services:
  redis-commander:
    image: rediscommander/redis-commander:latest
    ports:
      - "8082:8081"
    environment:
      REDIS_HOSTS: local:redis:6379
    depends_on:
      - redis
EOF
      ;;
    cassandra-columnar)
      cat <<EOF > $repo/docker-compose.yml
version: "3.8"
services:
  cassandra:
    image: cassandra:4
    container_name: cassandra
    ports:
      - "9042:9042"
    volumes:
      - cassandra_data:/var/lib/cassandra
    restart: always

volumes:
  cassandra_data:
EOF

      cat <<EOF > $repo/docker-compose.dev.yml
# Cassandra não possui UI oficial leve via container.
# Este arquivo pode incluir ferramentas de seed ou administração futura.
version: "3.8"
services:
  cassandra:
    image: cassandra:4
    ports:
      - "9042:9042"
    volumes:
      - cassandra_data:/var/lib/cassandra
EOF
      ;;
    neo4j-graph)
      cat <<EOF > $repo/docker-compose.yml
version: "3.8"
services:
  neo4j:
    image: neo4j:5
    container_name: neo4j
    ports:
      - "7474:7474"
      - "7687:7687"
    environment:
      NEO4J_AUTH: neo4j/test123
    volumes:
      - neo4j_data:/data
    restart: always

volumes:
  neo4j_data:
EOF

      cat <<EOF > $repo/docker-compose.dev.yml
# Ambiente de desenvolvimento com debug ou seed extra
version: "3.8"
services:
  neo4j:
    image: neo4j:5
    ports:
      - "7474:7474"
      - "7687:7687"
    environment:
      NEO4J_AUTH: neo4j/test123
EOF
      ;;
  esac

  echo "✅ Estrutura criada: $repo"
done

echo "🎉 Todos os repositórios estão prontos com docker-compose.yml e docker-compose.dev.yml!"
