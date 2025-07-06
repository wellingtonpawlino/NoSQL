from pymongo import MongoClient

# Conexão com MongoDB local (via Docker)
client = MongoClient("mongodb://localhost:27017/")
db = client["lojaDigital"]
colecao = db["produtos"]

# Inserir documentos
produtos = [
    { "nome": "Notebook Gamer", "preco": 4899.90, "categoria": "eletrônicos", "estoque": 15 },
    { "nome": "Teclado Mecânico", "preco": 299.99, "categoria": "periféricos", "estoque": 40 },
    { "nome": "Câmera de segurança", "preco": 649.00, "categoria": "segurança", "estoque": 18 }
]

resultado = colecao.insert_many(produtos)
print("IDs inseridos:", resultado.inserted_ids)

# Consultar todos os produtos
print("\n📦 Produtos no banco:")
for produto in colecao.find():
    print(produto)