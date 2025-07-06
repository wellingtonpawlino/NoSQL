from pymongo import MongoClient

# Conectar ao MongoDB local via Docker
client = MongoClient("mongodb://localhost:27017/")
db = client["lojaDigital"]
colecao = db["produtos"]

# Consulta: produtos da categoria 'eletrônicos' com nome e preço
print("\n📦 Produtos eletrônicos:")
for doc in colecao.find({ "categoria": "eletrônicos" }, { "_id": 0, "nome": 1, "preco": 1 }):
    print(doc)

# Consulta: produtos com preço maior que R$ 500
print("\n💰 Produtos com preço acima de R$ 500:")
for doc in colecao.find({ "preco": { "$gt": 500 } }, { "_id": 0, "nome": 1, "preco": 1 }):
    print(doc)