from pymongo import MongoClient

# Conexão com MongoDB
client = MongoClient("mongodb://localhost:27017/")
db = client["lojaDigital"]
colecao = db["produtos"]

# ✅ Atualizar estoque (acrescentar 10 unidades ao 'Notebook Gamer')
colecao.update_one(
    { "nome": "Notebook Gamer" },
    { "$inc": { "estoque": 10 } }
)

# ✅ Atualizar categoria de um produto
colecao.update_one(
    { "nome": "Teclado Mecânico" },
    { "$set": { "categoria": "hardware" } }
)

# Mostrar atualizações
print("\n🔄 Produtos atualizados:")
for produto in colecao.find({ "nome": { "$in": ["Notebook Gamer", "Teclado Mecânico"] } }):
    print(produto)