#!/bin/bash

# Проверить sudo
if [ "$(id -u)" != "0" ]; then
        echo "Please run script as root"
        exit 1
fi

# Цвета
COLOR='\033[34m'
ENDC='\033[0m'

# Остановка служб
systemctl stop validator 2>&1
systemctl stop mytoncore 2>&1
systemctl stop dht-server 2>&1

# Переменные
str=$(systemctl cat mytoncore | grep User | cut -d '=' -f2)
user=$(echo ${str})

# Удаление служб
rm -rf /etc/systemd/system/validator.service 2>&1
rm -rf /etc/systemd/system/mytoncore.service 2>&1
rm -rf /etc/systemd/system/dht-server.service 2>&1
systemctl daemon-reload

# Удаление файлов
rm -rf /usr/src/ton 2>&1
rm -rf /usr/src/mytonctrl 2>&1
rm -rf /usr/bin/ton 2>&1
rm -rf /var/ton-work 2>&1
rm -rf /var/ton-dht-server 2>&1
rm -rf /tmp/myton* 2>&1
rm -rf /usr/local/bin/mytoninstaller/ 2>&1
rm -rf /usr/local/bin/mytoncore/mytoncore.db 2>&1
rm -rf /home/${user}/.local/share/mytonctrl 2>&1
rm -rf /home/${user}/.local/share/mytoncore/mytoncore.db 2>&1

# Удаление ссылок
rm -rf /usr/bin/fift 2>&1
rm -rf /usr/bin/liteclient 2>&1
rm -rf /usr/bin/validator-console 2>&1
rm -rf /usr/bin/mytonctrl 2>&1

# Конец
echo -e "${COLOR}Uninstall Complete${ENDC}"
