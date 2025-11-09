# 🐳 AdventureWorksDW2022 en Docker

Base de datos de ejemplo **AdventureWorksDW2022** lista para usar en **Docker** y conectarse fácilmente con **Power BI**.

---

## 🚀 Inicio Rápido

### 🔧 Requisitos
- Docker Desktop instalado  
- 4 GB de RAM disponible  
- 5 GB de espacio en disco  

---

### 🧩 Pasos para levantar la base de datos

#### 1️⃣ Clona este repositorio
```bash
git clone https://github.com/IPineda24/AdvedtueWorkDB-BI.git
cd adventureworks-docker
```

#### 2️⃣ Agrega el respaldo
Coloca el archivo `AdventureWorksDW2022.bak` dentro de la carpeta:
```
backups/
```

#### 3️⃣ Levanta el contenedor
```bash
docker-compose up -d
```

#### 4️⃣ Verifica el inicio del contenedor
```bash
docker logs -f adventureworks-sql
```

#### 5️⃣ Copia el backup y el script al contenedor
```bash
# Copiar el backup
docker cp .\backups\AdventureWorksDW2022.bak adventureworks-sql:/var/opt/mssql/data/

# Copiar el script de restauración
docker cp .\scripts\restore-database.sql adventureworks-sql:/tmp/
```

#### 6️⃣ Restaura la base de datos
```bash
docker exec -it adventureworks-sql /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P MyStrongPass123! -C -i /tmp/restore-database.sql
```

#### 7️⃣ Verifica que la base se haya restaurado
```bash
docker exec -it adventureworks-sql /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P MyStrongPass123! -C -Q "SELECT name, database_id, state_desc FROM sys.databases WHERE name = 'AdventureWorksDW2022'"
```

Si ves `AdventureWorksDW2022` en los resultados, ¡todo está listo! ✅

---

## 🗃️ Tablas principales

Para listar las tablas disponibles:
```bash
docker exec -it adventureworks-sql /opt/mssql-tools18/bin/sqlcmd \
  -S localhost -U sa -P MyStrongPass123! -C \
  -Q "USE AdventureWorksDW2022; SELECT name FROM sys.tables ORDER BY name"
```

---

## 📊 Conexión con Power BI

| Parámetro | Valor |
|------------|--------|
| **Servidor** | `localhost,1433` |
| **Base de datos** | `AdventureWorksDW2022` |
| **Usuario** | `sa` |
| **Contraseña** | `MyStrongPass123!` |

---

## 🛑 Detener y eliminar el contenedor
```bash
docker-compose down
```

---

## ⚠️ Notas importantes
- La contraseña se define en el archivo `docker-compose.yml`.  
- **Cámbiala en producción.**  
- Los datos se guardan en un **volumen de Docker** (persisten aunque detengas el contenedor).  
