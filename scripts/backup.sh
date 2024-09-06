#!/bin/bash

# Configuración
MINECRAFT_DIR="/path/to/your/minecraft/data"
BACKUP_DIR="/path/to/your/backup/directory"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="minecraft_backup_$DATE.tar.gz"

# Asegúrate de que el directorio de backup existe
mkdir -p $BACKUP_DIR

# Detener el servidor de Minecraft (asumiendo que usas Docker Compose)
echo "Deteniendo el servidor de Minecraft..."
docker-compose down

# Crear el backup
echo "Creando backup..."
tar -czf $BACKUP_DIR/$BACKUP_FILE -C $MINECRAFT_DIR .

# Reiniciar el servidor
echo "Reiniciando el servidor de Minecraft..."
docker-compose up -d

# Verificar si el backup se creó correctamente
if [ -f "$BACKUP_DIR/$BACKUP_FILE" ]; then
    echo "Backup creado exitosamente: $BACKUP_FILE"
else
    echo "Error: No se pudo crear el backup"
fi

# Opcional: Eliminar backups antiguos (mantener solo los últimos 5)
cd $BACKUP_DIR
ls -t | tail -n +6 | xargs -I {} rm -- {}

echo "Proceso de backup completado"