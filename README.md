# Scanner Linux - Bash Script

Un script en Bash para automatizar tareas básicas de reconocimiento en redes locales.  
Este script permite:

- Verificar dependencias (`nmap`, `xclip`).
- Detectar el sistema operativo objetivo (Linux o Windows) mediante TTL.
- Realizar un escaneo rápido de todos los puertos abiertos con `nmap`.
- Copiar automáticamente los puertos abiertos al portapapeles para facilitar el trabajo posterior.

## 🚀 Cómo usar

1. Clona este repositorio:
   ```bash
   git clone https://github.com/Jassedmt/Scanner.git
   cd Scanner
   ```
2. Dale permisos de ejecución al script:
   ```bash
   chmod +x scanner.sh
   ```
3. Ejecuta el script pasando una dirección IP como argumento:

    ```bash
    ./scanner.sh <IP_objetivo>
    ```
Ejemplo
   ```bash
     ./scanner.sh 192.168.1.100
   ```

