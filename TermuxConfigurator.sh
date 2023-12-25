#!/bin/bash

SCRIPT_VERSION="1.1"
DEVELOPER="Termux_Laif"

CONFIG_DIR="$HOME/.termux_config"

PACKAGES="git vim python python2 nodejs curl wget zsh neofetch htop mc openssh fish tmux ruby golang aircrack-ng"

cleanup() {
    echo -e "\e[1;33mОчистка перед выходом...\e[0m"
    echo -e "\e[1mВыход из скрипта. Удачного использования Termux!\e[0m"
    exit
}


install_configure_figlet() {
    echo -e "\e[1mУстановка и настройка figlet...\e[0m"
    pkg install -y figlet
    echo -e "\e[1mУстановка figlet завершена.\e[0m"
}

configure_figlet() {
    read -p "Хотите настроить figlet? (yes/no): " configure_figlet
    if [ "$configure_figlet" == "yes" ]; then
        read -p "Введите стиль для figlet (например, 'block'): " figlet_style
        echo "export FIGLET_FONT=$figlet_style" >> ~/.bashrc
        echo -e "\e[1mНастройка figlet завершена.\e[0m"
    fi
}


configure_command_history() {
    echo -e "\e[1mНастройка сохранения истории команд в Termux...\e[0m"
    termux-setup-storage # Убедимся, что разрешения на сохранение истории команд установлены
    echo "export HISTFILE=$HOME/.bash_history" >> ~/.bashrc
    echo "export HISTSIZE=1000" >> ~/.bashrc
    echo "export HISTFILESIZE=2000" >> ~/.bashrc
    echo "export PROMPT_COMMAND='history -a'" >> ~/.bashrc
    source ~/.bashrc
    echo -e "\e[1mНастройка сохранения истории команд завершена.\e[0m"
}

backup_config() {
    echo -e "\e[1mСоздание резервной копии конфигурации...\e[0m"
    mkdir -p $CONFIG_DIR
    tar czf $CONFIG_DIR/termux_config_backup.tar.gz $HOME/.vimrc $HOME/.tmux.conf $HOME/.bashrc # Добавьте другие файлы по необходимости
    echo -e "\e[1mРезервное копирование завершено.\e[0m"
}

restore_config() {
    echo -e "\e[1mВосстановление конфигурации из резервной копии...\e[0m"
    if [ -e $CONFIG_DIR/termux_config_backup.tar.gz ]; then
        tar xzf $CONFIG_DIR/termux_config_backup.tar.gz -C ~/
        echo -e "\e[1mВосстановление завершено.\e[0m"
    else
        echo -e "\e[1;31mРезервная копия не найдена.\e[0m"
    fi
}

install_packages() {
    echo -e "\e[1mУстановка пакетов...\e[0m"
    pkg install -y $PACKAGES
    if [ $? -eq 0 ]; then
        echo -e "\e[1mУстановка завершена.\e[0m"
    else
        echo -e "\e[1;31mОшибка при установке пакетов.\e[0m"
    fi
}

configure_git() {
    read -p "Введите ваше имя для git: " git_name
    read -p "Введите вашу электронную почту для git: " git_email
    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
    echo -e "\e[1mНастройка git завершена.\e[0m"
}

configure_vim() {
    echo -e "\e[1mНастройка Vim...\e[0m"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    cp vimrc ~/.vimrc
    vim +PluginInstall +qall
    echo -e "\e[1mНастройка Vim завершена.\e[0m"
}

install_configure_wifi_tools() {
    echo -e "\e[1mУстановка и настройка инструментов Wi-Fi...\e[0m"
    pkg install -y aircrack-ng
    echo -e "\e[1mУстановка инструментов Wi-Fi завершена.\e[0m"
}

install_configure_tmux() {
    echo -e "\e[1mУстановка и настройка tmux...\e[0m"
    pkg install -y tmux
    cp tmux.conf ~/.tmux.conf
    echo -e "\e[1mНастройка tmux завершена.\e[0m"
}

trap cleanup INT TERM

while true; do
    clear
    echo -e "\e[1;34m===== TermuxConfigurator v$SCRIPT_VERSION =====\e[0m"
    echo -e "\e[1;34m===== Разработчик: $DEVELOPER =====\e[0m"
    echo -e "\e[1;34m===== Меню настройки Termux =====\e[0m"
    echo "1. Установить основные пакеты"
    echo "2. Настроить git"
    echo "3. Настроить Vim"
    echo "4. Установить и настроить VSCode"
    echo "5. Настроить пользовательские алиасы"
    echo "6. Установить и настроить SSH-сервер"
    echo "7. Установить и настроить ngrok"
    echo "8. Установить и настроить rsync"
    echo "9. Установить и настроить Fish Shell"
    echo "10. Установить и настроить tmux"
    echo "11. Установить и настроить Python"
    echo "12. Установить и настроить Node.js"
    echo "13. Установить и настроить Ruby"
    echo "14. Установить и настроить Go"
    echo "15. Обновить установленные пакеты"
    echo "16. Создать директорию"
    echo "17. Удалить директорию"
    echo "18. Установить и настроить цвета в Termux"
    echo "19. Установить и настроить инструменты Wi-Fi"
    echo "20. Создать резервную копию конфигурации"
    echo "21. Восстановить конфигурацию из резервной копии"
    echo "22. Настроить сохранение истории команд в Termux"
    echo "23. Установка и настройка пакета 'figlet' для создания ASCII-арт текста"
    echo "0. Выход"
    echo -e "\e[1;34m===============================\e[0m"

    read -p "Выберите опцию (0-19): " option

    case $option in
        1) install_packages ;;
        2) configure_git ;;
        3) configure_vim ;;
        4) install_configure_vscode ;;
        5) configure_aliases ;;
        6) install_configure_ssh ;;
        7) install_configure_ngrok ;;
        8) configure_rsync ;;
        9) pkg install -y fish ;;
        10) install_configure_tmux ;;
        11) configure_python ;;
        12) configure_nodejs ;;
        13) configure_ruby ;;
        14) configure_golang ;;
        15) update_packages ;;
        16) create_directory ;;
        17) remove_directory ;;
        18) configure_termux_colors ;;
        19) install_configure_wifi_tools ;;
        20) backup_config ;;
        21) restore_config ;;
        22) configure_command_history ;;
        23) configure_figlet ;;
        0) cleanup ;;
        *) echo -e "\e[1;31mНеверный ввод. Пожалуйста, введите корректный номер опции.\e[0m" ;;
    esac

    read -p "Нажмите Enter, чтобы продолжить..."
done
