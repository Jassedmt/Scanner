#!/bin/bash

# Colores
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# Comprobar dependencias
test -f /usr/bin/nmap

if [ "$(echo $?)" == "0" ]; then
        echo -e "${turquoiseColour}Las dependencias están satisfechas${endColour}"
else
        echo -e "${yellowColour}Hay que instalar dependencias${endColour}" && apt update >/dev/null && apt install nmap xclip -y >/dev/null && echo -e "${greenColour}Dependencias instaladas${endColour}"
fi

if [ -z "$1" ]; then
    echo -e "${redColour}[*] Uso: $0 <IP>${endColour}"
    exit 1
fi

# IP objetivo
ip=$1

# Comprobar conectividad con ping
ping -c 1 $ip > ping.log

# Detectar el sistema operativo (Linux o Windows)
for i in $(seq 60 70); do
        if test $(grep ttl=$i ping.log -c) = 1; then
                echo -e "Sistema operativo: ${greenColour}Linux${endColour}"
        fi
done

for i in $(seq 100 200); do
        if test $(grep ttl=$i ping.log -c) = 1; then
                echo -e "Sistema operativo: ${greenColour}Windows${endColour}"
        fi
done

rm ping.log

nmap -p- -sCV --open -sS --min-rate 5000 -n -Pn $ip -oN scan

# Verificar si hay puertos abiertos
if test $(grep "open" scan -c) -gt 0; then
        echo -e "${blueColour}Puertos abiertos en ${endColour}${greenColour}$ip${endColour}"
        # Extraer puertos abiertos y copiarlos al portapapeles
        open_ports=$(grep "open" scan | awk '/^[0-9]+\/tcp/ {print $1}' | cut -d '/' -f 1 | tr '\n' ' ' | sed 's/ $//')
        echo -e "${open_ports}"
        echo "$open_ports" | xclip -selection clipboard  # Copiar puertos al portapapeles
        echo -e "${greenColour}Los puertos abiertos se han copiado al portapapeles.${endColour}"
else
        echo -e "${redColour}No se encontraron puertos abiertos${endColour}"
fi
