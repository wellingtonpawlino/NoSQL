from pymongo import MongoClient

# Conecta ao MongoDB local
client = MongoClient("mongodb://localhost:27017")

# Acessa ou cria o banco de dados
db = client["meu_banco"]

# Acessa ou cria a coleção
colecao = db["clientes"]

# Documento de exemplo
documento = {
    "nome": "Wellington",
    "email": "weel@example.com",
    "idade": 34
}

# Inserir documento
resultado = colecao.insert_one(documento)

# Mostrar ID gerado
print("ID inserido:", resultado.inserted_id)

# Buscar e exibir todos os documentos
for doc in colecao.find():
    print(doc)