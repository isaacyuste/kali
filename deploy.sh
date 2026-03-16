#!/bin/bash

# ============================
#  COLORES
# ============================
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

# ============================
#  FUNCIONES
# ============================
error() {
    echo -e "${RED}[ERROR] $1${RESET}"
    exit 1
}

ok() {
    echo -e "${GREEN}[OK] $1${RESET}"
}

info() {
    echo -e "${YELLOW}[INFO] $1${RESET}"
}

# ============================
#  1. COMPROBAR DOCKER
# ============================
info "Comprobando si Docker está instalado..."

if ! command -v docker &> /dev/null; then
    error "Docker no está instalado. Instálalo antes de continuar."
else
    ok "Docker está instalado."
fi

# ============================
#  2. COMPROBAR PUERTO 80
# ============================
info "Comprobando si el puerto 80 está libre..."

if lsof -i :80 &> /dev/null; then
    error "El puerto 80 está ocupado. Cierra el proceso que lo usa."
else
    ok "El puerto 80 está libre."
fi

# ============================
#  3. COMPROBAR PUERTO 3306
# ============================
info "Comprobando si el puerto 3306 está libre..."

if lsof -i :3306 &> /dev/null; then
    error "El puerto 3306 está ocupado. Cierra el proceso que lo usa."
else
    ok "El puerto 3306 está libre."
fi

# ============================
#  4. LEVANTAR INFRAESTRUCTURA
# ============================
info "Levantando infraestructura con Docker Compose..."

docker compose up -d || error "Fallo al ejecutar docker compose."

ok "Infraestructura desplegada correctamente."