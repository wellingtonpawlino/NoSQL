from pymongo import MongoClient
from pprint import pprint

# 📡 Conexão com MongoDB local via Docker
client = MongoClient("mongodb://localhost:27017/")
db = client["vendas"]
colecao = db["clientes"]

# 🔍 Listar coleções existentes antes de qualquer operação
print("\n📁 Coleções no banco 'vendas':")
colecoes = db.list_collection_names()
if colecoes:
    for nome in colecoes:
        print(f"- {nome}")
else:
    print("⚠️ Nenhuma coleção encontrada.")

# 🧨 Remover o banco (descomente para ativar)
# client.drop_database("vendas")
# print("❌ Banco 'vendas' removido.")

# 📥 Inserir o primeiro documento
cliente = { "nome": "João Lima", "cpf": "123.456.789-00", "vip": True }
resultado = colecao.insert_one(cliente)
print("\n✅ Cliente inserido com ID:", resultado.inserted_id)

# 👀 Consultar todos os documentos na coleção
print("\n👥 Documentos na coleção 'clientes':")
for cliente in colecao.find({}, { "_id": 0 }):  # Oculta o campo _id
    pprint(cliente)

# Encontrar duplicados por CPF
duplicados = colecao.aggregate([
    {
        "$group": {
            "_id": { "cpf": "$cpf" },
            "ids": { "$addToSet": "_id" },
            "count": { "$sum": 1 }
        }
    },
    {
        "$match": { "count": { "$gt": 1 } }
    }
])

# Remover duplicados, mantendo o primeiro
for doc in duplicados:
    ids = doc["ids"]
    ids.pop(0)  # Remove o primeiro da lista (mantém ele)
    colecao.delete_many({ "_id": { "$in": ids } })

print("✅ Duplicados removidos com sucesso!")