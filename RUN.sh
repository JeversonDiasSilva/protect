#!/bin/bash

# Cores e formatação
RESET="\033[0m"
BOLD_ORANGE="\033[1;33m"
BOLD_GREEN="\033[1;32m"

# Mensagem de abertura
echo -e "${BOLD_ORANGE}╔════════════════════════════════════════════════════╗"
echo -e "║             INSTALAÇÃO DO SISTEMA DE PROTEÇÃO       ║"
echo -e "║                COMPATÍVEL COM BATOCERA V40 / V41    ║"
echo -e "╚════════════════════════════════════════════════════╝${RESET}"

# Caminhos
DOWNLOAD_DIR="/userdata/extractions"
SYS_FILE="$DOWNLOAD_DIR/SYS"
DOWNLOAD_URL="https://github.com/JeversonDiasSilva/protect/releases/download/v1.0/SYS"

# Cria o diretório de download se não existir
mkdir -p "$DOWNLOAD_DIR"

# Baixa o arquivo SYS
wget "$DOWNLOAD_URL" -O "$SYS_FILE"

# Extrai o conteúdo para o destino
unsquashfs -d /usr/share/JCGAMES "$SYS_FILE"

# Move os arquivos desejados
mv /usr/share/JCGAMES/MGames /usr/bin
mv /usr/share/JCGAMES/verificando /usr/bin

# Dá permissões de execução
chmod +x /usr/bin/MGames
chmod +x /usr/bin/verificando

# Espera um pouco
sleep 1

# Insere "verificando" abaixo de "# ulimit -c unlimited", se ainda não estiver
if ! grep -A1 '# ulimit -c unlimited' /etc/X11/xinit/xinitrc | grep -q '^verificando$'; then
    sed -i '/# ulimit -c unlimited/a\verificando' /etc/X11/xinit/xinitrc
fi

# Remove o arquivo baixado
rm -f "$SYS_FILE"

# Salva as alterações no sistema
batocera-save-overlay

# Mensagem final de sucesso
echo -e "${BOLD_GREEN}Todos os pacotes foram instalados com sucesso!${RESET}"

echo
echo -e "${BOLD_ORANGE}══════════════════════════════════════════════════════"
echo -e "        By @JCGAMESCLASSICOS - Batocera Wine Pack     "
echo -e "══════════════════════════════════════════════════════${RESET}"

# Mensagem para reiniciar o sistema
echo -e "\033[1;34m🔁 REINICIE O SISTEMA PARA APLICAR TODAS AS ALTERAÇÕES.\033[0m"
