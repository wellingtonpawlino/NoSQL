from pymongo import MongoClient

# Conexão com MongoDB
client = MongoClient("mongodb://localhost:27017/")
db = client["lojaDigital"]
colecao = db["produtos"]

# ❌ Excluir produto específico
colecao.delete_one({ "nome": "Carregador USB-C" })

# ❌ Excluir todos com estoque menor que 20
colecao.delete_many({ "estoque": { "$lt": 20 } })

# Mostrar coleção restante
print("\n📉 Produtos restantes após exclusão:")
for produto in colecao.find():
    print(produto)
