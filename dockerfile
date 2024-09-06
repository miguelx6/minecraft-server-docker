# Usamos la imagen base del servidor de Minecraft
FROM itzg/minecraft-server:latest

# Establecemos las variables de entorno por defecto
ENV EULA=TRUE \
    ONLINE_MODE=false \
    DIFFICULTY=easy \
    GAMEMODE=creative \
    MAX_PLAYERS=20 \
    ALLOW_NETHER=true \
    ENABLE_COMMAND_BLOCK=true \
    MOTD="Servidor de la celda"

# Exponemos el puerto 25565 para que otros jugadores puedan conectarse
EXPOSE 25565

# Directorio donde se almacenarán los datos del servidor
VOLUME ["/data"]

# Iniciar el servidor cuando el contenedor se inicie
ENTRYPOINT ["start-minecraft"]
