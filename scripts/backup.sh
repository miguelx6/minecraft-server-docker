# backup.ps1

# Configuración
$MINECRAFT_DIR = "C:\Users\migue\AppData\Roaming\.minecraft"
$BACKUP_DIR = "C:\Users\migue\AppData\Roaming\.minecraft\backup"
$DATE = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$BACKUP_FILE = "minecraft_backup_$DATE.zip"

# Asegúrate de que el directorio de backup existe
if (-not (Test-Path $BACKUP_DIR)) {
    New-Item -ItemType Directory -Force -Path $BACKUP_DIR
}

# Aviso al usuario
Write-Host "Asegúrate de haber cerrado el juego antes de continuar."
Read-Host "Presiona Enter para continuar..."

# Crear el backup
Write-Host "Creando backup..."
Compress-Archive -Path "$MINECRAFT_DIR\*" -DestinationPath "$BACKUP_DIR\$BACKUP_FILE" -Force

# Verificar si el backup se creó correctamente
if (Test-Path "$BACKUP_DIR\$BACKUP_FILE") {
    Write-Host "Backup creado exitosamente: $BACKUP_FILE"
} else {
    Write-Host "Error: No se pudo crear el backup"
}

# Opcional: Eliminar backups antiguos (mantener solo los últimos 5)
Get-ChildItem $BACKUP_DIR | Where-Object {$_.Name -like "minecraft_backup_*.zip"} | Sort-Object CreationTime -Descending | Select-Object -Skip 5 | Remove-Item -Force

Write-Host "Proceso de backup completado"