#!/bin/bash

CONF_FILE="/etc/mysql/mysql.conf.d/mysqld.cnf"

echo "[INFO] Installing MySQL server..."
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server

configure_mysql() {
    echo "[INFO] Configuring MySQL to accept only from ${DB_HOST}..."

    # bind-address
    if grep -q "^bind-address" "$CONF_FILE"; then
        sed -i "s/^bind-address.*/bind-address = ${DB_HOST}/" "$CONF_FILE"
    else
        echo "bind-address = ${DB_HOST}" >> "$CONF_FILE"
    fi

    # mysqlx-bind-address
    if grep -q "^mysqlx-bind-address" "$CONF_FILE"; then
        sed -i "s/^mysqlx-bind-address.*/mysqlx-bind-address = ${DB_HOST}/" "$CONF_FILE"
    else
        echo "mysqlx-bind-address = ${DB_HOST}" >> "$CONF_FILE"
    fi

    systemctl restart mysql
}

create_database(){
    echo "[INFO] Creating database ${DB_NAME}..."
    mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
}

create_user_and_grant(){
    echo "[INFO] Creating user ${DB_USER} and granting privileges..."
    mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'${APP_HOST}' IDENTIFIED BY '${DB_PASS}';"
    mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'${APP_HOST}'; FLUSH PRIVILEGES;"
}

main(){
    configure_mysql
    create_database
    create_user_and_grant
}

main