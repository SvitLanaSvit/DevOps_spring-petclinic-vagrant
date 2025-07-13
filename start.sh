#!/bin/bash

# Запит параметрів у користувача
read -p "Please enter DB_NAME: " DB_NAME
read -p "Please enter DB_USER: " DB_USER
read -sp "Please enter DB_PASSWORD: " DB_PASS
echo ""

# Встановлюємо дефолтні значення
DB_HOST="192.168.56.10"
APP_HOST="192.168.56.20"
DB_PORT="3306"
APP_USER="petclinicapp"

# Експортуємо змінні середовища
export DB_NAME
export DB_USER
export DB_PASS
export DB_HOST
export DB_PORT
export APP_USER
export APP_HOST

# Запуск DB_VM
echo "[INFO] Starting DB_VM..."
vagrant up DB_VM --provision

echo "[INFO] Waiting while DB is configured..."
sleep 60

# Запуск APP_VM
echo "[INFO] Starting APP_VM..."
vagrant up APP_VM --provision

echo "[✅] All done! PetClinic should be available at http://${APP_HOST}:8080"
