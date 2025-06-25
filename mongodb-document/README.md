


# 🗃️ MongoDB - Banco baseado em documentos

Este repositório demonstra o uso de MongoDB — banco de dados orientado a documentos — com Docker, Python e MongoDB Compass, em um ambiente de aprendizado prático e progressivo.

## 🚀 Tecnologias utilizadas

- MongoDB 7 (via Docker)
- MongoDB Compass (interface gráfica)
- Python + PyMongo
- Docker Compose
- VS Code


---
## 🧠 Comparativo entre Modelos de Banco de Dados

| 💾 **Relacional (SQL)**               | 📄 **MongoDB (Documentos)**              |
|--------------------------------------|------------------------------------------|
| **Tabelas e colunas fixas**          | **Coleções e documentos flexíveis**      |
| **Dados normalizados (multi tabelas)** | **Dados aninhados em um único documento** |
| **JOINs entre tabelas**              | **Documentos autocontidos (sem JOIN)**   |
| **Schema rígido**                    | **Schema dinâmico (campos podem variar)**|
| **Linguagem SQL**                    | **Sintaxe JSON-like**                    |


## 📦 Comandos MongoDB Essenciais

| SQL (relacional)            | MongoDB (documentos)                           |
|-----------------------------|-------------------------------------------------|
| `SELECT * FROM clientes`    | `db.clientes.find()`                           |
| `SELECT nome FROM clientes` | `db.clientes.find({}, { nome: 1, _id: 0 })`     |
| `SELECT * WHERE idade > 30` | `db.clientes.find({ idade: { $gt: 30 } })`     |
| `INSERT INTO clientes (...)`| `db.clientes.insertOne({ nome: "Ana", idade: 25 })` |
| `UPDATE clientes SET idade=26 WHERE nome="Ana"` | `db.clientes.updateOne({ nome: "Ana" }, { $set: { idade: 26 } })` |
| `DELETE FROM clientes WHERE nome="Ana"` | `db.clientes.deleteOne({ nome: "Ana" })` |