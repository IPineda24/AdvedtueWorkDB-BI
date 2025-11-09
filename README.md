# AdventureWorksDW2022 en Docker 🐳

Base de datos de ejemplo AdventureWorksDW2022 dockerizada y lista para usar con Power BI.

## 🚀 Inicio Rápido

### Requisitos
- Docker Desktop instalado
- 4GB de RAM disponible
- 5GB de espacio en disco

### Levantar la base de datos

1. Clona este repositorio:
```bash
git clone [URL-DE-TU-REPO]
cd adventureworks-docker
```

2. Asegúrate de que el archivo `AdventureWorksDW2022.bak` esté en la carpeta `backups/`

3. Levanta el contenedor:
```bash
docker-compose up -d
```

4. Espera 30 segundos y restaura la base de datos:
```bash
docker exec -it adventureworks-sql /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P MyStrongPass123! -i /var/opt/mssql/scripts/restore-database.sql
```

### Verificar que funciona
```bash
docker exec -it adventureworks-sql /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P MyStrongPass123! -Q "SELECT name FROM sys.databases"
```

Deberías ver `AdventureWorksDW2022` en la lista.

## 📊 Conectar con Power BI

**Servidor:** `localhost,1433`  
**Base de datos:** `AdventureWorksDW2022`  
**Usuario:** `sa`  
**Contraseña:** `MyStrongPass123!`

## 🛑 Detener el contenedor
```bash
docker-compose down
```

## ⚠️ Importante
- La contraseña está en el archivo `docker-compose.yml`
- Cámbiala en producción
- Los datos persisten en un volumen de Docker