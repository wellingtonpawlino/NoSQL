

from pymongo import MongoClient

# Conexão com MongoDB
client = MongoClient("mongodb://localhost:27017/")

# 📂 Listar todos os databases disponíveis
print("\n📚 Bases de dados existentes:")
for db_info in client.list_databases():
    print(f"- {db_info['name']} ({db_info['sizeOnDisk'] / 1024:.2f} KB)")
