#!/bin/bash

APP_USER="petclinicapp"
APP_DIR="/home/${APP_USER}/app"
PROJECT_DIR="/home/${APP_USER}/spring-petclinic"

install_dependencies() {
    echo "[INFO] Installing dependencies..."
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-21-jdk git maven
}

create_app_user() {
    echo "[INFO] Creating application user ${APP_USER}..."
    useradd -m -s /bin/bash ${APP_USER}
}

clone_project(){
    echo "[INFO] Cloning Spring PetClinic..."
    sudo -u ${APP_USER} git clone https://github.com/spring-projects/spring-petclinic.git ${PROJECT_DIR}
}

build_project(){
    echo "[INFO] Building PetClinic with Maven..."
    cd ${PROJECT_DIR}
    sudo -u ${APP_USER} ./mvnw package -DskipTests
}

prepare_jar(){
    echo "[INFO] Moving .jar to app directory..."
    mkdir -p ${APP_DIR}
    cp ${PROJECT_DIR}/target/*.jar ${APP_DIR}/petclinic.jar
    chown -R ${APP_USER}:${APP_USER} ${APP_DIR}
}

create_systemd_service(){
    echo "[INFO] Creating systemd service for PetClinic..."

    cat <<EOF > /etc/systemd/system/petclinic.service
[Unit]
Description=Spring PetClinic Application
After=network.target

[Service]
User=${APP_USER}
ExecStart=/usr/bin/java -jar ${APP_DIR}/petclinic.jar \
 --spring.profiles.active=mysql \
 --server.port=8080 \
 --server.address=0.0.0.0 \
 --spring.datasource.url=jdbc:mysql://${DB_HOST}:${DB_PORT}/${DB_NAME} \
 --spring.datasource.username=${DB_USER} \
 --spring.datasource.password=${DB_PASS}
WorkingDirectory=${APP_DIR}
Restart=always

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reexec
    systemctl daemon-reload
    systemctl enable petclinic
    systemctl start petclinic
}

main() {
    install_dependencies
    create_app_user
    clone_project
    build_project
    prepare_jar
    create_systemd_service
}

main
echo "[✅] PetClinic app setup complete! Access it at http://localhost:8080"