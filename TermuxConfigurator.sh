#!/bin/bash

SCRIPT_VERSION="1.0"

DEVELOPER="Termux_Laif"


PACKAGES="git vim python python2 nodejs curl wget zsh neofetch htop mc openssh fish tmux ruby golang"

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

# Старые опции

install_configure_tmux() {
    echo -e "\e[1mУстановка и настройка tmux...\e[0m"
    pkg install -y tmux
    cp tmux.conf ~/.tmux.conf
    echo -e "\e[1mНастройка tmux завершена.\e[0m"
}

configure_python() {
    echo -e "\e[1mУстановка pip...\e[0m"
    pkg install -y python
    curl -sL https://bootstrap.pypa.io/get-pip.py | python
    echo -e "\e[1mУстановка pip завершена.\e[0m"
}

configure_nodejs() {
    echo -e "\e[1mУстановка Node.js...\e[0m"
    pkg install -y nodejs
    echo -e "\e[1mУстановка Node.js завершена.\e[0m"
}

configure_ruby() {
    echo -e "\e[1mУстановка Ruby...\e[0m"
    pkg install -y ruby
    echo -e "\e[1mУстановка Ruby завершена.\e[0m"
}

configure_golang() {
    echo -e "\e[1mУстановка Go...\e[0m"
    pkg install -y golang
    echo -e "\e[1mУстановка Go завершена.\e[0m"
}

update_packages() {
    echo -e "\e[1mОбновление установленных пакетов...\e[0m"
    pkg update -y && pkg upgrade -y
    echo -e "\e[1mОбновление завершено.\e[0m"
}

create_directory() {
    read -p "Введите имя директории для создания: " dir_name
    mkdir $dir_name
    echo -e "\e[1mДиректория '$dir_name' создана.\e[0m"
}

remove_directory() {
    read -p "Введите имя директории для удаления: " dir_name
    rm -rf $dir_name
    echo -e "\e[1mДиректория '$dir_name' удалена.\e[0m"
}

cleanup() {
    echo -e "\e[1;33mОчистка перед выходом...\e[0m"
    echo -e "\e[1mВыход из скрипта. Удачного использования Termux!\e[0m"
    exit
}

# Новые опции

install_configure_vscode() {
    echo -e "\e[1mУстановка и настройка VSCode...\e[0m"
    pkg install -y code
    echo -e "\e[1mУстановка VSCode завершена.\e[0m"
}

configure_aliases() {
    echo -e "\e[1mНастройка пользовательских алиасов...\e[0m"
    echo "alias ll='ls -alF'" >> ~/.bashrc
    source ~/.bashrc
    echo -e "\e[1mНастройка алиасов завершена.\e[0m"
}

install_configure_ssh() {
    echo -e "\e[1mУстановка и настройка SSH-сервера...\e[0m"
    if [ ! -e $PREFIX/etc/ssh/sshd_config ]; then
        pkg install -y openssh
    fi
    ssh-keygen -A
    sshd
    echo -e "\e[1mНастройка SSH-сервера завершена.\e[0m"
}

install_configure_ngrok() {
    echo -e "\e[1mУстановка и настройка ngrok...\e[0m"
    pkg install -y ngrok
    echo -e "\e[1mУстановка ngrok завершена.\e[0m"
}

configure_rsync() {
    echo -e "\e[1mУстановка и настройка rsync...\e[0m"
    pkg install -y rsync
    echo -e "\e[1mУстановка rsync завершена.\e[0m"
}

# Меню с новыми и старыми опциями

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
    echo "0. Выход"
    echo -e "\e[1;34m===============================\e[0m"

    read -p "Выберите опцию (0-17): " option

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
        0) cleanup ;;
        *) echo -e "\e[1;31mНеверный ввод. Пожалуйста, введите корректный номер опции.\e[0m" ;;
    esac

    read -p "Нажмите Enter, чтобы продолжить..."
done
